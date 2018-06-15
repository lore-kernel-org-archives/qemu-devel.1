Received: from eggs.gnu.org ([2001:4830:134:3::10]:58895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0U-00007K-1D
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0S-0006cy-Mg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:22 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Jun 2018 16:51:00 +0100
Message-Id: <20180615155103.11924-4-berrange@redhat.com>
In-Reply-To: <20180615155103.11924-1-berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] migration: add support for a "tls-authz"
 migration parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The QEMU instance that runs as the server for the migration data
transport (ie the target QEMU) needs to be able to configure access
control so it can prevent unauthorized clients initiating an incoming
migration. This adds a new 'tls-authz' migration parameter that is used
to provide the QOM ID of a QAuthZ subclass instance that provides the
access control check. This is checked against the x509 certificate
obtained during the TLS handshake.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hmp.c                 |  9 +++++++++
 migration/migration.c |  8 ++++++++
 migration/tls.c       |  2 +-
 qapi/migration.json   | 12 +++++++++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 74e18db103..bef8ea2531 100644
--- a/hmp.c
+++ b/hmp.c
@@ -370,6 +370,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        monitor_printf(mon, " %s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
+            params->has_tls_authz ? params->tls_authz : "");
     }
 
     qapi_free_MigrationParameters(params);
@@ -1632,6 +1635,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->tls_hostname->type = QTYPE_QSTRING;
         visit_type_str(v, param, &p->tls_hostname->u.s, &err);
         break;
+    case MIGRATION_PARAMETER_TLS_AUTHZ:
+        p->has_tls_authz = true;
+        p->tls_authz = g_new0(StrOrNull, 1);
+        p->tls_authz->type = QTYPE_QSTRING;
+        visit_type_str(v, param, &p->tls_authz->u.s, &err);
+        break;
     case MIGRATION_PARAMETER_MAX_BANDWIDTH:
         p->has_max_bandwidth = true;
         /*
diff --git a/migration/migration.c b/migration/migration.c
index 1e99ec9b7e..d14c8d7003 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -645,6 +645,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->tls_creds = g_strdup(s->parameters.tls_creds);
     params->has_tls_hostname = true;
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
+    params->has_tls_authz = true;
+    params->tls_authz = g_strdup(s->parameters.tls_authz);
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
     params->has_downtime_limit = true;
@@ -1106,6 +1108,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
     }
 
+    if (params->has_tls_authz) {
+        g_free(s->parameters.tls_authz);
+        assert(params->tls_authz->type == QTYPE_QSTRING);
+        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+    }
+
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
         if (s->to_dst_file) {
diff --git a/migration/tls.c b/migration/tls.c
index 3b9e8c9263..5171afc6c4 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -94,7 +94,7 @@ void migration_tls_channel_process_incoming(MigrationState *s,
 
     tioc = qio_channel_tls_new_server(
         ioc, creds,
-        NULL, /* XXX pass ACL name */
+        s->parameters.tls_authz,
         errp);
     if (!tioc) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index f7e10ee90f..b9ba34e3a6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -488,6 +488,10 @@
 #                hostname must be provided so that the server's x509
 #                certificate identity can be validated. (Since 2.7)
 #
+# @tls-authz: ID of the 'authz' object subclass that provides access control
+#             checking of the TLS x509 certificate distinguished name. (Since
+#             2.13)
+#
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
 #
@@ -522,7 +526,7 @@
 { 'enum': 'MigrationParameter',
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
            'cpu-throttle-initial', 'cpu-throttle-increment',
-           'tls-creds', 'tls-hostname', 'max-bandwidth',
+           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
            'xbzrle-cache-size' ] }
@@ -605,6 +609,7 @@
             '*cpu-throttle-increment': 'int',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
+            '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
@@ -667,6 +672,10 @@
 #                associated with the migration URI, if any. (Since 2.9)
 #                Note: 2.8 reports this by omitting tls-hostname instead.
 #
+# @tls-authz: ID of the 'authz' object subclass that provides access control
+#             checking of the TLS x509 certificate distinguished name. (Since
+#             2.13)
+#
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
 #
@@ -704,6 +713,7 @@
             '*cpu-throttle-increment': 'uint8',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
+            '*tls-authz': 'str',
             '*max-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': 'uint32',
-- 
2.17.0
