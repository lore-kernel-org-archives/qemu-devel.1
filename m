Received: from eggs.gnu.org ([2001:4830:134:3::10]:40912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAZc-0000tR-MH
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAZb-0001FY-1b
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPAZa-0001FG-Oi
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2600C057FAC
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:07:26 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  5 Jan 2017 16:07:01 +0000
Message-Id: <20170105160701.22118-9-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-1-berrange@redhat.com>
References: <20170105160701.22118-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 8/8] ui: add ability to specify multiple VNC
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This change allows the listen address and websocket address
options for -vnc to be repeated. This causes the VNC server
to listen on multiple addresses. e.g.

 $ $QEMU -vnc vnc=localhost:1,vnc=unix:/tmp/vnc,\
              websocket=127.0.0.1:8080,websocket=[::]:8081

results in listening on

127.0.0.1:5901, 127.0.0.1:8080, ::1:5901, :::8081 & /tmp/vnc

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 191 +++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 130 insertions(+), 61 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index d21ede9..1de9099 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3587,6 +3587,10 @@ static int vnc_display_get_address(const char *addrstr,
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
@@ -3633,80 +3637,130 @@ static int vnc_display_get_address(const char *addrstr,
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
+    char **saddrstr, **wsaddrstr;
+    size_t nsaddrstr, nwsaddrstr;
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
+    nsaddrstr = qemu_opt_get_all(opts, "vnc", &saddrstr);
+    nwsaddrstr = qemu_opt_get_all(opts, "websocket", &wsaddrstr);
+
+    *retsaddr = NULL;
+    *retnsaddr = 0;
+    *retwsaddr = NULL;
+    *retnwsaddr = 0;
+
+    if (nsaddrstr == 0 || strcmp(saddrstr[0], "none") == 0) {
+        ret = 0;
+        goto cleanup;
     }
 
     if (wsaddrstr &&
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
+    for (i = 0; i < nsaddrstr; i++) {
+        int rv;
+        rv = vnc_display_get_address(saddrstr[i], false, 0, to,
+                                     has_ipv4, has_ipv6,
+                                     ipv4, ipv6,
+                                     &saddr, errp);
+        if (rv < 0) {
+            goto cleanup;
+        }
+        /* Historical compat - if only a single listen address was
+         * provided, then the display num can be used to set the
+         * default websocket port
+         */
+        if (nsaddrstr == 1) {
+            displaynum = rv;
+        }
+        *retsaddr = g_renew(SocketAddress *, *retsaddr, *retnsaddr + 1);
+        (*retsaddr)[(*retnsaddr)++] = saddr;
     }
-    if (wsaddrstr) {
-        if (vnc_display_get_address(wsaddrstr, true, displaynum, to,
+    for (i = 0; i < nwsaddrstr; i++) {
+        if (vnc_display_get_address(wsaddrstr[i], true, displaynum, to,
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
+    g_strfreev(saddrstr);
+    g_strfreev(wsaddrstr);
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
+        error_setg(errp, "Expected a single address in reverse mo");
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
@@ -3727,6 +3781,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
     SocketAddress **rawaddrs = NULL;
     size_t nrawaddrs = 0;
     Error *listenerr = NULL;
+    bool listening = false;
     size_t i;
 
     if (qio_dns_resolver_lookup_sync(resolver, addr, &nrawaddrs,
@@ -3742,6 +3797,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
                 sioc, rawaddrs[i], listenerr == NULL ? &listenerr : NULL) < 0) {
             continue;
         }
+        listening = true;
         (*nlsock)++;
         *lsock = g_renew(QIOChannelSocket *, *lsock, *nlsock);
         *lsock_tag = g_renew(guint, *lsock_tag, *nlsock);
@@ -3756,7 +3812,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
     g_free(rawaddrs);
 
     if (listenerr) {
-        if (*nlsock == 0) {
+        if (!listening) {
             error_propagate(errp, listenerr);
             return -1;
         } else {
@@ -3775,28 +3831,33 @@ static int vnc_display_listen_addr(VncDisplay *vd,
 
 
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
-
-    if (vnc_display_listen_addr(vd, saddr,
-                                "vnc-listen",
-                                &vd->lsock,
-                                &vd->lsock_tag,
-                                &vd->nlsock,
-                                errp) < 0) {
-        return -1;
+    size_t i;
+
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
@@ -3807,7 +3868,8 @@ void vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
-    SocketAddress *saddr = NULL, *wsaddr = NULL;
+    SocketAddress **saddr = NULL, **wsaddr = NULL;
+    size_t nsaddr, nwsaddr;
     const char *share, *device_id;
     QemuConsole *con;
     bool password = false;
@@ -3820,6 +3882,7 @@ void vnc_display_open(const char *id, Error **errp)
     int acl = 0;
     int lock_key_sync = 1;
     int key_delay_ms;
+    size_t i;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3831,7 +3894,9 @@ void vnc_display_open(const char *id, Error **errp)
         return;
     }
 
-    if (vnc_display_get_addresses(opts, &saddr, &wsaddr, errp) < 0) {
+    if (vnc_display_get_addresses(opts, &saddr, &nsaddr,
+                                  &wsaddr, &nwsaddr, errp) < 0) {
+        g_printerr("failing\n");
         goto fail;
     }
 
@@ -4021,11 +4086,11 @@ void vnc_display_open(const char *id, Error **errp)
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
@@ -4034,14 +4099,18 @@ void vnc_display_open(const char *id, Error **errp)
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
2.9.3
