Received: from eggs.gnu.org ([2001:4830:134:3::10]:35909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1du0qQ-0003Ce-Md
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1du0qN-0000RQ-IK
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1du0qN-0000QJ-A0
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:32:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 18 Sep 2017 20:32:18 +0200
Message-Id: <1505759538-15365-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] default-configs: Replace $(and ...) with
 $(call land, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael S Tsirkin <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

Using $(and ...) is dangerous here: It only works as long as the first 
argument is set to 'y' or completely unset. It does not work if the
first argument is set to 'n' for example. Let's use the "land" make
function instead which has been written explicitely for this purpose.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/pci.mak           | 2 +-
 default-configs/ppc-softmmu.mak   | 2 +-
 default-configs/ppc64-softmmu.mak | 4 ++--
 default-configs/s390x-softmmu.mak | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index a758630..187e438 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -43,4 +43,4 @@ CONFIG_VGA=y
 CONFIG_VGA_PCI=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
-CONFIG_VHOST_USER_SCSI=$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index a3972c5..d7a3755 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -43,7 +43,7 @@ CONFIG_XILINX_ETHLITE=y
 CONFIG_PREP=y
 CONFIG_MAC=y
 CONFIG_E500=y
-CONFIG_OPENPIC_KVM=$(and $(CONFIG_E500),$(CONFIG_KVM))
+CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index af32589..9086475 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -48,7 +48,7 @@ CONFIG_POWERNV=y
 CONFIG_PREP=y
 CONFIG_MAC=y
 CONFIG_E500=y
-CONFIG_OPENPIC_KVM=$(and $(CONFIG_E500),$(CONFIG_KVM))
+CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 CONFIG_LIBDECNUMBER=y
@@ -56,7 +56,7 @@ CONFIG_SM501=y
 # For pSeries
 CONFIG_XICS=$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
-CONFIG_XICS_KVM=$(and $(CONFIG_PSERIES),$(CONFIG_KVM))
+CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
 # For PReP
 CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 6ab2bc6..444bf16 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,6 +1,6 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
-CONFIG_VHOST_USER_SCSI=$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
-- 
1.8.3.1
