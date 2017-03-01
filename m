Received: from eggs.gnu.org ([2001:4830:134:3::10]:58663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj3Qo-0004aV-KG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj3Qk-0002oR-PG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:32:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cj3Qk-0002nO-Iy
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:32:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F2DB8047F
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 12:32:30 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  1 Mar 2017 12:32:23 +0000
Message-Id: <20170301123223.12489-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: allow clearing migration string
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Some of the migration parameters are strings, which default to NULL,
eg tls_hostname and tls_creds.

The mgmt app will set the tls_creds parameter on both source and target
QEMU instances, in order to trigger use of TLS for migration.

After performing a TLS encrypted migration though, migration might be
used for other reasons - for example, to save the QEMU state to a file.
We need TLS turned off when doing this, but the migrate-set-parameters
QAPI command does not provide any facility to clear/reset parameters
to their default state.

If you simply ommit the tls_creds parameter in migrate-set-parameters,
then 'has_tls_creds' will be false and so no action will be taken. The
only option that works with migrate-set-parameters is to treat "" on
the wire as equivalent to requesting NULL. Failing that we would have
to create a new 'migrate-reset-parameters' method to explicitly put
a parameter back to its default value.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---

CC'ing Eric & Markus since this is related to QAPI schema for migrate
monitor commands

 migration/migration.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c6ae69d..a5d41a9 100644
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
+        if (*params->tls_hostnane == '\0') {
+            s->parameters.tls_hostnane = NULL;
+        } else {
+            s->parameters.tls_hostname = g_strdup(params->tls_hostname);
+        }
     }
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
-- 
2.9.3
