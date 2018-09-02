Received: from eggs.gnu.org ([2001:4830:134:3::10]:39416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fwKVq-0007FV-4d
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 01:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fwKUi-0003Ic-De
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 01:00:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1fwKUi-0003Gz-77
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 01:00:16 -0400
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-5-git-send-email-wei@redhat.com>
	<CAFEAcA_ycC8=YnUBF+zUHcTnsCHTCzXG5M77mu2yAgunuEpapg@mail.gmail.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <c428a189-bdd3-c7f0-7ef0-3d5285e18cee@redhat.com>
Date: Sun, 2 Sep 2018 00:00:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ycC8=YnUBF+zUHcTnsCHTCzXG5M77mu2yAgunuEpapg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 4/4] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Andrew Jones <drjones@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>



On 09/01/2018 05:07 AM, Peter Maydell wrote:
> On 1 September 2018 at 06:11, Wei Huang <wei@redhat.com> wrote:
>> This patch adds migration test support for aarch64. The test code, which
>> implements the same functionality as x86, is booted as a kernel in qemu.
>> Here are the design choices we make for aarch64:
>>
>>  * We choose this -kernel approach because aarch64 QEMU doesn't provide a
>>    built-in fw like x86 does. So instead of relying on a boot loader, we
>>    use -kernel approach for aarch64.
>>  * The serial output is sent to PL011 directly.
>>  * The physical memory base for mach-virt machine is 0x40000000. We change
>>    the start_address and end_address for aarch64.
>>
>> In addition to providing the binary, this patch also includes the source
>> code and the build script in tests/migration/aarch64. So users can change
>> the source and/or re-compile the binary as they wish.
>> +    } else if (strcmp(arch, "aarch64") == 0) {
>> +        struct utsname utsname;
>> +
> 
> The comment says:
> 
>> +        /* kvm and tcg need different cpu and gic-version configs */
> 
> ...but the code below it doesn't change the cpu or gic-version
> based on 'accel'.

My bad. The code below can be removed.

> 
>> +        if (access("/dev/kvm", F_OK) == 0 && uname(&utsname) == 0 &&
>> +            strcmp(utsname.machine, "aarch64") == 0) {
>> +            accel = "kvm";
>> +        } else {
>> +            accel = "tcg";
>> +        }
> 
> Maybe we could just use -accel=kvm,tcg rather than guessing
> whether kvm is going to work ? If this is how the x86 code
> works then probably best to do the same as that, though.

Yes, "kvm,tcg" work work (I just verified with "tcg" only). I will
update the code after more comments are collected.

> 
>> +
>> +        init_bootfile(bootpath, aarch64_kernel);
>> +        cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
>> +                                  "-name vmsource,debug-threads=on -cpu max "
>> +                                  "-m 150M -serial file:%s/src_serial "
>> +                                  "-kernel %s ",
>> +                                  accel, tmpfs, bootpath);
>> +        cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
>> +                                  "-name vmdest,debug-threads=on -cpu max "
>> +                                  "-m 150M -serial file:%s/dest_serial "
>> +                                  "-kernel %s "
>> +                                  "-incoming %s ",
>> +                                  accel, tmpfs, bootpath, uri);
>> +
>> +        start_address = ARM_TEST_MEM_START;
>> +        end_address = ARM_TEST_MEM_END;
>> +
>> +        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
> 
> thanks
> -- PMM
> 
