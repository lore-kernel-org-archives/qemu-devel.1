Received: from eggs.gnu.org ([2001:4830:134:3::10]:51702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1T-0006iv-41
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1N-0001kc-7V
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1M-0001jC-T2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0EB125C2A
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:48 +0200
Message-Id: <20170901153758.8628-38-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 37/47] hmp: Use qapi_enum_parse() in
 hmp_migrate_set_parameter()
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The error message on invalid parameter name changes from

    Invalid parameter "NAME"

to

    invalid parameter value: NAME

Slight degratation, perhaps.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170822132255.23945-10-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rebased, assertion added, commit message rewritten]
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-7-git-send-email-armbru@redhat.com>
---
 hmp.c | 138 +++++++++++++++++++++++++++++++++---------------------------=
------
 1 file changed, 68 insertions(+), 70 deletions(-)

diff --git a/hmp.c b/hmp.c
index 7e0bd3d63b..2b6e919501 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1556,84 +1556,82 @@ void hmp_migrate_set_parameter(Monitor *mon, cons=
t QDict *qdict)
     MigrateSetParameters *p =3D g_new0(MigrateSetParameters, 1);
     uint64_t valuebw =3D 0;
     Error *err =3D NULL;
-    int i, ret;
+    int val, ret;
=20
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
+    val =3D qapi_enum_parse(MigrationParameter_lookup, param, -1, &err);
+    if (val < 0) {
+        goto cleanup;
+    }
=20
-            if (err) {
-                goto cleanup;
-            }
-
-            qmp_migrate_set_parameters(p, &err);
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
+    default:
+        assert(0);
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
2.13.5
