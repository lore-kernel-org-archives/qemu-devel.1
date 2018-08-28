Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujXN-0006O1-Vp
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujO6-0004kC-Og
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujO6-0004gj-EB
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1137E8076895
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C40511049496
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Aug 2018 21:10:46 +0200
Message-Id: <20180828191048.29806-5-armbru@redhat.com>
In-Reply-To: <20180828191048.29806-1-armbru@redhat.com>
References: <20180828191048.29806-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] qapi: Update docs for generator changes
 since commit 9ee86b85267
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
Message-Id: <20180828120736.32323-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 131 ++++++++++++++++++++++++++---------
 1 file changed, 100 insertions(+), 31 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 220791d737..304c12d0ae 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1035,7 +1035,7 @@ Example:
     #ifndef EXAMPLE_QAPI_TYPES_H
     #define EXAMPLE_QAPI_TYPES_H
 
-[Built-in types omitted...]
+    #include "qapi/qapi-builtin-types.h"
 
     typedef struct UserDefOne UserDefOne;
 
@@ -1062,7 +1062,7 @@ Example:
         UserDefOneList *arg1;
     };
 
-    #endif
+    #endif /* EXAMPLE_QAPI_TYPES_H */
     $ cat qapi-generated/example-qapi-types.c
 [Uninteresting stuff omitted...]
 
@@ -1092,6 +1092,8 @@ Example:
         visit_free(v);
     }
 
+[Uninteresting stuff omitted...]
+
 === Code generated for visiting QAPI types ===
 
 These are the visitor functions used to walk through and convert
@@ -1118,7 +1120,9 @@ Example:
     #ifndef EXAMPLE_QAPI_VISIT_H
     #define EXAMPLE_QAPI_VISIT_H
 
-[Visitors for built-in types omitted...]
+    #include "qapi/qapi-builtin-visit.h"
+    #include "example-qapi-types.h"
+
 
     void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp);
     void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
@@ -1126,7 +1130,7 @@ Example:
 
     void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp);
 
-    #endif
+    #endif /* EXAMPLE_QAPI_VISIT_H */
     $ cat qapi-generated/example-qapi-visit.c
 [Uninteresting stuff omitted...]
 
@@ -1219,6 +1223,8 @@ Example:
         error_propagate(errp, err);
     }
 
+[Uninteresting stuff omitted...]
+
 === Code generated for commands ===
 
 These are the marshaling/dispatch functions for the commands defined
@@ -1238,18 +1244,17 @@ Example:
     $ cat qapi-generated/example-qapi-commands.h
 [Uninteresting stuff omitted...]
 
-    #ifndef EXAMPLE_QMP_COMMANDS_H
-    #define EXAMPLE_QMP_COMMANDS_H
+    #ifndef EXAMPLE_QAPI_COMMANDS_H
+    #define EXAMPLE_QAPI_COMMANDS_H
 
     #include "example-qapi-types.h"
-    #include "qapi/qmp/qdict.h"
     #include "qapi/qmp/dispatch.h"
 
-    void example_qmp_init_marshal(QmpCommandList *cmds);
     UserDefOne *qmp_my_command(UserDefOneList *arg1, Error **errp);
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp);
+    void example_qmp_init_marshal(QmpCommandList *cmds);
 
-    #endif
+    #endif /* EXAMPLE_QAPI_COMMANDS_H */
     $ cat qapi-generated/example-qapi-commands.c
 [Uninteresting stuff omitted...]
 
@@ -1316,6 +1321,8 @@ Example:
                              qmp_marshal_my_command, QCO_NO_OPTIONS);
     }
 
+[Uninteresting stuff omitted...]
+
 === Code generated for events ===
 
 This is the code related to events defined in the schema, providing
@@ -1333,10 +1340,10 @@ Example:
     $ cat qapi-generated/example-qapi-events.h
 [Uninteresting stuff omitted...]
 
-    #ifndef EXAMPLE_QAPI_EVENT_H
-    #define EXAMPLE_QAPI_EVENT_H
+    #ifndef EXAMPLE_QAPI_EVENTS_H
+    #define EXAMPLE_QAPI_EVENTS_H
 
-    #include "qapi/qmp/qdict.h"
+    #include "qapi/util.h"
     #include "example-qapi-types.h"
 
 
@@ -1348,11 +1355,11 @@ Example:
     } example_QAPIEvent;
 
     #define example_QAPIEvent_str(val) \
-        qapi_enum_lookup(example_QAPIEvent_lookup, (val))
+        qapi_enum_lookup(&example_QAPIEvent_lookup, (val))
 
-    extern const char *const example_QAPIEvent_lookup[];
+    extern const QEnumLookup example_QAPIEvent_lookup;
 
-    #endif
+    #endif /* EXAMPLE_QAPI_EVENTS_H */
     $ cat qapi-generated/example-qapi-events.c
 [Uninteresting stuff omitted...]
 
@@ -1380,6 +1387,8 @@ Example:
         .size = EXAMPLE_QAPI_EVENT__MAX
     };
 
+[Uninteresting stuff omitted...]
+
 === Code generated for introspection ===
 
 The following files are created:
@@ -1394,30 +1403,90 @@ Example:
     $ cat qapi-generated/example-qapi-introspect.h
 [Uninteresting stuff omitted...]
 
-    #ifndef EXAMPLE_QMP_INTROSPECT_H
-    #define EXAMPLE_QMP_INTROSPECT_H
+    #ifndef EXAMPLE_QAPI_INTROSPECT_H
+    #define EXAMPLE_QAPI_INTROSPECT_H
 
-    extern const QLitObject qmp_schema_qlit;
+    #include "qapi/qmp/qlit.h"
 
-    #endif
+    extern const QLitObject example_qmp_schema_qlit;
+
+    #endif /* EXAMPLE_QAPI_INTROSPECT_H */
     $ cat qapi-generated/example-qapi-introspect.c
 [Uninteresting stuff omitted...]
 
     const QLitObject example_qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         QLIT_QDICT(((QLitDictEntry[]) {
-            { "arg-type", QLIT_QSTR("0") },
-            { "meta-type", QLIT_QSTR("event") },
-            { "name", QLIT_QSTR("Event") },
-            { }
+            { "arg-type", QLIT_QSTR("0"), },
+            { "meta-type", QLIT_QSTR("command"), },
+            { "name", QLIT_QSTR("my-command"), },
+            { "ret-type", QLIT_QSTR("1"), },
+            {}
+        })),
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "arg-type", QLIT_QSTR("2"), },
+            { "meta-type", QLIT_QSTR("event"), },
+            { "name", QLIT_QSTR("MY_EVENT"), },
+            {}
+        })),
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "members", QLIT_QLIST(((QLitObject[]) {
+                QLIT_QDICT(((QLitDictEntry[]) {
+                    { "name", QLIT_QSTR("arg1"), },
+                    { "type", QLIT_QSTR("[1]"), },
+                    {}
+                })),
+                {}
+            })), },
+            { "meta-type", QLIT_QSTR("object"), },
+            { "name", QLIT_QSTR("0"), },
+            {}
+        })),
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "members", QLIT_QLIST(((QLitObject[]) {
+                QLIT_QDICT(((QLitDictEntry[]) {
+                    { "name", QLIT_QSTR("integer"), },
+                    { "type", QLIT_QSTR("int"), },
+                    {}
+                })),
+                QLIT_QDICT(((QLitDictEntry[]) {
+                    { "default", QLIT_QNULL, },
+                    { "name", QLIT_QSTR("string"), },
+                    { "type", QLIT_QSTR("str"), },
+                    {}
+                })),
+                {}
+            })), },
+            { "meta-type", QLIT_QSTR("object"), },
+            { "name", QLIT_QSTR("1"), },
+            {}
         })),
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
-                { }
-            })) },
-            { "meta-type", QLIT_QSTR("object") },
-            { "name", QLIT_QSTR("0") },
-            { }
-        })),
-        ...
-        { }
+                {}
+            })), },
+            { "meta-type", QLIT_QSTR("object"), },
+            { "name", QLIT_QSTR("2"), },
+            {}
+        })),
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "element-type", QLIT_QSTR("1"), },
+            { "meta-type", QLIT_QSTR("array"), },
+            { "name", QLIT_QSTR("[1]"), },
+            {}
+        })),
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "json-type", QLIT_QSTR("int"), },
+            { "meta-type", QLIT_QSTR("builtin"), },
+            { "name", QLIT_QSTR("int"), },
+            {}
+        })),
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "json-type", QLIT_QSTR("string"), },
+            { "meta-type", QLIT_QSTR("builtin"), },
+            { "name", QLIT_QSTR("str"), },
+            {}
+        })),
+        {}
     }));
+
+[Uninteresting stuff omitted...]
-- 
2.17.1
