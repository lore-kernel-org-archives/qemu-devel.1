Received: from eggs.gnu.org ([2001:4830:134:3::10]:55367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jb-0008GX-Ey
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JW-00079C-7q
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:07 +0200
Message-Id: <20170822132255.23945-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/54] qapi: introduce qapi_enum_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Stefan Hajnoczi <stefanha@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

This will help with the introduction of a new structure to handle
enum lookup.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/util.h                 |  2 +
 backends/hostmem.c                  |  3 +-
 block/backup.c                      |  3 +-
 block/file-posix.c                  |  5 ++-
 block/file-win32.c                  |  2 +-
 block/gluster.c                     |  4 +-
 block/iscsi.c                       |  3 +-
 block/nfs.c                         |  3 +-
 block/qcow2.c                       |  5 ++-
 block/qed.c                         |  3 +-
 block/rbd.c                         |  3 +-
 block/sheepdog.c                    |  3 +-
 blockdev.c                          |  6 ++-
 blockjob.c                          |  9 +++--
 chardev/char.c                      |  7 +++-
 crypto/block-luks.c                 | 17 ++++++---
 crypto/block.c                      |  5 ++-
 crypto/cipher-afalg.c               |  2 +-
 crypto/cipher-builtin.c             |  8 ++--
 crypto/cipher-gcrypt.c              |  4 +-
 crypto/cipher-nettle.c              |  8 ++--
 crypto/cipher.c                     |  1 +
 crypto/hmac-gcrypt.c                |  2 +-
 crypto/hmac-glib.c                  |  3 +-
 crypto/hmac-nettle.c                |  3 +-
 crypto/pbkdf-gcrypt.c               |  3 +-
 crypto/pbkdf-nettle.c               |  4 +-
 hmp.c                               | 74 +++++++++++++++++++++++--------=
------
 hw/block/fdc.c                      |  9 +++--
 hw/char/escc.c                      |  3 +-
 hw/core/qdev-properties.c           |  9 +++--
 hw/input/virtio-input-hid.c         |  5 ++-
 migration/colo-failover.c           |  6 ++-
 migration/colo.c                    | 17 +++++----
 migration/global_state.c            |  2 +-
 monitor.c                           | 24 +++++++-----
 net/net.c                           |  5 ++-
 qapi/qapi-util.c                    |  7 ++++
 qapi/qmp-dispatch.c                 |  4 +-
 tests/test-qobject-output-visitor.c |  4 +-
 tests/test-string-output-visitor.c  |  6 ++-
 tpm.c                               |  4 +-
 ui/input.c                          | 13 ++++---
 ui/vnc.c                            |  8 ++--
 vl.c                                |  7 ++--
 45 files changed, 206 insertions(+), 122 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 7436ed815c..60733b6a80 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,6 +11,8 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H
=20
+const char *qapi_enum_lookup(const char * const lookup[], int val);
+
 int qapi_enum_parse(const char * const lookup[], const char *buf,
                     int max, int def, Error **errp);
=20
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4606b73849..c4f795475c 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -13,6 +13,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qapi/visitor.h"
 #include "qapi-types.h"
 #include "qapi-visit.h"
@@ -304,7 +305,7 @@ host_memory_backend_memory_complete(UserCreatable *uc=
, Error **errp)
             return;
         } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_DEFAULT=
) {
             error_setg(errp, "host-nodes must be set for policy %s",
-                       HostMemPolicy_lookup[backend->policy]);
+                qapi_enum_lookup(HostMemPolicy_lookup, backend->policy))=
;
             return;
         }
=20
diff --git a/block/backup.c b/block/backup.c
index 504a089150..a700cc0315 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -19,6 +19,7 @@
 #include "block/blockjob_int.h"
 #include "block/block_backup.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ratelimit.h"
 #include "qemu/cutils.h"
@@ -596,7 +597,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         error_setg(errp,
                    "a sync_bitmap was provided to backup_run, "
                    "but received an incompatible sync_mode (%s)",
-                   MirrorSyncMode_lookup[sync_mode]);
+                   qapi_enum_lookup(MirrorSyncMode_lookup, sync_mode));
         return NULL;
     }
=20
diff --git a/block/file-posix.c b/block/file-posix.c
index cb3bfce147..48200aef0b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1725,7 +1725,7 @@ static int raw_regular_truncate(int fd, int64_t off=
set, PreallocMode prealloc,
     default:
         result =3D -ENOTSUP;
         error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return result;
     }
=20
@@ -1760,7 +1760,8 @@ static int raw_truncate(BlockDriverState *bs, int64=
_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Preallocation mode '%s' unsupported for this "
-                   "non-regular file", PreallocMode_lookup[prealloc]);
+                   "non-regular file", qapi_enum_lookup(PreallocMode_loo=
kup,
+                                                        prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/file-win32.c b/block/file-win32.c
index 4706335cff..2f3975f040 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -470,7 +470,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t=
 offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(reallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/gluster.c b/block/gluster.c
index 3064a45047..934f459014 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1050,7 +1050,7 @@ static int qemu_gluster_create(const char *filename=
,
     default:
         ret =3D -EINVAL;
         error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         break;
     }
=20
@@ -1102,7 +1102,7 @@ static int qemu_gluster_truncate(BlockDriverState *=
bs, int64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/iscsi.c b/block/iscsi.c
index d557c99668..5c1870340b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -39,6 +39,7 @@
 #include "qemu/uuid.h"
 #include "qmp-commands.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/util.h"
 #include "crypto/secret.h"
=20
 #include <iscsi/iscsi.h>
@@ -2087,7 +2088,7 @@ static int iscsi_truncate(BlockDriverState *bs, int=
64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/nfs.c b/block/nfs.c
index bec16b72a6..953728ae31 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -40,6 +40,7 @@
 #include "qapi-visit.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
+#include "qapi/util.h"
 #include <nfsc/libnfs.h>
=20
=20
@@ -772,7 +773,7 @@ static int nfs_file_truncate(BlockDriverState *bs, in=
t64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 40ba26c111..45b0579caa 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2732,7 +2732,8 @@ static int qcow2_create2(const char *filename, int6=
4_t total_size,
         int64_t prealloc_size =3D
             qcow2_calc_prealloc_size(total_size, cluster_size, refcount_=
order);
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_=
abort);
-        qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_lookup[preal=
loc],
+        qemu_opt_set(opts, BLOCK_OPT_PREALLOC,
+                     qapi_enum_lookup(PreallocMode_lookup, prealloc),
                      &error_abort);
     }
=20
@@ -3098,7 +3099,7 @@ static int qcow2_truncate(BlockDriverState *bs, int=
64_t offset,
         prealloc !=3D PREALLOC_MODE_FALLOC && prealloc !=3D PREALLOC_MOD=
E_FULL)
     {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/qed.c b/block/qed.c
index dc54bf4a93..756fcb85a7 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -19,6 +19,7 @@
 #include "trace.h"
 #include "qed.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/util.h"
 #include "sysemu/block-backend.h"
=20
 static int bdrv_qed_probe(const uint8_t *buf, int buf_size,
@@ -1399,7 +1400,7 @@ static int bdrv_qed_truncate(BlockDriverState *bs, =
int64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/rbd.c b/block/rbd.c
index 9c3aa638e7..09f8d18d1b 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -21,6 +21,7 @@
 #include "qemu/cutils.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/util.h"
=20
 /*
  * When specifying the image filename use:
@@ -944,7 +945,7 @@ static int qemu_rbd_truncate(BlockDriverState *bs, in=
t64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/sheepdog.c b/block/sheepdog.c
index abb2e79065..69d49fb720 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
+#include "qapi/util.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -2176,7 +2177,7 @@ static int sd_truncate(BlockDriverState *bs, int64_=
t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   qapi_enum_lookup(PreallocMode_lookup, prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/blockdev.c b/blockdev.c
index 02cd69bc21..6a067e81bf 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1468,8 +1468,10 @@ static int action_check_completion_mode(BlkActionS=
tate *s, Error **errp)
         error_setg(errp,
                    "Action '%s' does not support Transaction property "
                    "completion-mode =3D %s",
-                   TransactionActionKind_lookup[s->action->type],
-                   ActionCompletionMode_lookup[s->txn_props->completion_=
mode]);
+                   qapi_enum_lookup(TransactionActionKind_lookup,
+                                    s->action->type),
+                   qapi_enum_lookup(ActionCompletionMode_lookup,
+                                    s->txn_props->completion_mode));
         return -1;
     }
     return 0;
diff --git a/blockjob.c b/blockjob.c
index 70a78188b7..fca71123e0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -31,6 +31,7 @@
 #include "sysemu/block-backend.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/util.h"
 #include "qemu/coroutine.h"
 #include "qemu/id.h"
 #include "qmp-commands.h"
@@ -208,7 +209,8 @@ static char *child_job_get_parent_desc(BdrvChild *c)
 {
     BlockJob *job =3D c->opaque;
     return g_strdup_printf("%s job '%s'",
-                           BlockJobType_lookup[job->driver->job_type],
+                           qapi_enum_lookup(BlockJobType_lookup,
+                                            job->driver->job_type),
                            job->id);
 }
=20
@@ -553,7 +555,8 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **=
errp)
         return NULL;
     }
     info =3D g_new0(BlockJobInfo, 1);
-    info->type      =3D g_strdup(BlockJobType_lookup[job->driver->job_ty=
pe]);
+    info->type      =3D g_strdup(qapi_enum_lookup(BlockJobType_lookup,
+                                                job->driver->job_type));
     info->device    =3D g_strdup(job->id);
     info->len       =3D job->len;
     info->busy      =3D job->busy;
@@ -666,7 +669,7 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
     job->refcnt        =3D 1;
=20
     error_setg(&job->blocker, "block device is in use by block job: %s",
-               BlockJobType_lookup[driver->job_type]);
+               qapi_enum_lookup(BlockJobType_lookup, driver->job_type));
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abo=
rt);
     bs->job =3D job;
=20
diff --git a/chardev/char.c b/chardev/char.c
index 5d283b90d3..4408d12a08 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -30,6 +30,7 @@
 #include "chardev/char.h"
 #include "qmp-commands.h"
 #include "qapi-visit.h"
+#include "qapi/util.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
=20
@@ -931,7 +932,8 @@ ChardevReturn *qmp_chardev_add(const char *id, Charde=
vBackend *backend,
     ChardevReturn *ret;
     Chardev *chr;
=20
-    cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], errp=
);
+    cc =3D char_get_class(qapi_enum_lookup(ChardevBackendKind_lookup,
+                                         backend->type), errp);
     if (!cc) {
         return NULL;
     }
@@ -989,7 +991,8 @@ ChardevReturn *qmp_chardev_change(const char *id, Cha=
rdevBackend *backend,
         return NULL;
     }
=20
-    cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], errp=
);
+    cc =3D char_get_class(qapi_enum_lookup(ChardevBackendKind_lookup,
+                                         backend->type), errp);
     if (!cc) {
         return NULL;
     }
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index afb8543108..b78a6345f3 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu/bswap.h"
=20
 #include "crypto/block-luks.h"
@@ -257,7 +258,7 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherAlg=
orithm alg,
     }
=20
     error_setg(errp, "Algorithm '%s' not supported",
-               QCryptoCipherAlgorithm_lookup[alg]);
+               qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg));
     return NULL;
 }
=20
@@ -398,7 +399,7 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorith=
m cipher,
         break;
     default:
         error_setg(errp, "Cipher %s not supported with essiv",
-                   QCryptoCipherAlgorithm_lookup[cipher]);
+                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, ciphe=
r));
         return 0;
     }
 }
@@ -968,16 +969,20 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
=20
-    cipher_mode =3D QCryptoCipherMode_lookup[luks_opts.cipher_mode];
-    ivgen_alg =3D QCryptoIVGenAlgorithm_lookup[luks_opts.ivgen_alg];
+    cipher_mode =3D qapi_enum_lookup(QCryptoCipherMode_lookup,
+                                   luks_opts.cipher_mode);
+    ivgen_alg =3D qapi_enum_lookup(QCryptoIVGenAlgorithm_lookup,
+                                 luks_opts.ivgen_alg);
     if (luks_opts.has_ivgen_hash_alg) {
-        ivgen_hash_alg =3D QCryptoHashAlgorithm_lookup[luks_opts.ivgen_h=
ash_alg];
+        ivgen_hash_alg =3D qapi_enum_lookup(QCryptoHashAlgorithm_lookup,
+                                          luks_opts.ivgen_hash_alg);
         cipher_mode_spec =3D g_strdup_printf("%s-%s:%s", cipher_mode, iv=
gen_alg,
                                            ivgen_hash_alg);
     } else {
         cipher_mode_spec =3D g_strdup_printf("%s-%s", cipher_mode, ivgen=
_alg);
     }
-    hash_alg =3D QCryptoHashAlgorithm_lookup[luks_opts.hash_alg];
+    hash_alg =3D qapi_enum_lookup(QCryptoHashAlgorithm_lookup,
+                                luks_opts.hash_alg);
=20
=20
     if (strlen(cipher_alg) >=3D QCRYPTO_BLOCK_LUKS_CIPHER_NAME_LEN) {
diff --git a/crypto/block.c b/crypto/block.c
index b097d451af..2140e55426 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "crypto/blockpriv.h"
 #include "crypto/block-qcow.h"
 #include "crypto/block-luks.h"
@@ -61,7 +62,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOption=
s *options,
     if (options->format >=3D G_N_ELEMENTS(qcrypto_block_drivers) ||
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
-                   QCryptoBlockFormat_lookup[options->format]);
+            qapi_enum_lookup(QCryptoBlockFormat_lookup, options->format)=
);
         g_free(block);
         return NULL;
     }
@@ -92,7 +93,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOp=
tions *options,
     if (options->format >=3D G_N_ELEMENTS(qcrypto_block_drivers) ||
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
-                   QCryptoBlockFormat_lookup[options->format]);
+            qapi_enum_lookup(QCryptoBlockFormat_lookup, options->format)=
);
         g_free(block);
         return NULL;
     }
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index 01343b2b7c..24d7ba8277 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -52,7 +52,7 @@ qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm=
 alg,
         return NULL;
     }
=20
-    mode_name =3D QCryptoCipherMode_lookup[mode];
+    mode_name =3D qapi_enum_lookup(QCryptoCipherMode_lookup, mode);
     name =3D g_strdup_printf("%s(%s)", mode_name, alg_name);
=20
     return name;
diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index 16a36d4532..76c76fb05b 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -247,7 +247,7 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
         mode !=3D QCRYPTO_CIPHER_MODE_ECB &&
         mode !=3D QCRYPTO_CIPHER_MODE_XTS) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -379,7 +379,7 @@ qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
=20
     if (mode !=3D QCRYPTO_CIPHER_MODE_ECB) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -440,7 +440,7 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(Q=
CryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -460,7 +460,7 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(Q=
CryptoCipherAlgorithm alg,
     default:
         error_setg(errp,
                    "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgorithm_lookup[alg]);
+                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg))=
;
         return NULL;
     }
=20
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 0489147398..09210195a4 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -105,7 +105,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -160,7 +160,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
=20
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgorithm_lookup[alg]);
+                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg))=
;
         return NULL;
     }
=20
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index c51f119cbc..7c02b3e7a2 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -281,7 +281,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   qapi_enum_lookup(QCryptoCipherMode_lookup, mode));
         return NULL;
     }
=20
@@ -420,7 +420,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
=20
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgorithm_lookup[alg]);
+                   qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg))=
;
         goto error;
     }
=20
@@ -491,7 +491,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
=20
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[cipher->mode]);
+                   qapi_enum_lookup(QCryptoCipherMode_lookup, cipher->mo=
de));
         return -1;
     }
     return 0;
@@ -537,7 +537,7 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
=20
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[cipher->mode]);
+                   qapi_enum_lookup(QCryptoCipherMode_lookup, cipher->mo=
de));
         return -1;
     }
     return 0;
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 0aad9d6d79..43291cba7e 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "crypto/cipher.h"
 #include "cipherpriv.h"
+#include "qapi/util.h"
=20
=20
 static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] =3D {
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 76ca61ba24..0784795269 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -52,7 +52,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   QCryptoHashAlgorithm_lookup[alg]);
+                   qapi_enum_lookup(QCryptoHashAlgorithm_lookup, alg));
         return NULL;
     }
=20
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 8cf6b221ed..56b71dbf85 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "crypto/hmac.h"
 #include "hmacpriv.h"
=20
@@ -58,7 +59,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   QCryptoHashAlgorithm_lookup[alg]);
+                   qapi_enum_lookup(QCryptoHashAlgorithm_lookup, alg));
         return NULL;
     }
=20
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 1d5a915f03..be43511252 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "crypto/hmac.h"
 #include "hmacpriv.h"
 #include <nettle/hmac.h>
@@ -106,7 +107,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   QCryptoHashAlgorithm_lookup[alg]);
+                   qapi_enum_lookup(QCryptoHashAlgorithm_lookup, alg));
         return NULL;
     }
=20
diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index 40289858bf..a815138c46 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -22,6 +22,7 @@
 #include <gcrypt.h>
 #include "qapi/error.h"
 #include "crypto/pbkdf.h"
+#include "qapi/util.h"
=20
 bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
 {
@@ -68,7 +69,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
         hash_map[hash] =3D=3D GCRY_MD_NONE) {
         error_setg_errno(errp, ENOSYS,
                          "PBKDF does not support hash algorithm %s",
-                         QCryptoHashAlgorithm_lookup[hash]);
+                         qapi_enum_lookup(QCryptoHashAlgorithm_lookup, h=
ash));
         return -1;
     }
=20
diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
index 6fb2671656..84977fdd69 100644
--- a/crypto/pbkdf-nettle.c
+++ b/crypto/pbkdf-nettle.c
@@ -23,7 +23,7 @@
 #include <nettle/hmac.h>
 #include "qapi/error.h"
 #include "crypto/pbkdf.h"
-
+#include "qapi/util.h"
=20
 bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
 {
@@ -110,7 +110,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
     default:
         error_setg_errno(errp, ENOSYS,
                          "PBKDF does not support hash algorithm %s",
-                         QCryptoHashAlgorithm_lookup[hash]);
+                         qapi_enum_lookup(QCryptoHashAlgorithm_lookup, h=
ash));
         return -1;
     }
     return 0;
diff --git a/hmp.c b/hmp.c
index fd80dce758..29e42ab661 100644
--- a/hmp.c
+++ b/hmp.c
@@ -107,7 +107,8 @@ void hmp_info_status(Monitor *mon, const QDict *qdict=
)
                    info->singlestep ? " (single step mode)" : "");
=20
     if (!info->running && info->status !=3D RUN_STATE_PAUSED) {
-        monitor_printf(mon, " (%s)", RunState_lookup[info->status]);
+        monitor_printf(mon, " (%s)",
+                       qapi_enum_lookup(RunState_lookup, info->status));
     }
=20
     monitor_printf(mon, "\n");
@@ -172,7 +173,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
         monitor_printf(mon, "capabilities: ");
         for (cap =3D caps; cap; cap =3D cap->next) {
             monitor_printf(mon, "%s: %s ",
-                           MigrationCapability_lookup[cap->value->capabi=
lity],
+                           qapi_enum_lookup(MigrationCapability_lookup,
+                                            cap->value->capability),
                            cap->value->state ? "on" : "off");
         }
         monitor_printf(mon, "\n");
@@ -180,7 +182,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
=20
     if (info->has_status) {
         monitor_printf(mon, "Migration status: %s",
-                       MigrationStatus_lookup[info->status]);
+                       qapi_enum_lookup(MigrationStatus_lookup, info->st=
atus));
         if (info->status =3D=3D MIGRATION_STATUS_FAILED &&
             info->has_error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
@@ -278,7 +280,8 @@ void hmp_info_migrate_capabilities(Monitor *mon, cons=
t QDict *qdict)
     if (caps) {
         for (cap =3D caps; cap; cap =3D cap->next) {
             monitor_printf(mon, "%s: %s\n",
-                           MigrationCapability_lookup[cap->value->capabi=
lity],
+                           qapi_enum_lookup(MigrationCapability_lookup,
+                                            cap->value->capability),
                            cap->value->state ? "on" : "off");
         }
     }
@@ -295,48 +298,59 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
     if (params) {
         assert(params->has_compress_level);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_LEVEL=
],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_COMPRESS_LEVEL),
             params->compress_level);
         assert(params->has_compress_threads);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_THREA=
DS],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_COMPRESS_THREADS),
             params->compress_threads);
         assert(params->has_decompress_threads);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_DECOMPRESS_THR=
EADS],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_DECOMPRESS_THREADS),
             params->decompress_threads);
         assert(params->has_cpu_throttle_initial);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_I=
NITIAL],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
             params->cpu_throttle_initial);
         assert(params->has_cpu_throttle_increment);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_I=
NCREMENT],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT)=
,
             params->cpu_throttle_increment);
         assert(params->has_tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_CREDS],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_TLS_CREDS),
             params->tls_creds);
         assert(params->has_tls_hostname);
         monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_HOSTNAME],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_TLS_HOSTNAME),
             params->tls_hostname);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_MAX_BANDWIDTH]=
,
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
         assert(params->has_downtime_limit);
         monitor_printf(mon, "%s: %" PRId64 " milliseconds\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_DOWNTIME_LIMIT=
],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_DOWNTIME_LIMIT),
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_D=
ELAY],
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
         assert(params->has_block_incremental);
         monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_BLOCK_INCREMEN=
TAL],
-                       params->block_incremental ? "on" : "off");
+            qapi_enum_lookup(MigrationParameter_lookup,
+                             MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
+            params->block_incremental ? "on" : "off");
     }
=20
     qapi_free_MigrationParameters(params);
@@ -432,7 +446,7 @@ static void print_block_info(Monitor *mon, BlockInfo =
*info,
         }
         if (info->has_io_status && info->io_status !=3D BLOCK_DEVICE_IO_=
STATUS_OK) {
             monitor_printf(mon, "    I/O status:       %s\n",
-                           BlockDeviceIoStatus_lookup[info->io_status]);
+                qapi_enum_lookup(BlockDeviceIoStatus_lookup, info->io_st=
atus));
         }
=20
         if (info->removable) {
@@ -462,7 +476,8 @@ static void print_block_info(Monitor *mon, BlockInfo =
*info,
=20
     if (inserted->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF)=
 {
         monitor_printf(mon, "    Detect zeroes:    %s\n",
-                       BlockdevDetectZeroesOptions_lookup[inserted->dete=
ct_zeroes]);
+            qapi_enum_lookup(BlockdevDetectZeroesOptions_lookup,
+                             inserted->detect_zeroes));
     }
=20
     if (inserted->bps  || inserted->bps_rd  || inserted->bps_wr  ||
@@ -613,7 +628,7 @@ static void hmp_info_VncBasicInfo(Monitor *mon, VncBa=
sicInfo *info,
                    name,
                    info->host,
                    info->service,
-                   NetworkAddressFamily_lookup[info->family],
+                   qapi_enum_lookup(NetworkAddressFamily_lookup, info->f=
amily),
                    info->websocket ? " (Websocket)" : "");
 }
=20
@@ -623,8 +638,9 @@ static void hmp_info_vnc_authcrypt(Monitor *mon, cons=
t char *indent,
                                    VncVencryptSubAuth *vencrypt)
 {
     monitor_printf(mon, "%sAuth: %s (Sub: %s)\n", indent,
-                   VncPrimaryAuth_lookup[auth],
-                   vencrypt ? VncVencryptSubAuth_lookup[*vencrypt] : "no=
ne");
+        qapi_enum_lookup(VncPrimaryAuth_lookup, auth),
+        vencrypt ? qapi_enum_lookup(VncVencryptSubAuth_lookup, *vencrypt=
)
+                   : "none");
 }
=20
 static void hmp_info_vnc_clients(Monitor *mon, VncClientInfoList *client=
)
@@ -739,7 +755,7 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "        auth: %s\n", info->auth);
     monitor_printf(mon, "    compiled: %s\n", info->compiled_version);
     monitor_printf(mon, "  mouse-mode: %s\n",
-                   SpiceQueryMouseMode_lookup[info->mouse_mode]);
+        qapi_enum_lookup(SpiceQueryMouseMode_lookup, info->mouse_mode));
=20
     if (!info->has_channels || info->channels =3D=3D NULL) {
         monitor_printf(mon, "Channels: none\n");
@@ -1010,10 +1026,11 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdic=
t)
     for (info =3D info_list; info; info =3D info->next) {
         TPMInfo *ti =3D info->value;
         monitor_printf(mon, " tpm%d: model=3D%s\n",
-                       c, TpmModel_lookup[ti->model]);
+                       c, qapi_enum_lookup(TpmModel_lookup, ti->model));
=20
         monitor_printf(mon, "  \\ %s: type=3D%s",
-                       ti->id, TpmTypeOptionsKind_lookup[ti->options->ty=
pe]);
+                       ti->id, qapi_enum_lookup(TpmTypeOptionsKind_looku=
p,
+                                                ti->options->type));
=20
         switch (ti->options->type) {
         case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
@@ -2374,7 +2391,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdi=
ct)
         monitor_printf(mon, "  prealloc: %s\n",
                        m->value->prealloc ? "true" : "false");
         monitor_printf(mon, "  policy: %s\n",
-                       HostMemPolicy_lookup[m->value->policy]);
+            qapi_enum_lookup(HostMemPolicy_lookup, m->value->policy));
         visit_complete(v, &str);
         monitor_printf(mon, "  host nodes: %s\n", str);
=20
@@ -2405,8 +2422,8 @@ void hmp_info_memory_devices(Monitor *mon, const QD=
ict *qdict)
                 di =3D value->u.dimm.data;
=20
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
-                               MemoryDeviceInfoKind_lookup[value->type],
-                               di->id ? di->id : "");
+                    qapi_enum_lookup(MemoryDeviceInfoKind_lookup, value-=
>type),
+                    di->id ? di->id : "");
                 monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", di->addr)=
;
                 monitor_printf(mon, "  slot: %" PRId64 "\n", di->slot);
                 monitor_printf(mon, "  node: %" PRId64 "\n", di->node);
@@ -2799,7 +2816,8 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict=
)
     DumpQueryResult *result =3D qmp_query_dump(NULL);
=20
     assert(result && result->status < DUMP_STATUS__MAX);
-    monitor_printf(mon, "Status: %s\n", DumpStatus_lookup[result->status=
]);
+    monitor_printf(mon, "Status: %s\n",
+                   qapi_enum_lookup(DumpStatus_lookup, result->status));
=20
     if (result->status =3D=3D DUMP_STATUS_ACTIVE) {
         float percent =3D 0;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 401129073b..8ebe08d1af 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -31,6 +31,7 @@
 #include "hw/hw.h"
 #include "hw/block/fdc.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "hw/isa/isa.h"
@@ -392,9 +393,11 @@ static int pick_geometry(FDrive *drv)
             FLOPPY_DPRINTF("User requested floppy drive type '%s', "
                            "but inserted medium appears to be a "
                            "%"PRId64" sector '%s' type\n",
-                           FloppyDriveType_lookup[drv->drive],
+                           qapi_enum_lookup(FloppyDriveType_lookup,
+                                            drv->drive),
                            nb_sectors,
-                           FloppyDriveType_lookup[parse->drive]);
+                           qapi_enum_lookup(FloppyDriveType_lookup,
+                                            parse->drive));
         }
         match =3D type_match;
     }
@@ -403,7 +406,7 @@ static int pick_geometry(FDrive *drv)
     if (match =3D=3D -1) {
         error_setg(&error_abort, "No candidate geometries present in tab=
le "
                    " for floppy drive type '%s'",
-                   FloppyDriveType_lookup[drv->drive]);
+                   qapi_enum_lookup(FloppyDriveType_lookup, drv->drive))=
;
     }
=20
     parse =3D &(fd_formats[match]);
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 1aca564e33..5c1d7b0e29 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -31,6 +31,7 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "trace.h"
+#include "qapi/util.h"
=20
 /*
  * Chipset docs:
@@ -848,7 +849,7 @@ static void sunkbd_handle_event(DeviceState *dev, Qem=
uConsole *src,
     assert(evt->type =3D=3D INPUT_EVENT_KIND_KEY);
     key =3D evt->u.key.data;
     qcode =3D qemu_input_key_value_to_qcode(key->key);
-    trace_escc_sunkbd_event_in(qcode, QKeyCode_lookup[qcode],
+    trace_escc_sunkbd_event_in(qcode, qapi_enum_lookup(QKeyCode_lookup, =
qcode),
                                key->down);
=20
     if (qcode =3D=3D Q_KEY_CODE_CAPS_LOCK) {
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 078fc5d239..c82c693bca 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,6 +2,7 @@
 #include "net/net.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "hw/pci/pci.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
@@ -72,8 +73,9 @@ static void set_enum(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
=20
 static void set_default_value_enum(Object *obj, const Property *prop)
 {
-    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
-                            prop->name, &error_abort);
+    object_property_set_str(obj,
+        qapi_enum_lookup(prop->info->enum_table, prop->defval.i),
+        prop->name, &error_abort);
 }
=20
 /* Bit */
@@ -1095,7 +1097,8 @@ void qdev_prop_set_enum(DeviceState *dev, const cha=
r *name, int value)
     Property *prop;
=20
     prop =3D qdev_prop_find(dev, name);
-    object_property_set_str(OBJECT(dev), prop->info->enum_table[value],
+    object_property_set_str(OBJECT(dev),
+                            qapi_enum_lookup(prop->info->enum_table, val=
ue),
                             name, &error_abort);
 }
=20
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 46c038110c..64039236f1 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -15,6 +15,7 @@
 #include "ui/console.h"
=20
 #include "standard-headers/linux/input.h"
+#include "qapi/util.h"
=20
 #define VIRTIO_ID_NAME_KEYBOARD "QEMU Virtio Keyboard"
 #define VIRTIO_ID_NAME_MOUSE    "QEMU Virtio Mouse"
@@ -209,7 +210,7 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,
         } else {
             if (key->down) {
                 fprintf(stderr, "%s: unmapped key: %d [%s]\n", __func__,
-                        qcode, QKeyCode_lookup[qcode]);
+                        qcode, qapi_enum_lookup(QKeyCode_lookup, qcode))=
;
             }
         }
         break;
@@ -224,7 +225,7 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,
             if (btn->down) {
                 fprintf(stderr, "%s: unmapped button: %d [%s]\n", __func=
__,
                         btn->button,
-                        InputButton_lookup[btn->button]);
+                        qapi_enum_lookup(InputButton_lookup, btn->button=
));
             }
         }
         break;
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index f9914869c5..e5394ba631 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -17,6 +17,7 @@
 #include "migration.h"
 #include "qmp-commands.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/util.h"
 #include "qemu/error-report.h"
 #include "trace.h"
=20
@@ -34,7 +35,7 @@ static void colo_failover_bh(void *opaque)
                                    FAILOVER_STATUS_ACTIVE);
     if (old_state !=3D FAILOVER_STATUS_REQUIRE) {
         error_report("Unknown error for failover, old_state =3D %s",
-                    FailoverStatus_lookup[old_state]);
+                     qapi_enum_lookup(FailoverStatus_lookup, old_state))=
;
         return;
     }
=20
@@ -64,7 +65,8 @@ FailoverStatus failover_set_state(FailoverStatus old_st=
ate,
=20
     old =3D atomic_cmpxchg(&failover_state, old_state, new_state);
     if (old =3D=3D old_state) {
-        trace_colo_failover_set_state(FailoverStatus_lookup[new_state]);
+        trace_colo_failover_set_state(qapi_enum_lookup(FailoverStatus_lo=
okup,
+                                                       new_state));
     }
     return old;
 }
diff --git a/migration/colo.c b/migration/colo.c
index a4255432ac..2b683a0afc 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -24,6 +24,7 @@
 #include "migration/failover.h"
 #include "replication.h"
 #include "qmp-commands.h"
+#include "qapi/util.h"
=20
 static bool vmstate_loading;
=20
@@ -61,7 +62,8 @@ static void secondary_vm_do_failover(void)
                         FAILOVER_STATUS_RELAUNCH);
         if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
             error_report("Unknown error while do failover for secondary =
VM,"
-                         "old_state: %s", FailoverStatus_lookup[old_stat=
e]);
+                         "old_state: %s",
+                         qapi_enum_lookup(FailoverStatus_lookup, old_sta=
te));
         }
         return;
     }
@@ -91,7 +93,8 @@ static void secondary_vm_do_failover(void)
                                    FAILOVER_STATUS_COMPLETED);
     if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
         error_report("Incorrect state (%s) while doing failover for "
-                     "secondary VM", FailoverStatus_lookup[old_state]);
+                     "secondary VM",
+                     qapi_enum_lookup(FailoverStatus_lookup, old_state))=
;
         return;
     }
     /* Notify COLO incoming thread that failover work is finished */
@@ -126,7 +129,7 @@ static void primary_vm_do_failover(void)
                                    FAILOVER_STATUS_COMPLETED);
     if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
         error_report("Incorrect state (%s) while doing failover for Prim=
ary VM",
-                     FailoverStatus_lookup[old_state]);
+                     qapi_enum_lookup(FailoverStatus_lookup, old_state))=
;
         return;
     }
     /* Notify COLO thread that failover work is finished */
@@ -222,7 +225,7 @@ static void colo_send_message(QEMUFile *f, COLOMessag=
e msg,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Can't send COLO message");
     }
-    trace_colo_send_message(COLOMessage_lookup[msg]);
+    trace_colo_send_message(qapi_enum_lookup(COLOMessage_lookup, msg));
 }
=20
 static void colo_send_message_value(QEMUFile *f, COLOMessage msg,
@@ -242,7 +245,7 @@ static void colo_send_message_value(QEMUFile *f, COLO=
Message msg,
     ret =3D qemu_file_get_error(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to send value for message:%=
s",
-                         COLOMessage_lookup[msg]);
+                         qapi_enum_lookup(COLOMessage_lookup, msg));
     }
 }
=20
@@ -261,7 +264,7 @@ static COLOMessage colo_receive_message(QEMUFile *f, =
Error **errp)
         error_setg(errp, "%s: Invalid message", __func__);
         return msg;
     }
-    trace_colo_receive_message(COLOMessage_lookup[msg]);
+    trace_colo_receive_message(qapi_enum_lookup(COLOMessage_lookup, msg)=
);
     return msg;
 }
=20
@@ -299,7 +302,7 @@ static uint64_t colo_receive_message_value(QEMUFile *=
f, uint32_t expect_msg,
     ret =3D qemu_file_get_error(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to get value for COLO messa=
ge: %s",
-                         COLOMessage_lookup[expect_msg]);
+                         qapi_enum_lookup(COLOMessage_lookup, expect_msg=
));
     }
     return value;
 }
diff --git a/migration/global_state.c b/migration/global_state.c
index dcbbcb28be..4d57a9c5f2 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -42,7 +42,7 @@ int global_state_store(void)
=20
 void global_state_store_running(void)
 {
-    const char *state =3D RunState_lookup[RUN_STATE_RUNNING];
+    const char *state =3D qapi_enum_lookup(RunState_lookup, RUN_STATE_RU=
NNING);
     strncpy((char *)global_state.runstate,
            state, sizeof(global_state.runstate));
 }
diff --git a/monitor.c b/monitor.c
index 14c27d4b6f..ee2fdfd4f1 100644
--- a/monitor.c
+++ b/monitor.c
@@ -78,6 +78,7 @@
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "qapi/qmp/dispatch.h"
+#include "qapi/util.h"
=20
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
@@ -928,7 +929,7 @@ EventInfoList *qmp_query_events(Error **errp)
     QAPIEvent e;
=20
     for (e =3D 0 ; e < QAPI_EVENT__MAX ; e++) {
-        const char *event_name =3D QAPIEvent_lookup[e];
+        const char *event_name =3D qapi_enum_lookup(QAPIEvent_lookup, e)=
;
         assert(event_name !=3D NULL);
         info =3D g_malloc0(sizeof(*info));
         info->value =3D g_malloc0(sizeof(*info->value));
@@ -3249,8 +3250,9 @@ void netdev_add_completion(ReadLineState *rs, int n=
b_args, const char *str)
     }
     len =3D strlen(str);
     readline_set_completion_index(rs, len);
-    for (i =3D 0; NetClientDriver_lookup[i]; i++) {
-        add_completion_option(rs, str, NetClientDriver_lookup[i]);
+    for (i =3D 0; qapi_enum_lookup(NetClientDriver_lookup, i); i++) {
+        add_completion_option(rs, str,
+                              qapi_enum_lookup(NetClientDriver_lookup, i=
));
     }
 }
=20
@@ -3434,8 +3436,8 @@ void sendkey_completion(ReadLineState *rs, int nb_a=
rgs, const char *str)
     len =3D strlen(str);
     readline_set_completion_index(rs, len);
     for (i =3D 0; i < Q_KEY_CODE__MAX; i++) {
-        if (!strncmp(str, QKeyCode_lookup[i], len)) {
-            readline_add_completion(rs, QKeyCode_lookup[i]);
+        if (!strncmp(str, qapi_enum_lookup(QKeyCode_lookup, i), len)) {
+            readline_add_completion(rs, qapi_enum_lookup(QKeyCode_lookup=
, i));
         }
     }
 }
@@ -3537,8 +3539,9 @@ void watchdog_action_completion(ReadLineState *rs, =
int nb_args, const char *str)
         return;
     }
     readline_set_completion_index(rs, strlen(str));
-    for (i =3D 0; WatchdogExpirationAction_lookup[i]; i++) {
-        add_completion_option(rs, str, WatchdogExpirationAction_lookup[i=
]);
+    for (i =3D 0; qapi_enum_lookup(WatchdogExpirationAction_lookup, i); =
i++) {
+        add_completion_option(rs, str,
+            qapi_enum_lookup(WatchdogExpirationAction_lookup, i));
     }
 }
=20
@@ -3552,7 +3555,7 @@ void migrate_set_capability_completion(ReadLineStat=
e *rs, int nb_args,
     if (nb_args =3D=3D 2) {
         int i;
         for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-            const char *name =3D MigrationCapability_lookup[i];
+            const char *name =3D qapi_enum_lookup(MigrationCapability_lo=
okup, i);
             if (!strncmp(str, name, len)) {
                 readline_add_completion(rs, name);
             }
@@ -3573,7 +3576,7 @@ void migrate_set_parameter_completion(ReadLineState=
 *rs, int nb_args,
     if (nb_args =3D=3D 2) {
         int i;
         for (i =3D 0; i < MIGRATION_PARAMETER__MAX; i++) {
-            const char *name =3D MigrationParameter_lookup[i];
+            const char *name =3D qapi_enum_lookup(MigrationParameter_loo=
kup, i);
             if (!strncmp(str, name, len)) {
                 readline_add_completion(rs, name);
             }
@@ -3852,7 +3855,8 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         qdict =3D qdict_get_qdict(qobject_to_qdict(rsp), "error");
         if (qdict
             && !g_strcmp0(qdict_get_try_str(qdict, "class"),
-                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND]=
)) {
+                          qapi_enum_lookup(QapiErrorClass_lookup,
+                                           ERROR_CLASS_COMMAND_NOT_FOUND=
))) {
             /* Provide a more useful error message */
             qdict_del(qdict, "desc");
             qdict_put_str(qdict, "desc", "Expecting capabilities negotia=
tion"
diff --git a/net/net.c b/net/net.c
index 0e28099554..efe2252c59 100644
--- a/net/net.c
+++ b/net/net.c
@@ -48,6 +48,7 @@
 #include "sysemu/qtest.h"
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
+#include "qapi/util.h"
=20
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -1064,7 +1065,7 @@ static int net_client_init1(const void *object, boo=
l is_netdev, Error **errp)
         /* FIXME drop when all init functions store an Error */
         if (errp && !*errp) {
             error_setg(errp, QERR_DEVICE_INIT_FAILED,
-                       NetClientDriver_lookup[netdev->type]);
+                       qapi_enum_lookup(NetClientDriver_lookup, netdev->=
type));
         }
         return -1;
     }
@@ -1288,7 +1289,7 @@ void print_net_client(Monitor *mon, NetClientState =
*nc)
=20
     monitor_printf(mon, "%s: index=3D%d,type=3D%s,%s\n", nc->name,
                    nc->queue_index,
-                   NetClientDriver_lookup[nc->info->type],
+                   qapi_enum_lookup(NetClientDriver_lookup, nc->info->ty=
pe),
                    nc->info_str);
     if (!QTAILQ_EMPTY(&nc->filters)) {
         monitor_printf(mon, "filters:\n");
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 46eda7d196..7677caa51e 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -34,6 +34,13 @@ int qapi_enum_parse(const char * const lookup[], const=
 char *buf,
     return def;
 }
=20
+const char *qapi_enum_lookup(const char * const lookup[], int val)
+{
+    assert(val >=3D 0);
+
+    return lookup[val];
+}
+
 /*
  * Parse a valid QAPI name from @str.
  * A valid name consists of letters, digits, hyphen and underscore.
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5ad36f8a09..06f1470516 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi-types.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/util.h"
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
 {
@@ -118,7 +119,8 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
 QObject *qmp_build_error_object(Error *err)
 {
     return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                              QapiErrorClass_lookup[error_get_class(err)=
],
+                              qapi_enum_lookup(QapiErrorClass_lookup,
+                                               error_get_class(err)),
                               error_get_pretty(err));
 }
=20
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 7eb162059c..bb2d66b666 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -19,6 +19,7 @@
 #include "test-qapi-visit.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/util.h"
=20
 typedef struct TestOutputVisitorData {
     Visitor *ov;
@@ -133,7 +134,8 @@ static void test_visitor_out_enum(TestOutputVisitorDa=
ta *data,
=20
         qstr =3D qobject_to_qstring(visitor_get(data));
         g_assert(qstr);
-        g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, EnumOne_lookup[i]=
);
+        g_assert_cmpstr(qstring_get_str(qstr), =3D=3D,
+                        qapi_enum_lookup(EnumOne_lookup, i));
         visitor_reset(data);
     }
 }
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
index e736db3af8..0b2087d312 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -14,6 +14,7 @@
=20
 #include "qemu-common.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qapi/string-output-visitor.h"
 #include "test-qapi-types.h"
 #include "test-qapi-visit.h"
@@ -194,12 +195,13 @@ static void test_visitor_out_enum(TestOutputVisitor=
Data *data,
=20
         str =3D visitor_get(data);
         if (data->human) {
-            char *str_human =3D g_strdup_printf("\"%s\"", EnumOne_lookup=
[i]);
+            char *str_human =3D
+                g_strdup_printf("\"%s\"", qapi_enum_lookup(EnumOne_looku=
p, i));
=20
             g_assert_cmpstr(str, =3D=3D, str_human);
             g_free(str_human);
         } else {
-            g_assert_cmpstr(str, =3D=3D, EnumOne_lookup[i]);
+            g_assert_cmpstr(str, =3D=3D, qapi_enum_lookup(EnumOne_lookup=
, i));
         }
         visitor_reset(data);
     }
diff --git a/tpm.c b/tpm.c
index 9a7c7114d3..c3b731b3f2 100644
--- a/tpm.c
+++ b/tpm.c
@@ -19,6 +19,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
+#include "qapi/util.h"
=20
 static QLIST_HEAD(, TPMBackend) tpm_backends =3D
     QLIST_HEAD_INITIALIZER(tpm_backends);
@@ -102,7 +103,8 @@ static void tpm_display_backend_drivers(void)
=20
     for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
         fprintf(stderr, "%12s   %s\n",
-                TpmType_lookup[be_drivers[i]->type], be_drivers[i]->desc=
());
+                qapi_enum_lookup(TpmType_lookup, be_drivers[i]->type),
+                be_drivers[i]->desc());
     }
     fprintf(stderr, "\n");
 }
diff --git a/ui/input.c b/ui/input.c
index af05f06368..6bceb6b825 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -7,6 +7,7 @@
 #include "ui/input.h"
 #include "ui/console.h"
 #include "sysemu/replay.h"
+#include "qapi/util.h"
=20
 struct QemuInputHandlerState {
     DeviceState       *dev;
@@ -151,7 +152,7 @@ void qmp_input_send_event(bool has_device, const char=
 *device,
         if (!qemu_input_find_handler(1 << event->type, con)) {
             error_setg(errp, "Input handler not found for "
                              "event type %s",
-                            InputEventKind_lookup[event->type]);
+                       qapi_enum_lookup(InputEventKind_lookup, event->ty=
pe));
             return;
         }
     }
@@ -213,12 +214,12 @@ static void qemu_input_event_trace(QemuConsole *src=
, InputEvent *evt)
         switch (key->key->type) {
         case KEY_VALUE_KIND_NUMBER:
             qcode =3D qemu_input_key_number_to_qcode(key->key->u.number.=
data);
-            name =3D QKeyCode_lookup[qcode];
+            name =3D qapi_enum_lookup(QKeyCode_lookup, qcode);
             trace_input_event_key_number(idx, key->key->u.number.data,
                                          name, key->down);
             break;
         case KEY_VALUE_KIND_QCODE:
-            name =3D QKeyCode_lookup[key->key->u.qcode.data];
+            name =3D qapi_enum_lookup(QKeyCode_lookup, key->key->u.qcode=
.data);
             trace_input_event_key_qcode(idx, name, key->down);
             break;
         case KEY_VALUE_KIND__MAX:
@@ -228,17 +229,17 @@ static void qemu_input_event_trace(QemuConsole *src=
, InputEvent *evt)
         break;
     case INPUT_EVENT_KIND_BTN:
         btn =3D evt->u.btn.data;
-        name =3D InputButton_lookup[btn->button];
+        name =3D qapi_enum_lookup(InputButton_lookup, btn->button);
         trace_input_event_btn(idx, name, btn->down);
         break;
     case INPUT_EVENT_KIND_REL:
         move =3D evt->u.rel.data;
-        name =3D InputAxis_lookup[move->axis];
+        name =3D qapi_enum_lookup(InputAxis_lookup, move->axis);
         trace_input_event_rel(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_ABS:
         move =3D evt->u.abs.data;
-        name =3D InputAxis_lookup[move->axis];
+        name =3D qapi_enum_lookup(InputAxis_lookup, move->axis);
         trace_input_event_abs(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND__MAX:
diff --git a/ui/vnc.c b/ui/vnc.c
index 651cbb8606..20a45a7241 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -36,6 +36,7 @@
 #include "qemu/config-file.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/types.h"
+#include "qapi/util.h"
 #include "qmp-commands.h"
 #include "ui/input.h"
 #include "qapi-event.h"
@@ -131,7 +132,7 @@ static void vnc_init_basic_info(SocketAddress *addr,
     case SOCKET_ADDRESS_TYPE_VSOCK:
     case SOCKET_ADDRESS_TYPE_FD:
         error_setg(errp, "Unsupported socket address type %s",
-                   SocketAddressType_lookup[addr->type]);
+                   qapi_enum_lookup(SocketAddressType_lookup, addr->type=
));
         break;
     default:
         abort();
@@ -416,7 +417,7 @@ VncInfo *qmp_query_vnc(Error **errp)
         case SOCKET_ADDRESS_TYPE_VSOCK:
         case SOCKET_ADDRESS_TYPE_FD:
             error_setg(errp, "Unsupported socket address type %s",
-                       SocketAddressType_lookup[addr->type]);
+                       qapi_enum_lookup(SocketAddressType_lookup, addr->=
type));
             goto out_error;
         default:
             abort();
@@ -1839,7 +1840,8 @@ static void vnc_release_modifiers(VncState *vs)
=20
 static const char *code2name(int keycode)
 {
-    return QKeyCode_lookup[qemu_input_key_number_to_qcode(keycode)];
+    return qapi_enum_lookup(QKeyCode_lookup,
+                            qemu_input_key_number_to_qcode(keycode));
 }
=20
 static void key_event(VncState *vs, int down, uint32_t sym)
diff --git a/vl.c b/vl.c
index 8e247cc2a2..def4f5f05f 100644
--- a/vl.c
+++ b/vl.c
@@ -99,6 +99,7 @@ int main(int argc, char **argv)
 #include "sysemu/hax.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "qapi/util.h"
 #include "qapi-visit.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
@@ -688,7 +689,7 @@ bool runstate_check(RunState state)
=20
 bool runstate_store(char *str, size_t size)
 {
-    const char *state =3D RunState_lookup[current_run_state];
+    const char *state =3D qapi_enum_lookup(RunState_lookup, current_run_=
state);
     size_t len =3D strlen(state) + 1;
=20
     if (len > size) {
@@ -721,8 +722,8 @@ void runstate_set(RunState new_state)
=20
     if (!runstate_valid_transitions[current_run_state][new_state]) {
         error_report("invalid runstate transition: '%s' -> '%s'",
-                     RunState_lookup[current_run_state],
-                     RunState_lookup[new_state]);
+                     qapi_enum_lookup(RunState_lookup, current_run_state=
),
+                     qapi_enum_lookup(RunState_lookup, new_state));
         abort();
     }
     trace_runstate_set(new_state);
--=20
2.14.1.146.gd35faa819
