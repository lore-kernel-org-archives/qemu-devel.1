Received: from eggs.gnu.org ([2001:4830:134:3::10]:56176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df3Re-0008RC-PD
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df3Rb-00036s-NK
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:17:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1df3Rb-00036P-Gq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:17:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  8 Aug 2017 14:17:01 +0200
Message-Id: <20170808121701.18353-2-cohuck@redhat.com>
In-Reply-To: <20170808121701.18353-1-cohuck@redhat.com>
References: <20170808121701.18353-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] 9pfs: fix and simplify dependencies
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

We want to compile the 9pfs code iff virtfs is enabled and a virtio
transport is available (not only pci!).

Let's make the generated CONFIG_VIRTFS statement depend on either
CONFIG_VIRTIO_PCI or (new) CONFIG_VIRTIO_CCW. The Makefiles for fsdev/
and hw/9pfs/ can then depend on CONFIG_VIRTFS directly.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 configure                         | 2 +-
 default-configs/s390x-softmmu.mak | 1 +
 fsdev/Makefile.objs               | 2 +-
 hw/Makefile.objs                  | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index dd73cce62f..709884dff1 100755
--- a/configure
+++ b/configure
@@ -5771,7 +5771,7 @@ if test "$libattr" = "yes" ; then
   echo "CONFIG_LIBATTR=y" >> $config_host_mak
 fi
 if test "$virtfs" = "yes" ; then
-  echo "CONFIG_VIRTFS=y" >> $config_host_mak
+  echo 'CONFIG_VIRTFS=$(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW))' >> $config_host_mak
 fi
 if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
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
index 659df6e187..604cc8b6c4 100644
--- a/fsdev/Makefile.objs
+++ b/fsdev/Makefile.objs
@@ -1,4 +1,4 @@
-ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
+ifeq ($(CONFIG_VIRTFS),y)
 # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
 # only pull in the actual virtio-9p device if we also enabled virtio.
 common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a2c61f6b09..147d1dc9fb 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,4 @@
-devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),$(CONFIG_PCI))) += 9pfs/
+devices-dirs-$(CONFIG_VIRTFS) += 9pfs/
 devices-dirs-$(CONFIG_SOFTMMU) += acpi/
 devices-dirs-$(CONFIG_SOFTMMU) += adc/
 devices-dirs-$(CONFIG_SOFTMMU) += audio/
-- 
2.13.4
