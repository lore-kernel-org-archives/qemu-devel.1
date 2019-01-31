Received: from eggs.gnu.org ([209.51.188.92]:37705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0iW-0008UX-Cl
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0iS-0008PC-8h
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:29 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:38 +0100
Message-Id: <20190131005945.20149-7-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/13] block/sheepdog: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181213162727.17438-5-lvivier@redhat.com
[mreitz: Fixed sheepdog_snapshot_create_inode's format string to use
         PRIx32 for uint32_ts]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/sheepdog.c   | 47 +++++++++++++++++-----------------------------
 block/trace-events | 14 ++++++++++++++
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index ed14f7afbe..b916ba07bf 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -28,6 +28,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
+#include "trace.h"
=20
 #define SD_PROTO_VER 0x01
=20
@@ -299,19 +300,6 @@ static inline size_t count_data_objs(const struct Sh=
eepdogInode *inode)
                         (1UL << inode->block_size_shift));
 }
=20
-#undef DPRINTF
-#ifdef DEBUG_SDOG
-#define DEBUG_SDOG_PRINT 1
-#else
-#define DEBUG_SDOG_PRINT 0
-#endif
-#define DPRINTF(fmt, args...)                                           =
\
-    do {                                                                =
\
-        if (DEBUG_SDOG_PRINT) {                                         =
\
-            fprintf(stderr, "%s %d: " fmt, __func__, __LINE__, ##args); =
\
-        }                                                               =
\
-    } while (0)
-
 typedef struct SheepdogAIOCB SheepdogAIOCB;
 typedef struct BDRVSheepdogState BDRVSheepdogState;
=20
@@ -750,7 +738,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaq=
ue)
         Error *local_err =3D NULL;
         s->fd =3D get_sheep_fd(s, &local_err);
         if (s->fd < 0) {
-            DPRINTF("Wait for connection to be established\n");
+            trace_sheepdog_reconnect_to_sdog();
             error_report_err(local_err);
             qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000000ULL);
         }
@@ -847,7 +835,7 @@ static void coroutine_fn aio_read_response(void *opaq=
ue)
         break;
     case AIOCB_FLUSH_CACHE:
         if (rsp.result =3D=3D SD_RES_INVALID_PARMS) {
-            DPRINTF("disable cache since the server doesn't support it\n=
");
+            trace_sheepdog_aio_read_response();
             s->cache_flags =3D SD_FLAG_CMD_DIRECT;
             rsp.result =3D SD_RES_SUCCESS;
         }
@@ -1639,7 +1627,7 @@ static int sd_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     s->discard_supported =3D true;
=20
     if (snap_id || tag[0]) {
-        DPRINTF("%" PRIx32 " snapshot inode was open.\n", vid);
+        trace_sheepdog_open(vid);
         s->is_snapshot =3D true;
     }
=20
@@ -2252,7 +2240,7 @@ static void sd_close(BlockDriverState *bs)
     unsigned int wlen, rlen =3D 0;
     int fd, ret;
=20
-    DPRINTF("%s\n", s->name);
+    trace_sheepdog_close(s->name);
=20
     fd =3D connect_to_sdog(s, &local_err);
     if (fd < 0) {
@@ -2429,7 +2417,7 @@ static int sd_create_branch(BDRVSheepdogState *s)
     char *buf;
     bool deleted;
=20
-    DPRINTF("%" PRIx32 " is snapshot.\n", s->inode.vdi_id);
+    trace_sheepdog_create_branch_snapshot(s->inode.vdi_id);
=20
     buf =3D g_malloc(SD_INODE_SIZE);
=20
@@ -2445,7 +2433,7 @@ static int sd_create_branch(BDRVSheepdogState *s)
         goto out;
     }
=20
-    DPRINTF("%" PRIx32 " is created.\n", vid);
+    trace_sheepdog_create_branch_created(vid);
=20
     fd =3D connect_to_sdog(s, &local_err);
     if (fd < 0) {
@@ -2467,7 +2455,7 @@ static int sd_create_branch(BDRVSheepdogState *s)
=20
     s->is_snapshot =3D false;
     ret =3D 0;
-    DPRINTF("%" PRIx32 " was newly created.\n", s->inode.vdi_id);
+    trace_sheepdog_create_branch_new(s->inode.vdi_id);
=20
 out:
     g_free(buf);
@@ -2561,11 +2549,11 @@ static void coroutine_fn sd_co_rw_vector(Sheepdog=
AIOCB *acb)
         }
=20
         if (create) {
-            DPRINTF("update ino (%" PRIu32 ") %" PRIu64 " %" PRIu64 " %l=
d\n",
-                    inode->vdi_id, oid,
-                    vid_to_data_oid(inode->data_vdi_id[idx], idx), idx);
+            trace_sheepdog_co_rw_vector_update(inode->vdi_id, oid,
+                                  vid_to_data_oid(inode->data_vdi_id[idx=
], idx),
+                                  idx);
             oid =3D vid_to_data_oid(inode->vdi_id, idx);
-            DPRINTF("new oid %" PRIx64 "\n", oid);
+            trace_sheepdog_co_rw_vector_new(oid);
         }
=20
         aio_req =3D alloc_aio_req(s, acb, oid, len, offset, flags, creat=
e,
@@ -2670,9 +2658,8 @@ static int sd_snapshot_create(BlockDriverState *bs,=
 QEMUSnapshotInfo *sn_info)
     SheepdogInode *inode;
     unsigned int datalen;
=20
-    DPRINTF("sn_info: name %s id_str %s s: name %s vm_state_size %" PRId=
64 " "
-            "is_snapshot %d\n", sn_info->name, sn_info->id_str,
-            s->name, sn_info->vm_state_size, s->is_snapshot);
+    trace_sheepdog_snapshot_create_info(sn_info->name, sn_info->id_str, =
s->name,
+                                        sn_info->vm_state_size, s->is_sn=
apshot);
=20
     if (s->is_snapshot) {
         error_report("You can't create a snapshot of a snapshot VDI, "
@@ -2681,7 +2668,7 @@ static int sd_snapshot_create(BlockDriverState *bs,=
 QEMUSnapshotInfo *sn_info)
         return -EINVAL;
     }
=20
-    DPRINTF("%s %s\n", sn_info->name, sn_info->id_str);
+    trace_sheepdog_snapshot_create(sn_info->name, sn_info->id_str);
=20
     s->inode.vm_state_size =3D sn_info->vm_state_size;
     s->inode.vm_clock_nsec =3D sn_info->vm_clock_nsec;
@@ -2726,8 +2713,8 @@ static int sd_snapshot_create(BlockDriverState *bs,=
 QEMUSnapshotInfo *sn_info)
     }
=20
     memcpy(&s->inode, inode, datalen);
-    DPRINTF("s->inode: name %s snap_id %x oid %x\n",
-            s->inode.name, s->inode.snap_id, s->inode.vdi_id);
+    trace_sheepdog_snapshot_create_inode(s->inode.name, s->inode.snap_id=
,
+                                         s->inode.vdi_id);
=20
 cleanup:
     g_free(inode);
diff --git a/block/trace-events b/block/trace-events
index 41b998b7eb..70056eafd2 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -193,3 +193,17 @@ file_xfs_discard(const char *error) "cannot punch ho=
le (%s)"
 file_FindEjectableOpticalMedia(const char *media) "Matching using %s"
 file_setup_cdrom(const char *partition) "Using %s as optical disc"
 file_hdev_is_sg(int type, int version) "SG device found: type=3D%d, vers=
ion=3D%d"
+
+# block/sheepdog.c
+sheepdog_reconnect_to_sdog(void) "Wait for connection to be established"
+sheepdog_aio_read_response(void) "disable cache since the server doesn't=
 support it"
+sheepdog_open(uint32_t vid) "0x%" PRIx32 " snapshot inode was open"
+sheepdog_close(const char *name) "%s"
+sheepdog_create_branch_snapshot(uint32_t vdi) "0x%" PRIx32 " is snapshot=
"
+sheepdog_create_branch_created(uint32_t vdi) "0x%" PRIx32 " is created"
+sheepdog_create_branch_new(uint32_t vdi) "0x%" PRIx32 " was newly create=
d"
+sheepdog_co_rw_vector_update(uint32_t vdi, uint64_t oid, uint64_t data, =
long idx) "update ino (%" PRIu32 ") %" PRIu64 " %" PRIu64 " %ld"
+sheepdog_co_rw_vector_new(uint64_t oid) "new oid 0x%" PRIx64
+sheepdog_snapshot_create_info(const char *sn_name, const char *id, const=
 char *name, int64_t size, int is_snapshot) "sn_info: name %s id_str %s s=
: name %s vm_state_size %" PRId64 " " "is_snapshot %d"
+sheepdog_snapshot_create(const char *sn_name, const char *id) "%s %s"
+sheepdog_snapshot_create_inode(const char *name, uint32_t snap, uint32_t=
 vdi) "s->inode: name %s snap_id 0x%" PRIx32 " vdi 0x%" PRIx32
--=20
2.20.1
