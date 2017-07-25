Received: from eggs.gnu.org ([2001:4830:134:3::10]:35715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1da0zu-0000Gn-5G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1da0zp-0008HV-8b
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:39:42 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:8808 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1da0zo-0008FA-Tt
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:39:37 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 25 Jul 2017 17:39:23 +0300
Message-Id: <20170725143923.11241-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Calculate req_json only if trace_handle_qmp_command enabled.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
---
Changes from v1:
- written in the explicit for, as discussed in the mailing list

 monitor.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index d8ac20f6ca..2bfeb9bbcc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3822,7 +3822,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
     QDict *qdict =3D NULL;
     Monitor *mon =3D cur_mon;
     Error *err =3D NULL;
-    QString *req_json;
=20
     req =3D json_parser_parse_err(tokens, NULL, &err);
     if (!req && !err) {
@@ -3840,9 +3839,11 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
         qdict_del(qdict, "id");
     } /* else will fail qmp_dispatch() */
=20
-    req_json =3D qobject_to_json(req);
-    trace_handle_qmp_command(mon, qstring_get_str(req_json));
-    qobject_decref(QOBJECT(req_json));
+    if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
+        QString *req_json =3D qobject_to_json(req);
+        trace_handle_qmp_command(mon, qstring_get_str(req_json));
+        qobject_decref(QOBJECT(req_json));
+    }
=20
     rsp =3D qmp_dispatch(cur_mon->qmp.commands, req);
=20
--=20
2.11.0
