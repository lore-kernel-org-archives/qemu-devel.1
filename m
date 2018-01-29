Received: from eggs.gnu.org ([2001:4830:134:3::10]:43658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8O1-0004Vl-8U
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Nv-0000zh-00
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8Nu-0000zG-OK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 197C681239
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:18:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:17:50 +0100
Message-Id: <20180129121754.13033-2-quintela@redhat.com>
In-Reply-To: <20180129121754.13033-1-quintela@redhat.com>
References: <20180129121754.13033-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 1/5] migration: Create tcp_port parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

It will be used to store the uri tcp_port parameter.  This is the only
parameter than can change and we can need to be able to connect to it.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

This used to be uri parameter, but it has so many troubles to
reproduce that it don't just make sense.
---
 hmp.c                 |  3 +++
 migration/migration.c |  8 ++++++++
 qapi/migration.json   | 19 ++++++++++++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index b3de32d219..369cb991f2 100644
--- a/hmp.c
+++ b/hmp.c
@@ -345,6 +345,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        monitor_printf(mon, "%s: %d\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_X_TCP_PORT),
+            params->x_tcp_port);
     }
 
     qapi_free_MigrationParameters(params);
diff --git a/migration/migration.c b/migration/migration.c
index 44cbfb0ddd..eb6958dcda 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -522,6 +522,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_multifd_page_count = s->parameters.x_multifd_page_count;
     params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
+    params->has_x_tcp_port = true;
+    params->x_tcp_port = s->parameters.x_tcp_port;
 
     return params;
 }
@@ -889,6 +891,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
+    if (params->has_x_tcp_port) {
+        dest->x_tcp_port = params->x_tcp_port;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -961,6 +966,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
     }
+    if (params->has_x_tcp_port) {
+        s->parameters.x_tcp_port = params->x_tcp_port;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 4cd3d13158..26661b0df6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -488,6 +488,9 @@
 #                     and a power of 2
 #                     (Since 2.11)
 #
+# @x-tcp-port: Only used for tcp, to know what the real port is
+#                     (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -496,7 +499,7 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
-           'xbzrle-cache-size' ] }
+           'xbzrle-cache-size', 'x-tcp-port' ] }
 
 ##
 # @MigrateSetParameters:
@@ -564,6 +567,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @x-tcp-port: Only used for tcp, to know what the real port is
+#                     (Since 2.12)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -582,7 +589,8 @@
             '*block-incremental': 'bool',
             '*x-multifd-channels': 'int',
             '*x-multifd-page-count': 'int',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*x-tcp-port': 'uint16'} }
 
 ##
 # @migrate-set-parameters:
@@ -665,6 +673,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @x-tcp-port: Only used for tcp, to know what the real port is
+#                     (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -681,7 +693,8 @@
             '*block-incremental': 'bool' ,
             '*x-multifd-channels': 'uint8',
             '*x-multifd-page-count': 'uint32',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*x-tcp-port': 'uint16'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.14.3
