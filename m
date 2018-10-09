Received: from eggs.gnu.org ([2001:4830:134:3::10]:48341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <likan_999.student@sina.com>) id 1g9mSg-0005ZK-2p
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <likan_999.student@sina.com>) id 1g9mSc-0000VV-JS
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:29:46 -0400
Received: from mail7-212.sinamail.sina.com.cn ([202.108.7.212]:48990)
	by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <likan_999.student@sina.com>) id 1g9mSc-0000S4-8g
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:29:42 -0400
From: Kan Li <likan_999.student@sina.com>
Date: Tue,  9 Oct 2018 07:29:23 +0000
Message-Id: <20181009072923.871-1-likan_999.student@sina.com>
Subject: [Qemu-devel] [PATCH] Fix linux-user crashes in ioctl(SIOCGIFCONF)
 when ifc_buf is NULL.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Summary:
This is to fix bug https://bugs.launchpad.net/qemu/+bug/1796754.
It is valid for ifc_buf to be NULL according to
http://man7.org/linux/man-pages/man7/netdevice.7.html.

Signed-off-by: Kan Li <likan_999.student@sina.com>
---
 linux-user/syscall.c | 56 ++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ae3c0dfef7..fbab98d4f7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4134,28 +4134,33 @@ static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
     unlock_user(argptr, arg, 0);
 
     host_ifconf = (struct ifconf *)(unsigned long)buf_temp;
-    target_ifc_len = host_ifconf->ifc_len;
     target_ifc_buf = (abi_long)(unsigned long)host_ifconf->ifc_buf;
 
-    target_ifreq_size = thunk_type_size(ifreq_arg_type, 0);
-    nb_ifreq = target_ifc_len / target_ifreq_size;
-    host_ifc_len = nb_ifreq * sizeof(struct ifreq);
+    if (target_ifc_buf != 0) {
+        target_ifc_len = host_ifconf->ifc_len;
 
-    outbufsz = sizeof(*host_ifconf) + host_ifc_len;
-    if (outbufsz > MAX_STRUCT_SIZE) {
-        /* We can't fit all the extents into the fixed size buffer.
-         * Allocate one that is large enough and use it instead.
-         */
-        host_ifconf = malloc(outbufsz);
-        if (!host_ifconf) {
-            return -TARGET_ENOMEM;
+        target_ifreq_size = thunk_type_size(ifreq_arg_type, 0);
+        nb_ifreq = target_ifc_len / target_ifreq_size;
+        host_ifc_len = nb_ifreq * sizeof(struct ifreq);
+
+        outbufsz = sizeof(*host_ifconf) + host_ifc_len;
+        if (outbufsz > MAX_STRUCT_SIZE) {
+            /* We can't fit all the extents into the fixed size buffer.
+             * Allocate one that is large enough and use it instead.
+             */
+            host_ifconf = malloc(outbufsz);
+            if (!host_ifconf) {
+                return -TARGET_ENOMEM;
+            }
+            memcpy(host_ifconf, buf_temp, sizeof(*host_ifconf));
+            free_buf = 1;
         }
-        memcpy(host_ifconf, buf_temp, sizeof(*host_ifconf));
-        free_buf = 1;
-    }
-    host_ifc_buf = (char*)host_ifconf + sizeof(*host_ifconf);
+        host_ifc_buf = (char*)host_ifconf + sizeof(*host_ifconf);
 
-    host_ifconf->ifc_len = host_ifc_len;
+        host_ifconf->ifc_len = host_ifc_len;
+    } else {
+      host_ifc_buf = NULL;
+    }
     host_ifconf->ifc_buf = host_ifc_buf;
 
     ret = get_errno(safe_ioctl(fd, ie->host_cmd, host_ifconf));
@@ -4178,15 +4183,16 @@ static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
         thunk_convert(argptr, host_ifconf, arg_type, THUNK_TARGET);
         unlock_user(argptr, arg, target_size);
 
-	/* copy ifreq[] to target user */
-
-        argptr = lock_user(VERIFY_WRITE, target_ifc_buf, target_ifc_len, 0);
-        for (i = 0; i < nb_ifreq ; i++) {
-            thunk_convert(argptr + i * target_ifreq_size,
-                          host_ifc_buf + i * sizeof(struct ifreq),
-                          ifreq_arg_type, THUNK_TARGET);
+        if (target_ifc_buf != 0) {
+            /* copy ifreq[] to target user */
+            argptr = lock_user(VERIFY_WRITE, target_ifc_buf, target_ifc_len, 0);
+            for (i = 0; i < nb_ifreq ; i++) {
+                thunk_convert(argptr + i * target_ifreq_size,
+                              host_ifc_buf + i * sizeof(struct ifreq),
+                              ifreq_arg_type, THUNK_TARGET);
+            }
+            unlock_user(argptr, target_ifc_buf, target_ifc_len);
         }
-        unlock_user(argptr, target_ifc_buf, target_ifc_len);
     }
 
     if (free_buf) {
-- 
2.17.1
