Received: from eggs.gnu.org ([2001:4830:134:3::10]:34348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVx7r-0000Bx-1U
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVx7n-000139-U5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:43:07 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVx7n-00012f-Nk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:43:03 -0400
Received: by mail-wr0-f181.google.com with SMTP id 77so64816274wrb.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:43:03 -0700 (PDT)
References: <20170714021509.23681-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72a57684-fcbe-6096-32c6-6dfe19804667@redhat.com>
Date: Fri, 14 Jul 2017 11:42:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/20] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

On 14/07/2017 04:14, Fam Zheng wrote:
> v4: Add a pointer type param to DEFINE_PROP_LINK, don't change pointer types to
>     "Object *". [Paolo]
> 
> v3: Include Igor's patch, and fix virtio-crypto too.
>     Always use qdev_prop_allow_set_link_before_realize and
>     OBJ_PROP_LINK_UNREF_ON_RELEASE.
>     Include as many applicable devices as possible and some more clean-ups.
>     There are still more left but they use uncommon check and flags parameters,
>     it's better to take care of them in following batches.
> 
> v2: Create a new header for link properties. [Paolo]
>     Don't wrap, use PropertyInfo.create() (much better diffstat, yay!).
>     [Paolo]
> 
> Link properties of devices created with object_property_add_link() are not
> reflected in HMP "info qtree". For example, whether a virtio-blk device has an
> iothread (i.e. has enabled data plane) can not be introspected easily.
> 
> Introduce a new type of qdev property macro to fix that.
> 
> Fam Zheng (19):
>   qdev: Introduce PropertyInfo.create
>   qdev: Introduce DEFINE_PROP_LINK
>   qmp: Use ObjectProperty.type if present
>   qdev: Add const qualifier to PropertyInfo definitions
>   virtio-blk: Convert to DEFINE_PROP_LINK
>   virtio-scsi: Convert to DEFINE_PROP_LINK
>   virtio-rng: Convert to DEFINE_PROP_LINK
>   virtio-crypto: Convert to DEFINE_PROP_LINK
>   dimm: Convert to DEFINE_PROP_LINK
>   ivshmem: Convert to DEFINE_PROP_LINK
>   armv7m: Convert bitband.source-mamory to DEFINE_PROP_LINK
>   armv7m: Convert armv7m.memory to DEFINE_PROP_LINK
>   gicv3: Convert to DEFINE_PROP_LINK
>   xlnx_zynqmp: Convert to DEFINE_PROP_LINK
>   xilinx_axienet: Convert to DEFINE_PROP_LINK
>   xilinx_axidma: Convert to DEFINE_PROP_LINK
>   mips_cmgcr: Convert to DEFINE_PROP_LINK
>   cpu: Convert to DEFINE_PROP_LINK
>   spapr_rng: Convert to DEFINE_PROP_LINK
> 
> Igor Mammedov (1):
>   qom: enforce readonly nature of link's check callback
> 
>  exec.c                           | 27 +++++++++--------
>  hw/arm/armv7m.c                  | 16 +++-------
>  hw/arm/xlnx-zynqmp.c             |  7 ++---
>  hw/block/virtio-blk.c            |  6 ++--
>  hw/core/qdev-properties-system.c |  8 ++---
>  hw/core/qdev-properties.c        | 63 ++++++++++++++++++++++++++--------------
>  hw/core/qdev.c                   | 31 ++++++++++++--------
>  hw/display/xlnx_dp.c             |  2 +-
>  hw/dma/xilinx_axidma.c           | 16 +++-------
>  hw/intc/arm_gicv3_its_kvm.c      | 19 +++++-------
>  hw/ipmi/ipmi.c                   |  2 +-
>  hw/mem/pc-dimm.c                 | 30 +++++--------------
>  hw/misc/ivshmem.c                | 24 +++++----------
>  hw/misc/mips_cmgcr.c             | 16 +++-------
>  hw/net/xilinx_axienet.c          | 16 +++-------
>  hw/ppc/spapr_rng.c               |  8 ++---
>  hw/s390x/css.c                   |  4 +--
>  hw/s390x/s390-pci-bus.c          |  2 +-
>  hw/s390x/virtio-ccw.c            |  9 ------
>  hw/scsi/virtio-scsi.c            | 13 ++-------
>  hw/virtio/virtio-crypto-pci.c    |  2 --
>  hw/virtio/virtio-crypto.c        | 27 +++++------------
>  hw/virtio/virtio-pci.c           |  6 ----
>  hw/virtio/virtio-rng.c           | 12 +-------
>  include/hw/qdev-core.h           |  6 ++--
>  include/hw/qdev-properties.h     | 62 ++++++++++++++++++++++-----------------
>  include/hw/s390x/css.h           |  4 +--
>  include/qom/cpu.h                |  1 +
>  include/qom/object.h             |  6 ++--
>  qmp.c                            |  5 ++--
>  qom/cpu.c                        |  1 +
>  qom/object.c                     |  8 ++---
>  target/i386/cpu.c                |  2 +-
>  target/ppc/translate_init.c      |  2 +-
>  34 files changed, 193 insertions(+), 270 deletions(-)
> 

I'm leaving the ARM patches to Peter and respinning my pull request with
the others.

Thanks,

Paolo
