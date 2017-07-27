Received: from eggs.gnu.org ([2001:4830:134:3::10]:56123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal23-0005nV-DH
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal20-0004dA-9n
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal1z-0004cQ-W6
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2598AC0E722D
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 15:42:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:16 +0200
Message-Id: <20170727154126.11339-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/26] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Add #if defined(CONFIG_VNC) in generated code, and adjust the
qmp/hmp code accordingly.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 34 ++++++++++++++++++++++------------
 qapi/event.json  |  9 ++++++---
 hmp.c            | 14 +++++++++++++-
 qmp.c            | 30 ++++--------------------------
 4 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 9c6c3e1a53..829c66f9eb 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1660,7 +1660,8 @@
   'data': { 'host': 'str',
             'service': 'str',
             'family': 'NetworkAddressFamily',
-            'websocket': 'bool' } }
+            'websocket': 'bool' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncServerInfo:
@@ -1674,7 +1675,8 @@
 ##
 { 'struct': 'VncServerInfo',
   'base': 'VncBasicInfo',
-  'data': { '*auth': 'str' } }
+  'data': { '*auth': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncClientInfo:
@@ -1691,7 +1693,8 @@
 ##
 { 'struct': 'VncClientInfo',
   'base': 'VncBasicInfo',
-  'data': { '*x509_dname': 'str', '*sasl_username': 'str' } }
+  'data': { '*x509_dname': 'str', '*sasl_username': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncInfo:
@@ -1732,7 +1735,8 @@
 { 'struct': 'VncInfo',
   'data': {'enabled': 'bool', '*host': 'str',
            '*family': 'NetworkAddressFamily',
-           '*service': 'str', '*auth': 'str', '*clients': ['VncClientInf=
o']} }
+           '*service': 'str', '*auth': 'str', '*clients': ['VncClientInf=
o']},
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncPrimaryAuth:
@@ -1743,7 +1747,8 @@
 ##
 { 'enum': 'VncPrimaryAuth',
   'data': [ 'none', 'vnc', 'ra2', 'ra2ne', 'tight', 'ultra',
-            'tls', 'vencrypt', 'sasl' ] }
+            'tls', 'vencrypt', 'sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncVencryptSubAuth:
@@ -1757,7 +1762,8 @@
             'tls-none',  'x509-none',
             'tls-vnc',   'x509-vnc',
             'tls-plain', 'x509-plain',
-            'tls-sasl',  'x509-sasl' ] }
+            'tls-sasl',  'x509-sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
=20
 ##
@@ -1775,7 +1781,8 @@
 { 'struct': 'VncServerInfo2',
   'base': 'VncBasicInfo',
   'data': { 'auth'      : 'VncPrimaryAuth',
-            '*vencrypt' : 'VncVencryptSubAuth' } }
+            '*vencrypt' : 'VncVencryptSubAuth' },
+  'if': 'defined(CONFIG_VNC)' }
=20
=20
 ##
@@ -1808,7 +1815,8 @@
             'clients'   : ['VncClientInfo'],
             'auth'      : 'VncPrimaryAuth',
             '*vencrypt' : 'VncVencryptSubAuth',
-            '*display'  : 'str' } }
+            '*display'  : 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @query-vnc:
@@ -1839,7 +1847,8 @@
 #    }
 #
 ##
-{ 'command': 'query-vnc', 'returns': 'VncInfo' }
+{ 'command': 'query-vnc', 'returns': 'VncInfo',
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @query-vnc-servers:
@@ -1850,7 +1859,8 @@
 #
 # Since: 2.3
 ##
-{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'] }
+{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @SpiceBasicInfo:
@@ -3077,8 +3087,8 @@
 # Notes:  An empty password in this command will set the password to the=
 empty
 #         string.  Existing clients are unaffected by executing this com=
mand.
 ##
-{ 'command': 'change-vnc-password', 'data': {'password': 'str'} }
-
+{ 'command': 'change-vnc-password', 'data': {'password': 'str'},
+  'if': 'defined(CONFIG_VNC)' }
 ##
 # @change:
 #
diff --git a/qapi/event.json b/qapi/event.json
index 6d22b025cc..c8b8e9f384 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -263,7 +263,8 @@
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncBasicInfo' } }
+            'client': 'VncBasicInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_INITIALIZED:
@@ -290,7 +291,8 @@
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_DISCONNECTED:
@@ -316,7 +318,8 @@
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @SPICE_CONNECTED:
diff --git a/hmp.c b/hmp.c
index fd80dce758..9454c634bd 100644
--- a/hmp.c
+++ b/hmp.c
@@ -605,6 +605,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict *q=
dict)
     qapi_free_BlockStatsList(stats_list);
 }
=20
+#ifdef CONFIG_VNC
 /* Helper for hmp_info_vnc_clients, _servers */
 static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
                                   const char *name)
@@ -692,6 +693,12 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
     qapi_free_VncInfo2List(info2l);
=20
 }
+#else
+void hmp_info_vnc(Monitor *mon, const QDict *qdict)
+{
+    warn_report("VNC support is disabled");
+}
+#endif
=20
 #ifdef CONFIG_SPICE
 void hmp_info_spice(Monitor *mon, const QDict *qdict)
@@ -1708,12 +1715,14 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
=20
+#ifdef CONFIG_VNC
 static void hmp_change_read_arg(void *opaque, const char *password,
                                 void *readline_opaque)
 {
     qmp_change_vnc_password(password, NULL);
     monitor_read_command(opaque, 1);
 }
+#endif
=20
 void hmp_change(Monitor *mon, const QDict *qdict)
 {
@@ -1724,6 +1733,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     BlockdevChangeReadOnlyMode read_only_mode =3D 0;
     Error *err =3D NULL;
=20
+#ifdef CONFIG_VNC
     if (strcmp(device, "vnc") =3D=3D 0) {
         if (read_only) {
             monitor_printf(mon,
@@ -1738,7 +1748,9 @@ void hmp_change(Monitor *mon, const QDict *qdict)
             }
         }
         qmp_change("vnc", target, !!arg, arg, &err);
-    } else {
+    } else
+#endif
+    {
         if (read_only) {
             read_only_mode =3D
                 qapi_enum_parse(BlockdevChangeReadOnlyMode_lookup,
diff --git a/qmp.c b/qmp.c
index b86201e349..2c90dacb56 100644
--- a/qmp.c
+++ b/qmp.c
@@ -130,22 +130,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
     }
 }
=20
-#ifndef CONFIG_VNC
-/* If VNC support is enabled, the "true" query-vnc command is
-   defined in the VNC subsystem */
-VncInfo *qmp_query_vnc(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-    return NULL;
-};
-
-VncInfo2List *qmp_query_vnc_servers(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-    return NULL;
-};
-#endif
-
 #ifndef CONFIG_SPICE
 /*
  * qmp-commands.hx ensures that QMP command query-spice exists only
@@ -403,23 +387,17 @@ static void qmp_change_vnc(const char *target, bool=
 has_arg, const char *arg,
         qmp_change_vnc_listen(target, errp);
     }
 }
-#else
-void qmp_change_vnc_password(const char *password, Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-}
-static void qmp_change_vnc(const char *target, bool has_arg, const char =
*arg,
-                           Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-}
 #endif /* !CONFIG_VNC */
=20
 void qmp_change(const char *device, const char *target,
                 bool has_arg, const char *arg, Error **errp)
 {
     if (strcmp(device, "vnc") =3D=3D 0) {
+#ifdef CONFIG_VNC
         qmp_change_vnc(target, has_arg, arg, errp);
+#else
+        error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
+#endif
     } else {
         qmp_blockdev_change_medium(true, device, false, NULL, target,
                                    has_arg, arg, false, 0, errp);
--=20
2.14.0.rc0.1.g40ca67566
