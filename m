Received: from eggs.gnu.org ([2001:4830:134:3::10]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2q-0001x1-O6
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2p-0005hy-KT
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcX2p-0005gs-ET
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:17:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  1 Aug 2017 14:16:18 +0100
Message-Id: <20170801131618.27332-10-stefanha@redhat.com>
In-Reply-To: <20170801131618.27332-1-stefanha@redhat.com>
References: <20170801131618.27332-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] monitor: Reduce handle_qmp_command()
 tracing overhead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: "Denis V. Lunev" <den@openvz.org>

We are malloc'ing a QString and spending CPU cycles on converting a
QObject to string, just for the sake of sticking the string in the trace
message.  Wasted when we aren't tracing.  Avoid that.

[Commit message and description suggested by Markus Armbruster to
provide more detail about the rationale for this patch.

Use trace_event_get_state_backends() instead of trace_event_get_state()
to honor DTrace/UST backend dstates.
--Stefan]

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170725143923.11241-1-den@openvz.org
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6d040e620f..e0f880107f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3823,7 +3823,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
     QDict *qdict =3D NULL;
     Monitor *mon =3D cur_mon;
     Error *err =3D NULL;
-    QString *req_json;
=20
     req =3D json_parser_parse_err(tokens, NULL, &err);
     if (!req && !err) {
@@ -3841,9 +3840,11 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
         qdict_del(qdict, "id");
     } /* else will fail qmp_dispatch() */
=20
-    req_json =3D qobject_to_json(req);
-    trace_handle_qmp_command(mon, qstring_get_str(req_json));
-    QDECREF(req_json);
+    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
+        QString *req_json =3D qobject_to_json(req);
+        trace_handle_qmp_command(mon, qstring_get_str(req_json));
+        QDECREF(req_json);
+    }
=20
     rsp =3D qmp_dispatch(cur_mon->qmp.commands, req);
=20
--=20
2.13.3
