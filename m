Received: from eggs.gnu.org ([2001:4830:134:3::10]:56780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FW-0001vM-05
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FV-0005Em-1O
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6FU-0005Ed-R9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:21 +0200
Message-Id: <20170830165252.13421-14-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/44] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
on CONFIG_VIRTFS and CONFIG_VIRTIO/CONFIG_XEN only.

Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 fsdev/Makefile.objs   | 9 +++------
 hw/9pfs/Makefile.objs | 2 +-
 hw/Makefile.objs      | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index 659df6e187..fb38017c0b 100644
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
+# only pull in the actual 9p backend if we also enabled virtio or xen.
+common-obj-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
+common-obj-$(call lnot,$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN)))) = qemu-fsdev-dummy.o
 common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
 
 # Toplevel always builds this; targets without virtio will put it in
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index cab5e942ed..fd90b62900 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -7,4 +7,4 @@ common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
 common-obj-y += 9p-proxy.o
 common-obj-$(CONFIG_XEN) += xen-9p-backend.o
 
-obj-y += virtio-9p-device.o
+obj-$(CONFIG_VIRTIO) += virtio-9p-device.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a2c61f6b09..cf4cb2010b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,4 @@
-devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),$(CONFIG_PCI))) += 9pfs/
+devices-dirs-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-$(CONFIG_SOFTMMU) += acpi/
 devices-dirs-$(CONFIG_SOFTMMU) += adc/
 devices-dirs-$(CONFIG_SOFTMMU) += audio/
-- 
2.13.5
