Received: from eggs.gnu.org ([2001:4830:134:3::10]:48756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coBax-00006V-Lu
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coBat-0004p0-Hu
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coBat-0004on-8I
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:11 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 424755A6E
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 16:16:11 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 15 Mar 2017 16:16:03 +0000
Message-Id: <20170315161603.30135-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9] migration: use "" as the default for
 tls-creds/hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The tls-creds parameter has a default value of NULL indicating
that TLS should not be used. Setting it to non-NULL enables
use of TLS. Once tls-creds are set to a non-NULL value via the
monitor, it isn't possible to set them back to NULL again, due
to current implementation limitations. The empty string is not
a valid QObject identifier, so this switches to use "" as the
default, indicating that TLS will not be used

The tls-hostname parameter has a default value of NULL indicating
the the hostname from the migrate connection URI should be used.
Again, once tls-hostname is set non-NULL, to override the default
hostname for x509 cert validation, it isn't possible to reset it
back to NULL via the monitor. The empty string is not a valid
hostname, so this switches to use "" as the default, indicating
that the migrate URI hostname should be used.

Using "" as the default for both, also means that the monitor
commands "info migrate_parameters" / "query-migrate-parameters"
will report existance of tls-creds/tls-parameters even when set
to their default values.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/migration.c | 4 ++++
 migration/tls.c       | 2 +-
 qapi-schema.json      | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3dab684..54060f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -110,6 +110,8 @@ MigrationState *migrate_get_current(void)
 
     if (!once) {
         qemu_mutex_init(&current_migration.src_page_req_mutex);
+        current_migration.parameters.tls_creds = g_strdup("");
+        current_migration.parameters.tls_hostname = g_strdup("");
         once = true;
     }
     return &current_migration;
@@ -458,6 +460,7 @@ void migration_channel_process_incoming(MigrationState *s,
         ioc, object_get_typename(OBJECT(ioc)));
 
     if (s->parameters.tls_creds &&
+        *s->parameters.tls_creds &&
         !object_dynamic_cast(OBJECT(ioc),
                              TYPE_QIO_CHANNEL_TLS)) {
         Error *local_err = NULL;
@@ -480,6 +483,7 @@ void migration_channel_connect(MigrationState *s,
         ioc, object_get_typename(OBJECT(ioc)), hostname);
 
     if (s->parameters.tls_creds &&
+        *s->parameters.tls_creds &&
         !object_dynamic_cast(OBJECT(ioc),
                              TYPE_QIO_CHANNEL_TLS)) {
         Error *local_err = NULL;
diff --git a/migration/tls.c b/migration/tls.c
index 203c11d..45bec44 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -141,7 +141,7 @@ void migration_tls_channel_connect(MigrationState *s,
         return;
     }
 
-    if (s->parameters.tls_hostname) {
+    if (s->parameters.tls_hostname && *s->parameters.tls_hostname) {
         hostname = s->parameters.tls_hostname;
     }
     if (!hostname) {
diff --git a/qapi-schema.json b/qapi-schema.json
index 32b4a4b..eb9bf67 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1036,6 +1036,8 @@
 #             credentials must be for a 'server' endpoint. Setting this
 #             will enable TLS for all migrations. The default is unset,
 #             resulting in unsecured migration at the QEMU level. (Since 2.7)
+#             An empty string means that QEMU will use plain text mode for
+#             migration, rather than TLS (Since 2.9)
 #
 # @tls-hostname: #optional hostname of the target host for the migration. This
 #                is required when using x509 based TLS credentials and the
@@ -1043,6 +1045,8 @@
 #                example if using fd: or exec: based migration, the
 #                hostname must be provided so that the server's x509
 #                certificate identity can be validated. (Since 2.7)
+#                An empty string means that QEMU will use the hostname
+#                associated with the migration URI, if any. (Since 2.9)
 #
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
-- 
2.9.3
