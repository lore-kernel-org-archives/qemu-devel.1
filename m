Received: from eggs.gnu.org ([2001:4830:134:3::10]:36729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGt-0008Go-Th
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGp-0005os-G7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSGp-0005oT-Ae
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:03 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  7 Jul 2017 14:21:52 +0200
Message-Id: <20170707122159.24714-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/7] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Current support of zPCI in qemu is still a bit sketchy. For example,
we're not actually advertising the pci cpu facilities to the guest,
and therefore a Linux guest will not even try to use any pci devices.
We're also still missing a proper SIC implementation.

This can lead to a situation where pci devices are configured for an
instance but the guest user is not able to make proper use of them.
In order to avoid such surprises, it makes sense to be able to configure
out pci support for s390x so that no pci devices show up in the list
of available devices.

This RFC patch set (also available at github.com/cohuck/qemu no-zpci) tries
to clean up some of the s390x pci intertwinings so that we can do a non-pci
build by simply removing 'CONFIG_PCI=y' from the default config. It also
removes a dependency on pci by kvm code, which is probably unintended (it
seems all kvm platforms also support pci).

Patch set is RFC as:
- I'm not sure whether my fencing is architecturally correct, as I don't
  have access to the respective documentation,
- I don't really like the #ifdeffery too much.

Cornelia Huck (7):
  kvm: remove hard dependency on pci
  s390x: chsc nt2 events are pci-only
  s390x/sclp: properly guard pci-specific functions
  s390x/ccw: create s390 phb conditionally
  s390x/pci: fence off instructions for non-pci
  s390x/kvm: msi route fixup for non-pci
  s390x: refine pci dependencies

 default-configs/s390x-softmmu.mak |  2 +-
 hw/pci/pci-stub.c                 | 12 ++++++++++++
 hw/s390x/Makefile.objs            |  2 +-
 hw/s390x/s390-pci-bus.c           |  4 ++--
 hw/s390x/s390-pci-bus.h           |  4 ++--
 hw/s390x/s390-virtio-ccw.c        |  9 +++++----
 hw/s390x/sclp.c                   | 17 ++++++++++++++---
 target/s390x/ioinst.c             | 18 ++++++++++++++++++
 target/s390x/kvm.c                | 28 ++++++++++++++++++++++++++++
 9 files changed, 83 insertions(+), 13 deletions(-)

-- 
2.13.0
