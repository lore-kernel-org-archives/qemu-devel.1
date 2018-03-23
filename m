Received: from eggs.gnu.org ([2001:4830:134:3::10]:58121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ezK0k-0003W0-3Z
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ezK0h-0000Bx-1C
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:33:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ezK0g-00006x-Sr
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18B1C722DA
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 10:33:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Mar 2018 11:32:39 +0100
Message-Id: <20180323103239.32414-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] monitor: fix expected qmp_capabilities error
 description regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Fix regression introduced in commit cf869d53172920536a14180a83292b240e9d0=
545:

Before:
{"execute":"foo"}
{"error": {"class": "CommandNotFound", "desc": "Expecting capabilities ne=
gotiation with 'qmp_capabilities'"}}

After:
{"execute":"foo"}
{"error": {"class": "CommandNotFound", "desc": "The command foo has not b=
een found"}}

Because qmp_cmd_oob_check() happens before
monitor_qmp_dispatch_one(). Move the error manipulation code to
monitor_qmp_respond() instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6ccd2fc089..d57bbbb134 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3997,6 +3997,18 @@ static void monitor_qmp_respond(Monitor *mon, QObj=
ect *rsp,
             qdict_put_obj(qobject_to(QDict, rsp), "id", id);
         }
=20
+        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+            qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
+            if (qdict
+                && !g_strcmp0(qdict_get_try_str(qdict, "class"),
+                          QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOU=
ND))) {
+                /* Provide a more useful error message */
+                qdict_del(qdict, "desc");
+                qdict_put_str(qdict, "desc", "Expecting capabilities"
+                              " negotiation with 'qmp_capabilities'");
+            }
+        }
+
         monitor_json_emitter(mon, rsp);
     }
=20
@@ -4028,7 +4040,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
 {
     Monitor *mon, *old_mon;
     QObject *req, *rsp =3D NULL, *id;
-    QDict *qdict =3D NULL;
     bool need_resume;
=20
     req =3D req_obj->req;
@@ -4051,18 +4062,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *r=
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
2.17.0.rc1.1.g4c4f2b46a3
