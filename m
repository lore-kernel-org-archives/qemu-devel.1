Received: from eggs.gnu.org ([2001:4830:134:3::10]:59677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoH-0004vH-DY
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWo9-00067x-9t
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWo8-00064b-U9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E84574173BB6
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 11:59:49 +0100
Message-Id: <20180307110010.2205-4-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 03/24] migration: Create tcp_port parameter
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
index 016cb5c4f1..b37605d86a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -355,6 +355,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        monitor_printf(mon, "%s: %d\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_X_TCP_PORT),
+            params->x_tcp_port);
     }
 
     qapi_free_MigrationParameters(params);
diff --git a/migration/migration.c b/migration/migration.c
index e345d0cc7e..31b16a335b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -545,6 +545,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_multifd_page_count = s->parameters.x_multifd_page_count;
     params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
+    params->has_x_tcp_port = true;
+    params->x_tcp_port = s->parameters.x_tcp_port;
 
     return params;
 }
@@ -912,6 +914,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
+    if (params->has_x_tcp_port) {
+        dest->x_tcp_port = params->x_tcp_port;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -984,6 +989,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
     }
+    if (params->has_x_tcp_port) {
+        s->parameters.x_tcp_port = params->x_tcp_port;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 7f465a1902..b6ef193f47 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -490,6 +490,9 @@
 #                     and a power of 2
 #                     (Since 2.11)
 #
+# @x-tcp-port: Only used for tcp, to know what the real port is
+#                     (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -498,7 +501,7 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
-           'xbzrle-cache-size' ] }
+           'xbzrle-cache-size', 'x-tcp-port' ] }
 
 ##
 # @MigrateSetParameters:
@@ -566,6 +569,10 @@
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
@@ -584,7 +591,8 @@
             '*block-incremental': 'bool',
             '*x-multifd-channels': 'int',
             '*x-multifd-page-count': 'int',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*x-tcp-port': 'uint16'} }
 
 ##
 # @migrate-set-parameters:
@@ -667,6 +675,10 @@
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
@@ -683,7 +695,8 @@
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
