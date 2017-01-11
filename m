Received: from eggs.gnu.org ([2001:4830:134:3::10]:45319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgU-0003AO-6N
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgT-0003Li-5u
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:46 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgS-0003LX-VB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:45 -0500
Received: by mail-wm0-x242.google.com with SMTP id l2so324893wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:44 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:06 +0100
Message-Id: <1484163327-111841-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/33] stubs: move vhost stubs to stubs/vhost.o
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
1.8.3.1
