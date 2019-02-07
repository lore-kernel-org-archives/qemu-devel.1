Received: from eggs.gnu.org ([209.51.188.92]:57597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw4-00027G-Si
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw3-0002Nd-V7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnw3-0002N7-Gc
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id p6so829108wmc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:07 +0100
Message-Id: <1549562254-41157-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 24/51] tpm: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com, Yang Zhong <yang.zhong@intel.com>

This automatically removes the SCSI subsystem from the
binary altogether if no controllers are selected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-34-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Kconfig |  1 +
 hw/tpm/Kconfig  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 2da10af..73d33e9 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -7,6 +7,7 @@ config PC
     imply HYPERV
     imply QXL
     imply SEV
+    imply TPM_CRB
     imply TPM_TIS
     select I8259
     select I8254
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index b0c2c05..6fc6a2c 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,17 +1,25 @@
 config TPM
     bool
 
+config TPMDEV
+    bool
+
 config TPM_TIS
     bool
     depends on TPM && ISA_BUS
+    select TPMDEV
 
 config TPM_CRB
     bool
-    default y
-    depends on TPM && PC
+    depends on TPM
+    select TPMDEV
 
 config TPM_PASSTHROUGH
     bool
+    default y
+    depends on TPMDEV
 
 config TPM_EMULATOR
     bool
+    default y
+    depends on TPMDEV
-- 
1.8.3.1
