Received: from eggs.gnu.org ([2001:4830:134:3::10]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCn-0007eK-Ty
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCm-0004sZ-W8
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:01 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCm-0004sT-S2
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:00 -0500
Received: by mail-qt0-x243.google.com with SMTP id a29so14086335qtb.1
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:00 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:27 -0800
Message-Id: <20170123021748.13170-6-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 05/26] linux-user: Handle ERFKILL and EHWPOISON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

With definitions for generic, alpha and mips taken from 4.9-rc2.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/alpha/target_syscall.h  | 2 ++
 linux-user/errno_defs.h            | 3 +++
 linux-user/mips/target_syscall.h   | 5 +++++
 linux-user/mips64/target_syscall.h | 5 +++++
 linux-user/syscall.c               | 6 ++++++
 5 files changed, 21 insertions(+)

diff --git a/linux-user/alpha/target_syscall.h b/linux-user/alpha/target_syscall.h
index b580fc5..3426cc5 100644
--- a/linux-user/alpha/target_syscall.h
+++ b/linux-user/alpha/target_syscall.h
@@ -235,6 +235,8 @@ struct target_pt_regs {
 #define TARGET_ENOTRECOVERABLE	137
 #undef TARGET_ERFKILL
 #define TARGET_ERFKILL		138
+#undef TARGET_EHWPOISON
+#define TARGET_EHWPOISON        139
 
 // For sys_osf_getsysinfo
 #define TARGET_GSI_UACPROC		8
diff --git a/linux-user/errno_defs.h b/linux-user/errno_defs.h
index 65522c4..55fbebd 100644
--- a/linux-user/errno_defs.h
+++ b/linux-user/errno_defs.h
@@ -140,6 +140,9 @@
 #define TARGET_EOWNERDEAD      130     /* Owner died */
 #define TARGET_ENOTRECOVERABLE 131     /* State not recoverable */
 
+#define TARGET_ERFKILL         132     /* Operation not possible due to RF-kill */
+#define TARGET_EHWPOISON       133     /* Memory page has hardware error */
+
 /* QEMU internal, not visible to the guest. This is returned when a
  * system call should be restarted, to tell the main loop that it
  * should wind the guest PC backwards so it will re-execute the syscall
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 0b64b73..2fca1c6 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -221,6 +221,11 @@ struct target_pt_regs {
 #undef TARGET_ENOTRECOVERABLE
 #define TARGET_ENOTRECOVERABLE 166     /* State not recoverable */
 
+#undef TARGET_ERFKILL
+#define TARGET_ERFKILL         167
+#undef TARGET_EHWPOISON
+#define TARGET_EHWPOISON       168
+
 #undef TARGET_EDQUOT
 #define TARGET_EDQUOT          1133    /* Quota exceeded */
 
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 6692917..078437d 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -218,6 +218,11 @@ struct target_pt_regs {
 #undef TARGET_ENOTRECOVERABLE
 #define TARGET_ENOTRECOVERABLE 166     /* State not recoverable */
 
+#undef TARGET_ERFKILL
+#define TARGET_ERFKILL         167
+#undef TARGET_EHWPOISON
+#define TARGET_EHWPOISON       168
+
 #undef TARGET_EDQUOT
 #define TARGET_EDQUOT          1133    /* Quota exceeded */
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index acb004f..11a311f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -798,6 +798,12 @@ static uint16_t host_to_target_errno_table[ERRNO_TABLE_SIZE] = {
 #ifdef ENOMSG
     [ENOMSG]            = TARGET_ENOMSG,
 #endif
+#ifdef ERKFILL
+    [ERFKILL]           = TARGET_ERFKILL,
+#endif
+#ifdef EHWPOISON
+    [EHWPOISON]         = TARGET_EHWPOISON,
+#endif
 };
 
 static inline int host_to_target_errno(int err)
-- 
2.9.3
