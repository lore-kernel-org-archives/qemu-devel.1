Received: from eggs.gnu.org ([2001:4830:134:3::10]:35328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dddfc-0001Tv-6L
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddani-0003Iu-PS
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddani-0003H4-Hf
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:29:54 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 Aug 2017 13:29:37 +0200
Message-Id: <20170804112946.5247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Next version, not so many changes from v3.

As you might have guessed, the goals are still the same:
- Being able to disable PCI support in a build completely.
- Properly fencing off PCI if the relevant facility bit is not provided.

Changes v3->v4:
- introduce pci_available boolean
- use pci_available to fence off setting the zcpi facility bit
- collected tags

Branch is still git://github.com/cohuck/qemu no-zpci-cpumodel

Cornelia Huck (9):
  kvm: remove hard dependency on pci
  s390x/pci: add stubs
  s390x: chsc nt2 events are pci-only
  s390x/pci: do not advertise pci on non-pci builds
  s390x/ccw: create s390 phb conditionally
  s390x/sclp: properly guard pci-specific functions
  s390x/pci: fence off instructions for non-pci
  s390x/kvm: msi route fixup for non-pci
  s390x: refine pci dependencies

 accel/kvm/kvm-all.c               |  6 ++--
 default-configs/s390x-softmmu.mak |  2 +-
 hw/pci/pci-stub.c                 | 13 +++++++
 hw/pci/pci.c                      |  2 ++
 hw/s390x/Makefile.objs            |  3 +-
 hw/s390x/s390-pci-bus.c           |  4 +--
 hw/s390x/s390-pci-bus.h           |  4 +--
 hw/s390x/s390-pci-stub.c          | 74 +++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c        | 12 ++++---
 hw/s390x/sclp.c                   | 19 +++++++---
 include/hw/pci/pci.h              |  2 ++
 target/s390x/ioinst.c             | 16 +++++++++
 target/s390x/kvm.c                | 64 +++++++++++++++++++++++++--------
 13 files changed, 189 insertions(+), 32 deletions(-)
 create mode 100644 hw/s390x/s390-pci-stub.c

-- 
2.13.3
