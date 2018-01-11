Received: from eggs.gnu.org ([2001:4830:134:3::10]:51699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWn-0007rp-5s
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWl-0005Ov-L6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWl-0005Na-BY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70FC15D685
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 21:36:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:36 +0100
Message-Id: <20180111213250.16511-38-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 37/51] qapi: add conditions to VNC
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add #if defined(CONFIG_VNC) in generated code, and adjust the
qmp/hmp code accordingly.

query-qmp-schema no longer reports the command/events etc as
available when disabled at compile.

Commands made conditional:

* query-vnc, query-vnc-servers, change-vnc-password

  Before the patch, the commands for !CONFIG_VNC are stubs that fail
  like this:

    {"error": {"class": "GenericError",
               "desc": "The feature 'vnc' is not enabled"}}

  Afterwards, they fail like this:

    {"error": {"class": "CommandNotFound",
               "desc": "The command FOO has not been found"}}

  I call that an improvement, because it lets clients distinguish
  between command unavailable (class CommandNotFound) and command failed
  (class GenericError).

Events made conditional:

* VNC_CONNECTED, VNC_INITIALIZED, VNC_DISCONNECTED

HMP change:

* info vnc

  Will return "unknown command: 'info vnc'" when VNC is compiled
  out (same as error for spice when --disable-spice)

Occurrences of VNC (case insensitive) in the schema that aren't
covered by this change:

* add_client

  Command has other uses, including "socket bases character devices".
  These are unconditional as far as I can tell.

* set_password, expire_password

  In theory, these commands could be used for managing any service's
  password.  In practice, they're used for VNC and SPICE services.
  They're documented for "remote display session" / "remote display
  server".

  The service is selected by argument @protocol.  The code special-cases
  protocol-specific argument checking, then calls a protocol-specific
  function to do the work.  If it fails, the command fails with "Could
  not set password".  It does when the service isn't compiled in (it's a
  stub then).

  We could make these commands conditional on the conjunction of all
  services [currently: defined(CONFIG_VNC) || defined(CONFIG_SPICE)],
  but I doubt it's worthwhile.

* change

  Command has other uses, namely changing media.
  This patch inlines a stub; no functional change.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/ui.json         | 45 ++++++++++++++++++++++++++++-----------------
 ui/vnc.h             |  2 ++
 hmp.c                |  9 ++++++++-
 qmp.c                | 30 ++++--------------------------
 hmp-commands-info.hx |  2 ++
 5 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 07b468f625..05f1db27c8 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -369,7 +369,8 @@
   'data': { 'host': 'str',
             'service': 'str',
             'family': 'NetworkAddressFamily',
-            'websocket': 'bool' } }
+            'websocket': 'bool' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncServerInfo:
@@ -383,7 +384,8 @@
 ##
 { 'struct': 'VncServerInfo',
   'base': 'VncBasicInfo',
-  'data': { '*auth': 'str' } }
+  'data': { '*auth': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncClientInfo:
@@ -400,7 +402,8 @@
 ##
 { 'struct': 'VncClientInfo',
   'base': 'VncBasicInfo',
-  'data': { '*x509_dname': 'str', '*sasl_username': 'str' } }
+  'data': { '*x509_dname': 'str', '*sasl_username': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncInfo:
@@ -441,7 +444,8 @@
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
@@ -452,7 +456,8 @@
 ##
 { 'enum': 'VncPrimaryAuth',
   'data': [ 'none', 'vnc', 'ra2', 'ra2ne', 'tight', 'ultra',
-            'tls', 'vencrypt', 'sasl' ] }
+            'tls', 'vencrypt', 'sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncVencryptSubAuth:
@@ -466,8 +471,8 @@
             'tls-none',  'x509-none',
             'tls-vnc',   'x509-vnc',
             'tls-plain', 'x509-plain',
-            'tls-sasl',  'x509-sasl' ] }
-
+            'tls-sasl',  'x509-sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncServerInfo2:
@@ -484,8 +489,8 @@
 { 'struct': 'VncServerInfo2',
   'base': 'VncBasicInfo',
   'data': { 'auth'      : 'VncPrimaryAuth',
-            '*vencrypt' : 'VncVencryptSubAuth' } }
-
+            '*vencrypt' : 'VncVencryptSubAuth' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncInfo2:
@@ -517,7 +522,8 @@
             'clients'   : ['VncClientInfo'],
             'auth'      : 'VncPrimaryAuth',
             '*vencrypt' : 'VncVencryptSubAuth',
-            '*display'  : 'str' } }
+            '*display'  : 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @query-vnc:
@@ -548,8 +554,8 @@
 #    }
 #
 ##
-{ 'command': 'query-vnc', 'returns': 'VncInfo' }
-
+{ 'command': 'query-vnc', 'returns': 'VncInfo',
+  'if': 'defined(CONFIG_VNC)' }
 ##
 # @query-vnc-servers:
 #
@@ -559,7 +565,8 @@
 #
 # Since: 2.3
 ##
-{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'] }
+{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @change-vnc-password:
@@ -573,7 +580,8 @@
 # Notes:  An empty password in this command will set the password to the=
 empty
 #         string.  Existing clients are unaffected by executing this com=
mand.
 ##
-{ 'command': 'change-vnc-password', 'data': {'password': 'str'} }
+{ 'command': 'change-vnc-password', 'data': {'password': 'str'},
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_CONNECTED:
@@ -602,7 +610,8 @@
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncBasicInfo' } }
+            'client': 'VncBasicInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_INITIALIZED:
@@ -629,7 +638,8 @@
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_DISCONNECTED:
@@ -655,7 +665,8 @@
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # =3D Input
diff --git a/ui/vnc.h b/ui/vnc.h
index 694cf32ca9..5572bfdc9e 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -291,7 +291,9 @@ struct VncState
     bool encode_ws;
     bool websocket;
=20
+#ifdef CONFIG_VNC
     VncClientInfo *info;
+#endif
=20
     Buffer output;
     Buffer input;
diff --git a/hmp.c b/hmp.c
index 2d72f94193..0612ddc621 100644
--- a/hmp.c
+++ b/hmp.c
@@ -613,6 +613,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict *q=
dict)
     qapi_free_BlockStatsList(stats_list);
 }
=20
+#ifdef CONFIG_VNC
 /* Helper for hmp_info_vnc_clients, _servers */
 static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
                                   const char *name)
@@ -700,6 +701,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
     qapi_free_VncInfo2List(info2l);
=20
 }
+#endif
=20
 #ifdef CONFIG_SPICE
 void hmp_info_spice(Monitor *mon, const QDict *qdict)
@@ -1738,12 +1740,14 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
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
@@ -1754,6 +1758,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     BlockdevChangeReadOnlyMode read_only_mode =3D 0;
     Error *err =3D NULL;
=20
+#ifdef CONFIG_VNC
     if (strcmp(device, "vnc") =3D=3D 0) {
         if (read_only) {
             monitor_printf(mon,
@@ -1768,7 +1773,9 @@ void hmp_change(Monitor *mon, const QDict *qdict)
             }
         }
         qmp_change("vnc", target, !!arg, arg, &err);
-    } else {
+    } else
+#endif
+    {
         if (read_only) {
             read_only_mode =3D
                 qapi_enum_parse(&BlockdevChangeReadOnlyMode_lookup,
diff --git a/qmp.c b/qmp.c
index 52cfd2d81c..d26debcd75 100644
--- a/qmp.c
+++ b/qmp.c
@@ -125,22 +125,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
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
@@ -398,23 +382,17 @@ static void qmp_change_vnc(const char *target, bool=
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
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 54c3e5eac6..ea5733918b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -421,6 +421,7 @@ STEXI
 Show which guest mouse is receiving events.
 ETEXI
=20
+#if defined(CONFIG_VNC)
     {
         .name       =3D "vnc",
         .args_type  =3D "",
@@ -428,6 +429,7 @@ ETEXI
         .help       =3D "show the vnc server status",
         .cmd        =3D hmp_info_vnc,
     },
+#endif
=20
 STEXI
 @item info vnc
--=20
2.16.0.rc1.1.gef27df75a1
