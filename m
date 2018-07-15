Received: from eggs.gnu.org ([2001:4830:134:3::10]:54032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fen52-00036k-41
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fen4y-00066F-VU
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fen4y-00065X-KW
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 15 Jul 2018 21:52:39 +0200
Message-Id: <20180715195242.6645-2-laurent@vivier.eu>
In-Reply-To: <20180715195242.6645-1-laurent@vivier.eu>
References: <20180715195242.6645-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/4] linux-user: ppc64: use the correct values
 for F_*LK64s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

Qemu includes the glibc headers for the host defines and target headers are
part of the qemu source themselves. The glibc has the F_GETLK64, F_SETLK64
and F_SETLKW64 defined to 12, 13 and 14 for all archs in
sysdeps/unix/sysv/linux/bits/fcntl-linux.h. The linux kernel generic
definition for F_*LK is 5, 6 & 7 and F_*LK64* is 12,13, and 14 as seen in
include/uapi/asm-generic/fcntl.h. On 64bit machine, by default the kernel
assumes all F_*LK to 64bit calls and doesnt support use of F_*LK64* as
can be seen in include/linux/fcntl.h in linux source.

On x86_64 host, the values for F_*LK64* are set to 5, 6 and 7
explicitly in /usr/include/x86_64-linux-gnu/bits/fcntl.h by the glibc.
Whereas, a PPC64 host doesn't have such a definition in
/usr/include/powerpc64le-linux-gnu/bits/fcntl.h by the glibc. So,
the sources on PPC64 host sees the default value of F_*LK64*
as 12, 13 & 14(fcntl-linux.h).

Since the 64bit kernel doesnt support 12, 13 & 14; the glibc fcntl syscall
implementation(__libc_fcntl*(), __fcntl64_nocancel) does the F_*LK64* value
convertion back to F_*LK* values on PPC64 as seen in
sysdeps/unix/sysv/linux/powerpc/powerpc64/sysdep.h with FCNTL_ADJUST_CMD()
macro. Whereas on x86_64 host the values for F_*LK64* are set to 5, 6 and 7
and no adjustments are needed.

Since qemu doesnt use the glibc fcntl, but makes the safe_syscall* on its
own, the PPC64 qemu is calling the syscall with 12, 13, and 14(without
adjustment) and they all fail. The fcntl calls to F_GETLK/F_SETLK|W all
fail by all pplications run on PPC64 host user emulation.

The fix here could be to see why on PPC64 the glibc is still keeping
F_*LK64* different from F_*LK and why adjusting them to 5, 6 and 7 before
the syscall for PPC only. See if we can make the
/usr/include/powerpc64le-linux-gnu/bits/fcntl.h to have the values
5, 6 & 7 just like x86_64 and remove the adjustment code in glibc. That
way, qemu sources see the kernel supported values in glibc headers.

OR

On PPC64 host, qemu sources see both F_*LK & F_*LK64* as same and set to
12, 13 and 14 because __USE_FILE_OFFSET64 is defined in qemu
sources(also refer sysdeps/unix/sysv/linux/bits/fcntl-linux.h).
Do the value adjustment just like it is done by glibc source by using
F_GETLK value of 5. That way, we make the syscalls with the actual
supported values in Qemu. The patch is taking this approach.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 126 +++++++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e4b1b7d7da..b8b7bced9f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6545,63 +6545,97 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
 /* warning : doesn't handle linux specific flags... */
 static int target_to_host_fcntl_cmd(int cmd)
 {
+    int ret;
+
     switch(cmd) {
-	case TARGET_F_DUPFD:
-	case TARGET_F_GETFD:
-	case TARGET_F_SETFD:
-	case TARGET_F_GETFL:
-	case TARGET_F_SETFL:
-            return cmd;
-        case TARGET_F_GETLK:
-            return F_GETLK64;
-        case TARGET_F_SETLK:
-            return F_SETLK64;
-        case TARGET_F_SETLKW:
-            return F_SETLKW64;
-	case TARGET_F_GETOWN:
-	    return F_GETOWN;
-	case TARGET_F_SETOWN:
-	    return F_SETOWN;
-	case TARGET_F_GETSIG:
-	    return F_GETSIG;
-	case TARGET_F_SETSIG:
-	    return F_SETSIG;
+    case TARGET_F_DUPFD:
+    case TARGET_F_GETFD:
+    case TARGET_F_SETFD:
+    case TARGET_F_GETFL:
+    case TARGET_F_SETFL:
+        ret = cmd;
+        break;
+    case TARGET_F_GETLK:
+        ret = F_GETLK64;
+        break;
+    case TARGET_F_SETLK:
+        ret = F_SETLK64;
+        break;
+    case TARGET_F_SETLKW:
+        ret = F_SETLKW64;
+        break;
+    case TARGET_F_GETOWN:
+        ret = F_GETOWN;
+        break;
+    case TARGET_F_SETOWN:
+        ret = F_SETOWN;
+        break;
+    case TARGET_F_GETSIG:
+        ret = F_GETSIG;
+        break;
+    case TARGET_F_SETSIG:
+        ret = F_SETSIG;
+        break;
 #if TARGET_ABI_BITS == 32
-        case TARGET_F_GETLK64:
-	    return F_GETLK64;
-	case TARGET_F_SETLK64:
-	    return F_SETLK64;
-	case TARGET_F_SETLKW64:
-	    return F_SETLKW64;
-#endif
-        case TARGET_F_SETLEASE:
-            return F_SETLEASE;
-        case TARGET_F_GETLEASE:
-            return F_GETLEASE;
+    case TARGET_F_GETLK64:
+        ret = F_GETLK64;
+        break;
+    case TARGET_F_SETLK64:
+        ret = F_SETLK64;
+        break;
+    case TARGET_F_SETLKW64:
+        ret = F_SETLKW64;
+        break;
+#endif
+    case TARGET_F_SETLEASE:
+        ret = F_SETLEASE;
+        break;
+    case TARGET_F_GETLEASE:
+        ret = F_GETLEASE;
+        break;
 #ifdef F_DUPFD_CLOEXEC
-        case TARGET_F_DUPFD_CLOEXEC:
-            return F_DUPFD_CLOEXEC;
+    case TARGET_F_DUPFD_CLOEXEC:
+        ret = F_DUPFD_CLOEXEC;
+        break;
 #endif
-        case TARGET_F_NOTIFY:
-            return F_NOTIFY;
+    case TARGET_F_NOTIFY:
+        ret = F_NOTIFY;
+        break;
 #ifdef F_GETOWN_EX
-	case TARGET_F_GETOWN_EX:
-	    return F_GETOWN_EX;
+    case TARGET_F_GETOWN_EX:
+        ret = F_GETOWN_EX;
+        break;
 #endif
 #ifdef F_SETOWN_EX
-	case TARGET_F_SETOWN_EX:
-	    return F_SETOWN_EX;
+    case TARGET_F_SETOWN_EX:
+        ret = F_SETOWN_EX;
+        break;
 #endif
 #ifdef F_SETPIPE_SZ
-        case TARGET_F_SETPIPE_SZ:
-            return F_SETPIPE_SZ;
-        case TARGET_F_GETPIPE_SZ:
-            return F_GETPIPE_SZ;
+    case TARGET_F_SETPIPE_SZ:
+        ret = F_SETPIPE_SZ;
+        break;
+    case TARGET_F_GETPIPE_SZ:
+        ret = F_GETPIPE_SZ;
+        break;
 #endif
-	default:
-            return -TARGET_EINVAL;
+    default:
+        ret = -TARGET_EINVAL;
+        break;
     }
-    return -TARGET_EINVAL;
+
+#if defined(__powerpc64__)
+    /* On PPC64, glibc headers has the F_*LK* defined to 12, 13 and 14 and
+     * is not supported by kernel. The glibc fcntl call actually adjusts
+     * them to 5, 6 and 7 before making the syscall(). Since we make the
+     * syscall directly, adjust to what is supported by the kernel.
+     */
+    if (ret >= F_GETLK64 && ret <= F_SETLKW64) {
+        ret -= F_GETLK64 - 5;
+    }
+#endif
+
+    return ret;
 }
 
 #define FLOCK_TRANSTBL \
-- 
2.17.1
