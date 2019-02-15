Received: from eggs.gnu.org ([209.51.188.92]:37131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh5l-0005Rt-1e
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh5j-0006Zc-SC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:16:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 17:14:33 +0000
Message-Id: <20190215171436.30457-4-berrange@redhat.com>
In-Reply-To: <20190215171436.30457-1-berrange@redhat.com>
References: <20190215171436.30457-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/6] migration: add support for a
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
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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

  (qemu) object_add tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls=
,\
             endpoint=3Dserver,verify-peer=3Dyes \
  (qemu) object_add authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.exampl=
e.com,,\
             O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
  (qemu) migrate_incoming tcp:localhost:9000

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hmp.c                 |  9 +++++++++
 migration/migration.c |  8 ++++++++
 migration/tls.c       |  2 +-
 qapi/migration.json   | 14 +++++++++++++-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index c234634f8a..0aea14e9d4 100644
--- a/hmp.c
+++ b/hmp.c
@@ -398,6 +398,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BAND=
WIDTH),
             params->max_postcopy_bandwidth);
+        monitor_printf(mon, " %s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
+            params->has_tls_authz ? params->tls_authz : "");
     }
=20
     qapi_free_MigrationParameters(params);
@@ -1709,6 +1712,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
         p->tls_hostname->type =3D QTYPE_QSTRING;
         visit_type_str(v, param, &p->tls_hostname->u.s, &err);
         break;
+    case MIGRATION_PARAMETER_TLS_AUTHZ:
+        p->has_tls_authz =3D true;
+        p->tls_authz =3D g_new0(StrOrNull, 1);
+        p->tls_authz->type =3D QTYPE_QSTRING;
+        visit_type_str(v, param, &p->tls_authz->u.s, &err);
+        break;
     case MIGRATION_PARAMETER_MAX_BANDWIDTH:
         p->has_max_bandwidth =3D true;
         /*
diff --git a/migration/migration.c b/migration/migration.c
index 37e06b76dc..3a2f0b6c54 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -721,6 +721,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
     params->tls_creds =3D g_strdup(s->parameters.tls_creds);
     params->has_tls_hostname =3D true;
     params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
+    params->has_tls_authz =3D true;
+    params->tls_authz =3D g_strdup(s->parameters.tls_authz);
     params->has_max_bandwidth =3D true;
     params->max_bandwidth =3D s->parameters.max_bandwidth;
     params->has_downtime_limit =3D true;
@@ -1234,6 +1236,12 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
         s->parameters.tls_hostname =3D g_strdup(params->tls_hostname->u.=
s);
     }
=20
+    if (params->has_tls_authz) {
+        g_free(s->parameters.tls_authz);
+        assert(params->tls_authz->type =3D=3D QTYPE_QSTRING);
+        s->parameters.tls_authz =3D g_strdup(params->tls_authz->u.s);
+    }
+
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth =3D params->max_bandwidth;
         if (s->to_dst_file) {
diff --git a/migration/tls.c b/migration/tls.c
index 3b9e8c9263..5171afc6c4 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -94,7 +94,7 @@ void migration_tls_channel_process_incoming(MigrationSt=
ate *s,
=20
     tioc =3D qio_channel_tls_new_server(
         ioc, creds,
-        NULL, /* XXX pass ACL name */
+        s->parameters.tls_authz,
         errp);
     if (!tioc) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 7a795ecc16..1ece4a8756 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -522,6 +522,12 @@
 #                hostname must be provided so that the server's x509
 #                certificate identity can be validated. (Since 2.7)
 #
+# @tls-authz: ID of the 'authz' object subclass that provides access con=
trol
+#             checking of the TLS x509 certificate distinguished name.
+#             This object is only resolved at time of use, so can be del=
eted
+#             and recreated on the fly while the migration server is act=
ive.
+#             If missing, it will default to denying access (Since 3.1)
+#
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
 #
@@ -563,7 +569,7 @@
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
            'compress-wait-thread',
            'cpu-throttle-initial', 'cpu-throttle-increment',
-           'tls-creds', 'tls-hostname', 'max-bandwidth',
+           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
@@ -661,6 +667,7 @@
             '*cpu-throttle-increment': 'int',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
+            '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
@@ -730,6 +737,10 @@
 #                associated with the migration URI, if any. (Since 2.9)
 #                Note: 2.8 reports this by omitting tls-hostname instead=
.
 #
+# @tls-authz: ID of the 'authz' object subclass that provides access con=
trol
+#             checking of the TLS x509 certificate distinguished name. (=
Since
+#             3.1)
+#
 # @max-bandwidth: to set maximum speed for migration. maximum speed in
 #                 bytes per second. (Since 2.8)
 #
@@ -777,6 +788,7 @@
             '*cpu-throttle-increment': 'uint8',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
+            '*tls-authz': 'str',
             '*max-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': 'uint32',
--=20
2.20.1
