Received: from eggs.gnu.org ([2001:4830:134:3::10]:38582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eqNQJ-0000En-1u
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eqNQE-0007vw-2T
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:22:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1eqNQD-0007vj-NU
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:22:45 -0500
References: <20180222044417.15561-1-wei@redhat.com>
	<20180222044417.15561-4-wei@redhat.com>
	<20180222090012.mtwfbrbi3gayedcp@kamzik.brq.redhat.com>
	<3654e260-0dd6-04ed-7284-c17b78788dc1@redhat.com>
	<20180226090304.f6fzetytwp3ta7rr@kamzik.brq.redhat.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <0d9cdc7b-211c-89ab-c301-814357c1a3c0@redhat.com>
Date: Mon, 26 Feb 2018 12:22:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180226090304.f6fzetytwp3ta7rr@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 3/3] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com



On 02/26/2018 03:03 AM, Andrew Jones wrote:
> On Fri, Feb 23, 2018 at 04:13:08PM -0600, Wei Huang wrote:
>>
>>
>> On 02/22/2018 03:00 AM, Andrew Jones wrote:
>>> On Wed, Feb 21, 2018 at 10:44:17PM -0600, Wei Huang wrote:
>>>> This patch adds migration test support for aarch64. The test code, which
>>>> implements the same functionality as x86, is booted as a kernel in qemu.
>>>> Here are the design choices we make for aarch64:
>>>>
>>>>  * We choose this -kernel approach because aarch64 QEMU doesn't provide a
>>>>    built-in fw like x86 does. So instead of relying on a boot loader, we
>>>>    use -kernel approach for aarch64.
>>>>  * The serial output is sent to PL011 directly.
>>>>  * The physical memory base for mach-virt machine is 0x40000000. We change
>>>>    the start_address and end_address for aarch64.
>>>>
>>>> In addition to providing the binary, this patch also includes the source
>>>> code and the build script in tests/migration/. So users can change the
>>>> source and/or re-compile the binary as they wish.
>>>>
>>>> Signed-off-by: Wei Huang <wei@redhat.com>
>>>> ---
>>>>  tests/Makefile.include               |  1 +
>>>>  tests/migration-test.c               | 47 +++++++++++++++++++++---
>>>>  tests/migration/Makefile             | 12 +++++-
>>>>  tests/migration/aarch64-a-b-kernel.S | 71 ++++++++++++++++++++++++++++++++++++
>>>>  tests/migration/aarch64-a-b-kernel.h | 19 ++++++++++
>>>>  tests/migration/migration-test.h     |  5 +++
>>>>  6 files changed, 147 insertions(+), 8 deletions(-)
>>>>  create mode 100644 tests/migration/aarch64-a-b-kernel.S
>>>>  create mode 100644 tests/migration/aarch64-a-b-kernel.h
>>>>
>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>> index a1bcbffe12..df9f64438f 100644
>>>> --- a/tests/Makefile.include
>>>> +++ b/tests/Makefile.include
>>>> @@ -372,6 +372,7 @@ check-qtest-arm-y += tests/sdhci-test$(EXESUF)
>>>>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>>>>  check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
>>>>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
>>>> +check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>>>>  
>>>>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
>>>>  
>>>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>>>> index e2e06ed337..a4f6732a59 100644
>>>> --- a/tests/migration-test.c
>>>> +++ b/tests/migration-test.c
>>>> @@ -11,6 +11,7 @@
>>>>   */
>>>>  
>>>>  #include "qemu/osdep.h"
>>>> +#include <sys/utsname.h>
>>>>  
>>>>  #include "libqtest.h"
>>>>  #include "qapi/qmp/qdict.h"
>>>> @@ -23,8 +24,8 @@
>>>>  
>>>>  #include "migration/migration-test.h"
>>>>  
>>>> -const unsigned start_address = TEST_MEM_START;
>>>> -const unsigned end_address = TEST_MEM_END;
>>>> +unsigned start_address = TEST_MEM_START;
>>>> +unsigned end_address = TEST_MEM_END;
>>>>  bool got_stop;
>>>>  
>>>>  #if defined(__linux__)
>>>> @@ -81,12 +82,13 @@ static const char *tmpfs;
>>>>   * outputting a 'B' every so often if it's still running.
>>>>   */
>>>>  #include "tests/migration/x86-a-b-bootblock.h"
>>>> +#include "tests/migration/aarch64-a-b-kernel.h"
>>>>  
>>>> -static void init_bootfile_x86(const char *bootpath)
>>>> +static void init_bootfile(const char *bootpath, void *content)
>>>>  {
>>>>      FILE *bootfile = fopen(bootpath, "wb");
>>>>  
>>>> -    g_assert_cmpint(fwrite(x86_bootsect, 512, 1, bootfile), ==, 1);
>>>> +    g_assert_cmpint(fwrite(content, 512, 1, bootfile), ==, 1);
>>>>      fclose(bootfile);
>>>>  }
>>>>  
>>>> @@ -393,7 +395,7 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>>>>      got_stop = false;
>>>>  
>>>>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>>> -        init_bootfile_x86(bootpath);
>>>> +        init_bootfile(bootpath, x86_bootsect);
>>>>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>>>>                                    " -name source,debug-threads=on"
>>>>                                    " -serial file:%s/src_serial"
>>>> @@ -422,6 +424,39 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>>>>                                    " -serial file:%s/dest_serial"
>>>>                                    " -incoming %s",
>>>>                                    accel, tmpfs, uri);
>>>> +    } else if (strcmp(arch, "aarch64") == 0) {
>>>> +        const char *cpu;
>>>> +        const char *gic_ver;
>>>> +        struct utsname utsname;
>>>> +
>>>> +        /* kvm and tcg need different cpu and gic-version configs */
>>>> +        if (access("/dev/kvm", F_OK) == 0 && uname(&utsname) == 0 &&
>>>> +            strcmp(utsname.machine, "aarch64") == 0) {
>>>> +            accel = "kvm";
>>>> +            cpu = "host";
>>>> +            gic_ver = "host";
>>>> +        } else {
>>>> +            accel = "tcg";
>>>> +            cpu = "cortex-a57";
>>>> +            gic_ver = "2";
>>>> +        }
>>>> +
>>>> +        init_bootfile(bootpath, aarch64_kernel);
>>>> +        cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=%s "
>>>> +                                  "-name vmsource,debug-threads=on -cpu %s "
>>>> +                                  "-m 150M -serial file:%s/src_serial "
>>>> +                                  "-kernel %s ",
>>>> +                                  accel, gic_ver, cpu, tmpfs, bootpath);
>>>> +        cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=%s "
>>>> +                                  "-name vmdest,debug-threads=on -cpu %s "
>>>> +                                  "-m 150M -serial file:%s/dest_serial "
>>>> +                                  "-kernel %s "
>>>> +                                  "-incoming %s ",
>>>> +                                  accel, gic_ver, cpu, tmpfs, bootpath, uri);
>>>> +
>>>> +        /* aarch64 virt machine physical memory starts at 0x40000000 */
>>>> +        start_address = ARM_TEST_MEM_START;
>>>> +        end_address = ARM_TEST_MEM_END;
>>>>      } else {
>>>>          g_assert_not_reached();
>>>>      }
>>>> @@ -506,7 +541,7 @@ static void test_deprecated(void)
>>>>  {
>>>>      QTestState *from;
>>>>  
>>>> -    from = qtest_start("");
>>>> +    from = qtest_start("-machine none");
>>>>  
>>>>      deprecated_set_downtime(from, 0.12345);
>>>>      deprecated_set_speed(from, "12345");
>>>> diff --git a/tests/migration/Makefile b/tests/migration/Makefile
>>>> index b768d0729d..b72d41367f 100644
>>>> --- a/tests/migration/Makefile
>>>> +++ b/tests/migration/Makefile
>>>> @@ -15,6 +15,7 @@ cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call cross-ld,$(1)))))
>>>>  find-cross-prefix = $(subst gcc,,$(notdir $(call cross-gcc,$(1))))
>>>>  
>>>>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
>>>> +aarch64_cross_prefix := $(call find-cross-prefix,aarch64)
>>>>  
>>>>  export __note
>>>>  override define __note
>>>> @@ -25,7 +26,7 @@ override define __note
>>>>   */
>>>>  endef
>>>>  
>>>> -all: x86-a-b-bootblock.h
>>>> +all: x86-a-b-bootblock.h aarch64-a-b-kernel.h
>>>>  
>>>>  x86-a-b-bootblock.h: x86-a-b-bootblock.S
>>>>  	$(x86_64_cross_prefix)gcc -m32 -march=i486 -c $< -o x86.o
>>>> @@ -34,5 +35,12 @@ x86-a-b-bootblock.h: x86-a-b-bootblock.S
>>>>  	echo "$$__note" > $@
>>>>  	xxd -i x86.bootsect | sed -e 's/.*int.*//' >> $@
>>>>  
>>>> +aarch64-a-b-kernel.h: aarch64-a-b-kernel.S
>>>> +	$(aarch64_cross_prefix)gcc -o aarch64.elf -nostdlib \
>>>> +		-Wl,--build-id=none,-Ttext=40080000 $<
>>>
>>> Adding the arm64 Linux kernel offset here is a bit subtle. And, since the
>>> TEST_MEM_START is at 1M, that only leaves 512K for test code and data.
>>> I think you may want to define this offset somewhere, making it less
>>> subtle, and then also factor it in when computing the test mem start.
>>
>> I have fixed most parts based on your review comments, except for this
>> one. I think the section address, -Ttext=, doesn't matter in this case.
>> Such info is not present aarch64.kernel; plus QEMU loads the kernel into
> 
> In this case it doesn't matter because your code only uses pc-relative
> addresses. It's pretty safe to assume the compiler will only emit pc-
> relative addresses for code like this, so that's probably fine.
> 
>> the loader_start address, which is the physical memory base (0x40000000,
>> see virt.c). So the space to store kernel binary is 1MB, which should be
>> large enough to prevent aarch64-a-b-kernel.S from changing code.
> 
> No, it loads the kernel at 0x40000000 + 0x80000, see
> hw/arm/boot.c:load_aarch64_image() and KERNEL64_LOAD_ADDR.
> 
>>
>> Anyway I think we are fine to remove "-Ttext=40080000" here.
> 
> Fine by me, but you might want to add a comment saying the code *must*
> only compile to using pc-relative addresses.

I think all ARM label-based branches are PC-relative (see
https://community.arm.com/processors/b/blog/posts/branch-and-call-sequences-explained).
So compilers aren't supposed to change this semantic. Anyway I just sent
a new version. It adds comments about compiler requirements.

> 
> Thanks,
> drew
> 
