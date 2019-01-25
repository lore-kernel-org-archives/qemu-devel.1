Received: from eggs.gnu.org ([209.51.188.92]:56513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzs6-0002xZ-U1
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzs5-00073f-PB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzs5-00070i-HI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id p7so9992492wru.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:04 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:47 +0100
Message-Id: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 0/8] i386/kvm/hyper-v: refactor and
 implement 'hv-stimer-direct' and 'hv-all' enlightenments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

The recently introduced Direct Mode for Hyper-V synthetic timers
enlightenment is only exposed through KVM_GET_SUPPORTED_HV_CPUID ioctl.
Take the opportunity and re-implement the way we handle Hyper-V
enlightenments in QEMU, add support for hv-stimer-direct and 'hv-all'
pass-through mode, add missing dependencies between enlightenments.

RFC: we could've been more conservative and only use
KVM_GET_SUPPORTED_HV_CPUID for new enlightenments. I'd also like to know
what you think about the 'pass-through' approach taken to implement
'hv-all' mode: we could've kept QEMU filling in signature, vendor,...
but we take CPUIDs passed by KVM 'as-is'.

Vitaly Kuznetsov (8):
  Update linux headers (5.0-rc2)
  i386/kvm: add support for KVM_GET_SUPPORTED_HV_CPUID
  i386/kvm: move Hyper-V CPUID filling to hyperv_handle_properties()
  i386/kvm: Implement 'hv-all' pass-through mode
  i386/kvm: hv-evmcs requires hv-vapic
  i386/kvm: hv-stimer requires hv-time and hv-synic
  i386/kvm: hv-tlbflush/ipi require hv-vpindex
  i386/kvm: add support for Direct Mode for Hyper-V synthetic timers

 include/standard-headers/drm/drm_fourcc.h     |   63 +
 include/standard-headers/linux/ethtool.h      |   19 +-
 .../linux/input-event-codes.h                 |   19 +
 include/standard-headers/linux/pci_regs.h     |    1 +
 .../standard-headers/linux/virtio_balloon.h   |    8 +
 include/standard-headers/linux/virtio_blk.h   |   54 +
 .../standard-headers/linux/virtio_config.h    |    3 +
 include/standard-headers/linux/virtio_gpu.h   |   18 +
 include/standard-headers/linux/virtio_ring.h  |   52 +
 linux-headers/asm-arm/unistd-common.h         |    1 +
 linux-headers/asm-arm64/unistd.h              |    1 +
 linux-headers/asm-generic/unistd.h            |   10 +-
 linux-headers/asm-mips/sgidefs.h              |    8 -
 linux-headers/asm-mips/unistd.h               | 1074 +----------------
 linux-headers/asm-mips/unistd_n64.h           |  334 +++++
 linux-headers/asm-mips/unistd_o32.h           |  374 ++++++
 linux-headers/asm-powerpc/unistd.h            |  389 +-----
 linux-headers/asm-powerpc/unistd_32.h         |  381 ++++++
 linux-headers/asm-powerpc/unistd_64.h         |  372 ++++++
 linux-headers/linux/kvm.h                     |   29 +
 linux-headers/linux/vfio.h                    |   92 ++
 linux-headers/linux/vhost.h                   |  113 +-
 linux-headers/linux/vhost_types.h             |  128 ++
 scripts/update-linux-headers.sh               |   10 +-
 target/i386/cpu.c                             |    2 +
 target/i386/cpu.h                             |    2 +
 target/i386/hyperv-proto.h                    |    1 +
 target/i386/kvm.c                             |  749 +++++++++---
 28 files changed, 2533 insertions(+), 1774 deletions(-)
 create mode 100644 linux-headers/asm-mips/unistd_n64.h
 create mode 100644 linux-headers/asm-mips/unistd_o32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_64.h
 create mode 100644 linux-headers/linux/vhost_types.h

-- 
2.20.1
