Received: from eggs.gnu.org ([2001:4830:134:3::10]:38979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fjX-0001ry-US
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fjX-00089i-5f
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:49:15 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fjW-00088O-Uv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:49:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 16:30:45 +0100
Message-Id: <1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: Fix
 TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, pgndev <pgnet.dev@gmail.com>

The TARGET_MTIOCTOP/TARGET_MTIOCGET/TARGET_MTIOCPOS values
were being defined in terms of host struct types, but
these structures are such that their size might differ
on different hosts. Switch to using a target struct
definition instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall_defs.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f7cc9f9..16d56fa 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2706,9 +2706,34 @@ struct target_f_owner_ex {
 #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
 #define TARGET_VFAT_IOCTL_READDIR_SHORT   TARGET_IORU('r', 2)
 
-#define TARGET_MTIOCTOP        TARGET_IOW('m', 1, struct mtop)
-#define TARGET_MTIOCGET        TARGET_IOR('m', 2, struct mtget)
-#define TARGET_MTIOCPOS        TARGET_IOR('m', 3, struct mtpos)
+struct target_mtop {
+    abi_short mt_op;
+    abi_int mt_count;
+};
+
+#if defined(TARGET_SPARC) || defined(TARGET_MIPS)
+typedef abi_long target_kernel_daddr_t;
+#else
+typedef abi_int target_kernel_daddr_t;
+#endif
+
+struct target_mtget {
+    abi_long mt_type;
+    abi_long mt_resid;
+    abi_long mt_dsreg;
+    abi_long mt_gstat;
+    abi_long mt_erreg;
+    target_kernel_daddr_t mt_fileno;
+    target_kernel_daddr_t mt_blkno;
+};
+
+struct target_mtpos {
+    abi_long mt_blkno;
+};
+
+#define TARGET_MTIOCTOP        TARGET_IOW('m', 1, struct target_mtop)
+#define TARGET_MTIOCGET        TARGET_IOR('m', 2, struct target_mtget)
+#define TARGET_MTIOCPOS        TARGET_IOR('m', 3, struct target_mtpos)
 
 struct target_sysinfo {
     abi_long uptime;                /* Seconds since boot */
-- 
2.7.4
