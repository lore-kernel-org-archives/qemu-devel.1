Received: from eggs.gnu.org ([2001:4830:134:3::10]:32801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKY6-0001RP-GY
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKY5-0003C3-GG
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:11:14 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOKY5-0003BZ-5v
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:11:13 -0400
Received: by mail-ot0-x242.google.com with SMTP id 101-v6so2191894oth.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:11:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANr0WEeKL03vFNYh1Nfj8rNWv_F3hrjwXZJUk+pjySfePAKo9w@mail.gmail.com>
References: <CANr0WEeKL03vFNYh1Nfj8rNWv_F3hrjwXZJUk+pjySfePAKo9w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 11:10:52 +0100
Message-ID: <CAFEAcA_JudaxmJTqT262ioZWY_2J=+4Kkx4_ZwW3Gaa2D1YM8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] About cpu_physical_memory_map()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Huaicheng Li <huaicheng@cs.uchicago.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>

On 30 May 2018 at 01:24, Huaicheng Li <huaicheng@cs.uchicago.edu> wrote:
> Dear QEMU/KVM developers,
>
> I was trying to map a buffer in host QEMU process to a guest user space
> application. I tried to achieve this
> by allocating a buffer in the guest application first, then map this buffer
> to QEMU process address space via
> GVA -> GPA --> HVA (GPA to HVA is done via cpu_physical_memory_map). Last,
> I wrote a host kernel driver to
> walk QEMU process's page table and change corresponding page table entries
> of HVA to the HPA of the target
> buffer.

This seems like the wrong way round to try to do this. As a rule
of thumb, you'll have an easier life if you have things behave
similarly to how they would in real hardware. So it'll be simpler
if you start with the buffer in the host QEMU process, map this
in to the guest's physical address space at some GPA, tell the
guest kernel that that's the GPA to use, and have the guest kernel
map that GPA into the guest userspace process's virtual address space.
(Think of how you would map a framebuffer, for instance.)

Changing the host page table entries for QEMU under its feet seems
like it's never going to work reliably.

(I think the specific problem you're running into is that guest memory
is both mapped into the QEMU host process and also exposed to the
guest VM. The former is controlled by the page tables for the
QEMU host process, but the latter is a different set of page tables,
which QEMU asks the kernel to configure, using KVM_SET_USER_MEMORY_REGION
ioctls.)

thanks
-- PMM
