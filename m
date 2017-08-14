Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhKbq-0005de-HQ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 15:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhKbp-0004tr-Gb
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 15:01:06 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dhKbp-0004r3-9S
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 15:01:05 -0400
Received: by mail-wm0-x241.google.com with SMTP id d40so15414624wma.3
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 12:01:05 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87valqw9x0.fsf@dusky.pond.sub.org>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<87valqw9x0.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 14 Aug 2017 12:00:33 -0700
Message-ID: <CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Aug 14, 2017 at 6:34 AM, Markus Armbruster <armbru@redhat.com> wrote:
> PATCH 3/5 has the exact same subject.  Why are the two separate?

You are right, that is a mess.

This one doesn't check for newlines at the end while the earlier one
checked for and removed new lines.

>
> Alistair Francis <alistair.francis@xilinx.com> writes:
>
>> Convert any remaining uses of fprintf(stderr, "warning:"...
>> to use warn_report() instead. This helps standardise on a single
>> method of printing warnings to the user.
>>
>> All of the warnings were changed using this command:
>>   find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|Ig' {} +
>>
>> The #include lines and chagnes to the test Makefile were manually
>
> changes

Fixed.

>
>> updated to allow the code to compile.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  tests/Makefile.include | 4 ++--
>>  util/cutils.c          | 3 ++-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 7af278db55..4886caf565 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -560,8 +560,8 @@ tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
>>  tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
>>  tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
>>  tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
>> -tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
>> -tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
>> +tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-qom-obj-y)
>> +tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-qom-obj-y)
>
> No.  What symbols exactly is the linker missing?

Without the change, this is the error I see when running make check:

  CC      tests/test-x86-cpuid.o
  LINK    tests/test-x86-cpuid
  GTESTER tests/test-x86-cpuid
  CC      tests/test-xbzrle.o
  LINK    tests/test-xbzrle
libqemustub.a(monitor.o): In function `monitor_get_fd':
/scratch/alistai/master-qemu/stubs/monitor.c:10: undefined reference
to `error_setg_internal'
collect2: error: ld returned 1 exit status
/scratch/alistai/master-qemu/rules.mak:121: recipe for target
'tests/test-xbzrle' failed
make: *** [tests/test-xbzrle] Error 1

If only the xbzrle change is made then I see this:

  LINK    tests/test-xbzrle
  GTESTER tests/test-xbzrle
  CC      tests/test-vmstate.o
  LINK    tests/test-vmstate
  GTESTER tests/test-vmstate
  CC      tests/test-cutils.o
  LINK    tests/test-cutils
util/cutils.o: In function `parse_debug_env':
/scratch/alistai/master-qemu/util/cutils.c:605: undefined reference to
`warn_report'
collect2: error: ld returned 1 exit status
/scratch/alistai/master-qemu/rules.mak:121: recipe for target
'tests/test-cutils' failed
make: *** [tests/test-cutils] Error 1

Thanks,
Alistair


>
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
>> @@ -601,7 +602,7 @@ int parse_debug_env(const char *name, int max, int initial)
>>          return initial;
>>      }
>>      if (debug < 0 || debug > max || errno != 0) {
>> -        fprintf(stderr, "warning: %s not in [0, %d]", name, max);
>> +        warn_report("%s not in [0, %d]", name, max);
>>          return initial;
>>      }
>>      return debug;
