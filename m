Received: from eggs.gnu.org ([209.51.188.92]:35579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1guFQy-0005o5-LR
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1guFQx-0005MQ-8z
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:44:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:42968 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1guFQv-0005AG-24
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:44:03 -0500
From: Andreas Schwab <schwab@suse.de>
References: <mvmmun7y7m0.fsf@suse.de>
	<3c8aca9d-e47e-04a7-1e6a-a65deab125ce@vivier.eu>
Date: Thu, 14 Feb 2019 12:43:40 +0100
In-Reply-To: <3c8aca9d-e47e-04a7-1e6a-a65deab125ce@vivier.eu> (Laurent
	Vivier's message of "Thu, 14 Feb 2019 10:17:39 +0100")
Message-ID: <mvmimxmppcj.fsf_-_@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: fix emulation of
 accept4/getpeername/getsockname/recvfrom syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

System calls that return a socket address do so by writing the (possibly
truncated) address into the provided buffer space, but setting the
addrlen parameter to the actual size of the address.  To determine how
much to copy back to the target memory the emulation needs to remember
the incoming value of the addrlen parameter, so that it doesn't write
past the buffer limits.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4a320850bb..f24743a2b2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2885,7 +2885,7 @@ static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
 static abi_long do_accept4(int fd, abi_ulong target_addr,
                            abi_ulong target_addrlen_addr, int flags)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
     int host_flags;
@@ -2909,11 +2909,13 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
 
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
@@ -2922,7 +2924,7 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
 static abi_long do_getpeername(int fd, abi_ulong target_addr,
                                abi_ulong target_addrlen_addr)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
 
@@ -2938,11 +2940,13 @@ static abi_long do_getpeername(int fd, abi_ulong target_addr,
 
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
@@ -2951,7 +2955,7 @@ static abi_long do_getpeername(int fd, abi_ulong target_addr,
 static abi_long do_getsockname(int fd, abi_ulong target_addr,
                                abi_ulong target_addrlen_addr)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
 
@@ -2967,11 +2971,13 @@ static abi_long do_getsockname(int fd, abi_ulong target_addr,
 
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
@@ -3043,7 +3049,7 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
                             abi_ulong target_addr,
                             abi_ulong target_addrlen)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     void *host_msg;
     abi_long ret;
@@ -3061,10 +3067,12 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
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
@@ -3077,8 +3085,9 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
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
