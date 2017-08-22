Received: from eggs.gnu.org ([2001:4830:134:3::10]:55419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jk-0008OS-KY
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jd-0007Dg-PY
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:04 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:13 +0200
Message-Id: <20170822132255.23945-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/54] qapi: change enum lookup structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Weil <sw@weilnetz.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

Store the length in the lookup table, i.e. change it from
const char *const[] to struct { int n, const char *const s[] }.

The following conditional enum entry change will create "hole"
elements in the generated lookup array, that should be skipped.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/visitor.h              |  2 +-
 scripts/qapi.py                     | 11 +++++--
 scripts/qapi-types.py               |  6 ++++
 scripts/qapi-visit.py               |  2 +-
 include/hw/qdev-core.h              |  2 +-
 include/qapi/util.h                 |  6 ++--
 include/qom/object.h                |  4 +--
 qapi/qapi-visit-core.c              | 24 +++++++-------
 backends/hostmem.c                  |  4 +--
 block.c                             |  3 +-
 block/backup.c                      |  2 +-
 block/blkdebug.c                    |  4 +--
 block/file-posix.c                  | 17 +++++-----
 block/file-win32.c                  |  6 ++--
 block/gluster.c                     | 12 +++----
 block/iscsi.c                       |  2 +-
 block/nfs.c                         |  2 +-
 block/parallels.c                   | 10 ++++--
 block/qcow2.c                       | 14 ++++----
 block/qed.c                         |  2 +-
 block/quorum.c                      |  4 +--
 block/rbd.c                         |  2 +-
 block/sheepdog.c                    |  2 +-
 blockdev.c                          |  7 ++--
 blockjob.c                          |  6 ++--
 chardev/char.c                      |  4 +--
 crypto/block-luks.c                 | 38 +++++++++-------------
 crypto/block.c                      |  4 +--
 crypto/cipher-afalg.c               |  2 +-
 crypto/cipher-builtin.c             |  8 ++---
 crypto/cipher-gcrypt.c              |  4 +--
 crypto/cipher-nettle.c              |  8 ++---
 crypto/hmac-gcrypt.c                |  2 +-
 crypto/hmac-glib.c                  |  2 +-
 crypto/hmac-nettle.c                |  2 +-
 crypto/pbkdf-gcrypt.c               |  2 +-
 crypto/pbkdf-nettle.c               |  2 +-
 crypto/secret.c                     |  2 +-
 crypto/tlscreds.c                   |  2 +-
 hmp.c                               | 64 +++++++++++++++++--------------=
------
 hw/block/fdc.c                      |  6 ++--
 hw/char/escc.c                      |  2 +-
 hw/core/qdev-properties.c           | 10 +++---
 hw/input/virtio-input-hid.c         |  4 +--
 migration/colo-failover.c           |  4 +--
 migration/colo.c                    | 14 ++++----
 migration/global_state.c            |  5 ++-
 monitor.c                           | 20 ++++++------
 net/filter.c                        |  2 +-
 net/net.c                           |  4 +--
 qapi/qapi-util.c                    | 13 ++++----
 qapi/qmp-dispatch.c                 |  2 +-
 qemu-img.c                          |  6 ++--
 qemu-nbd.c                          |  3 +-
 qom/object.c                        | 16 +++++-----
 tests/check-qom-proplist.c          |  7 +++-
 tests/test-qapi-util.c              | 17 ++++------
 tests/test-qobject-input-visitor.c  |  8 ++---
 tests/test-qobject-output-visitor.c |  2 +-
 tests/test-string-input-visitor.c   |  4 +--
 tests/test-string-output-visitor.c  |  4 +--
 tpm.c                               |  4 +--
 ui/input-legacy.c                   |  6 ++--
 ui/input.c                          | 12 +++----
 ui/vnc.c                            |  6 ++--
 vl.c                                |  6 ++--
 66 files changed, 241 insertions(+), 248 deletions(-)

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
diff --git a/scripts/qapi.py b/scripts/qapi.py
index a3ac799535..314d7e0365 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1851,7 +1851,7 @@ def guardend(name):
 def gen_enum_lookup(name, values, prefix=3DNone):
     ret =3D mcgen('''
=20
-const char *const %(c_name)s_lookup[] =3D {
+static const char *const %(c_name)s_array[] =3D {
 ''',
                 c_name=3Dc_name(name))
     for value in values:
@@ -1865,8 +1865,13 @@ const char *const %(c_name)s_lookup[] =3D {
     ret +=3D mcgen('''
     [%(max_index)s] =3D NULL,
 };
+
+const QEnumLookup %(c_name)s_lookup =3D {
+    .array =3D %(c_name)s_array,
+    .size =3D %(max_index)s
+};
 ''',
-                 max_index=3Dmax_index)
+                 max_index=3Dmax_index, c_name=3Dc_name(name))
     return ret
=20
=20
@@ -1896,7 +1901,7 @@ typedef enum %(c_name)s {
=20
     ret +=3D mcgen('''
=20
-extern const char *const %(c_name)s_lookup[];
+extern const QEnumLookup %(c_name)s_lookup;
 ''',
                  c_name=3Dc_name(name))
     return ret
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index b45e7b5634..dc05268917 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -179,6 +179,12 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.defn =3D ''
         self._fwdecl =3D ''
         self._btin =3D guardstart('QAPI_TYPES_BUILTIN')
+        self._btin +=3D '''
+typedef struct QEnumLookup {
+    const char *const *array;
+    int size;
+} QEnumLookup;
+'''
=20
     def visit_end(self):
         self.decl =3D self._fwdecl + self.decl
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
index 60733b6a80..613f82bdcd 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,10 +11,10 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H
=20
-const char *qapi_enum_lookup(const char * const lookup[], int val);
+const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
=20
-int qapi_enum_parse(const char * const lookup[], const char *buf,
-                    int max, int def, Error **errp);
+int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
+                    int def, Error **errp);
=20
 int parse_qapi_name(const char *name, bool complete);
=20
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
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index ed6d2af462..8876ecf0cd 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -333,24 +333,22 @@ void visit_type_null(Visitor *v, const char *name, =
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
+    if (value < 0 || value > lookup->size || !lookup->array[value]) {
         error_setg(errp, QERR_INVALID_PARAMETER, name ? name : "null");
         return;
     }
=20
-    enum_str =3D (char *)strings[value];
+    enum_str =3D (char *)lookup->array[value];
     visit_type_str(v, name, &enum_str, errp);
 }
=20
 static void input_type_enum(Visitor *v, const char *name, int *obj,
-                            const char *const strings[], Error **errp)
+                            const QEnumLookup *lookup, Error **errp)
 {
     Error *local_err =3D NULL;
     int64_t value =3D 0;
@@ -362,14 +360,14 @@ static void input_type_enum(Visitor *v, const char =
*name, int *obj,
         return;
     }
=20
-    while (strings[value] !=3D NULL) {
-        if (strcmp(strings[value], enum_str) =3D=3D 0) {
+    while (value < lookup->size) {
+        if (!g_strcmp0(lookup->array[value], enum_str)) {
             break;
         }
         value++;
     }
=20
-    if (strings[value] =3D=3D NULL) {
+    if (value =3D=3D lookup->size) {
         error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
         g_free(enum_str);
         return;
@@ -380,16 +378,16 @@ static void input_type_enum(Visitor *v, const char =
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
diff --git a/backends/hostmem.c b/backends/hostmem.c
index c4f795475c..ce430f1d14 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -305,7 +305,7 @@ host_memory_backend_memory_complete(UserCreatable *uc=
, Error **errp)
             return;
         } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_DEFAULT=
) {
             error_setg(errp, "host-nodes must be set for policy %s",
-                qapi_enum_lookup(HostMemPolicy_lookup, backend->policy))=
;
+                qapi_enum_lookup(&HostMemPolicy_lookup, backend->policy)=
);
             return;
         }
=20
@@ -396,7 +396,7 @@ host_memory_backend_class_init(ObjectClass *oc, void =
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
index 3615a6809e..ffb1f8db13 100644
--- a/block.c
+++ b/block.c
@@ -1333,9 +1333,8 @@ static int bdrv_open_common(BlockDriverState *bs, B=
lockBackend *file,
     detect_zeroes =3D qemu_opt_get(opts, "detect-zeroes");
     if (detect_zeroes) {
         BlockdevDetectZeroesOptions value =3D
-            qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
+            qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
                             detect_zeroes,
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_err);
         if (local_err) {
diff --git a/block/backup.c b/block/backup.c
index a700cc0315..8d4f3bcc13 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -597,7 +597,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         error_setg(errp,
                    "a sync_bitmap was provided to backup_run, "
                    "but received an incompatible sync_mode (%s)",
-                   qapi_enum_lookup(MirrorSyncMode_lookup, sync_mode));
+                   qapi_enum_lookup(&MirrorSyncMode_lookup, sync_mode));
         return NULL;
     }
=20
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 50edda2a31..94068156dc 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -170,7 +170,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Err=
or **errp)
         error_setg(errp, "Missing event name for rule");
         return -1;
     }
-    event =3D qapi_enum_parse(BlkdebugEvent_lookup, event_name, BLKDBG__=
MAX, -1, errp);
+    event =3D qapi_enum_parse(&BlkdebugEvent_lookup, event_name, -1, err=
p);
     if (event < 0) {
         return -1;
     }
@@ -733,7 +733,7 @@ static int blkdebug_debug_breakpoint(BlockDriverState=
 *bs, const char *event,
     struct BlkdebugRule *rule;
     int blkdebug_event;
=20
-    blkdebug_event =3D qapi_enum_parse(BlkdebugEvent_lookup, event, BLKD=
BG__MAX, -1, NULL);
+    blkdebug_event =3D qapi_enum_parse(&BlkdebugEvent_lookup, event, -1,=
 NULL);
     if (blkdebug_event < 0) {
         return -ENOENT;
     }
diff --git a/block/file-posix.c b/block/file-posix.c
index 48200aef0b..578f9aae39 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -438,8 +438,8 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     aio_default =3D (bdrv_flags & BDRV_O_NATIVE_AIO)
                   ? BLOCKDEV_AIO_OPTIONS_NATIVE
                   : BLOCKDEV_AIO_OPTIONS_THREADS;
-    aio =3D qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts=
, "aio"),
-                          BLOCKDEV_AIO_OPTIONS__MAX, aio_default, &local=
_err);
+    aio =3D qapi_enum_parse(&BlockdevAioOptions_lookup, qemu_opt_get(opt=
s, "aio"),
+                          aio_default, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -447,8 +447,8 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     }
     s->use_linux_aio =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_NATIVE);
=20
-    locking =3D qapi_enum_parse(OnOffAuto_lookup, qemu_opt_get(opts, "lo=
cking"),
-                              ON_OFF_AUTO__MAX, ON_OFF_AUTO_AUTO, &local=
_err);
+    locking =3D qapi_enum_parse(&OnOffAuto_lookup, qemu_opt_get(opts, "l=
ocking"),
+                              ON_OFF_AUTO_AUTO, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -1725,7 +1725,7 @@ static int raw_regular_truncate(int fd, int64_t off=
set, PreallocMode prealloc,
     default:
         result =3D -ENOTSUP;
         error_setg(errp, "Unsupported preallocation mode: %s",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return result;
     }
=20
@@ -1760,7 +1760,7 @@ static int raw_truncate(BlockDriverState *bs, int64=
_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Preallocation mode '%s' unsupported for this "
-                   "non-regular file", qapi_enum_lookup(PreallocMode_loo=
kup,
+                   "non-regular file", qapi_enum_lookup(&PreallocMode_lo=
okup,
                                                         prealloc));
         return -ENOTSUP;
     }
@@ -1975,9 +1975,8 @@ static int raw_create(const char *filename, QemuOpt=
s *opts, Error **errp)
                           BDRV_SECTOR_SIZE);
     nocow =3D qemu_opt_get_bool(opts, BLOCK_OPT_NOCOW, false);
     buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, buf,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
+                               PREALLOC_MODE_OFF, &local_err);
     g_free(buf);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/file-win32.c b/block/file-win32.c
index 2f3975f040..be4146e030 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -303,8 +303,8 @@ static bool get_aio_option(QemuOpts *opts, int flags,=
 Error **errp)
=20
     aio_default =3D (flags & BDRV_O_NATIVE_AIO) ? BLOCKDEV_AIO_OPTIONS_N=
ATIVE
                                               : BLOCKDEV_AIO_OPTIONS_THR=
EADS;
-    aio =3D qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts=
, "aio"),
-                          BLOCKDEV_AIO_OPTIONS__MAX, aio_default, errp);
+    aio =3D qapi_enum_parse(&BlockdevAioOptions_lookup, qemu_opt_get(opt=
s, "aio"),
+                          aio_default, errp);
=20
     switch (aio) {
     case BLOCKDEV_AIO_OPTIONS_NATIVE:
@@ -470,7 +470,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t=
 offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(reallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&reallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/gluster.c b/block/gluster.c
index 934f459014..bc8eff5dd3 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -544,8 +544,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
         if (!strcmp(ptr, "tcp")) {
             ptr =3D "inet";       /* accept legacy "tcp" */
         }
-        type =3D qapi_enum_parse(SocketAddressType_lookup, ptr,
-                               SOCKET_ADDRESS_TYPE__MAX, -1, NULL);
+        type =3D qapi_enum_parse(&SocketAddressType_lookup, ptr, -1, NUL=
L);
         if (type !=3D SOCKET_ADDRESS_TYPE_INET
             && type !=3D SOCKET_ADDRESS_TYPE_UNIX) {
             error_setg(&local_err,
@@ -1002,9 +1001,8 @@ static int qemu_gluster_create(const char *filename=
,
                           BDRV_SECTOR_SIZE);
=20
     tmp =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, tmp,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, tmp,
+                               PREALLOC_MODE_OFF, &local_err);
     g_free(tmp);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1050,7 +1048,7 @@ static int qemu_gluster_create(const char *filename=
,
     default:
         ret =3D -EINVAL;
         error_setg(errp, "Unsupported preallocation mode: %s",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         break;
     }
=20
@@ -1102,7 +1100,7 @@ static int qemu_gluster_truncate(BlockDriverState *=
bs, int64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/iscsi.c b/block/iscsi.c
index 5c1870340b..c6bb0049bf 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2088,7 +2088,7 @@ static int iscsi_truncate(BlockDriverState *bs, int=
64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/nfs.c b/block/nfs.c
index 953728ae31..f0ac050169 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -773,7 +773,7 @@ static int nfs_file_truncate(BlockDriverState *bs, in=
t64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/parallels.c b/block/parallels.c
index e1e06d23cc..f870bbac3e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -69,12 +69,16 @@ typedef enum ParallelsPreallocMode {
     PRL_PREALLOC_MODE__MAX =3D 2,
 } ParallelsPreallocMode;
=20
-static const char *prealloc_mode_lookup[] =3D {
+static const char *prealloc_mode_array[] =3D {
     "falloc",
     "truncate",
     NULL,
 };
=20
+static QEnumLookup prealloc_mode_lookup =3D {
+    .array =3D prealloc_mode_array,
+    .size =3D G_N_ELEMENTS(prealloc_mode_array),
+};
=20
 typedef struct BDRVParallelsState {
     /** Locking is conservative, the lock protects
@@ -696,8 +700,8 @@ static int parallels_open(BlockDriverState *bs, QDict=
 *options, int flags,
         qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
     s->prealloc_size =3D MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_=
BITS);
     buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
-    s->prealloc_mode =3D qapi_enum_parse(prealloc_mode_lookup, buf,
-            PRL_PREALLOC_MODE__MAX, PRL_PREALLOC_MODE_FALLOCATE, &local_=
err);
+    s->prealloc_mode =3D qapi_enum_parse(&prealloc_mode_lookup, buf,
+                                       PRL_PREALLOC_MODE_FALLOCATE, &loc=
al_err);
     g_free(buf);
     if (local_err !=3D NULL) {
         goto fail_options;
diff --git a/block/qcow2.c b/block/qcow2.c
index 45b0579caa..c72fa2b476 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2733,7 +2733,7 @@ static int qcow2_create2(const char *filename, int6=
4_t total_size,
             qcow2_calc_prealloc_size(total_size, cluster_size, refcount_=
order);
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_=
abort);
         qemu_opt_set(opts, BLOCK_OPT_PREALLOC,
-                     qapi_enum_lookup(PreallocMode_lookup, prealloc),
+                     qapi_enum_lookup(&PreallocMode_lookup, prealloc),
                      &error_abort);
     }
=20
@@ -2933,9 +2933,8 @@ static int qcow2_create(const char *filename, QemuO=
pts *opts, Error **errp)
         goto finish;
     }
     buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, buf,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
+                               PREALLOC_MODE_OFF, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -3099,7 +3098,7 @@ static int qcow2_truncate(BlockDriverState *bs, int=
64_t offset,
         prealloc !=3D PREALLOC_MODE_FALLOC && prealloc !=3D PREALLOC_MOD=
E_FULL)
     {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
@@ -3624,9 +3623,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
ts, BlockDriverState *in_bs,
     }
=20
     optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, optstr,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, optstr,
+                               PREALLOC_MODE_OFF, &local_err);
     g_free(optstr);
     if (local_err) {
         goto err;
diff --git a/block/qed.c b/block/qed.c
index 756fcb85a7..aec2a559ce 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1400,7 +1400,7 @@ static int bdrv_qed_truncate(BlockDriverState *bs, =
int64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/quorum.c b/block/quorum.c
index e4271caa7a..44acd2702c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -911,9 +911,9 @@ static int quorum_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     if (!qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN)) {
         ret =3D QUORUM_READ_PATTERN_QUORUM;
     } else {
-        ret =3D qapi_enum_parse(QuorumReadPattern_lookup,
+        ret =3D qapi_enum_parse(&QuorumReadPattern_lookup,
                               qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN=
),
-                              QUORUM_READ_PATTERN__MAX, -EINVAL, NULL);
+                              -EINVAL, NULL);
     }
     if (ret < 0) {
         error_setg(&local_err, "Please set read-pattern as fifo or quoru=
m");
diff --git a/block/rbd.c b/block/rbd.c
index 09f8d18d1b..ff71259f05 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -945,7 +945,7 @@ static int qemu_rbd_truncate(BlockDriverState *bs, in=
t64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 69d49fb720..9eac7c0ec7 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2177,7 +2177,7 @@ static int sd_truncate(BlockDriverState *bs, int64_=
t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
+                   qapi_enum_lookup(&PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/blockdev.c b/blockdev.c
index 6a067e81bf..7834b8830e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -438,9 +438,8 @@ static void extract_common_blockdev_options(QemuOpts =
*opts, int *bdrv_flags,
=20
     if (detect_zeroes) {
         *detect_zeroes =3D
-            qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
+            qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
                             qemu_opt_get(opts, "detect-zeroes"),
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_error);
         if (local_error) {
@@ -1468,9 +1467,9 @@ static int action_check_completion_mode(BlkActionSt=
ate *s, Error **errp)
         error_setg(errp,
                    "Action '%s' does not support Transaction property "
                    "completion-mode =3D %s",
-                   qapi_enum_lookup(TransactionActionKind_lookup,
+                   qapi_enum_lookup(&TransactionActionKind_lookup,
                                     s->action->type),
-                   qapi_enum_lookup(ActionCompletionMode_lookup,
+                   qapi_enum_lookup(&ActionCompletionMode_lookup,
                                     s->txn_props->completion_mode));
         return -1;
     }
diff --git a/blockjob.c b/blockjob.c
index fca71123e0..3c815b89e4 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -209,7 +209,7 @@ static char *child_job_get_parent_desc(BdrvChild *c)
 {
     BlockJob *job =3D c->opaque;
     return g_strdup_printf("%s job '%s'",
-                           qapi_enum_lookup(BlockJobType_lookup,
+                           qapi_enum_lookup(&BlockJobType_lookup,
                                             job->driver->job_type),
                            job->id);
 }
@@ -555,7 +555,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **=
errp)
         return NULL;
     }
     info =3D g_new0(BlockJobInfo, 1);
-    info->type      =3D g_strdup(qapi_enum_lookup(BlockJobType_lookup,
+    info->type      =3D g_strdup(qapi_enum_lookup(&BlockJobType_lookup,
                                                 job->driver->job_type));
     info->device    =3D g_strdup(job->id);
     info->len       =3D job->len;
@@ -669,7 +669,7 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
     job->refcnt        =3D 1;
=20
     error_setg(&job->blocker, "block device is in use by block job: %s",
-               qapi_enum_lookup(BlockJobType_lookup, driver->job_type));
+               qapi_enum_lookup(&BlockJobType_lookup, driver->job_type))=
;
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abo=
rt);
     bs->job =3D job;
=20
diff --git a/chardev/char.c b/chardev/char.c
index 4408d12a08..ba2d110ae5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -932,7 +932,7 @@ ChardevReturn *qmp_chardev_add(const char *id, Charde=
vBackend *backend,
     ChardevReturn *ret;
     Chardev *chr;
=20
-    cc =3D char_get_class(qapi_enum_lookup(ChardevBackendKind_lookup,
+    cc =3D char_get_class(qapi_enum_lookup(&ChardevBackendKind_lookup,
                                          backend->type), errp);
     if (!cc) {
         return NULL;
@@ -991,7 +991,7 @@ ChardevReturn *qmp_chardev_change(const char *id, Cha=
rdevBackend *backend,
         return NULL;
     }
=20
-    cc =3D char_get_class(qapi_enum_lookup(ChardevBackendKind_lookup,
+    cc =3D char_get_class(qapi_enum_lookup(&ChardevBackendKind_lookup,
                                          backend->type), errp);
     if (!cc) {
         return NULL;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index b78a6345f3..a3c96d768b 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -258,47 +258,39 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherA=
lgorithm alg,
     }
=20
     error_setg(errp, "Algorithm '%s' not supported",
-               qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg));
+               qapi_enum_lookup(&QCryptoCipherAlgorithm_lookup, alg));
     return NULL;
 }
=20
-/* XXX replace with qapi_enum_parse() in future, when we can
+/* XXX replace with qapi_enum_parse(&) in future, when we can
  * make that function emit a more friendly error message */
 static int qcrypto_block_luks_name_lookup(const char *name,
-                                          const char *const *map,
-                                          size_t maplen,
+                                          const QEnumLookup *lookup,
                                           const char *type,
                                           Error **errp)
 {
-    size_t i;
-    for (i =3D 0; i < maplen; i++) {
-        if (g_str_equal(map[i], name)) {
-            return i;
-        }
+    int i =3D qapi_enum_parse(lookup, name, -1, NULL);
+    if (i < 0) {
+        error_setg(errp, "%s %s not supported", type, name);
     }
-
-    error_setg(errp, "%s %s not supported", type, name);
-    return 0;
+    return i;
 }
=20
 #define qcrypto_block_luks_cipher_mode_lookup(name, errp)               =
\
     qcrypto_block_luks_name_lookup(name,                                =
\
-                                   QCryptoCipherMode_lookup,            =
\
-                                   QCRYPTO_CIPHER_MODE__MAX,            =
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
-                                   QCRYPTO_HASH_ALG__MAX,               =
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
-                                   QCRYPTO_IVGEN_ALG__MAX,              =
\
+                                   &QCryptoIVGenAlgorithm_lookup,       =
 \
                                    "IV generator",                      =
\
                                    errp)
=20
@@ -399,7 +391,7 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorith=
m cipher,
         break;
     default:
         error_setg(errp, "Cipher %s not supported with essiv",
-                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, ciphe=
r));
+                   qapi_enum_lookup(&QCryptoCipherAlgorithm_lookup, ciph=
er));
         return 0;
     }
 }
@@ -969,19 +961,19 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
=20
-    cipher_mode =3D qapi_enum_lookup(QCryptoCipherMode_lookup,
+    cipher_mode =3D qapi_enum_lookup(&QCryptoCipherMode_lookup,
                                    luks_opts.cipher_mode);
-    ivgen_alg =3D qapi_enum_lookup(QCryptoIVGenAlgorithm_lookup,
+    ivgen_alg =3D qapi_enum_lookup(&QCryptoIVGenAlgorithm_lookup,
                                  luks_opts.ivgen_alg);
     if (luks_opts.has_ivgen_hash_alg) {
-        ivgen_hash_alg =3D qapi_enum_lookup(QCryptoHashAlgorithm_lookup,
+        ivgen_hash_alg =3D qapi_enum_lookup(&QCryptoHashAlgorithm_lookup=
,
                                           luks_opts.ivgen_hash_alg);
         cipher_mode_spec =3D g_strdup_printf("%s-%s:%s", cipher_mode, iv=
gen_alg,
                                            ivgen_hash_alg);
     } else {
         cipher_mode_spec =3D g_strdup_printf("%s-%s", cipher_mode, ivgen=
_alg);
     }
-    hash_alg =3D qapi_enum_lookup(QCryptoHashAlgorithm_lookup,
+    hash_alg =3D qapi_enum_lookup(&QCryptoHashAlgorithm_lookup,
                                 luks_opts.hash_alg);
=20
=20
diff --git a/crypto/block.c b/crypto/block.c
index 2140e55426..99606fe63a 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -62,7 +62,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOption=
s *options,
     if (options->format >=3D G_N_ELEMENTS(qcrypto_block_drivers) ||
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
-            qapi_enum_lookup(QCryptoBlockFormat_lookup, options->format)=
);
+            qapi_enum_lookup(&QCryptoBlockFormat_lookup, options->format=
));
         g_free(block);
         return NULL;
     }
@@ -93,7 +93,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOp=
tions *options,
     if (options->format >=3D G_N_ELEMENTS(qcrypto_block_drivers) ||
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
-            qapi_enum_lookup(QCryptoBlockFormat_lookup, options->format)=
);
+            qapi_enum_lookup(&QCryptoBlockFormat_lookup, options->format=
));
         g_free(block);
         return NULL;
     }
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index 24d7ba8277..f15fb2a9c8 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -52,7 +52,7 @@ qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm=
 alg,
         return NULL;
     }
=20
-    mode_name =3D qapi_enum_lookup(QCryptoCipherMode_lookup, mode);
+    mode_name =3D qapi_enum_lookup(&QCryptoCipherMode_lookup, mode);
     name =3D g_strdup_printf("%s(%s)", mode_name, alg_name);
=20
     return name;
diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index 76c76fb05b..e956cc5a53 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -247,7 +247,7 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
         mode !=3D QCRYPTO_CIPHER_MODE_ECB &&
         mode !=3D QCRYPTO_CIPHER_MODE_XTS) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
+                   qapi_enum_lookup(&QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -379,7 +379,7 @@ qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
=20
     if (mode !=3D QCRYPTO_CIPHER_MODE_ECB) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
+                   qapi_enum_lookup(&QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -440,7 +440,7 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(Q=
CryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
+                   qapi_enum_lookup(&QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -460,7 +460,7 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(Q=
CryptoCipherAlgorithm alg,
     default:
         error_setg(errp,
                    "Unsupported cipher algorithm %s",
-                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg))=
;
+                   qapi_enum_lookup(&QCryptoCipherAlgorithm_lookup, alg)=
);
         return NULL;
     }
=20
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 09210195a4..3e46ee7502 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -105,7 +105,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
+                   qapi_enum_lookup(&QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -160,7 +160,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
=20
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
-                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg))=
;
+                   qapi_enum_lookup(&QCryptoCipherAlgorithm_lookup, alg)=
);
         return NULL;
     }
=20
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index 7c02b3e7a2..5e70c7984a 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -281,7 +281,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
+                   qapi_enum_lookup(&QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -420,7 +420,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
=20
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
-                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg))=
;
+                   qapi_enum_lookup(&QCryptoCipherAlgorithm_lookup, alg)=
);
         goto error;
     }
=20
@@ -491,7 +491,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
=20
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   qapi_enum_lookup(QCryptoCipherMode_lookup, cipher->mo=
de));
+                   qapi_enum_lookup(&QCryptoCipherMode_lookup, cipher->m=
ode));
         return -1;
     }
     return 0;
@@ -537,7 +537,7 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
=20
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   qapi_enum_lookup(QCryptoCipherMode_lookup, cipher->mo=
de));
+                   qapi_enum_lookup(&QCryptoCipherMode_lookup, cipher->m=
ode));
         return -1;
     }
     return 0;
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 0784795269..f24d5a48c2 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -52,7 +52,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   qapi_enum_lookup(QCryptoHashAlgorithm_lookup, alg));
+                   qapi_enum_lookup(&QCryptoHashAlgorithm_lookup, alg));
         return NULL;
     }
=20
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 56b71dbf85..aac4b217c0 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -59,7 +59,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   qapi_enum_lookup(QCryptoHashAlgorithm_lookup, alg));
+                   qapi_enum_lookup(&QCryptoHashAlgorithm_lookup, alg));
         return NULL;
     }
=20
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index be43511252..07cc8af9b9 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -107,7 +107,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   qapi_enum_lookup(QCryptoHashAlgorithm_lookup, alg));
+                   qapi_enum_lookup(&QCryptoHashAlgorithm_lookup, alg));
         return NULL;
     }
=20
diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index a815138c46..eff037f08f 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -69,7 +69,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
         hash_map[hash] =3D=3D GCRY_MD_NONE) {
         error_setg_errno(errp, ENOSYS,
                          "PBKDF does not support hash algorithm %s",
-                         qapi_enum_lookup(QCryptoHashAlgorithm_lookup, h=
ash));
+                         qapi_enum_lookup(&QCryptoHashAlgorithm_lookup, =
hash));
         return -1;
     }
=20
diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
index 84977fdd69..bb6454b80c 100644
--- a/crypto/pbkdf-nettle.c
+++ b/crypto/pbkdf-nettle.c
@@ -110,7 +110,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
     default:
         error_setg_errno(errp, ENOSYS,
                          "PBKDF does not support hash algorithm %s",
-                         qapi_enum_lookup(QCryptoHashAlgorithm_lookup, h=
ash));
+                         qapi_enum_lookup(&QCryptoHashAlgorithm_lookup, =
hash));
         return -1;
     }
     return 0;
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
index ccc58e6d88..0eb318f938 100644
--- a/hmp.c
+++ b/hmp.c
@@ -108,7 +108,7 @@ void hmp_info_status(Monitor *mon, const QDict *qdict=
)
=20
     if (!info->running && info->status !=3D RUN_STATE_PAUSED) {
         monitor_printf(mon, " (%s)",
-                       qapi_enum_lookup(RunState_lookup, info->status));
+                       qapi_enum_lookup(&RunState_lookup, info->status))=
;
     }
=20
     monitor_printf(mon, "\n");
@@ -173,7 +173,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
         monitor_printf(mon, "capabilities: ");
         for (cap =3D caps; cap; cap =3D cap->next) {
             monitor_printf(mon, "%s: %s ",
-                           qapi_enum_lookup(MigrationCapability_lookup,
+                           qapi_enum_lookup(&MigrationCapability_lookup,
                                             cap->value->capability),
                            cap->value->state ? "on" : "off");
         }
@@ -182,7 +182,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
=20
     if (info->has_status) {
         monitor_printf(mon, "Migration status: %s",
-                       qapi_enum_lookup(MigrationStatus_lookup, info->st=
atus));
+                       qapi_enum_lookup(&MigrationStatus_lookup, info->s=
tatus));
         if (info->status =3D=3D MIGRATION_STATUS_FAILED &&
             info->has_error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
@@ -280,7 +280,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, cons=
t QDict *qdict)
     if (caps) {
         for (cap =3D caps; cap; cap =3D cap->next) {
             monitor_printf(mon, "%s: %s\n",
-                           qapi_enum_lookup(MigrationCapability_lookup,
+                           qapi_enum_lookup(&MigrationCapability_lookup,
                                             cap->value->capability),
                            cap->value->state ? "on" : "off");
         }
@@ -298,57 +298,57 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
     if (params) {
         assert(params->has_compress_level);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_COMPRESS_LEVEL),
             params->compress_level);
         assert(params->has_compress_threads);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_COMPRESS_THREADS),
             params->compress_threads);
         assert(params->has_decompress_threads);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_DECOMPRESS_THREADS),
             params->decompress_threads);
         assert(params->has_cpu_throttle_initial);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
             params->cpu_throttle_initial);
         assert(params->has_cpu_throttle_increment);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT)=
,
             params->cpu_throttle_increment);
         assert(params->has_tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_TLS_CREDS),
             params->tls_creds);
         assert(params->has_tls_hostname);
         monitor_printf(mon, "%s: '%s'\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_TLS_HOSTNAME),
             params->tls_hostname);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
         assert(params->has_downtime_limit);
         monitor_printf(mon, "%s: %" PRId64 " milliseconds\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_DOWNTIME_LIMIT),
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
         assert(params->has_block_incremental);
         monitor_printf(mon, "%s: %s\n",
-            qapi_enum_lookup(MigrationParameter_lookup,
+            qapi_enum_lookup(&MigrationParameter_lookup,
                              MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
             params->block_incremental ? "on" : "off");
     }
@@ -446,7 +446,7 @@ static void print_block_info(Monitor *mon, BlockInfo =
*info,
         }
         if (info->has_io_status && info->io_status !=3D BLOCK_DEVICE_IO_=
STATUS_OK) {
             monitor_printf(mon, "    I/O status:       %s\n",
-                qapi_enum_lookup(BlockDeviceIoStatus_lookup, info->io_st=
atus));
+                qapi_enum_lookup(&BlockDeviceIoStatus_lookup, info->io_s=
tatus));
         }
=20
         if (info->removable) {
@@ -476,7 +476,7 @@ static void print_block_info(Monitor *mon, BlockInfo =
*info,
=20
     if (inserted->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF)=
 {
         monitor_printf(mon, "    Detect zeroes:    %s\n",
-            qapi_enum_lookup(BlockdevDetectZeroesOptions_lookup,
+            qapi_enum_lookup(&BlockdevDetectZeroesOptions_lookup,
                              inserted->detect_zeroes));
     }
=20
@@ -628,7 +628,7 @@ static void hmp_info_VncBasicInfo(Monitor *mon, VncBa=
sicInfo *info,
                    name,
                    info->host,
                    info->service,
-                   qapi_enum_lookup(NetworkAddressFamily_lookup, info->f=
amily),
+                   qapi_enum_lookup(&NetworkAddressFamily_lookup, info->=
family),
                    info->websocket ? " (Websocket)" : "");
 }
=20
@@ -638,8 +638,8 @@ static void hmp_info_vnc_authcrypt(Monitor *mon, cons=
t char *indent,
                                    VncVencryptSubAuth *vencrypt)
 {
     monitor_printf(mon, "%sAuth: %s (Sub: %s)\n", indent,
-        qapi_enum_lookup(VncPrimaryAuth_lookup, auth),
-        vencrypt ? qapi_enum_lookup(VncVencryptSubAuth_lookup, *vencrypt=
)
+        qapi_enum_lookup(&VncPrimaryAuth_lookup, auth),
+        vencrypt ? qapi_enum_lookup(&VncVencryptSubAuth_lookup, *vencryp=
t)
                    : "none");
 }
=20
@@ -755,7 +755,7 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "        auth: %s\n", info->auth);
     monitor_printf(mon, "    compiled: %s\n", info->compiled_version);
     monitor_printf(mon, "  mouse-mode: %s\n",
-        qapi_enum_lookup(SpiceQueryMouseMode_lookup, info->mouse_mode));
+        qapi_enum_lookup(&SpiceQueryMouseMode_lookup, info->mouse_mode))=
;
=20
     if (!info->has_channels || info->channels =3D=3D NULL) {
         monitor_printf(mon, "Channels: none\n");
@@ -1026,10 +1026,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdic=
t)
     for (info =3D info_list; info; info =3D info->next) {
         TPMInfo *ti =3D info->value;
         monitor_printf(mon, " tpm%d: model=3D%s\n",
-                       c, qapi_enum_lookup(TpmModel_lookup, ti->model));
+                       c, qapi_enum_lookup(&TpmModel_lookup, ti->model))=
;
=20
         monitor_printf(mon, "  \\ %s: type=3D%s",
-                       ti->id, qapi_enum_lookup(TpmTypeOptionsKind_looku=
p,
+                       ti->id, qapi_enum_lookup(&TpmTypeOptionsKind_look=
up,
                                                 ti->options->type));
=20
         switch (ti->options->type) {
@@ -1546,8 +1546,7 @@ void hmp_migrate_set_capability(Monitor *mon, const=
 QDict *qdict)
     MigrationCapabilityStatusList *caps =3D g_malloc0(sizeof(*caps));
     int val;
=20
-    val =3D qapi_enum_parse(MigrationCapability_lookup, cap,
-                          MIGRATION_CAPABILITY__MAX, -1, &err);
+    val =3D qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
     if (val < 0) {
         goto end;
     }
@@ -1576,8 +1575,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
     Error *err =3D NULL;
     int val, ret;
=20
-    val =3D qapi_enum_parse(MigrationParameter_lookup, param,
-                          MIGRATION_PARAMETER__MAX,  -1, &err);
+    val =3D qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err)=
;
     if (val < 0) {
         goto cleanup;
     }
@@ -1752,10 +1750,8 @@ void hmp_change(Monitor *mon, const QDict *qdict)
         qmp_change("vnc", target, !!arg, arg, &err);
     } else {
         if (read_only) {
-            read_only_mode =3D
-                qapi_enum_parse(BlockdevChangeReadOnlyMode_lookup,
-                                read_only, BLOCKDEV_CHANGE_READ_ONLY_MOD=
E__MAX,
-                                BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &=
err);
+            read_only_mode =3D qapi_enum_parse(&BlockdevChangeReadOnlyMo=
de_lookup,
+                read_only, BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &err);
             if (err) {
                 hmp_handle_error(mon, &err);
                 return;
@@ -2386,7 +2382,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdi=
ct)
         monitor_printf(mon, "  prealloc: %s\n",
                        m->value->prealloc ? "true" : "false");
         monitor_printf(mon, "  policy: %s\n",
-            qapi_enum_lookup(HostMemPolicy_lookup, m->value->policy));
+            qapi_enum_lookup(&HostMemPolicy_lookup, m->value->policy));
         visit_complete(v, &str);
         monitor_printf(mon, "  host nodes: %s\n", str);
=20
@@ -2417,7 +2413,7 @@ void hmp_info_memory_devices(Monitor *mon, const QD=
ict *qdict)
                 di =3D value->u.dimm.data;
=20
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
-                    qapi_enum_lookup(MemoryDeviceInfoKind_lookup, value-=
>type),
+                    qapi_enum_lookup(&MemoryDeviceInfoKind_lookup, value=
->type),
                     di->id ? di->id : "");
                 monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", di->addr)=
;
                 monitor_printf(mon, "  slot: %" PRId64 "\n", di->slot);
@@ -2812,7 +2808,7 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict=
)
=20
     assert(result && result->status < DUMP_STATUS__MAX);
     monitor_printf(mon, "Status: %s\n",
-                   qapi_enum_lookup(DumpStatus_lookup, result->status));
+                   qapi_enum_lookup(&DumpStatus_lookup, result->status))=
;
=20
     if (result->status =3D=3D DUMP_STATUS_ACTIVE) {
         float percent =3D 0;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 8ebe08d1af..df35f3e1cc 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -393,10 +393,10 @@ static int pick_geometry(FDrive *drv)
             FLOPPY_DPRINTF("User requested floppy drive type '%s', "
                            "but inserted medium appears to be a "
                            "%"PRId64" sector '%s' type\n",
-                           qapi_enum_lookup(FloppyDriveType_lookup,
+                           qapi_enum_lookup(&FloppyDriveType_lookup,
                                             drv->drive),
                            nb_sectors,
-                           qapi_enum_lookup(FloppyDriveType_lookup,
+                           qapi_enum_lookup(&FloppyDriveType_lookup,
                                             parse->drive));
         }
         match =3D type_match;
@@ -406,7 +406,7 @@ static int pick_geometry(FDrive *drv)
     if (match =3D=3D -1) {
         error_setg(&error_abort, "No candidate geometries present in tab=
le "
                    " for floppy drive type '%s'",
-                   qapi_enum_lookup(FloppyDriveType_lookup, drv->drive))=
;
+                   qapi_enum_lookup(&FloppyDriveType_lookup, drv->drive)=
);
     }
=20
     parse =3D &(fd_formats[match]);
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 5c1d7b0e29..d5aba2a8a4 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -849,7 +849,7 @@ static void sunkbd_handle_event(DeviceState *dev, Qem=
uConsole *src,
     assert(evt->type =3D=3D INPUT_EVENT_KIND_KEY);
     key =3D evt->u.key.data;
     qcode =3D qemu_input_key_value_to_qcode(key->key);
-    trace_escc_sunkbd_event_in(qcode, qapi_enum_lookup(QKeyCode_lookup, =
qcode),
+    trace_escc_sunkbd_event_in(qcode, qapi_enum_lookup(&QKeyCode_lookup,=
 qcode),
                                key->down);
=20
     if (qcode =3D=3D Q_KEY_CODE_CAPS_LOCK) {
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c82c693bca..ee4fc9812b 100644
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
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 64039236f1..235b11082f 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -210,7 +210,7 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,
         } else {
             if (key->down) {
                 fprintf(stderr, "%s: unmapped key: %d [%s]\n", __func__,
-                        qcode, qapi_enum_lookup(QKeyCode_lookup, qcode))=
;
+                        qcode, qapi_enum_lookup(&QKeyCode_lookup, qcode)=
);
             }
         }
         break;
@@ -225,7 +225,7 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,
             if (btn->down) {
                 fprintf(stderr, "%s: unmapped button: %d [%s]\n", __func=
__,
                         btn->button,
-                        qapi_enum_lookup(InputButton_lookup, btn->button=
));
+                        qapi_enum_lookup(&InputButton_lookup, btn->butto=
n));
             }
         }
         break;
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index e5394ba631..c3dd0969d6 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -35,7 +35,7 @@ static void colo_failover_bh(void *opaque)
                                    FAILOVER_STATUS_ACTIVE);
     if (old_state !=3D FAILOVER_STATUS_REQUIRE) {
         error_report("Unknown error for failover, old_state =3D %s",
-                     qapi_enum_lookup(FailoverStatus_lookup, old_state))=
;
+                     qapi_enum_lookup(&FailoverStatus_lookup, old_state)=
);
         return;
     }
=20
@@ -65,7 +65,7 @@ FailoverStatus failover_set_state(FailoverStatus old_st=
ate,
=20
     old =3D atomic_cmpxchg(&failover_state, old_state, new_state);
     if (old =3D=3D old_state) {
-        trace_colo_failover_set_state(qapi_enum_lookup(FailoverStatus_lo=
okup,
+        trace_colo_failover_set_state(qapi_enum_lookup(&FailoverStatus_l=
ookup,
                                                        new_state));
     }
     return old;
diff --git a/migration/colo.c b/migration/colo.c
index 2b683a0afc..8bd7ef0531 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -63,7 +63,7 @@ static void secondary_vm_do_failover(void)
         if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
             error_report("Unknown error while do failover for secondary =
VM,"
                          "old_state: %s",
-                         qapi_enum_lookup(FailoverStatus_lookup, old_sta=
te));
+                         qapi_enum_lookup(&FailoverStatus_lookup, old_st=
ate));
         }
         return;
     }
@@ -94,7 +94,7 @@ static void secondary_vm_do_failover(void)
     if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
         error_report("Incorrect state (%s) while doing failover for "
                      "secondary VM",
-                     qapi_enum_lookup(FailoverStatus_lookup, old_state))=
;
+                     qapi_enum_lookup(&FailoverStatus_lookup, old_state)=
);
         return;
     }
     /* Notify COLO incoming thread that failover work is finished */
@@ -129,7 +129,7 @@ static void primary_vm_do_failover(void)
                                    FAILOVER_STATUS_COMPLETED);
     if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
         error_report("Incorrect state (%s) while doing failover for Prim=
ary VM",
-                     qapi_enum_lookup(FailoverStatus_lookup, old_state))=
;
+                     qapi_enum_lookup(&FailoverStatus_lookup, old_state)=
);
         return;
     }
     /* Notify COLO thread that failover work is finished */
@@ -225,7 +225,7 @@ static void colo_send_message(QEMUFile *f, COLOMessag=
e msg,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Can't send COLO message");
     }
-    trace_colo_send_message(qapi_enum_lookup(COLOMessage_lookup, msg));
+    trace_colo_send_message(qapi_enum_lookup(&COLOMessage_lookup, msg));
 }
=20
 static void colo_send_message_value(QEMUFile *f, COLOMessage msg,
@@ -245,7 +245,7 @@ static void colo_send_message_value(QEMUFile *f, COLO=
Message msg,
     ret =3D qemu_file_get_error(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to send value for message:%=
s",
-                         qapi_enum_lookup(COLOMessage_lookup, msg));
+                         qapi_enum_lookup(&COLOMessage_lookup, msg));
     }
 }
=20
@@ -264,7 +264,7 @@ static COLOMessage colo_receive_message(QEMUFile *f, =
Error **errp)
         error_setg(errp, "%s: Invalid message", __func__);
         return msg;
     }
-    trace_colo_receive_message(qapi_enum_lookup(COLOMessage_lookup, msg)=
);
+    trace_colo_receive_message(qapi_enum_lookup(&COLOMessage_lookup, msg=
));
     return msg;
 }
=20
@@ -302,7 +302,7 @@ static uint64_t colo_receive_message_value(QEMUFile *=
f, uint32_t expect_msg,
     ret =3D qemu_file_get_error(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to get value for COLO messa=
ge: %s",
-                         qapi_enum_lookup(COLOMessage_lookup, expect_msg=
));
+                         qapi_enum_lookup(&COLOMessage_lookup, expect_ms=
g));
     }
     return value;
 }
diff --git a/migration/global_state.c b/migration/global_state.c
index 4d57a9c5f2..486979c4cc 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -42,7 +42,7 @@ int global_state_store(void)
=20
 void global_state_store_running(void)
 {
-    const char *state =3D qapi_enum_lookup(RunState_lookup, RUN_STATE_RU=
NNING);
+    const char *state =3D qapi_enum_lookup(&RunState_lookup, RUN_STATE_R=
UNNING);
     strncpy((char *)global_state.runstate,
            state, sizeof(global_state.runstate));
 }
@@ -89,8 +89,7 @@ static int global_state_post_load(void *opaque, int ver=
sion_id)
     s->received =3D true;
     trace_migrate_global_state_post_load(runstate);
=20
-    r =3D qapi_enum_parse(RunState_lookup, runstate, RUN_STATE__MAX,
-                                -1, &local_err);
+    r =3D qapi_enum_parse(&RunState_lookup, runstate, -1, &local_err);
=20
     if (r =3D=3D -1) {
         if (local_err) {
diff --git a/monitor.c b/monitor.c
index ee2fdfd4f1..228f246fcc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -929,7 +929,7 @@ EventInfoList *qmp_query_events(Error **errp)
     QAPIEvent e;
=20
     for (e =3D 0 ; e < QAPI_EVENT__MAX ; e++) {
-        const char *event_name =3D qapi_enum_lookup(QAPIEvent_lookup, e)=
;
+        const char *event_name =3D qapi_enum_lookup(&QAPIEvent_lookup, e=
);
         assert(event_name !=3D NULL);
         info =3D g_malloc0(sizeof(*info));
         info->value =3D g_malloc0(sizeof(*info->value));
@@ -3250,9 +3250,9 @@ void netdev_add_completion(ReadLineState *rs, int n=
b_args, const char *str)
     }
     len =3D strlen(str);
     readline_set_completion_index(rs, len);
-    for (i =3D 0; qapi_enum_lookup(NetClientDriver_lookup, i); i++) {
+    for (i =3D 0; qapi_enum_lookup(&NetClientDriver_lookup, i); i++) {
         add_completion_option(rs, str,
-                              qapi_enum_lookup(NetClientDriver_lookup, i=
));
+                              qapi_enum_lookup(&NetClientDriver_lookup, =
i));
     }
 }
=20
@@ -3436,8 +3436,8 @@ void sendkey_completion(ReadLineState *rs, int nb_a=
rgs, const char *str)
     len =3D strlen(str);
     readline_set_completion_index(rs, len);
     for (i =3D 0; i < Q_KEY_CODE__MAX; i++) {
-        if (!strncmp(str, qapi_enum_lookup(QKeyCode_lookup, i), len)) {
-            readline_add_completion(rs, qapi_enum_lookup(QKeyCode_lookup=
, i));
+        if (!strncmp(str, qapi_enum_lookup(&QKeyCode_lookup, i), len)) {
+            readline_add_completion(rs, qapi_enum_lookup(&QKeyCode_looku=
p, i));
         }
     }
 }
@@ -3539,9 +3539,9 @@ void watchdog_action_completion(ReadLineState *rs, =
int nb_args, const char *str)
         return;
     }
     readline_set_completion_index(rs, strlen(str));
-    for (i =3D 0; qapi_enum_lookup(WatchdogExpirationAction_lookup, i); =
i++) {
+    for (i =3D 0; qapi_enum_lookup(&WatchdogExpirationAction_lookup, i);=
 i++) {
         add_completion_option(rs, str,
-            qapi_enum_lookup(WatchdogExpirationAction_lookup, i));
+            qapi_enum_lookup(&WatchdogExpirationAction_lookup, i));
     }
 }
=20
@@ -3555,7 +3555,7 @@ void migrate_set_capability_completion(ReadLineStat=
e *rs, int nb_args,
     if (nb_args =3D=3D 2) {
         int i;
         for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-            const char *name =3D qapi_enum_lookup(MigrationCapability_lo=
okup, i);
+            const char *name =3D qapi_enum_lookup(&MigrationCapability_l=
ookup, i);
             if (!strncmp(str, name, len)) {
                 readline_add_completion(rs, name);
             }
@@ -3576,7 +3576,7 @@ void migrate_set_parameter_completion(ReadLineState=
 *rs, int nb_args,
     if (nb_args =3D=3D 2) {
         int i;
         for (i =3D 0; i < MIGRATION_PARAMETER__MAX; i++) {
-            const char *name =3D qapi_enum_lookup(MigrationParameter_loo=
kup, i);
+            const char *name =3D qapi_enum_lookup(&MigrationParameter_lo=
okup, i);
             if (!strncmp(str, name, len)) {
                 readline_add_completion(rs, name);
             }
@@ -3855,7 +3855,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         qdict =3D qdict_get_qdict(qobject_to_qdict(rsp), "error");
         if (qdict
             && !g_strcmp0(qdict_get_try_str(qdict, "class"),
-                          qapi_enum_lookup(QapiErrorClass_lookup,
+                          qapi_enum_lookup(&QapiErrorClass_lookup,
                                            ERROR_CLASS_COMMAND_NOT_FOUND=
))) {
             /* Provide a more useful error message */
             qdict_del(qdict, "desc");
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
diff --git a/net/net.c b/net/net.c
index efe2252c59..f4b8739b0b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1065,7 +1065,7 @@ static int net_client_init1(const void *object, boo=
l is_netdev, Error **errp)
         /* FIXME drop when all init functions store an Error */
         if (errp && !*errp) {
             error_setg(errp, QERR_DEVICE_INIT_FAILED,
-                       qapi_enum_lookup(NetClientDriver_lookup, netdev->=
type));
+                       qapi_enum_lookup(&NetClientDriver_lookup, netdev-=
>type));
         }
         return -1;
     }
@@ -1289,7 +1289,7 @@ void print_net_client(Monitor *mon, NetClientState =
*nc)
=20
     monitor_printf(mon, "%s: index=3D%d,type=3D%s,%s\n", nc->name,
                    nc->queue_index,
-                   qapi_enum_lookup(NetClientDriver_lookup, nc->info->ty=
pe),
+                   qapi_enum_lookup(&NetClientDriver_lookup, nc->info->t=
ype),
                    nc->info_str);
     if (!QTAILQ_EMPTY(&nc->filters)) {
         monitor_printf(mon, "filters:\n");
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 7677caa51e..363214efb1 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -15,8 +15,8 @@
 #include "qemu-common.h"
 #include "qapi/util.h"
=20
-int qapi_enum_parse(const char * const lookup[], const char *buf,
-                    int max, int def, Error **errp)
+int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
+                    int def, Error **errp)
 {
     int i;
=20
@@ -24,8 +24,8 @@ int qapi_enum_parse(const char * const lookup[], const =
char *buf,
         return def;
     }
=20
-    for (i =3D 0; i < max; i++) {
-        if (!strcmp(buf, lookup[i])) {
+    for (i =3D 0; i < lookup->size; i++) {
+        if (!g_strcmp0(buf, lookup->array[i])) {
             return i;
         }
     }
@@ -34,11 +34,12 @@ int qapi_enum_parse(const char * const lookup[], cons=
t char *buf,
     return def;
 }
=20
-const char *qapi_enum_lookup(const char * const lookup[], int val)
+const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
 {
     assert(val >=3D 0);
+    assert(val < lookup->size);
=20
-    return lookup[val];
+    return lookup->array[val];
 }
=20
 /*
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 06f1470516..7f3302ad3c 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -119,7 +119,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
 QObject *qmp_build_error_object(Error *err)
 {
     return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                              qapi_enum_lookup(QapiErrorClass_lookup,
+                              qapi_enum_lookup(&QapiErrorClass_lookup,
                                                error_get_class(err)),
                               error_get_pretty(err));
 }
diff --git a/qemu-img.c b/qemu-img.c
index 56ef49e214..19f1996f90 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3490,10 +3490,8 @@ static int img_resize(int argc, char **argv)
             image_opts =3D true;
             break;
         case OPTION_PREALLOCATION:
-            prealloc =3D qapi_enum_parse(PreallocMode_lookup, optarg,
-                                       PREALLOC_MODE__MAX, PREALLOC_MODE=
__MAX,
-                                       NULL);
-            if (prealloc =3D=3D PREALLOC_MODE__MAX) {
+            prealloc =3D qapi_enum_parse(&PreallocMode_lookup, optarg, -=
1, NULL);
+            if (prealloc =3D=3D -1) {
                 error_report("Invalid preallocation mode '%s'", optarg);
                 return 1;
             }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 27164b8205..0dda0cce05 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -639,9 +639,8 @@ int main(int argc, char **argv)
             break;
         case QEMU_NBD_OPT_DETECT_ZEROES:
             detect_zeroes =3D
-                qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
+                qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
                                 optarg,
-                                BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                                 BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                                 &local_err);
             if (local_err) {
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
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index c51e6e734d..0ba8b55ce1 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -53,6 +53,11 @@ static const char *const dummy_animal_map[DUMMY_LAST +=
 1] =3D {
     [DUMMY_LAST] =3D NULL,
 };
=20
+const QEnumLookup dummy_animal_lookup =3D {
+    .array =3D dummy_animal_map,
+    .size =3D DUMMY_LAST
+};
+
 struct DummyObject {
     Object parent_obj;
=20
@@ -142,7 +147,7 @@ static void dummy_class_init(ObjectClass *cls, void *=
data)
                                   NULL);
     object_class_property_add_enum(cls, "av",
                                    "DummyAnimal",
-                                   dummy_animal_map,
+                                   &dummy_animal_lookup,
                                    dummy_get_av,
                                    dummy_set_av,
                                    NULL);
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index e8697577a5..fc9436ff94 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -20,24 +20,21 @@ static void test_qapi_enum_parse(void)
     Error *err =3D NULL;
     int ret;
=20
-    ret =3D qapi_enum_parse(QType_lookup, NULL, QTYPE__MAX, QTYPE_NONE,
-                          &error_abort);
+    ret =3D qapi_enum_parse(&QType_lookup, NULL, QTYPE_NONE, &error_abor=
t);
     g_assert_cmpint(ret, =3D=3D, QTYPE_NONE);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
-                          NULL);
+    ret =3D qapi_enum_parse(&QType_lookup, "junk", -1, NULL);
     g_assert_cmpint(ret, =3D=3D, -1);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
-                          &err);
+    ret =3D qapi_enum_parse(&QType_lookup, "junk", -1, &err);
     error_free_or_abort(&err);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "none", QTYPE__MAX, -1,
-                          &error_abort);
+    ret =3D qapi_enum_parse(&QType_lookup, "none", -1, &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE_NONE);
=20
-    ret =3D qapi_enum_parse(QType_lookup, QType_lookup[QTYPE__MAX - 1],
-                          QTYPE__MAX, QTYPE__MAX - 1,
+    ret =3D qapi_enum_parse(&QType_lookup,
+                          qapi_enum_lookup(&QType_lookup, QTYPE__MAX - 1=
),
+                          QTYPE__MAX - 1,
                           &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE__MAX - 1);
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index bdd00f6bd8..be7d7ea654 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -382,10 +382,10 @@ static void test_visitor_in_enum(TestInputVisitorDa=
ta *data,
     Visitor *v;
     EnumOne i;
=20
-    for (i =3D 0; EnumOne_lookup[i]; i++) {
+    for (i =3D 0; i < EnumOne_lookup.size; i++) {
         EnumOne res =3D -1;
=20
-        v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
+        v =3D visitor_input_test_init(data, "%s", EnumOne_lookup.array[i=
]);
=20
         visit_type_EnumOne(v, NULL, &res, &error_abort);
         g_assert_cmpint(i, =3D=3D, res);
@@ -699,7 +699,7 @@ static void test_native_list_integer_helper(TestInput=
VisitorData *data,
         }
     }
     g_string_append_printf(gstr_union,  "{ 'type': '%s', 'data': [ %s ] =
}",
-                           UserDefNativeListUnionKind_lookup[kind],
+                           UserDefNativeListUnionKind_lookup.array[kind]=
,
                            gstr_list->str);
     v =3D visitor_input_test_init_raw(data,  gstr_union->str);
=20
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
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index bb2d66b666..55a8c932e0 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -135,7 +135,7 @@ static void test_visitor_out_enum(TestOutputVisitorDa=
ta *data,
         qstr =3D qobject_to_qstring(visitor_get(data));
         g_assert(qstr);
         g_assert_cmpstr(qstring_get_str(qstr), =3D=3D,
-                        qapi_enum_lookup(EnumOne_lookup, i));
+                        qapi_enum_lookup(&EnumOne_lookup, i));
         visitor_reset(data);
     }
 }
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-=
visitor.c
index 79313a7f7a..5828359830 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -279,10 +279,10 @@ static void test_visitor_in_enum(TestInputVisitorDa=
ta *data,
     Visitor *v;
     EnumOne i;
=20
-    for (i =3D 0; EnumOne_lookup[i]; i++) {
+    for (i =3D 0; i < EnumOne_lookup.size; i++) {
         EnumOne res =3D -1;
=20
-        v =3D visitor_input_test_init(data, EnumOne_lookup[i]);
+        v =3D visitor_input_test_init(data, EnumOne_lookup.array[i]);
=20
         visit_type_EnumOne(v, NULL, &res, &err);
         g_assert(!err);
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
index 0b2087d312..a5d26ac0ca 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -196,12 +196,12 @@ static void test_visitor_out_enum(TestOutputVisitor=
Data *data,
         str =3D visitor_get(data);
         if (data->human) {
             char *str_human =3D
-                g_strdup_printf("\"%s\"", qapi_enum_lookup(EnumOne_looku=
p, i));
+                g_strdup_printf("\"%s\"", qapi_enum_lookup(&EnumOne_look=
up, i));
=20
             g_assert_cmpstr(str, =3D=3D, str_human);
             g_free(str_human);
         } else {
-            g_assert_cmpstr(str, =3D=3D, qapi_enum_lookup(EnumOne_lookup=
, i));
+            g_assert_cmpstr(str, =3D=3D, qapi_enum_lookup(&EnumOne_looku=
p, i));
         }
         visitor_reset(data);
     }
diff --git a/tpm.c b/tpm.c
index f175661bfe..3ddd889906 100644
--- a/tpm.c
+++ b/tpm.c
@@ -63,7 +63,7 @@ static bool tpm_model_is_registered(enum TpmModel model=
)
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type)
 {
-    int i =3D qapi_enum_parse(TpmType_lookup, type, TPM_TYPE__MAX, -1, N=
ULL);
+    int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
=20
     return i >=3D 0 ? be_drivers[i] : NULL;
 }
@@ -92,7 +92,7 @@ static void tpm_display_backend_drivers(void)
             continue;
         }
         fprintf(stderr, "%12s   %s\n",
-                qapi_enum_lookup(TpmType_lookup, i),
+                qapi_enum_lookup(&TpmType_lookup, i),
                 be_drivers[i]->desc());
     }
     fprintf(stderr, "\n");
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 7159747404..c597bdc711 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -61,9 +61,9 @@ int index_from_key(const char *key, size_t key_length)
 {
     int i;
=20
-    for (i =3D 0; QKeyCode_lookup[i] !=3D NULL; i++) {
-        if (!strncmp(key, QKeyCode_lookup[i], key_length) &&
-            !QKeyCode_lookup[i][key_length]) {
+    for (i =3D 0; QKeyCode_lookup.array[i] !=3D NULL; i++) {
+        if (!strncmp(key, QKeyCode_lookup.array[i], key_length) &&
+            !QKeyCode_lookup.array[i][key_length]) {
             break;
         }
     }
diff --git a/ui/input.c b/ui/input.c
index 6bceb6b825..dfae347154 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -152,7 +152,7 @@ void qmp_input_send_event(bool has_device, const char=
 *device,
         if (!qemu_input_find_handler(1 << event->type, con)) {
             error_setg(errp, "Input handler not found for "
                              "event type %s",
-                       qapi_enum_lookup(InputEventKind_lookup, event->ty=
pe));
+                       qapi_enum_lookup(&InputEventKind_lookup, event->t=
ype));
             return;
         }
     }
@@ -214,12 +214,12 @@ static void qemu_input_event_trace(QemuConsole *src=
, InputEvent *evt)
         switch (key->key->type) {
         case KEY_VALUE_KIND_NUMBER:
             qcode =3D qemu_input_key_number_to_qcode(key->key->u.number.=
data);
-            name =3D qapi_enum_lookup(QKeyCode_lookup, qcode);
+            name =3D qapi_enum_lookup(&QKeyCode_lookup, qcode);
             trace_input_event_key_number(idx, key->key->u.number.data,
                                          name, key->down);
             break;
         case KEY_VALUE_KIND_QCODE:
-            name =3D qapi_enum_lookup(QKeyCode_lookup, key->key->u.qcode=
.data);
+            name =3D qapi_enum_lookup(&QKeyCode_lookup, key->key->u.qcod=
e.data);
             trace_input_event_key_qcode(idx, name, key->down);
             break;
         case KEY_VALUE_KIND__MAX:
@@ -229,17 +229,17 @@ static void qemu_input_event_trace(QemuConsole *src=
, InputEvent *evt)
         break;
     case INPUT_EVENT_KIND_BTN:
         btn =3D evt->u.btn.data;
-        name =3D qapi_enum_lookup(InputButton_lookup, btn->button);
+        name =3D qapi_enum_lookup(&InputButton_lookup, btn->button);
         trace_input_event_btn(idx, name, btn->down);
         break;
     case INPUT_EVENT_KIND_REL:
         move =3D evt->u.rel.data;
-        name =3D qapi_enum_lookup(InputAxis_lookup, move->axis);
+        name =3D qapi_enum_lookup(&InputAxis_lookup, move->axis);
         trace_input_event_rel(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_ABS:
         move =3D evt->u.abs.data;
-        name =3D qapi_enum_lookup(InputAxis_lookup, move->axis);
+        name =3D qapi_enum_lookup(&InputAxis_lookup, move->axis);
         trace_input_event_abs(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND__MAX:
diff --git a/ui/vnc.c b/ui/vnc.c
index 20a45a7241..afe46dd8ae 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -132,7 +132,7 @@ static void vnc_init_basic_info(SocketAddress *addr,
     case SOCKET_ADDRESS_TYPE_VSOCK:
     case SOCKET_ADDRESS_TYPE_FD:
         error_setg(errp, "Unsupported socket address type %s",
-                   qapi_enum_lookup(SocketAddressType_lookup, addr->type=
));
+                   qapi_enum_lookup(&SocketAddressType_lookup, addr->typ=
e));
         break;
     default:
         abort();
@@ -417,7 +417,7 @@ VncInfo *qmp_query_vnc(Error **errp)
         case SOCKET_ADDRESS_TYPE_VSOCK:
         case SOCKET_ADDRESS_TYPE_FD:
             error_setg(errp, "Unsupported socket address type %s",
-                       qapi_enum_lookup(SocketAddressType_lookup, addr->=
type));
+                       qapi_enum_lookup(&SocketAddressType_lookup, addr-=
>type));
             goto out_error;
         default:
             abort();
@@ -1840,7 +1840,7 @@ static void vnc_release_modifiers(VncState *vs)
=20
 static const char *code2name(int keycode)
 {
-    return qapi_enum_lookup(QKeyCode_lookup,
+    return qapi_enum_lookup(&QKeyCode_lookup,
                             qemu_input_key_number_to_qcode(keycode));
 }
=20
diff --git a/vl.c b/vl.c
index def4f5f05f..adeb6ed479 100644
--- a/vl.c
+++ b/vl.c
@@ -689,7 +689,7 @@ bool runstate_check(RunState state)
=20
 bool runstate_store(char *str, size_t size)
 {
-    const char *state =3D qapi_enum_lookup(RunState_lookup, current_run_=
state);
+    const char *state =3D qapi_enum_lookup(&RunState_lookup, current_run=
_state);
     size_t len =3D strlen(state) + 1;
=20
     if (len > size) {
@@ -722,8 +722,8 @@ void runstate_set(RunState new_state)
=20
     if (!runstate_valid_transitions[current_run_state][new_state]) {
         error_report("invalid runstate transition: '%s' -> '%s'",
-                     qapi_enum_lookup(RunState_lookup, current_run_state=
),
-                     qapi_enum_lookup(RunState_lookup, new_state));
+                     qapi_enum_lookup(&RunState_lookup, current_run_stat=
e),
+                     qapi_enum_lookup(&RunState_lookup, new_state));
         abort();
     }
     trace_runstate_set(new_state);
--=20
2.14.1.146.gd35faa819
