Received: from eggs.gnu.org ([2001:4830:134:3::10]:59184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dT3Vs-00058Y-Cz
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dT3Vo-0003xu-Hp
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dT3Vo-0003xJ-8b
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:55:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C614C04D29A
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 09:55:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  6 Jul 2017 10:55:45 +0100
Message-Id: <20170706095545.5632-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] hmp: Update info vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, berrange@redhat.com
Cc: lcapitulino@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The QMP query-vnc interfaces have gained a lot more information that
the HMP interfaces hasn't got yet. Update it.

Note the output format has changed, but this is HMP so that's OK.

In particular, this now includes client information for reverse
connections:

-vnc :0
(qemu) info vnc
default:
  Server: 0.0.0.0:5900 (ipv4)
    Auth: none (Sub: none)

  (Now connect a client)

(qemu) info vnc
default:
  Server: 0.0.0.0:5900 (ipv4)
    Auth: none (Sub: none)
  Client: 127.0.0.1:51828 (ipv4)
    x509_dname: none
    sasl_username: none

-vnc localhost:7000,reverse
(qemu) info vnc
default:
  Client: ::1:7000 (ipv6)
    x509_dname: none
    sasl_username: none
  Auth: none (Sub: none)

-vnc :1,password,id=3Dpass -vnc localhost:7000,reverse
(qemu) info vnc
default:
  Client: ::1:7000 (ipv6)
    x509_dname: none
    sasl_username: none
  Auth: none (Sub: none)
rev:
  Server: 0.0.0.0:5901 (ipv4)
    Auth: vnc (Sub: none)
  Client: 127.0.0.1:53616 (ipv4)
    x509_dname: none
    sasl_username: none

This was originally RH bz 1461682

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--
v2
  Say 'sasl_username' - from Marc-Andr=C3=A9's comment
  use 'has_x509_dname' - from Marc-Andr=C3=A9's comment
  Don't display top level auth info except in reverse
  case - Dan's comment
---
 hmp.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++--------------=
------
 1 file changed, 73 insertions(+), 31 deletions(-)

diff --git a/hmp.c b/hmp.c
index dee40284c1..7db797ed9d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -600,50 +600,92 @@ void hmp_info_blockstats(Monitor *mon, const QDict =
*qdict)
     qapi_free_BlockStatsList(stats_list);
 }
=20
+/* Helper for hmp_info_vnc_clients, _servers */
+static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
+                                  const char *name)
+{
+    monitor_printf(mon, "  %s: %s:%s (%s%s)\n",
+                   name,
+                   info->host,
+                   info->service,
+                   NetworkAddressFamily_lookup[info->family],
+                   info->websocket ? " (Websocket)" : "");
+}
+
+/* Helper displaying and euth and crypt info */
+static void hmp_info_vnc_authcrypt(Monitor *mon, const char *indent,
+                                   VncPrimaryAuth auth,
+                                   VncVencryptSubAuth *vencrypt)
+{
+    monitor_printf(mon, "%sAuth: %s (Sub: %s)\n", indent,
+                   VncPrimaryAuth_lookup[auth],
+                   vencrypt ? VncVencryptSubAuth_lookup[*vencrypt] : "no=
ne");
+}
+
+static void hmp_info_vnc_clients(Monitor *mon, VncClientInfoList *client=
)
+{
+    while (client) {
+        VncClientInfo *cinfo =3D client->value;
+
+        hmp_info_VncBasicInfo(mon, (VncBasicInfo *)cinfo, "Client");
+        monitor_printf(mon, "    x509_dname: %s\n",
+                       cinfo->has_x509_dname ?
+                       cinfo->x509_dname : "none");
+        monitor_printf(mon, "    sasl_username: %s\n",
+                       cinfo->has_sasl_username ?
+                       cinfo->sasl_username : "none");
+
+        client =3D client->next;
+    }
+}
+
+static void hmp_info_vnc_servers(Monitor *mon, VncServerInfo2List *serve=
r)
+{
+    while (server) {
+        VncServerInfo2 *sinfo =3D server->value;
+        hmp_info_VncBasicInfo(mon, (VncBasicInfo *)sinfo, "Server");
+        hmp_info_vnc_authcrypt(mon, "    ", sinfo->auth,
+                               sinfo->has_vencrypt ? &sinfo->vencrypt : =
NULL);
+        server =3D server->next;
+    }
+}
+
 void hmp_info_vnc(Monitor *mon, const QDict *qdict)
 {
-    VncInfo *info;
+    VncInfo2List *info2l;
     Error *err =3D NULL;
-    VncClientInfoList *client;
=20
-    info =3D qmp_query_vnc(&err);
+    info2l =3D qmp_query_vnc_servers(&err);
     if (err) {
         error_report_err(err);
         return;
     }
-
-    if (!info->enabled) {
-        monitor_printf(mon, "Server: disabled\n");
-        goto out;
-    }
-
-    monitor_printf(mon, "Server:\n");
-    if (info->has_host && info->has_service) {
-        monitor_printf(mon, "     address: %s:%s\n", info->host, info->s=
ervice);
-    }
-    if (info->has_auth) {
-        monitor_printf(mon, "        auth: %s\n", info->auth);
+    if (!info2l) {
+        monitor_printf(mon, "None\n");
+        return;
     }
=20
-    if (!info->has_clients || info->clients =3D=3D NULL) {
-        monitor_printf(mon, "Client: none\n");
-    } else {
-        for (client =3D info->clients; client; client =3D client->next) =
{
-            monitor_printf(mon, "Client:\n");
-            monitor_printf(mon, "     address: %s:%s\n",
-                           client->value->host,
-                           client->value->service);
-            monitor_printf(mon, "  x509_dname: %s\n",
-                           client->value->x509_dname ?
-                           client->value->x509_dname : "none");
-            monitor_printf(mon, "    username: %s\n",
-                           client->value->has_sasl_username ?
-                           client->value->sasl_username : "none");
+    while (info2l) {
+        VncInfo2 *info =3D info2l->value;
+        monitor_printf(mon, "%s:\n", info->id);
+        hmp_info_vnc_servers(mon, info->server);
+        hmp_info_vnc_clients(mon, info->clients);
+        if (!info->server) {
+            /* The server entry displays its auth, we only
+             * need to display in the case of 'reverse' connections
+             * where there's no server.
+             */
+            hmp_info_vnc_authcrypt(mon, "  ", info->auth,
+                               info->has_vencrypt ? &info->vencrypt : NU=
LL);
         }
+        if (info->has_display) {
+            monitor_printf(mon, "  Display: %s\n", info->display);
+        }
+        info2l =3D info2l->next;
     }
=20
-out:
-    qapi_free_VncInfo(info);
+    qapi_free_VncInfo2List(info2l);
+
 }
=20
 #ifdef CONFIG_SPICE
--=20
2.13.0
