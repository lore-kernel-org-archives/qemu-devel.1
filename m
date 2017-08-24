Received: from eggs.gnu.org ([2001:4830:134:3::10]:37150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmO-0003PO-J2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmL-0000NM-D4
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmL-0000ML-36
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:17 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:45:56 +0200
Message-Id: <1503564371-26090-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/16] qapi: Update qapi-code-gen.txt examples
 to match current code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9903ac4..ae05327 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -957,6 +957,8 @@ Example:
 
     typedef struct UserDefOneList UserDefOneList;
 
+    typedef struct q_obj_my_command_arg q_obj_my_command_arg;
+
     struct UserDefOne {
         int64_t integer;
         bool has_string;
@@ -972,6 +974,10 @@ Example:
 
     void qapi_free_UserDefOneList(UserDefOneList *obj);
 
+    struct q_obj_my_command_arg {
+        UserDefOneList *arg1;
+    };
+
     #endif
     $ cat qapi-generated/example-qapi-types.c
 [Uninteresting stuff omitted...]
@@ -1036,6 +1042,8 @@ Example:
     void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
     void visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp);
 
+    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp);
+
     #endif
     $ cat qapi-generated/example-qapi-visit.c
 [Uninteresting stuff omitted...]
@@ -1104,6 +1112,9 @@ Example:
             }
         }
 
+        if (!err) {
+            visit_check_list(v, &err);
+        }
         visit_end_list(v, (void **)obj);
         if (err && visit_is_input(v)) {
             qapi_free_UserDefOneList(*obj);
@@ -1113,6 +1124,19 @@ Example:
         error_propagate(errp, err);
     }
 
+    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp)
+    {
+        Error *err = NULL;
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
 === scripts/qapi-commands.py ===
 
 Used to generate the marshaling/dispatch functions for the commands
@@ -1145,9 +1169,12 @@ Example:
 
     #include "example-qapi-types.h"
     #include "qapi/qmp/qdict.h"
+    #include "qapi/qmp/dispatch.h"
     #include "qapi/error.h"
 
+    void example_qmp_init_marshal(QmpCommandList *cmds);
     UserDefOne *qmp_my_command(UserDefOneList *arg1, Error **errp);
+    void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp);
 
     #endif
     $ cat qapi-generated/example-qmp-marshal.c
@@ -1170,19 +1197,19 @@ Example:
         visit_free(v);
     }
 
-    static void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp)
+    void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp)
     {
         Error *err = NULL;
         UserDefOne *retval;
         Visitor *v;
-        UserDefOneList *arg1 = NULL;
+        q_obj_my_command_arg arg = {0};
 
         v = qobject_input_visitor_new(QOBJECT(args));
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
 
-        retval = qmp_my_command(arg1, &err);
+        retval = qmp_my_command(arg.arg1, &err);
         if (err) {
             goto out;
         }
@@ -1203,17 +1230,18 @@ Example:
         visit_free(v);
         v = qapi_dealloc_visitor_new();
         visit_start_struct(v, NULL, NULL, 0, NULL);
-        visit_type_UserDefOneList(v, "arg1", &arg1, NULL);
+        visit_type_q_obj_my_command_arg_members(v, &arg, NULL);
         visit_end_struct(v, NULL);
         visit_free(v);
     }
 
-    static void qmp_init_marshal(void)
+    void example_qmp_init_marshal(QmpCommandList *cmds)
     {
-        qmp_register_command("my-command", qmp_marshal_my_command, QCO_NO_OPTIONS);
-    }
+        QTAILQ_INIT(cmds);
 
-    qapi_init(qmp_init_marshal);
+        qmp_register_command(cmds, "my-command",
+                             qmp_marshal_my_command, QCO_NO_OPTIONS);
+    }
 
 === scripts/qapi-event.py ===
 
@@ -1258,6 +1286,7 @@ Example:
         QDict *qmp;
         Error *err = NULL;
         QMPEventFuncEmit emit;
+
         emit = qmp_event_get_func_emit();
         if (!emit) {
             return;
-- 
2.7.5
