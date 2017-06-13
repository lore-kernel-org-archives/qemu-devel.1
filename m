Received: from eggs.gnu.org ([2001:4830:134:3::10]:50808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4N-0004IQ-Er
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4K-0000QD-Vh
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4K-0000Q6-Q7
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:03 -0300
Message-Id: <20170613165313.20954-6-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 05/15] qapi: Use IGNORE_ERRORS instead of NULL on
 generated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qapi-commands.py | 6 +++---
 scripts/qapi-types.py    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 1943de4852..afa58915ba 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -75,7 +75,7 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
     error_propagate(errp, err);
     visit_free(v);
     v = qapi_dealloc_visitor_new();
-    visit_type_%(c_name)s(v, "unused", &ret_in, NULL);
+    visit_type_%(c_name)s(v, "unused", &ret_in, IGNORE_ERRORS);
     visit_free(v);
 }
 ''',
@@ -162,7 +162,7 @@ out:
 ''')
 
     if have_args:
-        visit_members = ('visit_type_%s_members(v, &arg, NULL);'
+        visit_members = ('visit_type_%s_members(v, &arg, IGNORE_ERRORS);'
                          % arg_type.c_name())
     else:
         visit_members = ''
@@ -173,7 +173,7 @@ out:
 
     ret += mcgen('''
     v = qapi_dealloc_visitor_new();
-    visit_start_struct(v, NULL, NULL, 0, NULL);
+    visit_start_struct(v, NULL, NULL, 0, IGNORE_ERRORS);
     %(visit_members)s
     visit_end_struct(v, NULL);
     visit_free(v);
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 814ac672be..ab78fa56e9 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -157,7 +157,7 @@ void qapi_free_%(c_name)s(%(c_name)s *obj)
     }
 
     v = qapi_dealloc_visitor_new();
-    visit_type_%(c_name)s(v, NULL, &obj, NULL);
+    visit_type_%(c_name)s(v, NULL, &obj, IGNORE_ERRORS);
     visit_free(v);
 }
 ''',
-- 
2.11.0.259.g40922b1
