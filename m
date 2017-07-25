Received: from eggs.gnu.org ([2001:4830:134:3::10]:52320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1da1qH-00005l-UJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1da1qD-0007xp-JS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1da1qD-0007xQ-DW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:33:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 17:33:21 +0200
Message-Id: <20170725153330.14966-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/9] s390x: zPCI detangling
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

Next version, now without RFC. The goals are still the same:
- Being able to disable PCI support in a build completely.
- Properly fencing off PCI if the relevant facility bit is not provided.

Changes v2->v3:
- Only enable the zpci bit conditionally, keep the aen bit always on.
  Use a method that actually works...
- Some reordering in the msi route patch to keep the change small.
- Collected some r-bs.

Branch is still git://github.com/cohuck/qemu no-zpci-cpumodel

Likely 2.11 material, even though the 'fence off if facility bit is not
set' part could count as bugfixes. Thoughts?

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

 default-configs/s390x-softmmu.mak |  2 +-
 hw/pci/pci-stub.c                 | 12 ++++++
 hw/s390x/Makefile.objs            |  3 +-
 hw/s390x/s390-pci-bus.c           |  9 ++++-
 hw/s390x/s390-pci-bus.h           |  5 ++-
 hw/s390x/s390-pci-stub.c          | 78 +++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c        | 12 +++---
 hw/s390x/sclp.c                   | 19 ++++++++--
 target/s390x/ioinst.c             | 16 ++++++++
 target/s390x/kvm.c                | 61 +++++++++++++++++++++++-------
 10 files changed, 188 insertions(+), 29 deletions(-)
 create mode 100644 hw/s390x/s390-pci-stub.c

-- 
2.13.3
