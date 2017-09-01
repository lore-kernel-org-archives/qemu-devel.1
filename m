Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1S-0006i3-EO
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1L-0001iP-Ml
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1L-0001h1-75
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C6C14629B
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C9C8260C2F
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:43 +0200
Message-Id: <20170901153758.8628-33-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 32/47] qapi: Update qapi-code-gen.txt
 examples to match current code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-2-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 47 +++++++++++++++++++++++++++++++++++---=
------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9903ac4c19..ae05327869 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -957,6 +957,8 @@ Example:
=20
     typedef struct UserDefOneList UserDefOneList;
=20
+    typedef struct q_obj_my_command_arg q_obj_my_command_arg;
+
     struct UserDefOne {
         int64_t integer;
         bool has_string;
@@ -972,6 +974,10 @@ Example:
=20
     void qapi_free_UserDefOneList(UserDefOneList *obj);
=20
+    struct q_obj_my_command_arg {
+        UserDefOneList *arg1;
+    };
+
     #endif
     $ cat qapi-generated/example-qapi-types.c
 [Uninteresting stuff omitted...]
@@ -1036,6 +1042,8 @@ Example:
     void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne =
**obj, Error **errp);
     void visit_type_UserDefOneList(Visitor *v, const char *name, UserDef=
OneList **obj, Error **errp);
=20
+    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_co=
mmand_arg *obj, Error **errp);
+
     #endif
     $ cat qapi-generated/example-qapi-visit.c
 [Uninteresting stuff omitted...]
@@ -1104,6 +1112,9 @@ Example:
             }
         }
=20
+        if (!err) {
+            visit_check_list(v, &err);
+        }
         visit_end_list(v, (void **)obj);
         if (err && visit_is_input(v)) {
             qapi_free_UserDefOneList(*obj);
@@ -1113,6 +1124,19 @@ Example:
         error_propagate(errp, err);
     }
=20
+    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_co=
mmand_arg *obj, Error **errp)
+    {
+        Error *err =3D NULL;
+
+        visit_type_UserDefOneList(v, "arg1", &obj->arg1, &err);
+        if (err) {
+            goto out;
+        }
+
+    out:
+        error_propagate(errp, err);
+    }
+
 =3D=3D=3D scripts/qapi-commands.py =3D=3D=3D
=20
 Used to generate the marshaling/dispatch functions for the commands
@@ -1145,9 +1169,12 @@ Example:
=20
     #include "example-qapi-types.h"
     #include "qapi/qmp/qdict.h"
+    #include "qapi/qmp/dispatch.h"
     #include "qapi/error.h"
=20
+    void example_qmp_init_marshal(QmpCommandList *cmds);
     UserDefOne *qmp_my_command(UserDefOneList *arg1, Error **errp);
+    void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp=
);
=20
     #endif
     $ cat qapi-generated/example-qmp-marshal.c
@@ -1170,19 +1197,19 @@ Example:
         visit_free(v);
     }
=20
-    static void qmp_marshal_my_command(QDict *args, QObject **ret, Error=
 **errp)
+    void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp=
)
     {
         Error *err =3D NULL;
         UserDefOne *retval;
         Visitor *v;
-        UserDefOneList *arg1 =3D NULL;
+        q_obj_my_command_arg arg =3D {0};
=20
         v =3D qobject_input_visitor_new(QOBJECT(args));
         visit_start_struct(v, NULL, NULL, 0, &err);
         if (err) {
             goto out;
         }
-        visit_type_UserDefOneList(v, "arg1", &arg1, &err);
+        visit_type_q_obj_my_command_arg_members(v, &arg, &err);
         if (!err) {
             visit_check_struct(v, &err);
         }
@@ -1191,7 +1218,7 @@ Example:
             goto out;
         }
=20
-        retval =3D qmp_my_command(arg1, &err);
+        retval =3D qmp_my_command(arg.arg1, &err);
         if (err) {
             goto out;
         }
@@ -1203,17 +1230,18 @@ Example:
         visit_free(v);
         v =3D qapi_dealloc_visitor_new();
         visit_start_struct(v, NULL, NULL, 0, NULL);
-        visit_type_UserDefOneList(v, "arg1", &arg1, NULL);
+        visit_type_q_obj_my_command_arg_members(v, &arg, NULL);
         visit_end_struct(v, NULL);
         visit_free(v);
     }
=20
-    static void qmp_init_marshal(void)
+    void example_qmp_init_marshal(QmpCommandList *cmds)
     {
-        qmp_register_command("my-command", qmp_marshal_my_command, QCO_N=
O_OPTIONS);
-    }
+        QTAILQ_INIT(cmds);
=20
-    qapi_init(qmp_init_marshal);
+        qmp_register_command(cmds, "my-command",
+                             qmp_marshal_my_command, QCO_NO_OPTIONS);
+    }
=20
 =3D=3D=3D scripts/qapi-event.py =3D=3D=3D
=20
@@ -1258,6 +1286,7 @@ Example:
         QDict *qmp;
         Error *err =3D NULL;
         QMPEventFuncEmit emit;
+
         emit =3D qmp_event_get_func_emit();
         if (!emit) {
             return;
--=20
2.13.5
