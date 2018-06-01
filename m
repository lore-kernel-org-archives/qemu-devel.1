Received: from eggs.gnu.org ([2001:4830:134:3::10]:38084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1fOf1y-0005G3-I3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1fOf1t-0002ZW-EW
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:03:26 -0400
Received: from mx.cs.uchicago.edu ([128.135.164.214]:56574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huaicheng@cs.uchicago.edu>)
	id 1fOf1t-0002Z2-6X
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:03:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx.cs.uchicago.edu (Postfix) with ESMTP id 32B196B879
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 03:03:20 -0500 (CDT)
Received: from mx.cs.uchicago.edu ([127.0.0.1])
	by localhost (mx.cs.uchicago.edu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6O_8k-7KEH4a for <qemu-devel@nongnu.org>;
	Fri,  1 Jun 2018 03:03:19 -0500 (CDT)
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
	[209.85.213.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.cs.uchicago.edu (Postfix) with ESMTPSA id 1DD4A6B86E
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 03:03:19 -0500 (CDT)
Received: by mail-vk0-f46.google.com with SMTP id e67-v6so14949464vke.7
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 01:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANr0WEeKL03vFNYh1Nfj8rNWv_F3hrjwXZJUk+pjySfePAKo9w@mail.gmail.com>
	<CAFEAcA_JudaxmJTqT262ioZWY_2J=+4Kkx4_ZwW3Gaa2D1YM8Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_JudaxmJTqT262ioZWY_2J=+4Kkx4_ZwW3Gaa2D1YM8Q@mail.gmail.com>
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Date: Fri, 1 Jun 2018 01:00:37 -0700
Message-ID: <CANr0WEeZCHbOjKNWJfpx2+ai_h97bgt-J-pLw5PYct7=jSG=fw@mail.gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

Hi Peter,

Thank you a lot for the analysis!

So it'll be simpler
> if you start with the buffer in the host QEMU process, map this
> in to the guest's physical address space at some GPA, tell the
> guest kernel that that's the GPA to use, and have the guest kernel
> map that GPA into the guest userspace process's virtual address space.
> (Think of how you would map a framebuffer, for instance.)


This makes sense to me. Could you help provide a pointer where I can refer
to similar implementations?
Should I do something like this during system memory initialization:

    memory_region_init_ram_ptr(my_mr, owner, "mybuf", buf_size, buf); //
where buf is the buffer in QEMU AS
    memory_region_add_subregion(system_memory, GPA_OFFSET, my_mr);

If I set guest memory to be "-m 1G", can I make "GPA_OFFSET" beyond 1GB
(e.g. 2GB)? This way, the guest OS
won't be able to access my buffer and use it like other regular RAM.

Thanks!

Best,
Huaicheng




On Thu, May 31, 2018 at 3:11 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 30 May 2018 at 01:24, Huaicheng Li <huaicheng@cs.uchicago.edu> wrote:
> > Dear QEMU/KVM developers,
> >
> > I was trying to map a buffer in host QEMU process to a guest user space
> > application. I tried to achieve this
> > by allocating a buffer in the guest application first, then map this
> buffer
> > to QEMU process address space via
> > GVA -> GPA --> HVA (GPA to HVA is done via cpu_physical_memory_map).
> Last,
> > I wrote a host kernel driver to
> > walk QEMU process's page table and change corresponding page table
> entries
> > of HVA to the HPA of the target
> > buffer.
>
> This seems like the wrong way round to try to do this. As a rule
> of thumb, you'll have an easier life if you have things behave
> similarly to how they would in real hardware. So it'll be simpler
> if you start with the buffer in the host QEMU process, map this
> in to the guest's physical address space at some GPA, tell the
> guest kernel that that's the GPA to use, and have the guest kernel
> map that GPA into the guest userspace process's virtual address space.
> (Think of how you would map a framebuffer, for instance.)
>
> Changing the host page table entries for QEMU under its feet seems
> like it's never going to work reliably.
>
> (I think the specific problem you're running into is that guest memory
> is both mapped into the QEMU host process and also exposed to the
> guest VM. The former is controlled by the page tables for the
> QEMU host process, but the latter is a different set of page tables,
> which QEMU asks the kernel to configure, using KVM_SET_USER_MEMORY_REGION
> ioctls.)
>
> thanks
> -- PMM
>
