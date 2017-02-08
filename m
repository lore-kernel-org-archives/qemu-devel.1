Received: from eggs.gnu.org ([2001:4830:134:3::10]:51444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbUjO-0004ge-N6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbUjL-0004vD-Fy
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:04:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cbUjL-0004v4-B5
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:04:27 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82B567FB7F
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 16:04:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Feb 2017 17:04:23 +0100
Message-Id: <1486569864-17005-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1486569864-17005-1-git-send-email-armbru@redhat.com>
References: <1486569864-17005-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] numa: Turn simple union NumaOptions into a
 flat union
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
---
 numa.c           | 4 ++--
 qapi-schema.json | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

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
index cbdffdd..f9a9941 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5545,6 +5545,12 @@
             'events' : [ 'InputEvent' ] } }
 
 ##
+# @NumaOptionsType:
+##
+{ 'enum': 'NumaOptionsType',
+  'data': [ 'node' ] }
+
+##
 # @NumaOptions:
 #
 # A discriminated record of NUMA options. (for OptsVisitor)
@@ -5552,6 +5558,8 @@
 # Since: 2.1
 ##
 { 'union': 'NumaOptions',
+  'base': { 'type': 'NumaOptionsType' },
+  'discriminator': 'type',
   'data': {
     'node': 'NumaNodeOptions' }}
 
-- 
2.7.4
