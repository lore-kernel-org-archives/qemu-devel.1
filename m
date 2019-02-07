Received: from eggs.gnu.org ([209.51.188.92]:47263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grjV1-00035P-TX
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grjV0-0006W3-8G
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:13:51 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1grjUx-0006NC-Jh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:13:48 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Feb 2019 14:13:14 +0100
Message-Id: <20190207131316.2957-2-laurent@vivier.eu>
In-Reply-To: <20190207131316.2957-1-laurent@vivier.eu>
References: <20190207131316.2957-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 1/3] Fix linux-user crashes in
 ioctl(SIOCGIFCONF) when ifc_buf is NULL.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Kan Li <likan_999.student@sina.com>, Laurent Vivier <lvivier@redhat.com>

From: Kan Li <likan_999.student@sina.com>

Summary:
This is to fix bug https://bugs.launchpad.net/qemu/+bug/1796754.
It is valid for ifc_buf to be NULL according to
http://man7.org/linux/man-pages/man7/netdevice.7.html.

Signed-off-by: Kan Li <likan_999.student@sina.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20181024201303.114-1-likan_999.student@sina.com>
[lv: fix errors reported by checkpatch.pl]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 56 ++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bf076cbf8c..08acc4d860 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4187,28 +4187,33 @@ static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
     unlock_user(argptr, arg, 0);
 
     host_ifconf = (struct ifconf *)(unsigned long)buf_temp;
-    target_ifc_len = host_ifconf->ifc_len;
     target_ifc_buf = (abi_long)(unsigned long)host_ifconf->ifc_buf;
-
     target_ifreq_size = thunk_type_size(ifreq_arg_type, 0);
-    nb_ifreq = target_ifc_len / target_ifreq_size;
-    host_ifc_len = nb_ifreq * sizeof(struct ifreq);
 
-    outbufsz = sizeof(*host_ifconf) + host_ifc_len;
-    if (outbufsz > MAX_STRUCT_SIZE) {
-        /* We can't fit all the extents into the fixed size buffer.
-         * Allocate one that is large enough and use it instead.
-         */
-        host_ifconf = malloc(outbufsz);
-        if (!host_ifconf) {
-            return -TARGET_ENOMEM;
+    if (target_ifc_buf != 0) {
+        target_ifc_len = host_ifconf->ifc_len;
+        nb_ifreq = target_ifc_len / target_ifreq_size;
+        host_ifc_len = nb_ifreq * sizeof(struct ifreq);
+
+        outbufsz = sizeof(*host_ifconf) + host_ifc_len;
+        if (outbufsz > MAX_STRUCT_SIZE) {
+            /*
+             * We can't fit all the extents into the fixed size buffer.
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
+        host_ifc_buf = (char *)host_ifconf + sizeof(*host_ifconf);
 
-    host_ifconf->ifc_len = host_ifc_len;
+        host_ifconf->ifc_len = host_ifc_len;
+    } else {
+      host_ifc_buf = NULL;
+    }
     host_ifconf->ifc_buf = host_ifc_buf;
 
     ret = get_errno(safe_ioctl(fd, ie->host_cmd, host_ifconf));
@@ -4231,15 +4236,16 @@ static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
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
2.20.1
