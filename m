Received: from eggs.gnu.org ([2001:4830:134:3::10]:51717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTS1-0001VB-Dh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTS0-0005TO-AV
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjTS0-0005S8-0w
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:19:32 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2757B80484
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 16:19:32 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  2 Mar 2017 16:19:20 +0000
Message-Id: <20170302161921.10181-2-berrange@redhat.com>
In-Reply-To: <20170302161921.10181-1-berrange@redhat.com>
References: <20170302161921.10181-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] migration: allow clearing migration
 string parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Some of the migration parameters are strings, which default to NULL,
eg tls-hostname and tls-creds.

The mgmt app will set the tls-creds parameter on both source and target
QEMU instances, in order to trigger use of TLS for migration.

After performing a TLS encrypted migration though, migration might be
used for other reasons - for example, to save the QEMU state to a file.
We need TLS turned off when doing this, but the migrate-set-parameters
QAPI command does not provide any facility to clear/reset parameters
to their default state.

If you simply omit the tls_creds parameter in migrate-set-parameters,
then 'has_tls_creds' will be false and so no action will be taken. JSON
allows a parameter to have a nil value, but the QEMU JSON visitor will
reject that when deserializing into a QObject.

The migration code has no need to distinguish "" vs NULL for the TLS
hostname or TLS credentials object name, since "" is invalid in both
cases. This enables clearing of tls-hostname and tls-creds by
treating "" as equivalent to NULL.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/migration.c | 12 ++++++++++--
 qapi-schema.json      |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c6ae69d..a8cb56e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -872,11 +872,19 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     }
     if (params->has_tls_creds) {
         g_free(s->parameters.tls_creds);
-        s->parameters.tls_creds = g_strdup(params->tls_creds);
+        if (*params->tls_creds == '\0') {
+            s->parameters.tls_creds = NULL;
+        } else {
+            s->parameters.tls_creds = g_strdup(params->tls_creds);
+        }
     }
     if (params->has_tls_hostname) {
         g_free(s->parameters.tls_hostname);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname);
+        if (*params->tls_hostname == '\0') {
+            s->parameters.tls_hostname = NULL;
+        } else {
+            s->parameters.tls_hostname = g_strdup(params->tls_hostname);
+        }
     }
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
diff --git a/qapi-schema.json b/qapi-schema.json
index 150ee98..d1df9a4 100644
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
