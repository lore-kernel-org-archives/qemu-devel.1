Received: from eggs.gnu.org ([209.51.188.92]:58462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMovi-00055j-M7
	for qemu-devel@nongnu.org; Sat, 04 May 2019 03:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMovh-0000Mc-DF
	for qemu-devel@nongnu.org; Sat, 04 May 2019 03:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMovh-0000MJ-5l
	for qemu-devel@nongnu.org; Sat, 04 May 2019 03:17:53 -0400
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
	<40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
	<20190503210011.GW28722@habkost.net>
	<20190503213457.GX28722@habkost.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b86fd845-ba4b-6e27-73ac-50b2c8810fe8@redhat.com>
Date: Sat, 4 May 2019 09:17:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190503213457.GX28722@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/19] configure: automatically pick python3
 is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 03/05/2019 23.34, Eduardo Habkost wrote:
> On Fri, May 03, 2019 at 06:00:11PM -0300, Eduardo Habkost wrote:
>> On Fri, May 03, 2019 at 06:41:43PM +0200, Thomas Huth wrote:
>>> On 03/05/2019 02.41, Eduardo Habkost wrote:
>>>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>>
>>>> Unless overridden via an env var or configure arg, QEMU will only lo=
ok
>>>> for the 'python' binary in $PATH. This is unhelpful on distros which
>>>> are only shipping Python 3.x (eg Fedora) in their default install as=
,
>>>> if they comply with PEP 394, the bare 'python' binary won't exist.
>>>>
>>>> This changes configure so that by default it will search for all thr=
ee
>>>> common python binaries, preferring to find Python 3.x versions.
>>>>
>>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>> Message-Id: <20190327170701.23798-1-berrange@redhat.com>
>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> ---
>>>>  configure | 18 +++++++++++++++---
>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> I haven't bisected it, but I think this patch here broke the gitlab-c=
i tests:
>>>
>>>  https://gitlab.com/huth/qemu/-/jobs/206806257
>>>
>>> Seems like the test is now failing when you don't have an UTF-8 local=
e:
>>>
>>>  LANG=3DC make check-qapi-schema
>>
>> I couldn't reproduce it this way, probably because I'm running Python =
3.7 which
>> implements PEP 538 ("Coercing the legacy C locale to a UTF-8 based loc=
ale").
>>
>> But I can force it to break using:
>>
>>   PYTHONIOENCODING=3Dascii make check-qapi-schema
>>
>>>  [...]
>>>  TEST    tests/qapi-schema/union-base-empty.out
>>>  --- /builds/huth/qemu/tests/qapi-schema/unicode-str.err	2019-05-03 1=
5:21:39.000000000 +0000
>>>  +++ -	2019-05-03 15:42:01.561762978 +0000
>>>  @@ -1 +1 @@
>>>  -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=
=C3=A9'
>>>  +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=
\xe9'
>>>  /builds/huth/qemu/tests/Makefile.include:1105: recipe for target 'ch=
eck-tests/qapi-schema/unicode-str.json' failed
>>>  make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
>>>
>>> Any ideas how to fix this?
>>
>> Probably we just need to specify an explicit encoding at the statement=
 that
>> prints the error message to stderr.  I will give it a try.
>=20
> Forcing a specific encoding inside test-qapi.py would very easy
> on Python 3.7+ (sys.stderr.reconfigure(...)), but tricky on older
> versions.  I believe this is the simplest way to fix the problem
> on Python 3.5 and 3.6.
>=20
> Can somebody confirm this really fixes the problem on gitlab-ci?
>=20
> ---
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7c8b9c84b2..af88ab6f8b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1103,7 +1103,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iot=
ests-quick.sh qemu-img$(EXESUF)
>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
>  $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PA=
TH)/%.json
>  	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
> -		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
> +		PYTHONIOENCODING=3Dutf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/tes=
t-qapi.py \
>  		$^ >$*.test.out 2>$*.test.err; \
>  		echo $$? >$*.test.exit, \
>  		"TEST","$*.out")

Yes, thanks, this seems to fix this issue:

 https://gitlab.com/huth/qemu/-/jobs/207041381

It also works on my laptop now (which uses Python 3.6).

 Thomas
