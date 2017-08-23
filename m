Received: from eggs.gnu.org ([2001:4830:134:3::10]:36149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXzq-0005ZU-Es
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXzn-0000gO-DR
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkXzn-0000ep-7D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 23 Aug 2017 17:54:49 +0200
Message-Id: <20170823155458.19601-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/9] zpci detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Hopefully should be close now...

v4->v5:
- dropped "s390x/kvm: msi route fixup for non-pci"
- reworked "s390x/sclp: properly guard pci-specific functions": the
  configure/deconfigure stuff is about I/O adapters, we were missing
  checks, and I used an incorrect return code -- please review
- collected more r-bs

Cornelia Huck (9):
  9pfs: fix dependencies
  kvm: remove hard dependency on pci
  s390x/pci: add stubs
  s390x: chsc nt2 events are pci-only
  s390x/pci: do not advertise pci on non-pci builds
  s390x/ccw: create s390 phb conditionally
  s390x/sclp: properly guard pci-specific functions
  s390x/pci: fence off instructions for non-pci
  s390x: refine pci dependencies

 accel/kvm/kvm-all.c               |  6 ++--
 default-configs/s390x-softmmu.mak |  2 +-
 fsdev/Makefile.objs               |  9 ++---
 hw/9pfs/Makefile.objs             |  2 +-
 hw/Makefile.objs                  |  2 +-
 hw/pci/pci-stub.c                 | 16 ++++++++-
 hw/pci/pci.c                      |  2 ++
 hw/s390x/Makefile.objs            |  3 +-
 hw/s390x/s390-pci-bus.c           | 18 +++-------
 hw/s390x/s390-pci-bus.h           | 12 ++-----
 hw/s390x/s390-pci-stub.c          | 76 +++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c        | 14 ++++----
 hw/s390x/sclp.c                   | 39 +++++++++++++++++---
 include/hw/pci/pci.h              |  2 ++
 include/hw/s390x/sclp.h           | 17 ++++++---
 target/s390x/ioinst.c             | 16 +++++++++
 target/s390x/kvm.c                | 58 ++++++++++++++++++++++--------
 17 files changed, 227 insertions(+), 67 deletions(-)
 create mode 100644 hw/s390x/s390-pci-stub.c

-- 
2.13.5
