Received: from eggs.gnu.org ([2001:4830:134:3::10]:48818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1daPGY-0008MG-2l
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1daPGW-0000aS-9N
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:34:30 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1daPGW-0000YQ-2a
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:34:28 -0400
Received: by mail-wr0-x241.google.com with SMTP id y67so21706495wrb.3
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 09:34:27 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170726162858.GT7620@redhat.com>
References: <cover.1501084908.git.alistair.francis@xilinx.com>
	<0b0baf0b0f0132a615e20fb7944d7cecac23933a.1501084908.git.alistair.francis@xilinx.com>
	<20170726162858.GT7620@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 26 Jul 2017 09:33:56 -0700
Message-ID: <CAKmqyKNOB-FES0eghORkyvpHghu8J=EchXN9btx7ZBxa9Q9yEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jul 26, 2017 at 9:28 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Jul 26, 2017 at 09:07:59AM -0700, Alistair Francis wrote:
>> Convert any remaining uses of fprintf(stderr, "warning:"...
>> to use warn_report() instead. This helps standardise on a single
>> method of printing warnings to the user.
>>
>> All of the warnings were changed using this command:
>>   find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|Ig' {} +
>>
>> The #include lines and chagnes to the test Makefile were manually
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
> This doesn't look right to me - $(test-qom-obj-y) is the same as
> $(test-util-obj-y), but with $(qom-obj-y) added.  AFAIK, your
> warn_report function doesn't use any code from $(qom-obj-y), so
> we should not need to link to that. So I think there's something
> else going on here.

The problem I was seeing is that monitor_get_fd() is getting called in
stubs/monitor.c which then requires error_setg_internal() to be linked
in. Apparently this doesn't happen without this change as I kept
seeing linker errors.

Thanks,
Alistair

>
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
>> --
>> 2.11.0
>>
>>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
