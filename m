Received: from eggs.gnu.org ([2001:4830:134:3::10]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cbfIH-0006jQ-Hl
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 22:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cbfID-0006yJ-Fm
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 22:21:13 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1cbfID-0006xz-5n
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 22:21:09 -0500
Received: by mail-pg0-x242.google.com with SMTP id 194so16572304pgd.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 19:21:07 -0800 (PST)
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <10156236-ffaa-4899-b0d9-89b6527e1122@ozlabs.ru>
Date: Thu, 9 Feb 2017 14:21:01 +1100
MIME-Version: 1.0
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] ISA 3.00 KVM guest support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 07/02/17 13:56, Sam Bobroff wrote:
> Because KVM will soon provide the necessary infrastructure for KVM guests to
> run on POWER9 CPUs, we can now start exploiting this new functionality from
> QEMU. See:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-January/153433.html
> 
> This work is not yet complete but it is functional and is presented for early
> review. It overlaps in some places with current work supporting the same guests
> under full emulation.
> 
> This set aims to support only the following scenarios:
> * A POWER9 host running in radix mode, running a guest in radix mode.
> * A POWER9 host running in hash mode, running a guest in hash mode.
> * A POWER9 host running in hash mode, running a guest in legacy(+) mode.
> (+) Where legacy means that the guest does not support ISA 3.00.
> 
> Hash or radix mode for the host is controlled via the "disable_radix" kernel
> command line parameter: the host will use radix unless disable_radix is given.
> For the guest it should be automatically selected to match the host.
> 
> Bad legacy guests: There are some recent kernels (e.g. 4.9) that will, when run
> as a KVM guest and if the ibm,pa-features entry in the device tree has the
> Radix MMU bit set, attempt to initialize the MMU as if they were a host (which
> will cause them to crash). To avoid exposing this problem, the Radix MMU bit
> is removed from ibm,pa-features when a legacy guest is detected.
> 
> Prerequsites:
> * This set is based on current QEMU master, but relies on some work already posted here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02527.html
> Specifically patches 1..4 which set up the new CPU and MMU models.


It would help if you pushed this as a tree with all prerequisites somewhere
(github?); same about the kernel which has bits which this patchset is
using. Thanks.


> 
> Notes:
>     * Migration/snapshots are not yet investigated.
>     * If the host cannot support the guest (e.g. radix host and a legacy guest)
>       then the guest will crash but QEMU should probably terminate with a
>       descriptive message.
> 
> 
> Sam Bobroff (9):
>   spapr: fix off-by-one error in spapr_ovec_populate_dt()
>   Update headers using update-linux-headers.sh
>   spapr: Add ibm,processor-radix-AP-encodings to the device tree
>   target-ppc: support KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
>   spapr: Only setup HTP if necessary.
>   spapr: Add h_register_process_table() hypercall
>   spapr: Set ISA 3.00 radix and hash bits in OV5
>   spapr: Advertise ISA 3.0 MMU features in pa_features
>   spapr: Small cleanup of PPC MMU enums
> 
>  hw/ppc/spapr.c                                     | 152 +++++---
>  hw/ppc/spapr_hcall.c                               |  52 ++-
>  hw/ppc/spapr_ovec.c                                |   2 +-
>  include/hw/ppc/spapr.h                             |   4 +-
>  include/hw/ppc/spapr_ovec.h                        |   6 +
>  include/standard-headers/linux/input-event-codes.h |   2 +-
>  include/standard-headers/linux/pci_regs.h          |   8 +
>  include/standard-headers/linux/virtio_ids.h        |   1 +
>  linux-headers/asm-arm/kvm.h                        |   2 +
>  linux-headers/asm-arm/unistd.h                     | 419 +--------------------
>  linux-headers/asm-powerpc/kvm.h                    |  25 ++
>  linux-headers/asm-powerpc/unistd.h                 |   1 +
>  linux-headers/asm-x86/kvm_para.h                   |   4 +-
>  linux-headers/linux/kvm.h                          |  11 +-
>  linux-headers/linux/vfio.h                         |  10 +
>  target/ppc/cpu-qom.h                               |  12 +-
>  target/ppc/cpu.h                                   |   5 +
>  target/ppc/kvm.c                                   |  66 +++-
>  target/ppc/kvm_ppc.h                               |  13 +
>  target/ppc/mmu-hash64.c                            |  10 +-
>  target/ppc/mmu_helper.c                            |  67 ++--
>  target/ppc/translate.c                             |  12 +-
>  22 files changed, 346 insertions(+), 538 deletions(-)
> 


-- 
Alexey
