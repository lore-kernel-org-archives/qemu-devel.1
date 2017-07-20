Received: from eggs.gnu.org ([2001:4830:134:3::10]:54187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HT-0003k0-1Y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HR-0003Aj-He
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Jul 2017 09:53:38 +0200
Message-Id: <1500537221-20556-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1500537221-20556-1-git-send-email-armbru@redhat.com>
References: <1500537221-20556-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/10] migration: Clean up around tls_creds,
 tls_hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

Optional MigrationParameters members tls_creds and tls_hostname can't
actually be absent outside qmp_migrate_set_parameters() since commit
4af245d (v2.9.0).

Note that commit 4af245d reverted the part of commit de63ab6 (v2.8.0)
that made tls_creds and tls_hostname absent instead of "" in the value
of query-migrate-parameters, even though commit de63ab6 called that a
mistake.  What a mess.

Drop the redundant tests for presence, and update documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c                 |  6 ++++--
 migration/migration.c |  4 ++--
 qapi-schema.json      | 11 +++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hmp.c b/hmp.c
index dae4604..d7b4727 100644
--- a/hmp.c
+++ b/hmp.c
@@ -313,12 +313,14 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT],
             params->cpu_throttle_increment);
+        assert(params->has_tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_CREDS],
-            params->has_tls_creds ? params->tls_creds : "");
+            params->tls_creds);
+        assert(params->has_tls_hostname);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_HOSTNAME],
-            params->has_tls_hostname ? params->tls_hostname : "");
+            params->tls_hostname);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_MAX_BANDWIDTH],
diff --git a/migration/migration.c b/migration/migration.c
index 7615391..88b9277 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -444,9 +444,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
     params->has_cpu_throttle_increment = true;
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->has_tls_creds = !!s->parameters.tls_creds;
+    params->has_tls_creds = true;
     params->tls_creds = g_strdup(s->parameters.tls_creds);
-    params->has_tls_hostname = !!s->parameters.tls_hostname;
+    params->has_tls_hostname = true;
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
diff --git a/qapi-schema.json b/qapi-schema.json
index 8b015be..62e7d07 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1054,9 +1054,7 @@
 # @MigrationParameters:
 #
 # Optional members can be omitted on input ('migrate-set-parameters')
-# but most members will always be present on output
-# ('query-migrate-parameters'), with the exception of tls-creds and
-# tls-hostname.
+# but members will always be present on output.
 #
 # @compress-level: compression level
 #
@@ -1077,10 +1075,10 @@
 #             channel. On the outgoing side of the migration, the credentials
 #             must be for a 'client' endpoint, while for the incoming side the
 #             credentials must be for a 'server' endpoint. Setting this
-#             will enable TLS for all migrations. The default is unset,
-#             resulting in unsecured migration at the QEMU level. (Since 2.7)
+#             to a non-empty string enables TLS for all migrations.
 #             An empty string means that QEMU will use plain text mode for
-#             migration, rather than TLS (Since 2.9)
+#             migration, rather than TLS (Since 2.7)
+#             Note: 2.8 reports this by omitting tls-creds instead.
 #
 # @tls-hostname: hostname of the target host for the migration. This
 #                is required when using x509 based TLS credentials and the
@@ -1090,6 +1088,7 @@
 #                certificate identity can be validated. (Since 2.7)
 #                An empty string means that QEMU will use the hostname
 #                associated with the migration URI, if any. (Since 2.9)
+#                Note: 2.8 reports this by omitting tls-hostname instead.
 #
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
-- 
2.7.5
