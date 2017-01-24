Received: from eggs.gnu.org ([2001:4830:134:3::10]:44767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnN-0000jo-HF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnM-0005S2-AY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxnM-0005Rj-2z
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:44 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30EC97FE8E
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:53:44 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 09:53:26 +0000
Message-Id: <20170124095332.23955-3-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-1-berrange@redhat.com>
References: <20170124095332.23955-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/8] ui: fix reporting of VNC auth in
 query-vnc-servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently the VNC authentication info is emitted at the
top level of the query-vnc-servers data. This is wrong
because the authentication scheme differs between plain
and websockets when TLS is enabled. We should instead
report auth against the individual servers. e.g.

(QEMU) query-vnc-servers
{
    "return": [
        {
            "clients": [],
            "id": "default",
            "auth": "vencrypt",
            "vencrypt": "x509-vnc",
            "server": [
                {
                    "host": "127.0.0.1"
                    "service": "5901",
                    "websocket": false,
                    "family": "ipv4",
                    "auth": "vencrypt",
                    "vencrypt": "x509-vnc"
                },
                {
                    "host": "127.0.0.1",
                    "service": "5902",
                    "websocket": true,
                    "family": "ipv4",
                    "auth": "vnc"
                }
            ]
        }
    ]
}

This also future proofs the QMP schema so that we can
cope with multiple VNC server instances, listening on
different interfaces or ports, with different auth
setup.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qapi-schema.json | 28 ++++++++++++++++---
 ui/vnc.c         | 85 +++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 74 insertions(+), 39 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index ac55f4a..846bcb8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1506,7 +1506,8 @@
 #
 # The network connection information for server
 #
-# @auth: #optional, authentication method
+# @auth: #optional, authentication method used for
+#        the plain (non-websocket) VNC server
 #
 # Since: 2.1
 ##
@@ -1597,6 +1598,25 @@
             'tls-plain', 'x509-plain',
             'tls-sasl',  'x509-sasl' ] }
 
+
+##
+# @VncServerInfo2:
+#
+# The network connection information for server
+#
+# @auth: The current authentication type used by the servers
+#
+# @vencrypt: #optional The vencrypt sub authentication type used by the
+#            servers, only specified in case auth == vencrypt.
+#
+# Since: 2.9
+##
+{ 'struct': 'VncServerInfo2',
+  'base': 'VncBasicInfo',
+  'data': { 'auth'      : 'VncPrimaryAuth',
+            '*vencrypt' : 'VncVencryptSubAuth' } }
+
+
 ##
 # @VncInfo2:
 #
@@ -1612,9 +1632,9 @@
 # @clients: A list of @VncClientInfo of all currently connected clients.
 #           The list can be empty, for obvious reasons.
 #
-# @auth: The current authentication type used by the server
+# @auth: The current authentication type used by the non-websockets servers
 #
-# @vencrypt: #optional The vencrypt sub authentication type used by the server,
+# @vencrypt: #optional The vencrypt authentication type used by the servers,
 #            only specified in case auth == vencrypt.
 #
 # @display: #optional The display device the vnc server is linked to.
@@ -1623,7 +1643,7 @@
 ##
 { 'struct': 'VncInfo2',
   'data': { 'id'        : 'str',
-            'server'    : ['VncBasicInfo'],
+            'server'    : ['VncServerInfo2'],
             'clients'   : ['VncClientInfo'],
             'auth'      : 'VncPrimaryAuth',
             '*vencrypt' : 'VncVencryptSubAuth',
diff --git a/ui/vnc.c b/ui/vnc.c
index c82e476..bd81922 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -429,12 +429,20 @@ out_error:
     return NULL;
 }
 
-static VncBasicInfoList *qmp_query_server_entry(QIOChannelSocket *ioc,
-                                                bool websocket,
-                                                VncBasicInfoList *prev)
+
+static void qmp_query_auth(int auth, int subauth,
+                           VncPrimaryAuth *qmp_auth,
+                           VncVencryptSubAuth *qmp_vencrypt,
+                           bool *qmp_has_vencrypt);
+
+static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
+                                                  bool websocket,
+                                                  int auth,
+                                                  int subauth,
+                                                  VncServerInfo2List *prev)
 {
-    VncBasicInfoList *list;
-    VncBasicInfo *info;
+    VncServerInfo2List *list;
+    VncServerInfo2 *info;
     Error *err = NULL;
     SocketAddress *addr;
 
@@ -444,85 +452,91 @@ static VncBasicInfoList *qmp_query_server_entry(QIOChannelSocket *ioc,
         return prev;
     }
 
-    info = g_new0(VncBasicInfo, 1);
-    vnc_init_basic_info(addr, info, &err);
+    info = g_new0(VncServerInfo2, 1);
+    vnc_init_basic_info(addr, qapi_VncServerInfo2_base(info), &err);
     qapi_free_SocketAddress(addr);
     if (err) {
-        qapi_free_VncBasicInfo(info);
+        qapi_free_VncServerInfo2(info);
         error_free(err);
         return prev;
     }
     info->websocket = websocket;
 
-    list = g_new0(VncBasicInfoList, 1);
+    qmp_query_auth(auth, subauth, &info->auth,
+                   &info->vencrypt, &info->has_vencrypt);
+
+    list = g_new0(VncServerInfo2List, 1);
     list->value = info;
     list->next = prev;
     return list;
 }
 
-static void qmp_query_auth(VncDisplay *vd, VncInfo2 *info)
+static void qmp_query_auth(int auth, int subauth,
+                           VncPrimaryAuth *qmp_auth,
+                           VncVencryptSubAuth *qmp_vencrypt,
+                           bool *qmp_has_vencrypt)
 {
-    switch (vd->auth) {
+    switch (auth) {
     case VNC_AUTH_VNC:
-        info->auth = VNC_PRIMARY_AUTH_VNC;
+        *qmp_auth = VNC_PRIMARY_AUTH_VNC;
         break;
     case VNC_AUTH_RA2:
-        info->auth = VNC_PRIMARY_AUTH_RA2;
+        *qmp_auth = VNC_PRIMARY_AUTH_RA2;
         break;
     case VNC_AUTH_RA2NE:
-        info->auth = VNC_PRIMARY_AUTH_RA2NE;
+        *qmp_auth = VNC_PRIMARY_AUTH_RA2NE;
         break;
     case VNC_AUTH_TIGHT:
-        info->auth = VNC_PRIMARY_AUTH_TIGHT;
+        *qmp_auth = VNC_PRIMARY_AUTH_TIGHT;
         break;
     case VNC_AUTH_ULTRA:
-        info->auth = VNC_PRIMARY_AUTH_ULTRA;
+        *qmp_auth = VNC_PRIMARY_AUTH_ULTRA;
         break;
     case VNC_AUTH_TLS:
-        info->auth = VNC_PRIMARY_AUTH_TLS;
+        *qmp_auth = VNC_PRIMARY_AUTH_TLS;
         break;
     case VNC_AUTH_VENCRYPT:
-        info->auth = VNC_PRIMARY_AUTH_VENCRYPT;
-        info->has_vencrypt = true;
-        switch (vd->subauth) {
+        *qmp_auth = VNC_PRIMARY_AUTH_VENCRYPT;
+        *qmp_has_vencrypt = true;
+        switch (subauth) {
         case VNC_AUTH_VENCRYPT_PLAIN:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_PLAIN;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_PLAIN;
             break;
         case VNC_AUTH_VENCRYPT_TLSNONE:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_NONE;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_NONE;
             break;
         case VNC_AUTH_VENCRYPT_TLSVNC:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_VNC;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_VNC;
             break;
         case VNC_AUTH_VENCRYPT_TLSPLAIN:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_PLAIN;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_PLAIN;
             break;
         case VNC_AUTH_VENCRYPT_X509NONE:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_NONE;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_NONE;
             break;
         case VNC_AUTH_VENCRYPT_X509VNC:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_VNC;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_VNC;
             break;
         case VNC_AUTH_VENCRYPT_X509PLAIN:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_PLAIN;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_PLAIN;
             break;
         case VNC_AUTH_VENCRYPT_TLSSASL:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_SASL;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_TLS_SASL;
             break;
         case VNC_AUTH_VENCRYPT_X509SASL:
-            info->vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_SASL;
+            *qmp_vencrypt = VNC_VENCRYPT_SUB_AUTH_X509_SASL;
             break;
         default:
-            info->has_vencrypt = false;
+            *qmp_has_vencrypt = false;
             break;
         }
         break;
     case VNC_AUTH_SASL:
-        info->auth = VNC_PRIMARY_AUTH_SASL;
+        *qmp_auth = VNC_PRIMARY_AUTH_SASL;
         break;
     case VNC_AUTH_NONE:
     default:
-        info->auth = VNC_PRIMARY_AUTH_NONE;
+        *qmp_auth = VNC_PRIMARY_AUTH_NONE;
         break;
     }
 }
@@ -538,7 +552,8 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
         info = g_new0(VncInfo2, 1);
         info->id = g_strdup(vd->id);
         info->clients = qmp_query_client_list(vd);
-        qmp_query_auth(vd, info);
+        qmp_query_auth(vd->auth, vd->subauth, &info->auth,
+                       &info->vencrypt, &info->has_vencrypt);
         if (vd->dcl.con) {
             dev = DEVICE(object_property_get_link(OBJECT(vd->dcl.con),
                                                   "device", NULL));
@@ -547,11 +562,11 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
         }
         if (vd->lsock != NULL) {
             info->server = qmp_query_server_entry(
-                vd->lsock, false, info->server);
+                vd->lsock, false, vd->auth, vd->subauth, info->server);
         }
         if (vd->lwebsock != NULL) {
             info->server = qmp_query_server_entry(
-                vd->lwebsock, true, info->server);
+                vd->lwebsock, true, vd->ws_auth, vd->ws_subauth, info->server);
         }
 
         item = g_new0(VncInfo2List, 1);
-- 
2.9.3
