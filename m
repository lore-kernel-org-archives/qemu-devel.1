Received: from eggs.gnu.org ([2001:4830:134:3::10]:43601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cH6f1-0007pS-Tt
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cH6ew-0002GQ-Mf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:19:43 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cH6ew-0002GG-AI
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:19:38 -0500
Received: by mail-vk0-f48.google.com with SMTP id 137so21091689vkl.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 02:19:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161213211606.x4cssgt4knld4m4z@hawk.localdomain>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<20161213211606.x4cssgt4knld4m4z@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 10:18:17 +0000
Message-ID: <CAFEAcA9xBBaXVya6KY9DG1cFuu4vBd6KyuJ+3soZtc2V=gOnNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 00/23] arm: Add virtualization to GICv3,
 and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Christoffer Dall <christoffer.dall@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 13 December 2016 at 21:16, Andrew Jones <drjones@redhat.com> wrote:
> On Tue, Dec 13, 2016 at 10:36:01AM +0000, Peter Maydell wrote:
>> This patchset adds support for the Virtualization extensions to QEMU's
>> GICv3 emulation. This was the last missing piece that was stopping
>> us from turning on the EL2 support in the CPU model, so the patchset
>> also adds support for enabling it all on the virt board via the
>> '-machine virtualization=on' option.
>>
>> The result works well enough to allow booting a KVM outer guest kernel
>> and then running QEMU + an inner guest under KVM inside it. The outer
>> guest KVM also passes the kvm-unit-tests GIC tests.
>>
>
> I've started some testing with this. When I boot an outer (L1) kernel
> with more than one cpu allocated I get
>
> [    3.441908] CPU: CPUs started in inconsistent modes
> [    3.442787] ------------[ cut here ]------------
> [    3.445434] WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/smp.c:418 smp_cpus_done+0x80/0xa0
> ...
>
> and KVM does not init. Booting with only one cpu I see we do start in EL2
> and KVM does init. I'm booting the L1 kernel through UEFI (AAVMF). Also,
> my L1 guest kernel is 4.9 based, but not pure upstream. I can try a more
> pure 4.9 kernel with a defconfig later.

Yeah, I don't think I ever tried an SMP config in outer QEMU.
This seems like it would be a problem with the boot.c code rather than
the new GIC features, though... I'll have a look.

thanks
-- PMM
