Received: from eggs.gnu.org ([2001:4830:134:3::10]:38590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXYxU-0002GB-SD
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXYxT-0005lP-8p
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXYxS-0005kU-Rf
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3E64C000797
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 20:51:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 21:51:08 +0100
Message-Id: <20180105205109.683-2-quintela@redhat.com>
In-Reply-To: <20180105205109.683-1-quintela@redhat.com>
References: <20180105205109.683-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/2] migration: Create tcp_port parameter
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
 hmp.c                 |  7 +++++++
 migration/migration.c | 10 ++++++++++
 qapi/migration.json   | 19 ++++++++++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 354baaa6b6..1bb9d5d8f8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -360,6 +360,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        monitor_printf(mon, "%s: %d\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_TCP_PORT),
+            params->tcp_port);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1674,6 +1677,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         }
         p->xbzrle_cache_size = cache_size;
         break;
+    case MIGRATION_PARAMETER_TCP_PORT:
+        p->has_tcp_port = true;
+        visit_type_uint16(v, param, &p->tcp_port, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/migration.c b/migration/migration.c
index 7a77b193c1..4cdd8ee31b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -522,6 +522,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_multifd_page_count = s->parameters.x_multifd_page_count;
     params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
+    params->has_tcp_port = true;
+    params->tcp_port = s->parameters.tcp_port;
 
     return params;
 }
@@ -923,6 +925,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
+    if (params->has_tcp_port) {
+        dest->tcp_port = params->tcp_port;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -995,6 +1000,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
     }
+    if (params->has_tcp_port) {
+        s->parameters.tcp_port = params->tcp_port;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -2470,6 +2478,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
+    DEFINE_PROP_UINT16("tcp-port", MigrationState,
+                       parameters.tcp_port, 0),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
diff --git a/qapi/migration.json b/qapi/migration.json
index 70e7b677ef..2be1400249 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -501,6 +501,9 @@
 #                     and a power of 2
 #                     (Since 2.11)
 #
+# @tcp-port: Only used for tcp, to know what the real port is
+#                     (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -509,7 +512,7 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
-           'xbzrle-cache-size' ] }
+           'xbzrle-cache-size', 'tcp-port' ] }
 
 ##
 # @MigrateSetParameters:
@@ -577,6 +580,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @tcp-port: Only used for tcp, to know what the real port is
+#                     (Since 2.12)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -595,7 +602,8 @@
             '*block-incremental': 'bool',
             '*x-multifd-channels': 'int',
             '*x-multifd-page-count': 'int',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*tcp-port': 'uint16'} }
 
 ##
 # @migrate-set-parameters:
@@ -678,6 +686,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @tcp-port: Only used for tcp, to know what the real port is
+#                     (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -694,7 +706,8 @@
             '*block-incremental': 'bool' ,
             '*x-multifd-channels': 'uint8',
             '*x-multifd-page-count': 'uint32',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*tcp-port': 'uint16'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.14.3
