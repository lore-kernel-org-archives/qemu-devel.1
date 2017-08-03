Received: from eggs.gnu.org ([2001:4830:134:3::10]:33390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ddIIW-0003hO-EC
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ddIIV-0005Px-FJ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:44:28 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ddIIV-0005OI-8u
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:44:27 -0400
Received: by mail-wr0-x242.google.com with SMTP id 12so1265140wrb.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 08:44:27 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <9cf48d75-16da-9d54-5215-fda002f1f863@amsat.org>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<9cf48d75-16da-9d54-5215-fda002f1f863@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 3 Aug 2017 08:43:55 -0700
Message-ID: <CAKmqyKOpuCL06cC=v-8NQaTQvDs2fmAAcmMmoLbfE4pYKDh=JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Fri, Jul 28, 2017 at 4:57 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Alistair,
>
> On 07/28/2017 07:16 PM, Alistair Francis wrote:
>>
>> Convert any remaining uses of fprintf(stderr, "warning:"...
>> to use warn_report() instead. This helps standardise on a single
>> method of printing warnings to the user.
>>
>> All of the warnings were changed using this command:
>>    find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:]
>> |warn_report("|Ig' {} +
>>
>> The #include lines and chagnes to the test Makefile were manually
>> updated to allow the code to compile.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>   tests/Makefile.include | 4 ++--
>>   util/cutils.c          | 3 ++-
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 7af278db55..4886caf565 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -560,8 +560,8 @@ tests/test-thread-pool$(EXESUF):
>> tests/test-thread-pool.o $(test-block-obj-y)
>>   tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
>>   tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
>> $(test-crypto-obj-y)
>>   tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
>> -tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o
>> migration/page_cache.o $(test-util-obj-y)
>> +tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o
>> migration/page_cache.o $(test-qom-obj-y)
>
>
> I don't understand what was not working in the previous line.
>
>> -tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
>> +tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
>> $(test-qom-obj-y)
>
>
> Here adding $(util-obj-y) should be enough.
>
> But I did not test it :P

I didn't understand it either. It is possible I was doing something
really wrong, but I couldn't get it to work otherwise.

Thanks,
Alistair

>
> Regards,
>
> Phil.
>
>
>>   tests/test-int128$(EXESUF): tests/test-int128.o
>>   tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
>>   tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 1534682083..b33ede83d1 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -30,6 +30,7 @@
>>   #include "qemu/iov.h"
>>   #include "net/net.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>     void strpadcpy(char *buf, int buf_size, const char *str, char pad)
>>   {
>> @@ -601,7 +602,7 @@ int parse_debug_env(const char *name, int max, int
>> initial)
>>           return initial;
>>       }
>>       if (debug < 0 || debug > max || errno !=3D 0) {
>> -        fprintf(stderr, "warning: %s not in [0, %d]", name, max);
>> +        warn_report("%s not in [0, %d]", name, max);
>>           return initial;
>>       }
>>       return debug;
>>
>
