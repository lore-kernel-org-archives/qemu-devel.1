Received: from eggs.gnu.org ([2001:4830:134:3::10]:33877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboM0-000077-U4
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboLw-00024N-C6
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cboLw-00023z-3t
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34DA81B174D
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 13:01:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Feb 2017 14:01:17 +0100
Message-Id: <1486645277-4724-11-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
References: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] ui: add ability to specify multiple VNC
 listen addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

This change allows the listen address and websocket address
options for -vnc to be repeated. This causes the VNC server
to listen on multiple addresses. e.g.

 $ $QEMU -vnc vnc=localhost:1,vnc=unix:/tmp/vnc,\
              websocket=127.0.0.1:8080,websocket=[::]:8081

results in listening on

127.0.0.1:5901, 127.0.0.1:8080, ::1:5901, :::8081 & /tmp/vnc

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170203120649.15637-9-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 195 +++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 62 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 36e50e7..da9fa00 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3563,6 +3563,10 @@ static int vnc_display_get_address(const char *addrstr,
         if (websocket) {
             if (g_str_equal(addrstr, "") ||
                 g_str_equal(addrstr, "on")) {
+                if (displaynum == -1) {
+                    error_setg(errp, "explicit websocket port is required");
+                    goto cleanup;
+                }
                 inet->port = g_strdup_printf(
                     "%d", displaynum + 5700);
                 if (to) {
@@ -3609,80 +3613,133 @@ static int vnc_display_get_address(const char *addrstr,
 }
 
 static int vnc_display_get_addresses(QemuOpts *opts,
-                                     SocketAddress **retsaddr,
-                                     SocketAddress **retwsaddr,
+                                     SocketAddress ***retsaddr,
+                                     size_t *retnsaddr,
+                                     SocketAddress ***retwsaddr,
+                                     size_t *retnwsaddr,
                                      Error **errp)
 {
     SocketAddress *saddr = NULL;
     SocketAddress *wsaddr = NULL;
-    const char *saddrstr = qemu_opt_get(opts, "vnc");
-    const char *wsaddrstr = qemu_opt_get(opts, "websocket");
+    QemuOptsIter addriter;
+    const char *addr;
     int to = qemu_opt_get_number(opts, "to", 0);
     bool has_ipv4 = qemu_opt_get(opts, "ipv4");
     bool has_ipv6 = qemu_opt_get(opts, "ipv6");
     bool ipv4 = qemu_opt_get_bool(opts, "ipv4", false);
     bool ipv6 = qemu_opt_get_bool(opts, "ipv6", false);
+    size_t i;
+    int displaynum = -1;
+    int ret = -1;
 
-    if (!saddrstr || strcmp(saddrstr, "none") == 0) {
-        *retsaddr = NULL;
-        *retwsaddr = NULL;
-        return 0;
+    *retsaddr = NULL;
+    *retnsaddr = 0;
+    *retwsaddr = NULL;
+    *retnwsaddr = 0;
+
+    addr = qemu_opt_get(opts, "vnc");
+    if (addr == NULL || g_str_equal(addr, "none")) {
+        ret = 0;
+        goto cleanup;
     }
-
-    if (wsaddrstr &&
+    if (qemu_opt_get(opts, "websocket") &&
         !qcrypto_hash_supports(QCRYPTO_HASH_ALG_SHA1)) {
         error_setg(errp,
                    "SHA1 hash support is required for websockets");
-        goto error;
+        goto cleanup;
     }
 
-    int displaynum = vnc_display_get_address(saddrstr, false, 0, to,
-                                             has_ipv4, has_ipv6,
-                                             ipv4, ipv6,
-                                             &saddr, errp);
-    if (displaynum < 0) {
-        goto error;
+    qemu_opt_iter_init(&addriter, opts, "vnc");
+    while ((addr = qemu_opt_iter_next(&addriter)) != NULL) {
+        int rv;
+        rv = vnc_display_get_address(addr, false, 0, to,
+                                     has_ipv4, has_ipv6,
+                                     ipv4, ipv6,
+                                     &saddr, errp);
+        if (rv < 0) {
+            goto cleanup;
+        }
+        /* Historical compat - first listen address can be used
+         * to set the default websocket port
+         */
+        if (displaynum == -1) {
+            displaynum = rv;
+        }
+        *retsaddr = g_renew(SocketAddress *, *retsaddr, *retnsaddr + 1);
+        (*retsaddr)[(*retnsaddr)++] = saddr;
     }
-    if (wsaddrstr) {
-        if (vnc_display_get_address(wsaddrstr, true, displaynum, to,
+
+    /* If we had multiple primary displays, we don't do defaults
+     * for websocket, and require explicit config instead. */
+    if (*retnsaddr > 1) {
+        displaynum = -1;
+    }
+
+    qemu_opt_iter_init(&addriter, opts, "websocket");
+    while ((addr = qemu_opt_iter_next(&addriter)) != NULL) {
+        if (vnc_display_get_address(addr, true, displaynum, to,
                                     has_ipv4, has_ipv6,
                                     ipv4, ipv6,
                                     &wsaddr, errp) < 0) {
-            goto error;
+            goto cleanup;
         }
-        if (saddr->type == SOCKET_ADDRESS_KIND_INET &&
+
+        /* Historical compat - if only a single listen address was
+         * provided, then this is used to set the default listen
+         * address for websocket too
+         */
+        if (*retnsaddr == 1 &&
+            (*retsaddr)[0]->type == SOCKET_ADDRESS_KIND_INET &&
             wsaddr->type == SOCKET_ADDRESS_KIND_INET &&
             g_str_equal(wsaddr->u.inet.data->host, "") &&
-            !g_str_equal(saddr->u.inet.data->host, "")) {
+            !g_str_equal((*retsaddr)[0]->u.inet.data->host, "")) {
             g_free(wsaddr->u.inet.data->host);
-            wsaddr->u.inet.data->host = g_strdup(saddr->u.inet.data->host);
+            wsaddr->u.inet.data->host =
+                g_strdup((*retsaddr)[0]->u.inet.data->host);
         }
+
+        *retwsaddr = g_renew(SocketAddress *, *retwsaddr, *retnwsaddr + 1);
+        (*retwsaddr)[(*retnwsaddr)++] = wsaddr;
     }
-    *retsaddr = saddr;
-    *retwsaddr = wsaddr;
-    return 0;
 
- error:
-    qapi_free_SocketAddress(saddr);
-    qapi_free_SocketAddress(wsaddr);
-    return -1;
+    ret = 0;
+ cleanup:
+    if (ret < 0) {
+        for (i = 0; i < *retnsaddr; i++) {
+            qapi_free_SocketAddress((*retsaddr)[i]);
+        }
+        g_free(*retsaddr);
+        for (i = 0; i < *retnwsaddr; i++) {
+            qapi_free_SocketAddress((*retwsaddr)[i]);
+        }
+        g_free(*retwsaddr);
+        *retsaddr = *retwsaddr = NULL;
+        *retnsaddr = *retnwsaddr = 0;
+    }
+    return ret;
 }
 
 static int vnc_display_connect(VncDisplay *vd,
-                               SocketAddress *saddr,
-                               SocketAddress *wsaddr,
+                               SocketAddress **saddr,
+                               size_t nsaddr,
+                               SocketAddress **wsaddr,
+                               size_t nwsaddr,
                                Error **errp)
 {
     /* connect to viewer */
     QIOChannelSocket *sioc = NULL;
-    if (wsaddr) {
+    if (nwsaddr != 0) {
         error_setg(errp, "Cannot use websockets in reverse mode");
         return -1;
     }
-    vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
+    if (nsaddr != 1) {
+        error_setg(errp, "Expected a single address in reverse mode");
+        return -1;
+    }
+    vd->is_unix = saddr[0]->type == SOCKET_ADDRESS_KIND_UNIX;
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-reverse");
-    if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
+    if (qio_channel_socket_connect_sync(sioc, saddr[0], errp) < 0) {
         return -1;
     }
     vnc_connect(vd, sioc, false, false);
@@ -3703,6 +3760,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
     SocketAddress **rawaddrs = NULL;
     size_t nrawaddrs = 0;
     Error *listenerr = NULL;
+    bool listening = false;
     size_t i;
 
     if (qio_dns_resolver_lookup_sync(resolver, addr, &nrawaddrs,
@@ -3718,6 +3776,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
                 sioc, rawaddrs[i], listenerr == NULL ? &listenerr : NULL) < 0) {
             continue;
         }
+        listening = true;
         (*nlsock)++;
         *lsock = g_renew(QIOChannelSocket *, *lsock, *nlsock);
         *lsock_tag = g_renew(guint, *lsock_tag, *nlsock);
@@ -3732,7 +3791,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
     g_free(rawaddrs);
 
     if (listenerr) {
-        if (*nlsock == 0) {
+        if (!listening) {
             error_propagate(errp, listenerr);
             return -1;
         } else {
@@ -3751,28 +3810,33 @@ static int vnc_display_listen_addr(VncDisplay *vd,
 
 
 static int vnc_display_listen(VncDisplay *vd,
-                              SocketAddress *saddr,
-                              SocketAddress *wsaddr,
+                              SocketAddress **saddr,
+                              size_t nsaddr,
+                              SocketAddress **wsaddr,
+                              size_t nwsaddr,
                               Error **errp)
 {
-    vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
+    size_t i;
 
-    if (vnc_display_listen_addr(vd, saddr,
-                                "vnc-listen",
-                                &vd->lsock,
-                                &vd->lsock_tag,
-                                &vd->nlsock,
-                                errp) < 0) {
-        return -1;
+    for (i = 0; i < nsaddr; i++) {
+        if (vnc_display_listen_addr(vd, saddr[i],
+                                    "vnc-listen",
+                                    &vd->lsock,
+                                    &vd->lsock_tag,
+                                    &vd->nlsock,
+                                    errp) < 0) {
+            return -1;
+        }
     }
-    if (wsaddr &&
-        vnc_display_listen_addr(vd, wsaddr,
-                                "vnc-ws-listen",
-                                &vd->lwebsock,
-                                &vd->lwebsock_tag,
-                                &vd->nlwebsock,
-                                errp) < 0) {
-        return -1;
+    for (i = 0; i < nwsaddr; i++) {
+        if (vnc_display_listen_addr(vd, wsaddr[i],
+                                    "vnc-ws-listen",
+                                    &vd->lwebsock,
+                                    &vd->lwebsock_tag,
+                                    &vd->nlwebsock,
+                                    errp) < 0) {
+            return -1;
+        }
     }
 
     return 0;
@@ -3783,7 +3847,8 @@ void vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
-    SocketAddress *saddr = NULL, *wsaddr = NULL;
+    SocketAddress **saddr = NULL, **wsaddr = NULL;
+    size_t nsaddr, nwsaddr;
     const char *share, *device_id;
     QemuConsole *con;
     bool password = false;
@@ -3796,6 +3861,7 @@ void vnc_display_open(const char *id, Error **errp)
     int acl = 0;
     int lock_key_sync = 1;
     int key_delay_ms;
+    size_t i;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3807,7 +3873,8 @@ void vnc_display_open(const char *id, Error **errp)
         return;
     }
 
-    if (vnc_display_get_addresses(opts, &saddr, &wsaddr, errp) < 0) {
+    if (vnc_display_get_addresses(opts, &saddr, &nsaddr,
+                                  &wsaddr, &nwsaddr, errp) < 0) {
         goto fail;
     }
 
@@ -4001,11 +4068,11 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     if (reverse) {
-        if (vnc_display_connect(vd, saddr, wsaddr, errp) < 0) {
+        if (vnc_display_connect(vd, saddr, nsaddr, wsaddr, nwsaddr, errp) < 0) {
             goto fail;
         }
     } else {
-        if (vnc_display_listen(vd, saddr, wsaddr, errp) < 0) {
+        if (vnc_display_listen(vd, saddr, nsaddr, wsaddr, nwsaddr, errp) < 0) {
             goto fail;
         }
     }
@@ -4014,14 +4081,18 @@ void vnc_display_open(const char *id, Error **errp)
         vnc_display_print_local_addr(vd);
     }
 
-    qapi_free_SocketAddress(saddr);
-    qapi_free_SocketAddress(wsaddr);
+ cleanup:
+    for (i = 0; i < nsaddr; i++) {
+        qapi_free_SocketAddress(saddr[i]);
+    }
+    for (i = 0; i < nwsaddr; i++) {
+        qapi_free_SocketAddress(wsaddr[i]);
+    }
     return;
 
 fail:
     vnc_display_close(vd);
-    qapi_free_SocketAddress(saddr);
-    qapi_free_SocketAddress(wsaddr);
+    goto cleanup;
 }
 
 void vnc_display_add_client(const char *id, int csock, bool skipauth)
-- 
1.8.3.1
