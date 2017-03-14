Received: from eggs.gnu.org ([2001:4830:134:3::10]:45227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnhoD-0004mW-Ip
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnho8-0000cN-Kj
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cnho8-0000bm-Co
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:27:52 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A4017E9E1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 08:27:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 14 Mar 2017 09:26:58 +0100
Message-Id: <1489480018-11443-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vnc: fix reverse mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

vnc server in reverse mode (qemu -vnc localhost:$nr,reverse) interprets
$nr as display number (i.e. with 5900 offset) in recent qemu versions.
Historical and documented behavior is interpreting $nr as port number
though. So we should bring code and documentation in line.

Given that default listening port for viewers is 5500 the 5900 offset is
pretty inconvinient, because it is simply impossible to connect to port
5500.  So, lets fix the code not the docs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 51f4b30..a72ea2b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3501,6 +3501,7 @@ vnc_display_create_creds(bool x509,
 
 static int vnc_display_get_address(const char *addrstr,
                                    bool websocket,
+                                   bool reverse,
                                    int displaynum,
                                    int to,
                                    bool has_ipv4,
@@ -3580,21 +3581,22 @@ static int vnc_display_get_address(const char *addrstr,
                 inet->port = g_strdup(port);
             }
         } else {
+            int offset = reverse ? 0 : 5900;
             if (parse_uint_full(port, &baseport, 10) < 0) {
                 error_setg(errp, "can't convert to a number: %s", port);
                 goto cleanup;
             }
             if (baseport > 65535 ||
-                baseport + 5900 > 65535) {
+                baseport + offset > 65535) {
                 error_setg(errp, "port %s out of range", port);
                 goto cleanup;
             }
             inet->port = g_strdup_printf(
-                "%d", (int)baseport + 5900);
+                "%d", (int)baseport + offset);
 
             if (to) {
                 inet->has_to = true;
-                inet->to = to + 5900;
+                inet->to = to + offset;
             }
         }
 
@@ -3616,6 +3618,7 @@ static int vnc_display_get_address(const char *addrstr,
 }
 
 static int vnc_display_get_addresses(QemuOpts *opts,
+                                     bool reverse,
                                      SocketAddress ***retsaddr,
                                      size_t *retnsaddr,
                                      SocketAddress ***retwsaddr,
@@ -3655,7 +3658,7 @@ static int vnc_display_get_addresses(QemuOpts *opts,
     qemu_opt_iter_init(&addriter, opts, "vnc");
     while ((addr = qemu_opt_iter_next(&addriter)) != NULL) {
         int rv;
-        rv = vnc_display_get_address(addr, false, 0, to,
+        rv = vnc_display_get_address(addr, false, reverse, 0, to,
                                      has_ipv4, has_ipv6,
                                      ipv4, ipv6,
                                      &saddr, errp);
@@ -3680,7 +3683,7 @@ static int vnc_display_get_addresses(QemuOpts *opts,
 
     qemu_opt_iter_init(&addriter, opts, "websocket");
     while ((addr = qemu_opt_iter_next(&addriter)) != NULL) {
-        if (vnc_display_get_address(addr, true, displaynum, to,
+        if (vnc_display_get_address(addr, true, reverse, displaynum, to,
                                     has_ipv4, has_ipv6,
                                     ipv4, ipv6,
                                     &wsaddr, errp) < 0) {
@@ -3876,7 +3879,8 @@ void vnc_display_open(const char *id, Error **errp)
         return;
     }
 
-    if (vnc_display_get_addresses(opts, &saddr, &nsaddr,
+    reverse = qemu_opt_get_bool(opts, "reverse", false);
+    if (vnc_display_get_addresses(opts, reverse, &saddr, &nsaddr,
                                   &wsaddr, &nwsaddr, errp) < 0) {
         goto fail;
     }
@@ -3902,7 +3906,6 @@ void vnc_display_open(const char *id, Error **errp)
         }
     }
 
-    reverse = qemu_opt_get_bool(opts, "reverse", false);
     lock_key_sync = qemu_opt_get_bool(opts, "lock-key-sync", true);
     key_delay_ms = qemu_opt_get_number(opts, "key-delay-ms", 1);
     sasl = qemu_opt_get_bool(opts, "sasl", false);
-- 
1.8.3.1
