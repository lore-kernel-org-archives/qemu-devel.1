Received: from eggs.gnu.org ([2001:4830:134:3::10]:50240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5u-0008V8-Ik
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5t-0004oy-Ko
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:25 -0300
Message-Id: <20170724182751.18261-10-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 09/35] ui/vnc: fix leak of
 SocketAddress **
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Extract the (correct) cleaning code as a new function vnc_free_addresses() then
use it to remove the memory leaks.

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ui/vnc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index eb91559b6b..651cbb8606 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3521,6 +3521,20 @@ static int vnc_display_get_address(const char *addrstr,
     return ret;
 }
 
+static void vnc_free_addresses(SocketAddress ***retsaddr,
+                               size_t *retnsaddr)
+{
+    size_t i;
+
+    for (i = 0; i < *retnsaddr; i++) {
+        qapi_free_SocketAddress((*retsaddr)[i]);
+    }
+    g_free(*retsaddr);
+
+    *retsaddr = NULL;
+    *retnsaddr = 0;
+}
+
 static int vnc_display_get_addresses(QemuOpts *opts,
                                      bool reverse,
                                      SocketAddress ***retsaddr,
@@ -3538,7 +3552,6 @@ static int vnc_display_get_addresses(QemuOpts *opts,
     bool has_ipv6 = qemu_opt_get(opts, "ipv6");
     bool ipv4 = qemu_opt_get_bool(opts, "ipv4", false);
     bool ipv6 = qemu_opt_get_bool(opts, "ipv6", false);
-    size_t i;
     int displaynum = -1;
     int ret = -1;
 
@@ -3614,16 +3627,8 @@ static int vnc_display_get_addresses(QemuOpts *opts,
     ret = 0;
  cleanup:
     if (ret < 0) {
-        for (i = 0; i < *retnsaddr; i++) {
-            qapi_free_SocketAddress((*retsaddr)[i]);
-        }
-        g_free(*retsaddr);
-        for (i = 0; i < *retnwsaddr; i++) {
-            qapi_free_SocketAddress((*retwsaddr)[i]);
-        }
-        g_free(*retwsaddr);
-        *retsaddr = *retwsaddr = NULL;
-        *retnsaddr = *retnwsaddr = 0;
+        vnc_free_addresses(retsaddr, retnsaddr);
+        vnc_free_addresses(retwsaddr, retnwsaddr);
     }
     return ret;
 }
@@ -3772,7 +3777,6 @@ void vnc_display_open(const char *id, Error **errp)
     int acl = 0;
     int lock_key_sync = 1;
     int key_delay_ms;
-    size_t i;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3993,12 +3997,8 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
  cleanup:
-    for (i = 0; i < nsaddr; i++) {
-        qapi_free_SocketAddress(saddr[i]);
-    }
-    for (i = 0; i < nwsaddr; i++) {
-        qapi_free_SocketAddress(wsaddr[i]);
-    }
+    vnc_free_addresses(&saddr, &nsaddr);
+    vnc_free_addresses(&wsaddr, &nwsaddr);
     return;
 
 fail:
-- 
2.13.3
