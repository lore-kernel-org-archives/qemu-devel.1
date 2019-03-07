Received: from eggs.gnu.org ([209.51.188.92]:43967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvn-000425-GZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvm-0007TN-Ff
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:15 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvm-0007Sb-00
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:14 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:51 +0100
Message-Id: <20190307100656.14044-5-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
References: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/9] linux-user: fix emulation of
 accept4/getpeername/getsockname/recvfrom syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Andreas Schwab <schwab@suse.de>

From: Andreas Schwab <schwab@suse.de>

System calls that return a socket address do so by writing the (possibly
truncated) address into the provided buffer space, but setting the
addrlen parameter to the actual size of the address.  To determine how
much to copy back to the target memory the emulation needs to remember
the incoming value of the addrlen parameter, so that it doesn't write
past the buffer limits.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <mvmimxmppcj.fsf_-_@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f380048cbd8b..5f72209debc9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2847,7 +2847,7 @@ static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
 static abi_long do_accept4(int fd, abi_ulong target_addr,
                            abi_ulong target_addrlen_addr, int flags)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
     int host_flags;
@@ -2871,11 +2871,13 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
 
     addr = alloca(addrlen);
 
-    ret = get_errno(safe_accept4(fd, addr, &addrlen, host_flags));
+    ret_addrlen = addrlen;
+    ret = get_errno(safe_accept4(fd, addr, &ret_addrlen, host_flags));
     if (!is_error(ret)) {
-        host_to_target_sockaddr(target_addr, addr, addrlen);
-        if (put_user_u32(addrlen, target_addrlen_addr))
+        host_to_target_sockaddr(target_addr, addr, MIN(addrlen, ret_addrlen));
+        if (put_user_u32(ret_addrlen, target_addrlen_addr)) {
             ret = -TARGET_EFAULT;
+        }
     }
     return ret;
 }
@@ -2884,7 +2886,7 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
 static abi_long do_getpeername(int fd, abi_ulong target_addr,
                                abi_ulong target_addrlen_addr)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
 
@@ -2900,11 +2902,13 @@ static abi_long do_getpeername(int fd, abi_ulong target_addr,
 
     addr = alloca(addrlen);
 
-    ret = get_errno(getpeername(fd, addr, &addrlen));
+    ret_addrlen = addrlen;
+    ret = get_errno(getpeername(fd, addr, &ret_addrlen));
     if (!is_error(ret)) {
-        host_to_target_sockaddr(target_addr, addr, addrlen);
-        if (put_user_u32(addrlen, target_addrlen_addr))
+        host_to_target_sockaddr(target_addr, addr, MIN(addrlen, ret_addrlen));
+        if (put_user_u32(ret_addrlen, target_addrlen_addr)) {
             ret = -TARGET_EFAULT;
+        }
     }
     return ret;
 }
@@ -2913,7 +2917,7 @@ static abi_long do_getpeername(int fd, abi_ulong target_addr,
 static abi_long do_getsockname(int fd, abi_ulong target_addr,
                                abi_ulong target_addrlen_addr)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
 
@@ -2929,11 +2933,13 @@ static abi_long do_getsockname(int fd, abi_ulong target_addr,
 
     addr = alloca(addrlen);
 
-    ret = get_errno(getsockname(fd, addr, &addrlen));
+    ret_addrlen = addrlen;
+    ret = get_errno(getsockname(fd, addr, &ret_addrlen));
     if (!is_error(ret)) {
-        host_to_target_sockaddr(target_addr, addr, addrlen);
-        if (put_user_u32(addrlen, target_addrlen_addr))
+        host_to_target_sockaddr(target_addr, addr, MIN(addrlen, ret_addrlen));
+        if (put_user_u32(ret_addrlen, target_addrlen_addr)) {
             ret = -TARGET_EFAULT;
+        }
     }
     return ret;
 }
@@ -3005,7 +3011,7 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
                             abi_ulong target_addr,
                             abi_ulong target_addrlen)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     void *host_msg;
     abi_long ret;
@@ -3023,10 +3029,12 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
             goto fail;
         }
         addr = alloca(addrlen);
+        ret_addrlen = addrlen;
         ret = get_errno(safe_recvfrom(fd, host_msg, len, flags,
-                                      addr, &addrlen));
+                                      addr, &ret_addrlen));
     } else {
         addr = NULL; /* To keep compiler quiet.  */
+        addrlen = 0; /* To keep compiler quiet.  */
         ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, NULL, 0));
     }
     if (!is_error(ret)) {
@@ -3039,8 +3047,9 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
             }
         }
         if (target_addr) {
-            host_to_target_sockaddr(target_addr, addr, addrlen);
-            if (put_user_u32(addrlen, target_addrlen)) {
+            host_to_target_sockaddr(target_addr, addr,
+                                    MIN(addrlen, ret_addrlen));
+            if (put_user_u32(ret_addrlen, target_addrlen)) {
                 ret = -TARGET_EFAULT;
                 goto fail;
             }
-- 
2.20.1
