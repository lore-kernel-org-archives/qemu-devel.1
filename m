Received: from eggs.gnu.org ([209.51.188.92]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghFCm-0005ve-8m
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghFCk-0002Jv-VV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:51:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ghFCk-0002Iz-M4
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:51:38 -0500
References: <1547043869-10520-1-git-send-email-thuth@redhat.com>
	<20190109143122.GR3998@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <21c94e77-ad1d-3ce2-72cd-fc86f6d619fc@redhat.com>
Date: Wed, 9 Jan 2019 15:51:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190109143122.GR3998@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] configure: Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2019-01-09 15:31, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 09, 2019 at 03:24:29PM +0100, Thomas Huth wrote:
>> Different versions of GCC and Clang use different versions of the C st=
andard.
>> This repeatedly caused problems already, e.g. with duplicated typedefs=
:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
>>
>> or with for-loop variable initializers:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
>>
>> To avoid these problems, we should enforce the C language version to t=
he
>> same level for all compilers. Since our minimum compiler versions is
>> GCC v4.8, our best option is "gnu99" right now ("gnu17" is not availab=
le
>> there yet, and "gnu11" is marked as "experimental").
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Use gnu99 instead of gnu11
>>
>>  configure | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>> diff --git a/configure b/configure
>> index b9f34af..721ade7 100755
>> --- a/configure
>> +++ b/configure
>> @@ -105,7 +105,8 @@ update_cxxflags() {
>>      for arg in $QEMU_CFLAGS; do
>>          case $arg in
>>              -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs=
|\
>> -            -Wold-style-declaration|-Wold-style-definition|-Wredundan=
t-decls)
>> +            -Wold-style-declaration|-Wold-style-definition|-Wredundan=
t-decls|\
>> +            -std=3Dgnu99)
>=20
> IIUC this is to  drop  -std=3Dgnu99 from CXXFLAGS, so C++ code (only th=
e
> guest-agent on Win32 IIUC) will use the compiler default still.

We also use it for the capstone disassembler and disas/libvixl.

> We could consider also setting a suitable -std for CXXFLAGS too in futu=
re
> though...

Shall I send a v3 with "-std=3Dgnu++98" (which seems to be the only usabl=
e
option right now), or shall we wait until we really hit a problem with
the C++ code?

 Thomas
