Received: from eggs.gnu.org ([2001:4830:134:3::10]:43165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8Te-0006vK-1g
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8Ta-0002Ud-S5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:46 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fG8Ta-0002Sg-J7
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  8 May 2018 21:40:23 +0200
Message-Id: <20180508194026.1281-3-laurent@vivier.eu>
In-Reply-To: <20180508194026.1281-1-laurent@vivier.eu>
References: <20180508194026.1281-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/5] linux-user: fix flock/flock64 padding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

include/uapi/asm-generic/fcntl.h insert a padding macro at
the end of the structures flock and flock64.

This macro is defined to "short __unused;" on sparc,
and "long pad[4]" on mips.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall_defs.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index ec3f561685..e4cd87cc00 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2643,6 +2643,17 @@ struct target_statfs64 {
 #define TARGET_O_SYNC    (TARGET___O_SYNC | TARGET_O_DSYNC)
 #endif
 
+#if defined(TARGET_SPARC)
+#define TARGET_ARCH_FLOCK_PAD abi_short __unused;
+#define TARGET_ARCH_FLOCK64_PAD abi_short __unused;
+#elif defined(TARGET_MIPS)
+#define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
+#define TARGET_ARCH_FLOCK64_PAD
+#else
+#define TARGET_ARCH_FLOCK_PAD
+#define TARGET_ARCH_FLOCK64_PAD
+#endif
+
 struct target_flock {
     short l_type;
     short l_whence;
@@ -2652,9 +2663,7 @@ struct target_flock {
     abi_long l_sysid;
 #endif
     int l_pid;
-#if defined(TARGET_MIPS)
-    abi_long pad[4];
-#endif
+    TARGET_ARCH_FLOCK_PAD
 };
 
 struct target_flock64 {
@@ -2663,6 +2672,7 @@ struct target_flock64 {
     abi_llong l_start;
     abi_llong l_len;
     abi_int   l_pid;
+    TARGET_ARCH_FLOCK64_PAD
 };
 
 struct target_f_owner_ex {
-- 
2.14.3
