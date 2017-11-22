Received: from eggs.gnu.org ([2001:4830:134:3::10]:39068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUMK-0004gU-Aa
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUMJ-0007A1-76
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHUMI-00079f-Uz
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:42:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 179783C92
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 12:42:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Nov 2017 13:42:16 +0100
Message-Id: <20171122124219.12954-4-quintela@redhat.com>
In-Reply-To: <20171122124219.12954-1-quintela@redhat.com>
References: <20171122124219.12954-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] migration: Create uri parameter
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

It will be used to store the uri migration parameter.  Right now it is
just the parameter code.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 |  7 +++++++
 migration/migration.c | 13 +++++++++++++
 qapi/migration.json   | 18 +++++++++++++++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 35a7041824..c9241f6947 100644
--- a/hmp.c
+++ b/hmp.c
@@ -345,6 +345,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_URI),
+            params->uri);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1659,6 +1662,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         }
         p->xbzrle_cache_size = cache_size;
         break;
+    case MIGRATION_PARAMETER_URI:
+        p->has_uri = true;
+        visit_type_str(v, param, &p->uri, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/migration.c b/migration/migration.c
index 706d2407ec..3e48d37880 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -517,6 +517,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_multifd_page_count = s->parameters.x_multifd_page_count;
     params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
+    params->has_uri = true;
+    params->uri = g_strdup(s->parameters.uri);
 
     return params;
 }
@@ -893,6 +895,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
+    if (params->has_uri) {
+        dest->uri = g_strdup(params->uri);
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -965,6 +970,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
     }
+    if (params->has_uri) {
+        g_free(s->parameters.uri);
+        s->parameters.uri = g_strdup(params->uri);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -2431,6 +2440,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
+    DEFINE_PROP_STRING("x-uri", MigrationState,
+                       parameters.uri),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -2465,6 +2476,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->error_mutex);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    g_free(params->uri);
     qemu_sem_destroy(&ms->pause_sem);
 }
 
@@ -2480,6 +2492,7 @@ static void migration_instance_init(Object *obj)
 
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->uri = g_strdup("");
 
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
diff --git a/qapi/migration.json b/qapi/migration.json
index bbc4671ded..ebde890604 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -488,6 +488,9 @@
 #                     and a power of 2
 #                     (Since 2.11)
 #
+# @uri: defines the method we are susing to migrate
+#                     (Since 2.11)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -496,7 +499,7 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
-           'xbzrle-cache-size' ] }
+           'xbzrle-cache-size', 'uri' ] }
 
 ##
 # @MigrateSetParameters:
@@ -564,6 +567,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @uri: defines the method we are susing to migrate
+#                     (Since 2.11)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -582,7 +589,8 @@
             '*block-incremental': 'bool',
             '*x-multifd-channels': 'int',
             '*x-multifd-page-count': 'int',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size' ,
+            '*uri': 'str'} }
 
 ##
 # @migrate-set-parameters:
@@ -665,6 +673,9 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @uri: defines the method we are susing to migrate
+#                     (Since 2.11)
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -681,7 +692,8 @@
             '*block-incremental': 'bool' ,
             '*x-multifd-channels': 'int',
             '*x-multifd-page-count': 'int',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size' ,
+            '*uri': 'str'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.13.6
