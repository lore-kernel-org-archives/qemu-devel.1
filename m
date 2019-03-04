Received: from eggs.gnu.org ([209.51.188.92]:46017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCm-00028u-2o
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCl-0004Te-6t
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCi-0004LX-9R
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id q1so6646860wrp.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:46 +0100
Message-Id: <1551723614-1823-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/54] tpm: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

This automatically removes the SCSI subsystem from the
binary altogether if no controllers are selected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-34-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Kconfig |  1 +
 hw/tpm/Kconfig  | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 9cd24d7..ea72f48 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -7,6 +7,7 @@ config PC
     imply HYPERV
     imply QXL
     imply SEV
+    imply TPM_CRB
     imply TPM_TIS
     select FDC
     select I8259
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 5c1ffa7..09adf32 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,14 +1,23 @@
+config TPMDEV
+    bool
+    depends on TPM
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
+    depends on TPMDEV && LINUX
 
 config TPM_EMULATOR
     bool
+    default y
+    depends on TPMDEV
-- 
1.8.3.1
