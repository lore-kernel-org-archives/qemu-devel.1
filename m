Received: from eggs.gnu.org ([2001:4830:134:3::10]:54286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUz-0000bU-Ge
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUm-0007QG-7k
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUl-0007PQ-Pi
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF1F07F3E2
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:56:10 +0200
Message-Id: <20170901125611.29295-47-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 46/47] qapi: Change data type of the FOO_lookup
 generated for enum FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Currently, a FOO_lookup is an array of strings terminated by a NULL
sentinel.

A future patch will generate enums with "holes".  NULL-termination
will cease to work then.

To prepare for that, store the length in the FOO_lookup by wrapping it
in a struct and adding a member for the length.

The sentinel will be dropped next.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170822132255.23945-13-marcandre.lureau@redhat.com>
[Basically redone]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-16-git-send-email-armbru@redhat.com>
---
 backends/hostmem.c                 |  2 +-
 block.c                            |  2 +-
 block/blkdebug.c                   |  4 ++--
 block/file-posix.c                 |  8 +++++---
 block/gluster.c                    |  4 ++--
 block/parallels.c                  | 14 ++++++++------
 block/qcow2.c                      |  4 ++--
 block/quorum.c                     |  2 +-
 blockdev.c                         |  2 +-
 crypto/block-luks.c                |  8 ++++----
 crypto/secret.c                    |  2 +-
 crypto/tlscreds.c                  |  2 +-
 hmp.c                              |  6 +++---
 hw/core/qdev-properties.c          | 10 +++++-----
 include/hw/qdev-core.h             |  2 +-
 include/qapi/util.h                |  9 +++++++--
 include/qapi/visitor.h             |  2 +-
 include/qom/object.h               |  4 ++--
 migration/global_state.c           |  2 +-
 net/filter.c                       |  2 +-
 qapi/qapi-util.c                   | 12 ++++++------
 qapi/qapi-visit-core.c             | 24 +++++++++++++-----------
 qemu-img.c                         |  2 +-
 qemu-nbd.c                         |  2 +-
 qom/object.c                       | 16 ++++++++--------
 scripts/qapi-visit.py              |  2 +-
 scripts/qapi.py                    | 13 ++++++++-----
 tests/check-qom-proplist.c         | 15 +++++++++------
 tests/test-qapi-util.c             | 10 +++++-----
 tests/test-qobject-input-visitor.c |  2 +-
 tpm.c                              |  2 +-
 31 files changed, 104 insertions(+), 87 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 06e8898e40..217cff6766 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -395,7 +395,7 @@ host_memory_backend_class_init(ObjectClass *oc, void =
*data)
         host_memory_backend_set_host_nodes,
         NULL, NULL, &error_abort);
     object_class_property_add_enum(oc, "policy", "HostMemPolicy",
-        HostMemPolicy_lookup,
+        &HostMemPolicy_lookup,
         host_memory_backend_get_policy,
         host_memory_backend_set_policy, &error_abort);
     object_class_property_add_str(oc, "id", get_id, set_id, &error_abort=
);
diff --git a/block.c b/block.c
index 845eff8177..b749bd6404 100644
--- a/block.c
+++ b/block.c
@@ -1332,7 +1332,7 @@ static int bdrv_open_common(BlockDriverState *bs, B=
lockBackend *file,
     detect_zeroes =3D qemu_opt_get(opts, "detect-zeroes");
     if (detect_zeroes) {
         BlockdevDetectZeroesOptions value =3D
-            qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
+            qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
                             detect_zeroes,
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_err);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index b370fcedfb..8e385acf54 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -169,7 +169,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Err=
or **errp)
         error_setg(errp, "Missing event name for rule");
         return -1;
     }
-    event =3D qapi_enum_parse(BlkdebugEvent_lookup, event_name, -1, errp=
);
+    event =3D qapi_enum_parse(&BlkdebugEvent_lookup, event_name, -1, err=
p);
     if (event < 0) {
         return -1;
     }
@@ -732,7 +732,7 @@ static int blkdebug_debug_breakpoint(BlockDriverState=
 *bs, const char *event,
     struct BlkdebugRule *rule;
     int blkdebug_event;
=20
-    blkdebug_event =3D qapi_enum_parse(BlkdebugEvent_lookup, event, -1, =
NULL);
+    blkdebug_event =3D qapi_enum_parse(&BlkdebugEvent_lookup, event, -1,=
 NULL);
     if (blkdebug_event < 0) {
         return -ENOENT;
     }
diff --git a/block/file-posix.c b/block/file-posix.c
index bfef91db63..6acbd56238 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -437,7 +437,8 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     aio_default =3D (bdrv_flags & BDRV_O_NATIVE_AIO)
                   ? BLOCKDEV_AIO_OPTIONS_NATIVE
                   : BLOCKDEV_AIO_OPTIONS_THREADS;
-    aio =3D qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts=
, "aio"),
+    aio =3D qapi_enum_parse(&BlockdevAioOptions_lookup,
+                          qemu_opt_get(opts, "aio"),
                           aio_default, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -446,7 +447,8 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     }
     s->use_linux_aio =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_NATIVE);
=20
-    locking =3D qapi_enum_parse(OnOffAuto_lookup, qemu_opt_get(opts, "lo=
cking"),
+    locking =3D qapi_enum_parse(&OnOffAuto_lookup,
+                              qemu_opt_get(opts, "locking"),
                               ON_OFF_AUTO_AUTO, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1973,7 +1975,7 @@ static int raw_create(const char *filename, QemuOpt=
s *opts, Error **errp)
                           BDRV_SECTOR_SIZE);
     nocow =3D qemu_opt_get_bool(opts, BLOCK_OPT_NOCOW, false);
     buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, buf,
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
                                PREALLOC_MODE_OFF, &local_err);
     g_free(buf);
     if (local_err) {
diff --git a/block/gluster.c b/block/gluster.c
index 29f9427e47..0f4265a3a4 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -543,7 +543,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
         if (!strcmp(ptr, "tcp")) {
             ptr =3D "inet";       /* accept legacy "tcp" */
         }
-        type =3D qapi_enum_parse(SocketAddressType_lookup, ptr, -1, NULL=
);
+        type =3D qapi_enum_parse(&SocketAddressType_lookup, ptr, -1, NUL=
L);
         if (type !=3D SOCKET_ADDRESS_TYPE_INET
             && type !=3D SOCKET_ADDRESS_TYPE_UNIX) {
             error_setg(&local_err,
@@ -1000,7 +1000,7 @@ static int qemu_gluster_create(const char *filename=
,
                           BDRV_SECTOR_SIZE);
=20
     tmp =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, tmp, PREALLOC_MODE=
_OFF,
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, tmp, PREALLOC_MOD=
E_OFF,
                                &local_err);
     g_free(tmp);
     if (local_err) {
diff --git a/block/parallels.c b/block/parallels.c
index d812210b4f..cce7336cac 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -68,13 +68,15 @@ typedef enum ParallelsPreallocMode {
     PRL_PREALLOC_MODE__MAX =3D 2,
 } ParallelsPreallocMode;
=20
-static const char *prealloc_mode_lookup[] =3D {
-    "falloc",
-    "truncate",
-    NULL,
+static QEnumLookup prealloc_mode_lookup =3D {
+    .array =3D (const char *const[]) {
+        "falloc",
+        "truncate",
+        NULL,
+    },
+    .size =3D PRL_PREALLOC_MODE__MAX
 };
=20
-
 typedef struct BDRVParallelsState {
     /** Locking is conservative, the lock protects
      *   - image file extending (truncate, fallocate)
@@ -695,7 +697,7 @@ static int parallels_open(BlockDriverState *bs, QDict=
 *options, int flags,
         qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
     s->prealloc_size =3D MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_=
BITS);
     buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
-    s->prealloc_mode =3D qapi_enum_parse(prealloc_mode_lookup, buf,
+    s->prealloc_mode =3D qapi_enum_parse(&prealloc_mode_lookup, buf,
                                        PRL_PREALLOC_MODE_FALLOCATE,
                                        &local_err);
     g_free(buf);
diff --git a/block/qcow2.c b/block/qcow2.c
index cbe9681fb0..2ec399663e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2915,7 +2915,7 @@ static int qcow2_create(const char *filename, QemuO=
pts *opts, Error **errp)
         goto finish;
     }
     buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, buf,
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
                                PREALLOC_MODE_OFF, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -3605,7 +3605,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
ts, BlockDriverState *in_bs,
     }
=20
     optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, optstr,
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, optstr,
                                PREALLOC_MODE_OFF, &local_err);
     g_free(optstr);
     if (local_err) {
diff --git a/block/quorum.c b/block/quorum.c
index 8d1c9f6306..272f9a5b77 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -912,7 +912,7 @@ static int quorum_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     if (!pattern_str) {
         ret =3D QUORUM_READ_PATTERN_QUORUM;
     } else {
-        ret =3D qapi_enum_parse(QuorumReadPattern_lookup, pattern_str,
+        ret =3D qapi_enum_parse(&QuorumReadPattern_lookup, pattern_str,
                               -EINVAL, NULL);
     }
     if (ret < 0) {
diff --git a/blockdev.c b/blockdev.c
index bfb2a95299..796beaed94 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -437,7 +437,7 @@ static void extract_common_blockdev_options(QemuOpts =
*opts, int *bdrv_flags,
=20
     if (detect_zeroes) {
         *detect_zeroes =3D
-            qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
+            qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
                             qemu_opt_get(opts, "detect-zeroes"),
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_error);
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 4e828951d4..36bc856084 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -264,7 +264,7 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherAlg=
orithm alg,
 /* XXX replace with qapi_enum_parse() in future, when we can
  * make that function emit a more friendly error message */
 static int qcrypto_block_luks_name_lookup(const char *name,
-                                          const char *const *map,
+                                          const QEnumLookup *map,
                                           const char *type,
                                           Error **errp)
 {
@@ -279,19 +279,19 @@ static int qcrypto_block_luks_name_lookup(const cha=
r *name,
=20
 #define qcrypto_block_luks_cipher_mode_lookup(name, errp)               =
\
     qcrypto_block_luks_name_lookup(name,                                =
\
-                                   QCryptoCipherMode_lookup,            =
\
+                                   &QCryptoCipherMode_lookup,           =
\
                                    "Cipher mode",                       =
\
                                    errp)
=20
 #define qcrypto_block_luks_hash_name_lookup(name, errp)                 =
\
     qcrypto_block_luks_name_lookup(name,                                =
\
-                                   QCryptoHashAlgorithm_lookup,         =
\
+                                   &QCryptoHashAlgorithm_lookup,        =
\
                                    "Hash algorithm",                    =
\
                                    errp)
=20
 #define qcrypto_block_luks_ivgen_name_lookup(name, errp)                =
\
     qcrypto_block_luks_name_lookup(name,                                =
\
-                                   QCryptoIVGenAlgorithm_lookup,        =
\
+                                   &QCryptoIVGenAlgorithm_lookup,       =
\
                                    "IV generator",                      =
\
                                    errp)
=20
diff --git a/crypto/secret.c b/crypto/secret.c
index 285ab7a63c..388abd7df5 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -378,7 +378,7 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data=
)
                                    NULL);
     object_class_property_add_enum(oc, "format",
                                    "QCryptoSecretFormat",
-                                   QCryptoSecretFormat_lookup,
+                                   &QCryptoSecretFormat_lookup,
                                    qcrypto_secret_prop_get_format,
                                    qcrypto_secret_prop_set_format,
                                    NULL);
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index a8965531b6..3cd41035bb 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -233,7 +233,7 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, void *d=
ata)
                                   NULL);
     object_class_property_add_enum(oc, "endpoint",
                                    "QCryptoTLSCredsEndpoint",
-                                   QCryptoTLSCredsEndpoint_lookup,
+                                   &QCryptoTLSCredsEndpoint_lookup,
                                    qcrypto_tls_creds_prop_get_endpoint,
                                    qcrypto_tls_creds_prop_set_endpoint,
                                    NULL);
diff --git a/hmp.c b/hmp.c
index 30819fe602..cd046c6d71 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1528,7 +1528,7 @@ void hmp_migrate_set_capability(Monitor *mon, const=
 QDict *qdict)
     MigrationCapabilityStatusList *caps =3D g_malloc0(sizeof(*caps));
     int val;
=20
-    val =3D qapi_enum_parse(MigrationCapability_lookup, cap, -1, &err);
+    val =3D qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
     if (val < 0) {
         goto end;
     }
@@ -1557,7 +1557,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
     Error *err =3D NULL;
     int val, ret;
=20
-    val =3D qapi_enum_parse(MigrationParameter_lookup, param, -1, &err);
+    val =3D qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err)=
;
     if (val < 0) {
         goto cleanup;
     }
@@ -1735,7 +1735,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     } else {
         if (read_only) {
             read_only_mode =3D
-                qapi_enum_parse(BlockdevChangeReadOnlyMode_lookup,
+                qapi_enum_parse(&BlockdevChangeReadOnlyMode_lookup,
                                 read_only,
                                 BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &=
err);
             if (err) {
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 7512bd4379..1dc80fcea2 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -587,7 +587,7 @@ const PropertyInfo qdev_prop_macaddr =3D {
 const PropertyInfo qdev_prop_on_off_auto =3D {
     .name =3D "OnOffAuto",
     .description =3D "on/off/auto",
-    .enum_table =3D OnOffAuto_lookup,
+    .enum_table =3D &OnOffAuto_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
     .set_default_value =3D set_default_value_enum,
@@ -599,7 +599,7 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) !=3D sizeof(=
int));
=20
 const PropertyInfo qdev_prop_losttickpolicy =3D {
     .name  =3D "LostTickPolicy",
-    .enum_table  =3D LostTickPolicy_lookup,
+    .enum_table  =3D &LostTickPolicy_lookup,
     .get   =3D get_enum,
     .set   =3D set_enum,
     .set_default_value =3D set_default_value_enum,
@@ -613,7 +613,7 @@ const PropertyInfo qdev_prop_blockdev_on_error =3D {
     .name =3D "BlockdevOnError",
     .description =3D "Error handling policy, "
                    "report/ignore/enospc/stop/auto",
-    .enum_table =3D BlockdevOnError_lookup,
+    .enum_table =3D &BlockdevOnError_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
     .set_default_value =3D set_default_value_enum,
@@ -627,7 +627,7 @@ const PropertyInfo qdev_prop_bios_chs_trans =3D {
     .name =3D "BiosAtaTranslation",
     .description =3D "Logical CHS translation algorithm, "
                    "auto/none/lba/large/rechs",
-    .enum_table =3D BiosAtaTranslation_lookup,
+    .enum_table =3D &BiosAtaTranslation_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
     .set_default_value =3D set_default_value_enum,
@@ -639,7 +639,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
     .name =3D "FdcDriveType",
     .description =3D "FDC drive type, "
                    "144/288/120/none/auto",
-    .enum_table =3D FloppyDriveType_lookup,
+    .enum_table =3D &FloppyDriveType_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
     .set_default_value =3D set_default_value_enum,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ae317286a4..089146197f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -249,7 +249,7 @@ struct Property {
 struct PropertyInfo {
     const char *name;
     const char *description;
-    const char * const *enum_table;
+    const QEnumLookup *enum_table;
     int (*print)(DeviceState *dev, Property *prop, char *dest, size_t le=
n);
     void (*set_default_value)(Object *obj, const Property *prop);
     void (*create)(Object *obj, Property *prop, Error **errp);
diff --git a/include/qapi/util.h b/include/qapi/util.h
index 5e50d0c1ce..a7c3c64148 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,8 +11,13 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H
=20
-const char *qapi_enum_lookup(const char *const lookup[], int val);
-int qapi_enum_parse(const char * const lookup[], const char *buf,
+typedef struct QEnumLookup {
+    const char *const *array;
+    int size;
+} QEnumLookup;
+
+const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
+int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
                     int def, Error **errp);
=20
 int parse_qapi_name(const char *name, bool complete);
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 0f3b8cb459..62a51a54cb 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -469,7 +469,7 @@ bool visit_optional(Visitor *v, const char *name, boo=
l *present);
  * that visit_type_str() must have no unwelcome side effects.
  */
 void visit_type_enum(Visitor *v, const char *name, int *obj,
-                     const char *const strings[], Error **errp);
+                     const QEnumLookup *lookup, Error **errp);
=20
 /*
  * Check if visitor is an input visitor.
diff --git a/include/qom/object.h b/include/qom/object.h
index 1b828994fa..f3e5cff37a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1415,14 +1415,14 @@ void object_class_property_add_bool(ObjectClass *=
klass, const char *name,
  */
 void object_property_add_enum(Object *obj, const char *name,
                               const char *typename,
-                              const char * const *strings,
+                              const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **),
                               Error **errp);
=20
 void object_class_property_add_enum(ObjectClass *klass, const char *name=
,
                                     const char *typename,
-                                    const char * const *strings,
+                                    const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **)=
,
                                     Error **errp);
diff --git a/migration/global_state.c b/migration/global_state.c
index 8db2f19459..dfdaf63910 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -88,7 +88,7 @@ static int global_state_post_load(void *opaque, int ver=
sion_id)
     s->received =3D true;
     trace_migrate_global_state_post_load(runstate);
=20
-    r =3D qapi_enum_parse(RunState_lookup, runstate, -1, &local_err);
+    r =3D qapi_enum_parse(&RunState_lookup, runstate, -1, &local_err);
=20
     if (r =3D=3D -1) {
         if (local_err) {
diff --git a/net/filter.c b/net/filter.c
index 1dfd2caa23..2fd7d7d663 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -179,7 +179,7 @@ static void netfilter_init(Object *obj)
                             netfilter_get_netdev_id, netfilter_set_netde=
v_id,
                             NULL);
     object_property_add_enum(obj, "queue", "NetFilterDirection",
-                             NetFilterDirection_lookup,
+                             &NetFilterDirection_lookup,
                              netfilter_get_direction, netfilter_set_dire=
ction,
                              NULL);
     object_property_add_str(obj, "status",
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 7af2f04d36..e9b266bb70 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -14,14 +14,14 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
=20
-const char *qapi_enum_lookup(const char *const lookup[], int val)
+const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
 {
-    assert(val >=3D 0);
+    assert(val >=3D 0 && val < lookup->size);
=20
-    return lookup[val];
+    return lookup->array[val];
 }
=20
-int qapi_enum_parse(const char * const lookup[], const char *buf,
+int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
                     int def, Error **errp)
 {
     int i;
@@ -30,8 +30,8 @@ int qapi_enum_parse(const char * const lookup[], const =
char *buf,
         return def;
     }
=20
-    for (i =3D 0; lookup[i]; i++) {
-        if (!strcmp(buf, lookup[i])) {
+    for (i =3D 0; i < lookup->size; i++) {
+        if (!strcmp(buf, lookup->array[i])) {
             return i;
         }
     }
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 30dc85b6f3..3dcb968867 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -333,24 +333,26 @@ void visit_type_null(Visitor *v, const char *name, =
QNull **obj,
 }
=20
 static void output_type_enum(Visitor *v, const char *name, int *obj,
-                             const char *const strings[], Error **errp)
+                             const QEnumLookup *lookup, Error **errp)
 {
-    int i =3D 0;
     int value =3D *obj;
     char *enum_str;
=20
-    while (strings[i++] !=3D NULL);
-    if (value < 0 || value >=3D i - 1) {
+    /*
+     * TODO why is this an error, not an assertion?  If assertion:
+     * delete, and rely on qapi_enum_lookup()
+     */
+    if (value < 0 || value >=3D lookup->size) {
         error_setg(errp, QERR_INVALID_PARAMETER, name ? name : "null");
         return;
     }
=20
-    enum_str =3D (char *)qapi_enum_lookup(strings, value);
+    enum_str =3D (char *)qapi_enum_lookup(lookup, value);
     visit_type_str(v, name, &enum_str, errp);
 }
=20
 static void input_type_enum(Visitor *v, const char *name, int *obj,
-                            const char *const strings[], Error **errp)
+                            const QEnumLookup *lookup, Error **errp)
 {
     Error *local_err =3D NULL;
     int64_t value;
@@ -362,7 +364,7 @@ static void input_type_enum(Visitor *v, const char *n=
ame, int *obj,
         return;
     }
=20
-    value =3D qapi_enum_parse(strings, enum_str, -1, NULL);
+    value =3D qapi_enum_parse(lookup, enum_str, -1, NULL);
     if (value < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
         g_free(enum_str);
@@ -374,16 +376,16 @@ static void input_type_enum(Visitor *v, const char =
*name, int *obj,
 }
=20
 void visit_type_enum(Visitor *v, const char *name, int *obj,
-                     const char *const strings[], Error **errp)
+                     const QEnumLookup *lookup, Error **errp)
 {
-    assert(obj && strings);
+    assert(obj && lookup);
     trace_visit_type_enum(v, name, obj);
     switch (v->type) {
     case VISITOR_INPUT:
-        input_type_enum(v, name, obj, strings, errp);
+        input_type_enum(v, name, obj, lookup, errp);
         break;
     case VISITOR_OUTPUT:
-        output_type_enum(v, name, obj, strings, errp);
+        output_type_enum(v, name, obj, lookup, errp);
         break;
     case VISITOR_CLONE:
         /* nothing further to do, scalar value was already copied by
diff --git a/qemu-img.c b/qemu-img.c
index a72a2e3133..df984b11b9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3489,7 +3489,7 @@ static int img_resize(int argc, char **argv)
             image_opts =3D true;
             break;
         case OPTION_PREALLOCATION:
-            prealloc =3D qapi_enum_parse(PreallocMode_lookup, optarg,
+            prealloc =3D qapi_enum_parse(&PreallocMode_lookup, optarg,
                                        PREALLOC_MODE__MAX, NULL);
             if (prealloc =3D=3D PREALLOC_MODE__MAX) {
                 error_report("Invalid preallocation mode '%s'", optarg);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index a97f3f4540..d75ca51482 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -638,7 +638,7 @@ int main(int argc, char **argv)
             break;
         case QEMU_NBD_OPT_DETECT_ZEROES:
             detect_zeroes =3D
-                qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
+                qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
                                 optarg,
                                 BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                                 &local_err);
diff --git a/qom/object.c b/qom/object.c
index fe6e744b4d..3e18537e9b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1246,7 +1246,7 @@ uint64_t object_property_get_uint(Object *obj, cons=
t char *name,
 }
=20
 typedef struct EnumProperty {
-    const char * const *strings;
+    const QEnumLookup *lookup;
     int (*get)(Object *, Error **);
     void (*set)(Object *, int, Error **);
 } EnumProperty;
@@ -1284,7 +1284,7 @@ int object_property_get_enum(Object *obj, const cha=
r *name,
     visit_complete(v, &str);
     visit_free(v);
     v =3D string_input_visitor_new(str);
-    visit_type_enum(v, name, &ret, enumprop->strings, errp);
+    visit_type_enum(v, name, &ret, enumprop->lookup, errp);
=20
     g_free(str);
     visit_free(v);
@@ -1950,7 +1950,7 @@ static void property_get_enum(Object *obj, Visitor =
*v, const char *name,
         return;
     }
=20
-    visit_type_enum(v, name, &value, prop->strings, errp);
+    visit_type_enum(v, name, &value, prop->lookup, errp);
 }
=20
 static void property_set_enum(Object *obj, Visitor *v, const char *name,
@@ -1960,7 +1960,7 @@ static void property_set_enum(Object *obj, Visitor =
*v, const char *name,
     int value;
     Error *err =3D NULL;
=20
-    visit_type_enum(v, name, &value, prop->strings, &err);
+    visit_type_enum(v, name, &value, prop->lookup, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1977,7 +1977,7 @@ static void property_release_enum(Object *obj, cons=
t char *name,
=20
 void object_property_add_enum(Object *obj, const char *name,
                               const char *typename,
-                              const char * const *strings,
+                              const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **),
                               Error **errp)
@@ -1985,7 +1985,7 @@ void object_property_add_enum(Object *obj, const ch=
ar *name,
     Error *local_err =3D NULL;
     EnumProperty *prop =3D g_malloc(sizeof(*prop));
=20
-    prop->strings =3D strings;
+    prop->lookup =3D lookup;
     prop->get =3D get;
     prop->set =3D set;
=20
@@ -2002,7 +2002,7 @@ void object_property_add_enum(Object *obj, const ch=
ar *name,
=20
 void object_class_property_add_enum(ObjectClass *klass, const char *name=
,
                                     const char *typename,
-                                    const char * const *strings,
+                                    const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **)=
,
                                     Error **errp)
@@ -2010,7 +2010,7 @@ void object_class_property_add_enum(ObjectClass *kl=
ass, const char *name,
     Error *local_err =3D NULL;
     EnumProperty *prop =3D g_malloc(sizeof(*prop));
=20
-    prop->strings =3D strings;
+    prop->lookup =3D lookup;
     prop->get =3D get;
     prop->set =3D set;
=20
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index bd0b742236..7e1cfc13f0 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -153,7 +153,7 @@ def gen_visit_enum(name):
 void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj=
, Error **errp)
 {
     int value =3D *obj;
-    visit_type_enum(v, name, &value, %(c_name)s_lookup, errp);
+    visit_type_enum(v, name, &value, &%(c_name)s_lookup, errp);
     *obj =3D value;
 }
 ''',
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8736b9c786..39a67270fc 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1849,19 +1849,22 @@ def guardend(name):
 def gen_enum_lookup(name, values, prefix=3DNone):
     ret =3D mcgen('''
=20
-const char *const %(c_name)s_lookup[] =3D {
+const QEnumLookup %(c_name)s_lookup =3D {
+    .array =3D (const char *const[]) {
 ''',
                 c_name=3Dc_name(name))
     for value in values:
         index =3D c_enum_const(name, value, prefix)
         ret +=3D mcgen('''
-    [%(index)s] =3D "%(value)s",
+        [%(index)s] =3D "%(value)s",
 ''',
                      index=3Dindex, value=3Dvalue)
=20
     max_index =3D c_enum_const(name, '_MAX', prefix)
     ret +=3D mcgen('''
-    [%(max_index)s] =3D NULL,
+        [%(max_index)s] =3D NULL,
+    },
+    .size =3D %(max_index)s
 };
 ''',
                  max_index=3Dmax_index)
@@ -1895,9 +1898,9 @@ typedef enum %(c_name)s {
     ret +=3D mcgen('''
=20
 #define %(c_name)s_str(val) \\
-    qapi_enum_lookup(%(c_name)s_lookup, (val))
+    qapi_enum_lookup(&%(c_name)s_lookup, (val))
=20
-extern const char *const %(c_name)s_lookup[];
+extern const QEnumLookup %(c_name)s_lookup;
 ''',
                  c_name=3Dc_name(name))
     return ret
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index c51e6e734d..07e351f950 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -46,11 +46,14 @@ enum DummyAnimal {
     DUMMY_LAST,
 };
=20
-static const char *const dummy_animal_map[DUMMY_LAST + 1] =3D {
-    [DUMMY_FROG] =3D "frog",
-    [DUMMY_ALLIGATOR] =3D "alligator",
-    [DUMMY_PLATYPUS] =3D "platypus",
-    [DUMMY_LAST] =3D NULL,
+const QEnumLookup dummy_animal_map =3D {
+    .array =3D (const char *const[]) {
+        [DUMMY_FROG] =3D "frog",
+        [DUMMY_ALLIGATOR] =3D "alligator",
+        [DUMMY_PLATYPUS] =3D "platypus",
+        [DUMMY_LAST] =3D NULL,
+    },
+    .size =3D DUMMY_LAST
 };
=20
 struct DummyObject {
@@ -142,7 +145,7 @@ static void dummy_class_init(ObjectClass *cls, void *=
data)
                                   NULL);
     object_class_property_add_enum(cls, "av",
                                    "DummyAnimal",
-                                   dummy_animal_map,
+                                   &dummy_animal_map,
                                    dummy_get_av,
                                    dummy_set_av,
                                    NULL);
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index 0992bdb218..4b5e4f8bd3 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -19,19 +19,19 @@ static void test_qapi_enum_parse(void)
     Error *err =3D NULL;
     int ret;
=20
-    ret =3D qapi_enum_parse(QType_lookup, NULL, QTYPE_NONE, &error_abort=
);
+    ret =3D qapi_enum_parse(&QType_lookup, NULL, QTYPE_NONE, &error_abor=
t);
     g_assert_cmpint(ret, =3D=3D, QTYPE_NONE);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "junk", -1, NULL);
+    ret =3D qapi_enum_parse(&QType_lookup, "junk", -1, NULL);
     g_assert_cmpint(ret, =3D=3D, -1);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "junk", -1, &err);
+    ret =3D qapi_enum_parse(&QType_lookup, "junk", -1, &err);
     error_free_or_abort(&err);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "none", -1, &error_abort);
+    ret =3D qapi_enum_parse(&QType_lookup, "none", -1, &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE_NONE);
=20
-    ret =3D qapi_enum_parse(QType_lookup, QType_str(QTYPE__MAX - 1),
+    ret =3D qapi_enum_parse(&QType_lookup, QType_str(QTYPE__MAX - 1),
                           QTYPE__MAX - 1, &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE__MAX - 1);
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index f8720aa5eb..fe591814e4 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1110,7 +1110,7 @@ static void test_visitor_in_fail_struct_missing(Tes=
tInputVisitorData *data,
     error_free_or_abort(&err);
     visit_optional(v, "optional", &present);
     g_assert(!present);
-    visit_type_enum(v, "enum", &en, EnumOne_lookup, &err);
+    visit_type_enum(v, "enum", &en, &EnumOne_lookup, &err);
     error_free_or_abort(&err);
     visit_type_int(v, "i64", &i64, &err);
     error_free_or_abort(&err);
diff --git a/tpm.c b/tpm.c
index 111f1ca63f..2d830d072a 100644
--- a/tpm.c
+++ b/tpm.c
@@ -33,7 +33,7 @@ void tpm_register_model(enum TpmModel model)
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type)
 {
-    int i =3D qapi_enum_parse(TpmType_lookup, type, -1, NULL);
+    int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
=20
     return i >=3D 0 ? be_drivers[i] : NULL;
 }
--=20
2.13.5
