Received: from eggs.gnu.org ([209.51.188.92]:42892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1tpB-0002n2-LS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1tp5-0006M8-Vk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:16:41 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1tp5-0006L4-LE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:16:35 -0500
Received: by mail-wr1-x436.google.com with SMTP id w2so17603322wrt.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:16:35 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id v6sm2753342wml.42.2019.03.07.06.16.33
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 06:16:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 15:16:31 +0100
Message-Id: <1551968191-10821-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551968191-10821-1-git-send-email-pbonzini@redhat.com>
References: <1551968191-10821-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 26/54] tpm: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This automatically removes the TPM backends from the
binary altogether if no front-ends are selected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure      | 24 ++++++++++++------------
 hw/tpm/Kconfig | 10 +++++++++-
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 0fdbab4..0fb4dce 100755
--- a/configure
+++ b/configure
@@ -466,7 +466,7 @@ gcrypt_hmac="no"
 auth_pam=""
 vte=""
 virglrenderer=""
-tpm="yes"
+tpm=""
 libssh2=""
 live_block_migration="yes"
 numa=""
@@ -3877,20 +3877,20 @@ EOF
 fi
 
 ##########################################
-# TPM passthrough is only on x86 Linux
+# TPM emulation is only on POSIX
 
-if test "$targetos" = Linux && { test "$cpu" = i386 || test "$cpu" = x86_64; }; then
-  tpm_passthrough=$tpm
-else
-  tpm_passthrough=no
+if test "$tpm" = ""; then
+  if test "$mingw32" = "yes"; then
+    tpm=no
+  else
+    tpm=yes
+  fi
+elif test "$tpm" = "yes"; then
+  if test "$mingw32" = "yes" ; then
+    error_exit "TPM emulation only available on POSIX systems"
+  fi
 fi
 
-# TPM emulator is for all posix systems
-if test "$mingw32" != "yes"; then
-  tpm_emulator=$tpm
-else
-  tpm_emulator=no
-fi
 ##########################################
 # attr probe
 
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index f654f0f..4c8ee87 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,16 +1,24 @@
-config TPM
+config TPMDEV
     bool
+    depends on TPM
 
 config TPM_TIS
     bool
     depends on TPM && ISA_BUS
+    select TPMDEV
 
 config TPM_CRB
     bool
     depends on TPM && PC
+    select TPMDEV
 
 config TPM_PASSTHROUGH
     bool
+    default y
+    # FIXME: should check for x86 host as well
+    depends on TPMDEV && LINUX
 
 config TPM_EMULATOR
     bool
+    default y
+    depends on TPMDEV
-- 
1.8.3.1
