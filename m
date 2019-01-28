Received: from eggs.gnu.org ([209.51.188.92]:51902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1go4QZ-0003o6-J5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1go4QY-00015e-Kj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:46:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:39736 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1go4QY-00014O-Au
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:46:06 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 054B3AF7E
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:46:03 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 28 Jan 2019 11:46:02 +0100
Message-ID: <mvmh8dt3vrp.fsf@suse.de>
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
To: qemu-devel@nongnu.org

System calls that return a socket address do so by putting the possibly
truncated address into the provided buffer space, but setting the addrlen
parameter to the actual size of the address.  To determine how much to
copy back to the target memory the emulation needs to remember the old
value of the addrlen parameter, so that it doesn't write past the buffer
limits.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d5db01122aa4..46ca889556c8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2884,7 +2884,7 @@ static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
 static abi_long do_accept4(int fd, abi_ulong target_addr,
                            abi_ulong target_addrlen_addr, int flags)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
     int host_flags;
@@ -2908,10 +2908,11 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
 
     addr = alloca(addrlen);
 
-    ret = get_errno(safe_accept4(fd, addr, &addrlen, host_flags));
+    ret_addrlen = addrlen;
+    ret = get_errno(safe_accept4(fd, addr, &ret_addrlen, host_flags));
     if (!is_error(ret)) {
-        host_to_target_sockaddr(target_addr, addr, addrlen);
-        if (put_user_u32(addrlen, target_addrlen_addr))
+        host_to_target_sockaddr(target_addr, addr, MIN(addrlen, ret_addrlen));
+        if (put_user_u32(ret_addrlen, target_addrlen_addr))
             ret = -TARGET_EFAULT;
     }
     return ret;
@@ -2921,7 +2922,7 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
 static abi_long do_getpeername(int fd, abi_ulong target_addr,
                                abi_ulong target_addrlen_addr)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
 
@@ -2937,10 +2938,11 @@ static abi_long do_getpeername(int fd, abi_ulong target_addr,
 
     addr = alloca(addrlen);
 
-    ret = get_errno(getpeername(fd, addr, &addrlen));
+    ret_addrlen = addrlen;
+    ret = get_errno(getpeername(fd, addr, &ret_addrlen));
     if (!is_error(ret)) {
-        host_to_target_sockaddr(target_addr, addr, addrlen);
-        if (put_user_u32(addrlen, target_addrlen_addr))
+        host_to_target_sockaddr(target_addr, addr, MIN(addrlen, ret_addrlen));
+        if (put_user_u32(ret_addrlen, target_addrlen_addr))
             ret = -TARGET_EFAULT;
     }
     return ret;
@@ -2950,7 +2952,7 @@ static abi_long do_getpeername(int fd, abi_ulong target_addr,
 static abi_long do_getsockname(int fd, abi_ulong target_addr,
                                abi_ulong target_addrlen_addr)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     abi_long ret;
 
@@ -2966,10 +2968,11 @@ static abi_long do_getsockname(int fd, abi_ulong target_addr,
 
     addr = alloca(addrlen);
 
-    ret = get_errno(getsockname(fd, addr, &addrlen));
+    ret_addrlen = addrlen;
+    ret = get_errno(getsockname(fd, addr, &ret_addrlen));
     if (!is_error(ret)) {
-        host_to_target_sockaddr(target_addr, addr, addrlen);
-        if (put_user_u32(addrlen, target_addrlen_addr))
+        host_to_target_sockaddr(target_addr, addr, MIN(addrlen, ret_addrlen));
+        if (put_user_u32(ret_addrlen, target_addrlen_addr))
             ret = -TARGET_EFAULT;
     }
     return ret;
@@ -3042,7 +3045,7 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
                             abi_ulong target_addr,
                             abi_ulong target_addrlen)
 {
-    socklen_t addrlen;
+    socklen_t addrlen, ret_addrlen;
     void *addr;
     void *host_msg;
     abi_long ret;
@@ -3060,10 +3063,12 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
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
@@ -3076,8 +3081,9 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
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

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
