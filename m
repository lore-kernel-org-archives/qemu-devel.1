Received: from eggs.gnu.org ([2001:4830:134:3::10]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfLFB-0004qw-QZ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfLF6-0002Sv-MV
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:17:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfLF6-0002Sg-G9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:17:24 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  9 Aug 2017 09:17:18 +0200
Message-Id: <20170809071718.17924-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
on CONFIG_VIRTFS and on the presence of an appropriate virtio transport
device.

Let's introduce CONFIG_VIRTIO_CCW to cover s390x and check for
CONFIG_VIRTFS && (CONFIG_VIRTIO_PCI || CONFIG_VIRTIO_CCW).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Changes v1->v2: drop extraneous spaces, fix build on cris

---
 default-configs/s390x-softmmu.mak | 1 +
 fsdev/Makefile.objs               | 9 +++------
 hw/Makefile.objs                  | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 51191b77df..e4c5236ceb 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_S390_FLIC=y
 CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
 CONFIG_VFIO_CCW=$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=y
+CONFIG_VIRTIO_CCW=y
diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index 659df6e187..3d157add31 100644
--- a/fsdev/Makefile.objs
+++ b/fsdev/Makefile.objs
@@ -1,10 +1,7 @@
-ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
-# only pull in the actual virtio-9p device if we also enabled virtio.
-common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
-else
-common-obj-y = qemu-fsdev-dummy.o
-endif
+# only pull in the actual virtio-9p device if we also enabled a virtio backend.
+common-obj-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))= qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
+common-obj-$(call lnot,$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))) = qemu-fsdev-dummy.o
 common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
 
 # Toplevel always builds this; targets without virtio will put it in
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a2c61f6b09..335f26b65e 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,4 @@
-devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),$(CONFIG_PCI))) += 9pfs/
+devices-dirs-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW))) += 9pfs/
 devices-dirs-$(CONFIG_SOFTMMU) += acpi/
 devices-dirs-$(CONFIG_SOFTMMU) += adc/
 devices-dirs-$(CONFIG_SOFTMMU) += audio/
-- 
2.13.4
