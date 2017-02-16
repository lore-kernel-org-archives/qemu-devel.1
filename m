Received: from eggs.gnu.org ([2001:4830:134:3::10]:53839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCo-0000kf-A8
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCj-0002Mg-97
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:46 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:57207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceNCi-0002ML-Ui
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:41 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:38:16 +0100
Message-Id: <20170216143816.2384-15-laurent@vivier.eu>
In-Reply-To: <20170216143816.2384-1-laurent@vivier.eu>
References: <20170216143816.2384-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 14/14] linux-user: Add FICLONE and
 FICLONERANGE ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>

From: Helge Deller <deller@gmx.de>

Add missing FICLONE and FICLONERANGE ioctls.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170211222602.GA6399@ls3530.fritz.box>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 5 +++++
 linux-user/syscall_defs.h  | 4 ++++
 linux-user/syscall_types.h | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 2f6e85b..e6997ff 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -112,6 +112,11 @@
 #ifdef FIBMAP
      IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
 #endif
+#ifdef FICLONE
+     IOCTL(FICLONE, IOC_W, TYPE_INT)
+     IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
+#endif
+
 #ifdef FIGETBSZ
      IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4442c22..72ca5b1 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1086,6 +1086,10 @@ struct target_pollfd {
 
 #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
 #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
+
+#define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
+#define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
+
 /* Note that the ioctl numbers claim type "long" but the actual type
  * used by the kernel is "int".
  */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 2b8c0c6..24631b0 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -232,6 +232,12 @@ STRUCT(dm_target_versions,
 STRUCT(dm_target_msg,
        TYPE_ULONGLONG) /* sector */
 
+STRUCT(file_clone_range,
+       TYPE_LONGLONG, /* src_fd */
+       TYPE_ULONGLONG, /* src_offset */
+       TYPE_ULONGLONG, /* src_length */
+       TYPE_ULONGLONG) /* dest_offset */
+
 STRUCT(fiemap_extent,
        TYPE_ULONGLONG, /* fe_logical */
        TYPE_ULONGLONG, /* fe_physical */
-- 
2.9.3
