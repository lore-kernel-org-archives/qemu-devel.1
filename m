Received: from eggs.gnu.org ([2001:4830:134:3::10]:57986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd2-0000og-Qx
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd1-00005H-Mm
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAd1-000058-HW
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C2188553F
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:31 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGUx001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:30 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:56 +0100
Message-Id: <20170116165916.8575-13-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/32] stubs: move vhost stubs to stubs/vhost.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

No need to include them in libqemustub.a, since only system emulators
need them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs                        | 2 +-
 hw/virtio/Makefile.objs                 | 6 +++++-
 stubs/vhost.c => hw/virtio/vhost-stub.c | 0
 stubs/Makefile.objs                     | 1 -
 4 files changed, 6 insertions(+), 3 deletions(-)
 rename stubs/vhost.c => hw/virtio/vhost-stub.c (100%)

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 2a73ae5..7be399e 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -29,7 +29,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-$(CONFIG_SOFTMMU) += usb/
 devices-dirs-$(CONFIG_SOFTMMU) += vfio/
-devices-dirs-$(CONFIG_VIRTIO) += virtio/
+devices-dirs-$(CONFIG_SOFTMMU) += virtio/
 devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
 devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 95c4c30..765d363 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -1,3 +1,4 @@
+ifeq ($(CONFIG_VIRTIO),y)
 common-obj-y += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-y += virtio-bus.o
@@ -5,7 +6,10 @@ common-obj-y += virtio-mmio.o
 
 obj-y += virtio.o virtio-balloon.o 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
-
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 obj-y += virtio-crypto.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
+endif
+
+common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o
+common-obj-$(CONFIG_ALL) += vhost-stub.o
diff --git a/stubs/vhost.c b/hw/virtio/vhost-stub.c
similarity index 100%
rename from stubs/vhost.c
rename to hw/virtio/vhost-stub.c
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 40b4e15..0b642d7 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -35,7 +35,6 @@ stub-obj-y += kvm.o
 stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
-stub-obj-y += vhost.o
 stub-obj-y += iohandler.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += migration-colo.o
-- 
2.9.3
