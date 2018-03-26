Received: from eggs.gnu.org ([2001:4830:134:3::10]:38156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lml-0002Bl-6I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmh-0006ge-HE
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Lmh-0006gZ-CW
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8AF2722C0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:10 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:38:54 +0800
Message-Id: <20180326063901.27425-2-peterx@redhat.com>
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 1/8] qmp: fix qmp_capabilities error
 regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

When someone sents a command before QMP handshake, error was like this:

 {"execute": "query-cpus"}
 {"error": {"class": "CommandNotFound", "desc":
            "Expecting capabilities negotiation with 'qmp_capabilities'"}=
}

While after cf869d5317 it becomes:

 {"execute": "query-cpus"}
 {"error": {"class": "CommandNotFound", "desc":
            "The command query-cpus has not been found"}}

Fix it back to the nicer one.

Fixes: cf869d5317 ("qmp: support out-of-band (oob) execution", 2018-03-19=
)
Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/monitor.c b/monitor.c
index 77f4c41cfa..849fa23bf9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1203,8 +1203,14 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDict =
*req, Error **errp)
=20
     cmd =3D qmp_find_command(mon->qmp.commands, command);
     if (!cmd) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
-                  "The command %s has not been found", command);
+        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                      "Expecting capabilities negotiation "
+                      "with 'qmp_capabilities'");
+        } else {
+            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                      "The command %s has not been found", command);
+        }
         return false;
     }
=20
@@ -4027,7 +4033,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
 {
     Monitor *mon, *old_mon;
     QObject *req, *rsp =3D NULL, *id;
-    QDict *qdict =3D NULL;
     bool need_resume;
=20
     req =3D req_obj->req;
@@ -4050,18 +4055,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *r=
eq_obj)
=20
     cur_mon =3D old_mon;
=20
-    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
-        qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
-        if (qdict
-            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
-                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) =
{
-            /* Provide a more useful error message */
-            qdict_del(qdict, "desc");
-            qdict_put_str(qdict, "desc", "Expecting capabilities negotia=
tion"
-                          " with 'qmp_capabilities'");
-        }
-    }
-
     /* Respond if necessary */
     monitor_qmp_respond(mon, rsp, NULL, id);
=20
--=20
2.14.3
