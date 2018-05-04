Received: from eggs.gnu.org ([2001:4830:134:3::10]:36039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEdaA-0002Sv-An
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEda9-0006Fs-0z
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:29:18 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEda8-0006EY-Su
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:29:16 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so13455964otf.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:29:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nG0_Eq1QWsCJMA6TKbZ_tf6mXWCVTrkxrFO5-UkmEvw@mail.gmail.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9nG0_Eq1QWsCJMA6TKbZ_tf6mXWCVTrkxrFO5-UkmEvw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 17:28:55 +0100
Message-ID: <CAFEAcA-6nkVOEBc59H0mcgnRy9ifPRoRjUrvJ_4Gcr94GdjuSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] arm: isolate and clean up dtb
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 3 May 2018 at 16:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 May 2018 at 13:08, Igor Mammedov <imammedo@redhat.com> wrote:
>>
>> Changelog v2->v3:
>>    * drop already merged patches
>>        'arm: always start from  first_cpu when registering loader cpu reset callback'
>>        'ppc: e500: switch E500 based  machines to full machine definition'
>>    * add small not related cleanup
>>        'arm: boot: set boot_info starting from first_cpu'
>>    * add extra suggested patch
>>        'make sure that we aren't overwriting mc->get_hotplug_handler by accident'
>>    * make sure that dtb_limit initialized to 0
>>    * drop stale comment
>>    * drop not needed line movement
>>    * drop not needed extra new line
>> Changelog v1->v2:
>>    * drop "arm: reuse  arm_boot_address_space() in armv7m_load_kernel()"
>>    * move "arm: always start from first_cpu  when registering loader cpu reset callback"
>>      at the begigning of series and rebase
>>    * add "ppc: e500: switch E500 based machines to full  machine definition"
>>      and rebase 4/5 on top of it
>>    * fixup typo in virt_machine_get_hotpug_handler() name
>>    * add doc comment to skip_dtb_autoload field
>>    * 1-2/5 are queued in respective arm/ppc trees and are included for series
>>      completness so it would be easier to test, I expect series to go through
>>      arm tree
>>
>
> Applied to target-arm.next, thanks.

Doing further testing within target-arm.next shows that this series (and
specifically patch 3/5) causes segfaults for the "no DTB provided" case.

$ gdb --args ./build/x86/arm-softmmu/qemu-system-arm -M vexpress-a15
-kernel /dev/null
GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1
[...]
(gdb) r
[...]
Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
(gdb) bt
#0  0x0000000000000000 in  ()
#1  0x000055555596565e in arm_load_dtb (addr=0, binfo=0x5555566dec00
<a15_daughterboard>, addr_limit=0, as=0x555556fa08a0) at
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/boot.c:515
#2  0x0000555555966d7f in arm_load_kernel (cpu=0x7ffff7fd6010,
info=0x5555566dec00 <a15_daughterboard>)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/boot.c:1156
#3  0x0000555555986f5b in vexpress_common_init (machine=0x555556e04060)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/vexpress.c:707
#4  0x0000555555b10341 in machine_run_board_init (machine=0x555556e04060)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/machine.c:829
#5  0x0000555555a4cbab in main (argc=5, argv=0x7fffffffe448,
envp=0x7fffffffe478)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/vl.c:4624

arm_load_dtb() is trying to call the binfo->get_dtb() hook and is not
handling the case where it is NULL (which it is on pretty much every
board except "virt").

(You get a segfault with an actual guest kernel as well; I just used
/dev/null here as an easy no-dependencies-required repro case.)

I've left patch 4 in target-arm.next as that was a standalone bugfix,
but have dropped the rest of the series for now.

thanks
-- PMM
