Received: from eggs.gnu.org ([2001:4830:134:3::10]:34843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKU-0003Qm-8P
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHKR-0001fF-6U
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgHKR-0001ek-00
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:46:31 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F39007F368
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:46:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:46:26 +0100
Message-Id: <1487709988-14322-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487709988-14322-1-git-send-email-armbru@redhat.com>
References: <1487709988-14322-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] numa: Flatten simple union NumaOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Simple unions are simpler than flat unions in the schema, but more
complicated in C and on the QMP wire: there's extra indirection in C
and extra nesting on the wire, both pointless.  They're best avoided
in new code.

NumaOptions isn't new, but it's only used internally, not in QMP.
Convert it to a flat union.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 numa.c           |  4 ++--
 qapi-schema.json | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index 9f56be9..e01cb54 100644
--- a/numa.c
+++ b/numa.c
@@ -228,8 +228,8 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
     }
 
     switch (object->type) {
-    case NUMA_OPTIONS_KIND_NODE:
-        numa_node_parse(object->u.node.data, opts, &err);
+    case NUMA_OPTIONS_TYPE_NODE:
+        numa_node_parse(&object->u.node, opts, &err);
         if (err) {
             goto end;
         }
diff --git a/qapi-schema.json b/qapi-schema.json
index e9a6364..a448ea8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5571,6 +5571,14 @@
             'events' : [ 'InputEvent' ] } }
 
 ##
+# @NumaOptionsType:
+#
+# Since: 2.1
+##
+{ 'enum': 'NumaOptionsType',
+  'data': [ 'node' ] }
+
+##
 # @NumaOptions:
 #
 # A discriminated record of NUMA options. (for OptsVisitor)
@@ -5578,6 +5586,8 @@
 # Since: 2.1
 ##
 { 'union': 'NumaOptions',
+  'base': { 'type': 'NumaOptionsType' },
+  'discriminator': 'type',
   'data': {
     'node': 'NumaNodeOptions' }}
 
-- 
2.7.4
