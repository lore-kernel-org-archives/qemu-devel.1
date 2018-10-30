Received: from eggs.gnu.org ([2001:4830:134:3::10]:39687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHTYf-0007DM-18
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHTYd-0006aO-SY
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:55:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60924 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHTYd-0006Dd-DS
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:55:43 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 13:55:07 +0100
Message-Id: <1540904108-30873-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540904108-30873-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540904108-30873-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 2/3] linux-user: Add support for
 semtimedop() syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu, ysu@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add support for semtimedop() emulation. It is based on invocation
of safe_semtimedop().

Conversion is left out of safe_semtimedop(), since other safe_xxx()
usually don't contain similar conversions.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1d3aaf5..709d9a7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6384,7 +6384,39 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
     return 0;
 }
 #endif
+#ifdef TARGET_NR_semtimedop
+static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned nsops,
+                                     abi_long timeout)
+{
+    struct sembuf *sops;
+    struct timespec ts, *pts;
+    abi_long ret;
+
+    if (timeout) {
+        pts = &ts;
+        if (target_to_host_timespec(pts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        pts = NULL;
+    }
 
+    sops = g_malloc(sizeof(struct sembuf) * nsops);
+    if (sops == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    if (target_to_host_sembuf(sops, ptr, nsops)) {
+        g_free(sops);
+        return -TARGET_EFAULT;
+    }
+
+    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
+    g_free(sops);
+
+    return ret;
+}
+#endif
 
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
@@ -8888,6 +8920,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_semop:
         return do_semop(arg1, arg2, arg3);
 #endif
+#ifdef TARGET_NR_semtimedop
+    case TARGET_NR_semtimedop:
+        return do_semtimedop(arg1, arg2, arg3, arg4);
+#endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
         return do_semctl(arg1, arg2, arg3, arg4);
-- 
2.7.4
