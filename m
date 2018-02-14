Received: from eggs.gnu.org ([2001:4830:134:3::10]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1elpkJ-0007QV-RL
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 00:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1elpkH-0000eH-3j
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 00:36:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46548 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1elpkG-0000dp-U0
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 00:36:41 -0500
Date: Wed, 14 Feb 2018 13:36:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180214053626.GJ4472@xz-mi>
References: <CAHyh4xiTDwB2xG_bg00bMA0042yTRq7-dJ-+y3muR+=9N3Vx-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xiTDwB2xG_bg00bMA0042yTRq7-dJ-+y3muR+=9N3Vx-g@mail.gmail.com>
Subject: Re: [Qemu-devel] Assigning network devices to nested VMs results in
 driver errors in nested VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, vfio-users@redhat.com

On Tue, Feb 13, 2018 at 11:44:09PM -0500, Jintack Lim wrote:
> Hi,
> 
> I'm trying to assign network devices to nested VMs on x86 using KVM,
> but I got network device driver errors in the nested VMs. (I've tried
> this about an year ago when vIOMMU patches were not upstreamed, and I
> got similar errors at that time.)
> 
> This could be network driver issues, but I'd like to get some help if
> somebody encountered similar issues.
> 
> I'm using v4.15.0 kernel and v2.11.0 QEMU, and I followed this [1]
> guide. I had no problem with assigning devices to the first level VMs
> (L1 VMs). And I also checked that the devices were assigned to nested
> VMs with the lspci command in the nested VMs. But network device
> drivers failed to initialize the device. I tried two network cards -
> Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection and
> Mellanox Technologies MT27500 Family.
> 
> Intel driver error in the nested VM looks like this.
> [    1.939552] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
> version 5.1.0-k
> [    1.949796] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [    2.210024] ixgbe 0000:00:04.0: HW Init failed: -12
> [    2.218144] ixgbe: probe of 0000:00:04.0 failed with error -12
> 
> and I saw lots of these messages in the host (L0) kernel log when
> booting the nested VM.
> 
> [ 1557.404173] DMAR: DRHD: handling fault status reg 102
> [ 1557.409813] DMAR: [DMA Read] Request device [06:00.0] fault addr
> 90000 [fault reason 06] PTE Read access is not set
> [ 1561.383957] DMAR: DRHD: handling fault status reg 202
> [ 1561.389598] DMAR: [DMA Read] Request device [06:00.0] fault addr
> 90000 [fault reason 06] PTE Read access is not set
> 
> This is Mellanox driver error in another nested VM.
> [    2.481694] mlx4_core: Initializing 0000:00:04.0
> [    3.519422] mlx4_core 0000:00:04.0: Installed FW has unsupported
> command interface revision 0
> [    3.537769] mlx4_core 0000:00:04.0: (Installed FW version is 0.0.000)
> [    3.551733] mlx4_core 0000:00:04.0: This driver version supports
> only revisions 2 to 3
> [    3.568758] mlx4_core 0000:00:04.0: QUERY_FW command failed, aborting
> [    3.582789] mlx4_core 0000:00:04.0: Failed to init fw, aborting.
> 
> The host showed similar messages as above.
> 
> I wonder what could be the cause of these errors. Please let me know
> if further information is needed.
> 
> [1] https://wiki.qemu.org/Features/VT-d

Hi, Jintack,

Thanks for reporting the problem.

I haven't been playing with nested assignment much recently (and even
before), but I think I encountered similar problem too in the past.

Will let you know if I had any progress, but it's possibly not gonna
happen in a few days since there'll be a whole week holiday starting
from tomorrow (which is Chinese Spring Festival).

-- 
Peter Xu
