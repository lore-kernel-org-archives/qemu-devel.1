Received: from eggs.gnu.org ([209.51.188.92]:40358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaL-0005CN-53
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaI-0006uY-SR
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:43588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1gycaI-0006tP-Bv
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:46 -0500
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Tue, 26 Feb 2019 16:15:34 +0300
Message-Id: <20190226131535.30361-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/3] hmp: add compress-type parameter to
 migration parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, qemu-devel@nongnu.org

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..5f105b816f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -334,6 +334,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     params = qmp_query_migrate_parameters(NULL);
 
     if (params) {
+        assert(params->has_compress_type);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_TYPE),
+            params->compress_type);
         assert(params->has_compress_level);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
@@ -1757,6 +1761,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_max_postcopy_bandwidth = true;
         visit_type_size(v, param, &p->max_postcopy_bandwidth, &err);
         break;
+    case MIGRATION_PARAMETER_COMPRESS_TYPE:
+        p->has_compress_type = true;
+        visit_type_int(v, param, &p->compress_type, &err);
+        break;
     default:
         assert(0);
     }
-- 
2.17.0
