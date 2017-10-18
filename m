Received: from eggs.gnu.org ([2001:4830:134:3::10]:58655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXe-0005HY-0S
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXc-00040W-9B
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:46 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:46831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXc-00040D-0M
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:44 -0400
Received: by mail-lf0-x243.google.com with SMTP id g70so5628429lfl.3
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:43 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:24 +0300
Message-Id: <f443e3960d9d3340dd286e5fc0b661bb165a8b22.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 10/10] linux-user: Fix
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
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The TARGET_MTIOCTOP/TARGET_MTIOCGET/TARGET_MTIOCPOS values
were being defined in terms of host struct types, but
these structures are such that their size might differ
on different hosts. Switch to using a target struct
definition instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall_defs.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 447915cf80..e405d1d31d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2712,9 +2712,34 @@ struct target_f_owner_ex {
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
2.14.2
