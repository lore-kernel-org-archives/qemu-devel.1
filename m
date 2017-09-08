Received: from eggs.gnu.org ([2001:4830:134:3::10]:46231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dqMJO-0005LV-Qy
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dqMJN-0006BQ-PO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:39:22 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dqMJN-0006AJ-I2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:39:21 -0400
Received: by mail-wm0-x243.google.com with SMTP id l19so2091935wmi.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 09:39:21 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87377xilxw.fsf@dusky.pond.sub.org>
References: <cover.1504228916.git.alistair.francis@xilinx.com>
	<852ce10cbd36276fe5207539cd2dcd77aac6c938.1504228916.git.alistair.francis@xilinx.com>
	<87377xilxw.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 8 Sep 2017 09:38:49 -0700
Message-ID: <CAKmqyKO8=xFjPPOk29ChBXrQYpFw_Q7f1xLbdEJf8ZO7NC1uAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] Convert remaining single line
 fprintf() to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Sep 8, 2017 at 2:22 AM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Alistair Francis <alistair.francis@xilinx.com> writes:
>
>> Convert any remaining uses of fprintf(stderr, "warning:"...
>> to use warn_report() instead. This helps standardise on a single
>> method of printing warnings to the user.
>>
>> All of the warnings were changed using this command:
>>   find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report=
("|Ig' {} +
>>
>> The #include line and the chagne to the test Makefile were manually
>
> s/chagne/change/
>
>> updated to allow the code to compile.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>
>> This pattern matches any case of fprintf(stderr, "warning:"... and is
>> the most open pattern match in the series.
>>
>>
>>  tests/Makefile.include | 2 +-
>>  util/cutils.c          | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 80527a8763..91d5a4544f 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -584,7 +584,7 @@ tests/test-iov$(EXESUF): tests/test-iov.o $(test-uti=
l-obj-y)
>>  tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(=
test-crypto-obj-y)
>>  tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
>>  tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migr=
ation/page_cache.o $(test-util-obj-y)
>> -tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
>> +tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-ut=
il-obj-y)
>>  tests/test-int128$(EXESUF): tests/test-int128.o
>>  tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
>>  tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 1534682083..b33ede83d1 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -30,6 +30,7 @@
>>  #include "qemu/iov.h"
>>  #include "net/net.h"
>>  #include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>
>>  void strpadcpy(char *buf, int buf_size, const char *str, char pad)
>>  {
>> @@ -601,7 +602,7 @@ int parse_debug_env(const char *name, int max, int i=
nitial)
>>          return initial;
>>      }
>>      if (debug < 0 || debug > max || errno !=3D 0) {
>> -        fprintf(stderr, "warning: %s not in [0, %d]", name, max);
>> +        warn_report("%s not in [0, %d]", name, max);
>>          return initial;
>>      }
>>      return debug;
>
> Just one?  That's a bit of an anti-climax after the commit message :)
>
> I don't understand why this can't be in PATCH 3 (of course PATCH 6 has
> to go before 3 then).  Not important.

Patch 3 was replacing the original fprintf(...\n) by removing the
newline as error_report() shouldn't have a new line. This case there
was no existing newline in the print so the regex expression was just
looking for any fprintf(.... Apparently there is only one case of
that.

Thanks,
Alistair

>
> With the commit message typo fixed:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
