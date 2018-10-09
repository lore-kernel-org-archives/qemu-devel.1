Received: from eggs.gnu.org ([2001:4830:134:3::10]:53249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9s00-00064d-Qn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rzx-0004Ef-Ij
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:32 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 14:23:27 +0100
Message-Id: <20181009132330.7549-4-berrange@redhat.com>
In-Reply-To: <20181009132330.7549-1-berrange@redhat.com>
References: <20181009132330.7549-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/6] migration: add support for a
 "tls-authz" migration parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The QEMU instance that runs as the server for the migration data
transport (ie the target QEMU) needs to be able to configure access
control so it can prevent unauthorized clients initiating an incoming
migration. This adds a new 'tls-authz' migration parameter that is used
to provide the QOM ID of a QAuthZ subclass instance that provides the
access control check. This is checked against the x509 certificate
obtained during the TLS handshake.

For example, when starting a QEMU for incoming migration, it is
possible to give an example identity of the source QEMU that is
intended to be connecting later:

  $QEMU \
     -monitor stdio \
     -incoming defer \
     ...other args...

  (qemu) object_add tls-creds-x509,id=tls0,dir=/home/berrange/qemutls,\
             endpoint=server,verify-peer=yes \
  (qemu) object_add authz-simple,id=auth0,identity=CN=laptop.example.com,,\
             O=Example Org,,L=London,,ST=London,,C=GB \
  (qemu) migrate_incoming tcp:localhost:9000

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hmp.c                 |  9 +++++++++
 migration/migration.c |  8 ++++++++
 migration/tls.c       |  2 +-
 qapi/migration.json   | 14 +++++++++++++-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 7fc5a6502f..52ee5e5444 100644
--- a/hmp.c
+++ b/hmp.c
@@ -396,6 +396,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
+        monitor_printf(mon, " %s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
+            params->has_tls_authz ? params->tls_authz : "");
     }
 
     qapi_free_MigrationParameters(params);
@@ -1702,6 +1705,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index d6ae879dc8..f8d0251885 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -685,6 +685,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->tls_creds = g_strdup(s->parameters.tls_creds);
     params->has_tls_hostname = true;
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
+    params->has_tls_authz = true;
+    params->tls_authz = g_strdup(s->parameters.tls_authz);
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
     params->has_downtime_limit = true;
@@ -1188,6 +1190,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
index 6e8c21258a..9c656effb0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -519,6 +519,12 @@
 #                hostname must be provided so that the server's x509
 #                certificate identity can be validated. (Since 2.7)
 #
+# @tls-authz: ID of the 'authz' object subclass that provides access control
+#             checking of the TLS x509 certificate distinguished name.
+#             This object is only resolved at time of use, so can be deleted
+#             and recreated on the fly while the migration server is active.
+#             If missing, it will default to denying access (Since 3.1)
+#
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
 #
@@ -560,7 +566,7 @@
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
            'compress-wait-thread',
            'cpu-throttle-initial', 'cpu-throttle-increment',
-           'tls-creds', 'tls-hostname', 'max-bandwidth',
+           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
@@ -658,6 +664,7 @@
             '*cpu-throttle-increment': 'int',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
+            '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
@@ -727,6 +734,10 @@
 #                associated with the migration URI, if any. (Since 2.9)
 #                Note: 2.8 reports this by omitting tls-hostname instead.
 #
+# @tls-authz: ID of the 'authz' object subclass that provides access control
+#             checking of the TLS x509 certificate distinguished name. (Since
+#             3.1)
+#
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
 #
@@ -774,6 +785,7 @@
             '*cpu-throttle-increment': 'uint8',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
+            '*tls-authz': 'str',
             '*max-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': 'uint32',
-- 
2.17.1
