Received: from eggs.gnu.org ([2001:4830:134:3::10]:38034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsj7-0003Sm-Ip
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsj1-0007nf-R4
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsj1-0007nQ-IT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:39 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBD51C00AFDA
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:22 +0400
Message-Id: <20170118160332.13390-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/25] monitor: suspend when running async
 and client has no async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When the client doesn't support 'async' capability, let's suspend the
monitor until the on-going async command completes. That way, the client
will be able to use -async commands, but will get only in order
reply: (t won't be able to do concurrent commands. In this case, the
'id' field isn't mandatory.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c           | 32 +++++++++++++++++++++++++++++++-
 qapi/qmp-dispatch.c |  3 ++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index c5c70d7e17..3ff32c000c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -165,6 +165,7 @@ typedef struct {
      * mode.
      */
     bool in_command_mode;       /* are we in command mode? */
+    QObject *suspended;
     QmpClient client;
 } MonitorQMP;
=20
@@ -3675,9 +3676,10 @@ static int monitor_can_read(void *opaque)
 {
     Monitor *mon =3D opaque;
=20
-    return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
+    return (mon->suspend_cnt =3D=3D 0 && !mon->qmp.suspended) ? 1 : 0;
 }
=20
+
 static bool invalid_qmp_mode(const Monitor *mon, const char *cmd,
                              Error **errp)
 {
@@ -3754,11 +3756,33 @@ static QDict *qmp_check_input_obj(QObject *input_=
obj, Error **errp)
     return input_dict;
 }
=20
+static void monitor_qmp_suspend(Monitor *mon, QObject *req)
+{
+    assert(monitor_is_qmp(mon));
+    assert(!mon->qmp.suspended);
+
+    qobject_incref(req);
+    mon->qmp.suspended =3D req;
+}
+
+static void monitor_qmp_resume(Monitor *mon)
+{
+    assert(monitor_is_qmp(mon));
+    assert(mon->qmp.suspended);
+
+    qobject_decref(mon->qmp.suspended);
+    mon->qmp.suspended =3D NULL;
+}
+
 static void qmp_dispatch_return(QmpClient *client, QObject *rsp)
 {
     Monitor *mon =3D container_of(client, Monitor, qmp.client);
=20
     monitor_json_emitter(mon, rsp);
+
+    if (mon->qmp.suspended) {
+        monitor_qmp_resume(mon);
+    }
 }
=20
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
@@ -3797,6 +3821,12 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
     }
=20
     qmp_dispatch(&mon->qmp.client, req, rqdict);
+
+    /* suspend if the command is on-going and client doesn't support asy=
nc */
+    if (!QLIST_EMPTY(&mon->qmp.client.pending) && !mon->qmp.client.has_a=
sync) {
+        monitor_qmp_suspend(mon, req);
+    }
+
     qobject_decref(req);
     return;
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 76c7402ac8..5bf4b1b520 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -109,7 +109,8 @@ static QObject *do_qmp_dispatch(QObject *request, Qmp=
Return *qret, Error **errp)
         }
         break;
     case QCT_ASYNC:
-        if (!qdict_haskey(qret->rsp, "id")) {
+        if (qret->client->has_async &&
+            !qdict_haskey(qret->rsp, "id")) {
             error_setg(errp, "An async command requires an 'id'");
             break;
         }
--=20
2.11.0.295.gd7dffce1c
