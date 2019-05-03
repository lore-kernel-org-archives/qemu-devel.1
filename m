Received: from eggs.gnu.org ([209.51.188.92]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbbX-00084o-KH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbbW-0006RX-BM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:04:11 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMbbW-0006QK-5T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:04:10 -0400
Received: by mail-wm1-f51.google.com with SMTP id m20so347537wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:04:10 -0700 (PDT)
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
	<40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b6e70863-4ec9-0209-46b0-b74eb1453fcf@redhat.com>
Date: Fri, 3 May 2019 19:04:07 +0200
MIME-Version: 1.0
In-Reply-To: <40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>

On 5/3/19 6:41 PM, Thomas Huth wrote:
> On 03/05/2019 02.41, Eduardo Habkost wrote:
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> Unless overridden via an env var or configure arg, QEMU will only look
>> for the 'python' binary in $PATH. This is unhelpful on distros which
>> are only shipping Python 3.x (eg Fedora) in their default install as,
>> if they comply with PEP 394, the bare 'python' binary won't exist.
>>
>> This changes configure so that by default it will search for all three
>> common python binaries, preferring to find Python 3.x versions.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Message-Id: <20190327170701.23798-1-berrange@redhat.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  configure | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> I haven't bisected it, but I think this patch here broke the gitlab-ci tests:
> 
>  https://gitlab.com/huth/qemu/-/jobs/206806257

What's the easier way to notice that automatically?

The quicker fix I have is Peter setup'ing a GitLab account mirroring his
repo:staging branch, and warn him, but that won't scale much.

> Seems like the test is now failing when you don't have an UTF-8 locale:
> 
>  LANG=C make check-qapi-schema
>  [...]
>  TEST    tests/qapi-schema/union-base-empty.out
>  --- /builds/huth/qemu/tests/qapi-schema/unicode-str.err	2019-05-03 15:21:39.000000000 +0000
>  +++ -	2019-05-03 15:42:01.561762978 +0000
>  @@ -1 +1 @@
>  -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name 'é'
>  +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '\xe9'
>  /builds/huth/qemu/tests/Makefile.include:1105: recipe for target 'check-tests/qapi-schema/unicode-str.json' failed
>  make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
> 
> Any ideas how to fix this?
> 
>  Thomas
> 
