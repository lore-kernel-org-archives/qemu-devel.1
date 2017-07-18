Received: from eggs.gnu.org ([2001:4830:134:3::10]:58159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7W-000575-KN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7V-00018u-3H
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXZ7U-00017y-Qa
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6C95A04EC
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-60.ams2.redhat.com
	[10.36.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 684B471CAD
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 22:29:20 +0200
Message-Id: <1500409760-20730-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1500409760-20730-1-git-send-email-armbru@redhat.com>
References: <1500409760-20730-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] migration: Use JSON null instead of "" to
 reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

migrate-set-parameters sets migration parameters according to is
arguments like this:

* Present means "set the parameter to this value"

* Absent means "leave the parameter unchanged"

* Except for parameters tls_creds and tls_hostname, "" means "reset
  the parameter to its default value

The first two are perfectly normal: presence of the parameter makes
the command do something.

The third one overloads the parameter with a second meaning.  The
overloading is *implicit*, i.e. it's not visible in the types.  Works
here, because "" is neither a valid TLS credentials ID, nor a valid
host name.

Pressing argument values the schema accepts, but are semantically
invalid, into service to mean "reset to default" is not general, as
suitable invalid values need not exist.  I also find it ugly.

To clean this up, we could add a separate flag argument to ask for
"reset to default", or add a distinct value to @tls_creds and
@tls_hostname.  This commit implements the latter: add JSON null to
the values of @tls_creds and @tls_hostname, deprecate "".

Because we're so close to the 2.10 freeze, implement it in the
stupidest way possible: have qmp_migrate_set_parameters() rewrite null
to "" before anything else can see the null.  The proper way to do it
would be rewriting "" to null, but that requires fixing up code to
work with null.  Add TODO comments for that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hmp.c                 |  8 ++++++--
 migration/migration.c | 18 ++++++++++++++++--
 qapi-schema.json      | 20 ++++++++++++++++++--
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index 0a5de75..40ebeef 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1541,11 +1541,15 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 break;
             case MIGRATION_PARAMETER_TLS_CREDS:
                 p->has_tls_creds = true;
-                visit_type_str(v, param, &p->tls_creds, &err);
+                p->tls_creds = g_new0(StrOrNull, 1);
+                p->tls_creds->type = QTYPE_QSTRING;
+                visit_type_str(v, param, &p->tls_creds->u.s, &err);
                 break;
             case MIGRATION_PARAMETER_TLS_HOSTNAME:
                 p->has_tls_hostname = true;
-                visit_type_str(v, param, &p->tls_hostname, &err);
+                p->tls_hostname = g_new0(StrOrNull, 1);
+                p->tls_hostname->type = QTYPE_QSTRING;
+                visit_type_str(v, param, &p->tls_hostname->u.s, &err);
                 break;
             case MIGRATION_PARAMETER_MAX_BANDWIDTH:
                 p->has_max_bandwidth = true;
diff --git a/migration/migration.c b/migration/migration.c
index f6a9443..e2cfb99 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -703,6 +703,20 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
                     "x_checkpoint_delay",
                     "is invalid, it should be positive");
     }
+    /* TODO Rewrite "" to null instead */
+    if (params->has_tls_creds
+        && params->tls_creds->type == QTYPE_QNULL) {
+        QDECREF(params->tls_creds->u.n);
+        params->tls_creds->type = QTYPE_QSTRING;
+        params->tls_creds->u.s = strdup("");
+    }
+    /* TODO Rewrite "" to null instead */
+    if (params->has_tls_hostname
+        && params->tls_hostname->type == QTYPE_QNULL) {
+        QDECREF(params->tls_hostname->u.n);
+        params->tls_hostname->type = QTYPE_QSTRING;
+        params->tls_hostname->u.s = strdup("");
+    }
 
     /*
      * TODO if we fuse MigrateSetParameters back into
@@ -726,11 +740,11 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
     }
     if (params->has_tls_creds) {
         g_free(s->parameters.tls_creds);
-        s->parameters.tls_creds = g_strdup(params->tls_creds);
+        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
     }
     if (params->has_tls_hostname) {
         g_free(s->parameters.tls_hostname);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname);
+        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
     }
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
diff --git a/qapi-schema.json b/qapi-schema.json
index b5ec942..9bd3390 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -116,6 +116,22 @@
 { 'command': 'qmp_capabilities' }
 
 ##
+# @StrOrNull:
+#
+# This is a string value or the explicit lack of a string (null
+# pointer in C).  Intended for cases when 'optional absent' already
+# has a different meaning.
+#
+# @s: the string value
+# @n: no string value
+#
+# Since: 2.10
+##
+{ 'alternate': 'StrOrNull',
+  'data': { 's': 'str',
+            'n': 'null' } }
+
+##
 # @LostTickPolicy:
 #
 # Policy for handling lost ticks in timer devices.
@@ -1098,8 +1114,8 @@
             '*decompress-threads': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
-            '*tls-creds': 'str',
-            '*tls-hostname': 'str',
+            '*tls-creds': 'StrOrNull',
+            '*tls-hostname': 'StrOrNull',
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
-- 
2.7.5
