Received: from eggs.gnu.org ([2001:4830:134:3::10]:60569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfr-0004fc-Qz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfk-0005mv-HT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:47 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfk-0005mD-BN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:40 -0400
Received: by mail-wm0-x243.google.com with SMTP id m127so3758122wmm.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:38 +0200
Message-Id: <1505824179-21541-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 49/50] default-configs: Replace $(and ...) with
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
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Using $(and ...) is dangerous here: It only works as long as the first
argument is set to 'y' or completely unset. It does not work if the
first argument is set to 'n' for example. Let's use the "land" make
function instead which has been written explicitely for this purpose.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1505759538-15365-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
