Received: from eggs.gnu.org ([2001:4830:134:3::10]:42531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEtdP-0004uw-KB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 06:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEtSU-0001Kn-Px
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:58:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57589 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEtSU-0000zQ-Ft
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:58:42 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 11:58:07 +0200
Message-Id: <1540288688-4482-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540288688-4482-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540288688-4482-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/3] linux-user: Add support for semtimedop()
 syscall
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

From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>

Add support for semtimedop() emulation.

Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b8435f2..4b00b72 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6162,7 +6162,29 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
     return 0;
 }
 #endif
+#ifdef TARGET_NR_semtimedop
+static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned nsops,
+                                     abi_long timeout)
+{
+    struct sembuf sops[nsops];
+    struct timespec ts, *pts;
+
+    if (timeout) {
+        pts = &ts;
+        if (target_to_host_timespec(pts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        pts = NULL;
+    }
 
+    if (target_to_host_sembuf(sops, ptr, nsops)) {
+        return -TARGET_EFAULT;
+    }
+
+    return get_errno(semtimedop(semid, sops, nsops, pts));
+}
+#endif
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
    futexes locally would make futexes shared between multiple processes
@@ -8661,6 +8683,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_semget:
         return get_errno(semget(arg1, arg2, arg3));
 #endif
+#ifdef TARGET_NR_semtimedop
+    case TARGET_NR_semtimedop:
+        ret = do_semtimedop(arg1, arg2, arg3, arg4);
+        break;
+#endif
 #ifdef TARGET_NR_semop
     case TARGET_NR_semop:
         return do_semop(arg1, arg2, arg3);
-- 
2.7.4
