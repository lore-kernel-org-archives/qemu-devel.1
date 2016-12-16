Received: from eggs.gnu.org ([2001:4830:134:3::10]:37422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxO-0001I4-Sa
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxK-0000KO-Ts
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:14 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cHxxK-0000Jk-O7
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:10 -0500
Received: by mail-pg0-x242.google.com with SMTP id 3so10556102pgd.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:14:10 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 16 Dec 2016 11:13:42 -0800
Message-Id: <20161216191405.9473-4-rth@twiddle.net>
In-Reply-To: <20161216191405.9473-1-rth@twiddle.net>
References: <20161216191405.9473-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 03/26] linux-user: Handle TIOCSTART and TIOCSTOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>

From: Helge Deller <deller@gmx.de>

Some architectures (ppc, alpha, sparc, parisc, sh and xtensa) define the
BSD TIOCSTART and TIOCSTOP ioctls in their kernel headers to provide
compatibility to other operating systems.

Those ioctls are not implemented in Linux, nevertheless, bash will use
this ioctl if it's available on those architectures.

To avoid false warnings, add code to simply ignore those ioctls.

Cc: Riku Voipio <riku.voipio@iki.fi>
Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20161206152403.GA6651@ls3530>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/ioctls.h  | 5 +++++
 linux-user/syscall.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 1bad701..eaf6fe6 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -422,3 +422,8 @@
                 MK_PTR(MK_STRUCT(STRUCT_rtentry)))
   IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
                 MK_PTR(MK_STRUCT(STRUCT_rtentry)))
+
+#ifdef TARGET_TIOCSTART
+  IOCTL_IGNORE(TIOCSTART)
+  IOCTL_IGNORE(TIOCSTOP)
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b77503..acb004f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5453,6 +5453,8 @@ static IOCTLEntry ioctl_entries[] = {
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
 #define IOCTL_SPECIAL(cmd, access, dofn, ...)                      \
     { TARGET_ ## cmd, cmd, #cmd, access, dofn, {  __VA_ARGS__ } },
+#define IOCTL_IGNORE(cmd) \
+    { TARGET_ ## cmd, 0, #cmd },
 #include "ioctls.h"
     { 0, 0, },
 };
@@ -5484,6 +5486,10 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
 #endif
     if (ie->do_ioctl) {
         return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
+    } else if (!ie->host_cmd) {
+        /* Some architectures define BSD ioctls in their headers
+           that are not implemented in Linux.  */
+        return -TARGET_ENOSYS;
     }
 
     switch(arg_type[0]) {
-- 
2.9.3
