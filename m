Received: from eggs.gnu.org ([2001:4830:134:3::10]:55287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JR-00085E-Kg
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JQ-00074f-4j
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JP-00073R-RF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33647883DC
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:23:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:10 +0200
Message-Id: <20170822132255.23945-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/54] hmp: use qapi_enum_parse() in
 hmp_migrate_set_parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hmp.c | 139 ++++++++++++++++++++++++++++++++----------------------------=
------
 1 file changed, 68 insertions(+), 71 deletions(-)

diff --git a/hmp.c b/hmp.c
index 4ba50e8e26..ccc58e6d88 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1574,84 +1574,81 @@ void hmp_migrate_set_parameter(Monitor *mon, cons=
t QDict *qdict)
     MigrateSetParameters *p =3D g_new0(MigrateSetParameters, 1);
     uint64_t valuebw =3D 0;
     Error *err =3D NULL;
-    int i, ret;
-
-    for (i =3D 0; i < MIGRATION_PARAMETER__MAX; i++) {
-        if (strcmp(param, MigrationParameter_lookup[i]) =3D=3D 0) {
-            switch (i) {
-            case MIGRATION_PARAMETER_COMPRESS_LEVEL:
-                p->has_compress_level =3D true;
-                visit_type_int(v, param, &p->compress_level, &err);
-                break;
-            case MIGRATION_PARAMETER_COMPRESS_THREADS:
-                p->has_compress_threads =3D true;
-                visit_type_int(v, param, &p->compress_threads, &err);
-                break;
-            case MIGRATION_PARAMETER_DECOMPRESS_THREADS:
-                p->has_decompress_threads =3D true;
-                visit_type_int(v, param, &p->decompress_threads, &err);
-                break;
-            case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
-                p->has_cpu_throttle_initial =3D true;
-                visit_type_int(v, param, &p->cpu_throttle_initial, &err)=
;
-                break;
-            case MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT:
-                p->has_cpu_throttle_increment =3D true;
-                visit_type_int(v, param, &p->cpu_throttle_increment, &er=
r);
-                break;
-            case MIGRATION_PARAMETER_TLS_CREDS:
-                p->has_tls_creds =3D true;
-                p->tls_creds =3D g_new0(StrOrNull, 1);
-                p->tls_creds->type =3D QTYPE_QSTRING;
-                visit_type_str(v, param, &p->tls_creds->u.s, &err);
-                break;
-            case MIGRATION_PARAMETER_TLS_HOSTNAME:
-                p->has_tls_hostname =3D true;
-                p->tls_hostname =3D g_new0(StrOrNull, 1);
-                p->tls_hostname->type =3D QTYPE_QSTRING;
-                visit_type_str(v, param, &p->tls_hostname->u.s, &err);
-                break;
-            case MIGRATION_PARAMETER_MAX_BANDWIDTH:
-                p->has_max_bandwidth =3D true;
-                /*
-                 * Can't use visit_type_size() here, because it
-                 * defaults to Bytes rather than Mebibytes.
-                 */
-                ret =3D qemu_strtosz_MiB(valuestr, NULL, &valuebw);
-                if (ret < 0 || valuebw > INT64_MAX
-                    || (size_t)valuebw !=3D valuebw) {
-                    error_setg(&err, "Invalid size %s", valuestr);
-                    break;
-                }
-                p->max_bandwidth =3D valuebw;
-                break;
-            case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
-                p->has_downtime_limit =3D true;
-                visit_type_int(v, param, &p->downtime_limit, &err);
-                break;
-            case MIGRATION_PARAMETER_X_CHECKPOINT_DELAY:
-                p->has_x_checkpoint_delay =3D true;
-                visit_type_int(v, param, &p->x_checkpoint_delay, &err);
-                break;
-            case MIGRATION_PARAMETER_BLOCK_INCREMENTAL:
-                p->has_block_incremental =3D true;
-                visit_type_bool(v, param, &p->block_incremental, &err);
-                break;
-            }
+    int val, ret;
=20
-            if (err) {
-                goto cleanup;
-            }
-
-            qmp_migrate_set_parameters(p, &err);
+    val =3D qapi_enum_parse(MigrationParameter_lookup, param,
+                          MIGRATION_PARAMETER__MAX,  -1, &err);
+    if (val < 0) {
+        goto cleanup;
+    }
+
+    switch (val) {
+    case MIGRATION_PARAMETER_COMPRESS_LEVEL:
+        p->has_compress_level =3D true;
+        visit_type_int(v, param, &p->compress_level, &err);
+        break;
+    case MIGRATION_PARAMETER_COMPRESS_THREADS:
+        p->has_compress_threads =3D true;
+        visit_type_int(v, param, &p->compress_threads, &err);
+        break;
+    case MIGRATION_PARAMETER_DECOMPRESS_THREADS:
+        p->has_decompress_threads =3D true;
+        visit_type_int(v, param, &p->decompress_threads, &err);
+        break;
+    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
+        p->has_cpu_throttle_initial =3D true;
+        visit_type_int(v, param, &p->cpu_throttle_initial, &err);
+        break;
+    case MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT:
+        p->has_cpu_throttle_increment =3D true;
+        visit_type_int(v, param, &p->cpu_throttle_increment, &err);
+        break;
+    case MIGRATION_PARAMETER_TLS_CREDS:
+        p->has_tls_creds =3D true;
+        p->tls_creds =3D g_new0(StrOrNull, 1);
+        p->tls_creds->type =3D QTYPE_QSTRING;
+        visit_type_str(v, param, &p->tls_creds->u.s, &err);
+        break;
+    case MIGRATION_PARAMETER_TLS_HOSTNAME:
+        p->has_tls_hostname =3D true;
+        p->tls_hostname =3D g_new0(StrOrNull, 1);
+        p->tls_hostname->type =3D QTYPE_QSTRING;
+        visit_type_str(v, param, &p->tls_hostname->u.s, &err);
+        break;
+    case MIGRATION_PARAMETER_MAX_BANDWIDTH:
+        p->has_max_bandwidth =3D true;
+        /*
+         * Can't use visit_type_size() here, because it
+         * defaults to Bytes rather than Mebibytes.
+         */
+        ret =3D qemu_strtosz_MiB(valuestr, NULL, &valuebw);
+        if (ret < 0 || valuebw > INT64_MAX
+            || (size_t)valuebw !=3D valuebw) {
+            error_setg(&err, "Invalid size %s", valuestr);
             break;
         }
+        p->max_bandwidth =3D valuebw;
+        break;
+    case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
+        p->has_downtime_limit =3D true;
+        visit_type_int(v, param, &p->downtime_limit, &err);
+        break;
+    case MIGRATION_PARAMETER_X_CHECKPOINT_DELAY:
+        p->has_x_checkpoint_delay =3D true;
+        visit_type_int(v, param, &p->x_checkpoint_delay, &err);
+        break;
+    case MIGRATION_PARAMETER_BLOCK_INCREMENTAL:
+        p->has_block_incremental =3D true;
+        visit_type_bool(v, param, &p->block_incremental, &err);
+        break;
     }
=20
-    if (i =3D=3D MIGRATION_PARAMETER__MAX) {
-        error_setg(&err, QERR_INVALID_PARAMETER, param);
+    if (err) {
+        goto cleanup;
     }
=20
+    qmp_migrate_set_parameters(p, &err);
+
  cleanup:
     qapi_free_MigrateSetParameters(p);
     visit_free(v);
--=20
2.14.1.146.gd35faa819
