Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcq0-0004Qt-T0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcpz-0005gM-Qe
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:52 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 20 Jun 2018 15:07:27 +0200
Message-Id: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 0/6] KVM/ARM: Dynamic and larger GPA size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com, suzuki.poulose@arm.com

At the moment the guest physical address space is limited to 40b
due to KVM limitations. [1] bumps this limitation and allows to
create a VM with up to 52b GPA address space.

With this series, QEMU creates a virt VM with the max IPA range
reported by the host kernel or 40b by default.

This choice can be overriden by using the -machine kvm-type=<bits>
option with bits within [40, 52]. If <bits> are not supported by
the host, the legacy 40b value is used.

It is an RFC as [1] is not upstream. This is not material for
QEMU 3.0 due to the kernel dependency. Also the EDK2 FW has a
fixed limit at 40b PA. Note at the moment there is no device or
RAM laid out after 1TB (40b) in virt machine model address space.
This will be addressed in a separate series.

Best Regards

Eric

kernel dependency:
[1] [PATCH v2 00/17] kvm: arm64: Dynamic & 52bit IPA support
https://lkml.org/lkml/2018/3/27/437
For testing, use my kernel branch:
https://github.com/eauger/linux/tree/4.16.0-rc3-Suzuki-52b-IPA-v2

This QEMU series can be found at:
https://github.com/eauger/qemu/tree/v2.12.0-ipa-rfc

Tests:
- On Cavium Gigabyte, a 48b VM was created.
- Migration tests were performed between kernel supporting the
  feature and destination kernel not suporting it

Eric Auger (6):
  linux-headers: Partial update for KVM/ARM
    KVM_ARM_GET_MAX_VM_PHYS_SHIFT
  hw/boards: Add a MachineState parameter to kvm_type callback
  kvm: add kvm_get_max_vm_phys_shift
  hw/arm/virt: Add virt-3.0 machine type
  hw/arm/virt: support kvm_type property
  hw/arm/virt: handle max_vm_phys_shift conflicts on migration

 accel/kvm/kvm-all.c           |   9 +++-
 accel/stubs/kvm-stub.c        |   5 +++
 hw/arm/virt.c                 | 102 +++++++++++++++++++++++++++++++++++++++---
 hw/ppc/mac_newworld.c         |   2 +-
 hw/ppc/mac_oldworld.c         |   2 +-
 hw/ppc/spapr.c                |   2 +-
 include/hw/arm/virt.h         |   3 ++
 include/hw/boards.h           |   2 +-
 include/sysemu/kvm.h          |   1 +
 linux-headers/asm-arm/kvm.h   |  15 -------
 linux-headers/asm-arm64/kvm.h |   6 ---
 linux-headers/linux/kvm.h     |   6 +++
 12 files changed, 124 insertions(+), 31 deletions(-)

-- 
2.5.5
