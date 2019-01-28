Received: from eggs.gnu.org ([209.51.188.92]:59989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1goAsX-0001py-HY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1goAsQ-00033z-Gl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:23 -0500
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Date: Mon, 28 Jan 2019 20:39:01 +0300
Message-Id: <20190128173901.3357-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block: split block/qapi.c to avoid linking
 utilities with qapi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>

Only part of block/qapi.c is used by qemu-io qemu-nbd and qemu-img
and its not realy about QAPI, so move it to separate file to reduce
amount of unused code linked to utilities and avoid unnecessary
dependencies.

Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
---
 block.c                               |   2 +-
 block/Makefile.objs                   |   3 +-
 block/bdrv_info.c                     | 582 ++++++++++++++++++++++++++
 block/qapi.c                          | 553 +-----------------------
 hmp.c                                 |   2 +-
 include/block/{qapi.h =3D> bdrv_info.h} |   6 +-
 monitor.c                             |   2 +-
 qemu-img.c                            |   2 +-
 qemu-io-cmds.c                        |   2 +-
 9 files changed, 593 insertions(+), 561 deletions(-)
 create mode 100644 block/bdrv_info.c
 rename include/block/{qapi.h =3D> bdrv_info.h} (97%)

diff --git a/block.c b/block.c
index 4f5ff2cc12..a14d64c2fd 100644
--- a/block.c
+++ b/block.c
@@ -43,7 +43,7 @@
 #include "qemu/notify.h"
 #include "qemu/option.h"
 #include "qemu/coroutine.h"
-#include "block/qapi.h"
+#include "block/bdrv_info.h"
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892a52..aab92d59ec 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -14,7 +14,7 @@ block-obj-y +=3D quorum.o
 block-obj-y +=3D blkdebug.o blkverify.o blkreplay.o
 block-obj-$(CONFIG_PARALLELS) +=3D parallels.o
 block-obj-y +=3D blklogwrites.o
-block-obj-y +=3D block-backend.o snapshot.o qapi.o
+block-obj-y +=3D block-backend.o snapshot.o bdrv_info.o
 block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
 block-obj-$(CONFIG_POSIX) +=3D file-posix.o
 block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
@@ -41,6 +41,7 @@ block-obj-y +=3D throttle.o copy-on-read.o
 block-obj-y +=3D crypto.o
=20
 common-obj-y +=3D stream.o
+common-obj-y +=3D qapi.o
=20
 nfs.o-libs         :=3D $(LIBNFS_LIBS)
 iscsi.o-cflags     :=3D $(LIBISCSI_CFLAGS)
diff --git a/block/bdrv_info.c b/block/bdrv_info.c
new file mode 100644
index 0000000000..425045421b
--- /dev/null
+++ b/block/bdrv_info.c
@@ -0,0 +1,582 @@
+/*
+ * Block layer qmp and info dump related functions
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/bdrv_info.h"
+#include "block/block_int.h"
+#include "block/write-threshold.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-block-core.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
+#include "sysemu/block-backend.h"
+#include "qemu/cutils.h"
+
+BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
+                                        BlockDriverState *bs, Error **er=
rp)
+{
+    ImageInfo **p_image_info;
+    BlockDriverState *bs0;
+    BlockDeviceInfo *info;
+
+    if (!bs->drv) {
+        error_setg(errp, "Block device %s is ejected", bs->node_name);
+        return NULL;
+    }
+
+    info =3D g_malloc0(sizeof(*info));
+    info->file                   =3D g_strdup(bs->filename);
+    info->ro                     =3D bs->read_only;
+    info->drv                    =3D g_strdup(bs->drv->format_name);
+    info->encrypted              =3D bs->encrypted;
+    info->encryption_key_missing =3D false;
+
+    info->cache =3D g_new(BlockdevCacheInfo, 1);
+    *info->cache =3D (BlockdevCacheInfo) {
+        .writeback      =3D blk ? blk_enable_write_cache(blk) : true,
+        .direct         =3D !!(bs->open_flags & BDRV_O_NOCACHE),
+        .no_flush       =3D !!(bs->open_flags & BDRV_O_NO_FLUSH),
+    };
+
+    if (bs->node_name[0]) {
+        info->has_node_name =3D true;
+        info->node_name =3D g_strdup(bs->node_name);
+    }
+
+    if (bs->backing_file[0]) {
+        info->has_backing_file =3D true;
+        info->backing_file =3D g_strdup(bs->backing_file);
+    }
+
+    info->detect_zeroes =3D bs->detect_zeroes;
+
+    if (blk && blk_get_public(blk)->throttle_group_member.throttle_state=
) {
+        ThrottleConfig cfg;
+        BlockBackendPublic *blkp =3D blk_get_public(blk);
+
+        throttle_group_get_config(&blkp->throttle_group_member, &cfg);
+
+        info->bps     =3D cfg.buckets[THROTTLE_BPS_TOTAL].avg;
+        info->bps_rd  =3D cfg.buckets[THROTTLE_BPS_READ].avg;
+        info->bps_wr  =3D cfg.buckets[THROTTLE_BPS_WRITE].avg;
+
+        info->iops    =3D cfg.buckets[THROTTLE_OPS_TOTAL].avg;
+        info->iops_rd =3D cfg.buckets[THROTTLE_OPS_READ].avg;
+        info->iops_wr =3D cfg.buckets[THROTTLE_OPS_WRITE].avg;
+
+        info->has_bps_max     =3D cfg.buckets[THROTTLE_BPS_TOTAL].max;
+        info->bps_max         =3D cfg.buckets[THROTTLE_BPS_TOTAL].max;
+        info->has_bps_rd_max  =3D cfg.buckets[THROTTLE_BPS_READ].max;
+        info->bps_rd_max      =3D cfg.buckets[THROTTLE_BPS_READ].max;
+        info->has_bps_wr_max  =3D cfg.buckets[THROTTLE_BPS_WRITE].max;
+        info->bps_wr_max      =3D cfg.buckets[THROTTLE_BPS_WRITE].max;
+
+        info->has_iops_max    =3D cfg.buckets[THROTTLE_OPS_TOTAL].max;
+        info->iops_max        =3D cfg.buckets[THROTTLE_OPS_TOTAL].max;
+        info->has_iops_rd_max =3D cfg.buckets[THROTTLE_OPS_READ].max;
+        info->iops_rd_max     =3D cfg.buckets[THROTTLE_OPS_READ].max;
+        info->has_iops_wr_max =3D cfg.buckets[THROTTLE_OPS_WRITE].max;
+        info->iops_wr_max     =3D cfg.buckets[THROTTLE_OPS_WRITE].max;
+
+        info->has_bps_max_length     =3D info->has_bps_max;
+        info->bps_max_length         =3D
+            cfg.buckets[THROTTLE_BPS_TOTAL].burst_length;
+        info->has_bps_rd_max_length  =3D info->has_bps_rd_max;
+        info->bps_rd_max_length      =3D
+            cfg.buckets[THROTTLE_BPS_READ].burst_length;
+        info->has_bps_wr_max_length  =3D info->has_bps_wr_max;
+        info->bps_wr_max_length      =3D
+            cfg.buckets[THROTTLE_BPS_WRITE].burst_length;
+
+        info->has_iops_max_length    =3D info->has_iops_max;
+        info->iops_max_length        =3D
+            cfg.buckets[THROTTLE_OPS_TOTAL].burst_length;
+        info->has_iops_rd_max_length =3D info->has_iops_rd_max;
+        info->iops_rd_max_length     =3D
+            cfg.buckets[THROTTLE_OPS_READ].burst_length;
+        info->has_iops_wr_max_length =3D info->has_iops_wr_max;
+        info->iops_wr_max_length     =3D
+            cfg.buckets[THROTTLE_OPS_WRITE].burst_length;
+
+        info->has_iops_size =3D cfg.op_size;
+        info->iops_size =3D cfg.op_size;
+
+        info->has_group =3D true;
+        info->group =3D
+            g_strdup(throttle_group_get_name(&blkp->throttle_group_membe=
r));
+    }
+
+    info->write_threshold =3D bdrv_write_threshold_get(bs);
+
+    bs0 =3D bs;
+    p_image_info =3D &info->image;
+    info->backing_file_depth =3D 0;
+    while (1) {
+        Error *local_err =3D NULL;
+        bdrv_query_image_info(bs0, p_image_info, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            qapi_free_BlockDeviceInfo(info);
+            return NULL;
+        }
+
+        if (bs0->drv && bs0->backing) {
+            info->backing_file_depth++;
+            bs0 =3D bs0->backing->bs;
+            (*p_image_info)->has_backing_image =3D true;
+            p_image_info =3D &((*p_image_info)->backing_image);
+        } else {
+            break;
+        }
+
+        /* Skip automatically inserted nodes that the user isn't aware o=
f for
+         * query-block (blk !=3D NULL), but not for query-named-block-no=
des */
+        while (blk && bs0->drv && bs0->implicit) {
+            bs0 =3D backing_bs(bs0);
+            assert(bs0);
+        }
+    }
+
+    return info;
+}
+
+/*
+ * Returns 0 on success, with *p_list either set to describe snapshot
+ * information, or NULL because there are no snapshots.  Returns -errno =
on
+ * error, with *p_list untouched.
+ */
+int bdrv_query_snapshot_info_list(BlockDriverState *bs,
+                                  SnapshotInfoList **p_list,
+                                  Error **errp)
+{
+    int i, sn_count;
+    QEMUSnapshotInfo *sn_tab =3D NULL;
+    SnapshotInfoList *info_list, *cur_item =3D NULL, *head =3D NULL;
+    SnapshotInfo *info;
+
+    sn_count =3D bdrv_snapshot_list(bs, &sn_tab);
+    if (sn_count < 0) {
+        const char *dev =3D bdrv_get_device_name(bs);
+        switch (sn_count) {
+        case -ENOMEDIUM:
+            error_setg(errp, "Device '%s' is not inserted", dev);
+            break;
+        case -ENOTSUP:
+            error_setg(errp,
+                       "Device '%s' does not support internal snapshots"=
,
+                       dev);
+            break;
+        default:
+            error_setg_errno(errp, -sn_count,
+                             "Can't list snapshots of device '%s'", dev)=
;
+            break;
+        }
+        return sn_count;
+    }
+
+    for (i =3D 0; i < sn_count; i++) {
+        info =3D g_new0(SnapshotInfo, 1);
+        info->id            =3D g_strdup(sn_tab[i].id_str);
+        info->name          =3D g_strdup(sn_tab[i].name);
+        info->vm_state_size =3D sn_tab[i].vm_state_size;
+        info->date_sec      =3D sn_tab[i].date_sec;
+        info->date_nsec     =3D sn_tab[i].date_nsec;
+        info->vm_clock_sec  =3D sn_tab[i].vm_clock_nsec / 1000000000;
+        info->vm_clock_nsec =3D sn_tab[i].vm_clock_nsec % 1000000000;
+
+        info_list =3D g_new0(SnapshotInfoList, 1);
+        info_list->value =3D info;
+
+        /* XXX: waiting for the qapi to support qemu-queue.h types */
+        if (!cur_item) {
+            head =3D cur_item =3D info_list;
+        } else {
+            cur_item->next =3D info_list;
+            cur_item =3D info_list;
+        }
+
+    }
+
+    g_free(sn_tab);
+    *p_list =3D head;
+    return 0;
+}
+
+/**
+ * bdrv_query_image_info:
+ * @bs: block device to examine
+ * @p_info: location to store image information
+ * @errp: location to store error information
+ *
+ * Store "flat" image information in @p_info.
+ *
+ * "Flat" means it does *not* query backing image information,
+ * i.e. (*pinfo)->has_backing_image will be set to false and
+ * (*pinfo)->backing_image to NULL even when the image does in fact have
+ * a backing image.
+ *
+ * @p_info will be set only on success. On error, store error in @errp.
+ */
+void bdrv_query_image_info(BlockDriverState *bs,
+                           ImageInfo **p_info,
+                           Error **errp)
+{
+    int64_t size;
+    const char *backing_filename;
+    BlockDriverInfo bdi;
+    int ret;
+    Error *err =3D NULL;
+    ImageInfo *info;
+
+    aio_context_acquire(bdrv_get_aio_context(bs));
+
+    size =3D bdrv_getlength(bs);
+    if (size < 0) {
+        error_setg_errno(errp, -size, "Can't get image size '%s'",
+                         bs->exact_filename);
+        goto out;
+    }
+
+    info =3D g_new0(ImageInfo, 1);
+    info->filename        =3D g_strdup(bs->filename);
+    info->format          =3D g_strdup(bdrv_get_format_name(bs));
+    info->virtual_size    =3D size;
+    info->actual_size     =3D bdrv_get_allocated_file_size(bs);
+    info->has_actual_size =3D info->actual_size >=3D 0;
+    if (bdrv_is_encrypted(bs)) {
+        info->encrypted =3D true;
+        info->has_encrypted =3D true;
+    }
+    if (bdrv_get_info(bs, &bdi) >=3D 0) {
+        if (bdi.cluster_size !=3D 0) {
+            info->cluster_size =3D bdi.cluster_size;
+            info->has_cluster_size =3D true;
+        }
+        info->dirty_flag =3D bdi.is_dirty;
+        info->has_dirty_flag =3D true;
+    }
+    info->format_specific     =3D bdrv_get_specific_info(bs);
+    info->has_format_specific =3D info->format_specific !=3D NULL;
+
+    backing_filename =3D bs->backing_file;
+    if (backing_filename[0] !=3D '\0') {
+        char *backing_filename2 =3D g_malloc0(PATH_MAX);
+        info->backing_filename =3D g_strdup(backing_filename);
+        info->has_backing_filename =3D true;
+        bdrv_get_full_backing_filename(bs, backing_filename2, PATH_MAX, =
&err);
+        if (err) {
+            /* Can't reconstruct the full backing filename, so we must o=
mit
+             * this field and apply a Best Effort to this query. */
+            g_free(backing_filename2);
+            backing_filename2 =3D NULL;
+            error_free(err);
+            err =3D NULL;
+        }
+
+        /* Always report the full_backing_filename if present, even if i=
t's the
+         * same as backing_filename. That they are same is useful info. =
*/
+        if (backing_filename2) {
+            info->full_backing_filename =3D g_strdup(backing_filename2);
+            info->has_full_backing_filename =3D true;
+        }
+
+        if (bs->backing_format[0]) {
+            info->backing_filename_format =3D g_strdup(bs->backing_forma=
t);
+            info->has_backing_filename_format =3D true;
+        }
+        g_free(backing_filename2);
+    }
+
+    ret =3D bdrv_query_snapshot_info_list(bs, &info->snapshots, &err);
+    switch (ret) {
+    case 0:
+        if (info->snapshots) {
+            info->has_snapshots =3D true;
+        }
+        break;
+    /* recoverable error */
+    case -ENOMEDIUM:
+    case -ENOTSUP:
+        error_free(err);
+        break;
+    default:
+        error_propagate(errp, err);
+        qapi_free_ImageInfo(info);
+        goto out;
+    }
+
+    *p_info =3D info;
+
+out:
+    aio_context_release(bdrv_get_aio_context(bs));
+}
+
+#define NB_SUFFIXES 4
+
+static char *get_human_readable_size(char *buf, int buf_size, int64_t si=
ze)
+{
+    static const char suffixes[NB_SUFFIXES] =3D {'K', 'M', 'G', 'T'};
+    int64_t base;
+    int i;
+
+    if (size <=3D 999) {
+        snprintf(buf, buf_size, "%" PRId64, size);
+    } else {
+        base =3D 1024;
+        for (i =3D 0; i < NB_SUFFIXES; i++) {
+            if (size < (10 * base)) {
+                snprintf(buf, buf_size, "%0.1f%c",
+                         (double)size / base,
+                         suffixes[i]);
+                break;
+            } else if (size < (1000 * base) || i =3D=3D (NB_SUFFIXES - 1=
)) {
+                snprintf(buf, buf_size, "%" PRId64 "%c",
+                         ((size + (base >> 1)) / base),
+                         suffixes[i]);
+                break;
+            }
+            base =3D base * 1024;
+        }
+    }
+    return buf;
+}
+
+void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
+                        QEMUSnapshotInfo *sn)
+{
+    char buf1[128], date_buf[128], clock_buf[128];
+    struct tm tm;
+    time_t ti;
+    int64_t secs;
+
+    if (!sn) {
+        func_fprintf(f,
+                     "%-10s%-20s%7s%20s%15s",
+                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
+    } else {
+        ti =3D sn->date_sec;
+        localtime_r(&ti, &tm);
+        strftime(date_buf, sizeof(date_buf),
+                 "%Y-%m-%d %H:%M:%S", &tm);
+        secs =3D sn->vm_clock_nsec / 1000000000;
+        snprintf(clock_buf, sizeof(clock_buf),
+                 "%02d:%02d:%02d.%03d",
+                 (int)(secs / 3600),
+                 (int)((secs / 60) % 60),
+                 (int)(secs % 60),
+                 (int)((sn->vm_clock_nsec / 1000000) % 1000));
+        func_fprintf(f,
+                     "%-10s%-20s%7s%20s%15s",
+                     sn->id_str, sn->name,
+                     get_human_readable_size(buf1, sizeof(buf1),
+                                             sn->vm_state_size),
+                     date_buf,
+                     clock_buf);
+    }
+}
+
+static void dump_qdict(fprintf_function func_fprintf, void *f, int inden=
tation,
+                       QDict *dict);
+static void dump_qlist(fprintf_function func_fprintf, void *f, int inden=
tation,
+                       QList *list);
+
+static void dump_qobject(fprintf_function func_fprintf, void *f,
+                         int comp_indent, QObject *obj)
+{
+    switch (qobject_type(obj)) {
+        case QTYPE_QNUM: {
+            QNum *value =3D qobject_to(QNum, obj);
+            char *tmp =3D qnum_to_string(value);
+            func_fprintf(f, "%s", tmp);
+            g_free(tmp);
+            break;
+        }
+        case QTYPE_QSTRING: {
+            QString *value =3D qobject_to(QString, obj);
+            func_fprintf(f, "%s", qstring_get_str(value));
+            break;
+        }
+        case QTYPE_QDICT: {
+            QDict *value =3D qobject_to(QDict, obj);
+            dump_qdict(func_fprintf, f, comp_indent, value);
+            break;
+        }
+        case QTYPE_QLIST: {
+            QList *value =3D qobject_to(QList, obj);
+            dump_qlist(func_fprintf, f, comp_indent, value);
+            break;
+        }
+        case QTYPE_QBOOL: {
+            QBool *value =3D qobject_to(QBool, obj);
+            func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "fals=
e");
+            break;
+        }
+        default:
+            abort();
+    }
+}
+
+static void dump_qlist(fprintf_function func_fprintf, void *f, int inden=
tation,
+                       QList *list)
+{
+    const QListEntry *entry;
+    int i =3D 0;
+
+    for (entry =3D qlist_first(list); entry; entry =3D qlist_next(entry)=
, i++) {
+        QType type =3D qobject_type(entry->value);
+        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
+        func_fprintf(f, "%*s[%i]:%c", indentation * 4, "", i,
+                     composite ? '\n' : ' ');
+        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
+        if (!composite) {
+            func_fprintf(f, "\n");
+        }
+    }
+}
+
+static void dump_qdict(fprintf_function func_fprintf, void *f, int inden=
tation,
+                       QDict *dict)
+{
+    const QDictEntry *entry;
+
+    for (entry =3D qdict_first(dict); entry; entry =3D qdict_next(dict, =
entry)) {
+        QType type =3D qobject_type(entry->value);
+        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
+        char *key =3D g_malloc(strlen(entry->key) + 1);
+        int i;
+
+        /* replace dashes with spaces in key (variable) names */
+        for (i =3D 0; entry->key[i]; i++) {
+            key[i] =3D entry->key[i] =3D=3D '-' ? ' ' : entry->key[i];
+        }
+        key[i] =3D 0;
+        func_fprintf(f, "%*s%s:%c", indentation * 4, "", key,
+                     composite ? '\n' : ' ');
+        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
+        if (!composite) {
+            func_fprintf(f, "\n");
+        }
+        g_free(key);
+    }
+}
+
+void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *=
f,
+                                   ImageInfoSpecific *info_spec)
+{
+    QObject *obj, *data;
+    Visitor *v =3D qobject_output_visitor_new(&obj);
+
+    visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
+    visit_complete(v, &obj);
+    data =3D qdict_get(qobject_to(QDict, obj), "data");
+    dump_qobject(func_fprintf, f, 1, data);
+    qobject_unref(obj);
+    visit_free(v);
+}
+
+void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
+                          ImageInfo *info)
+{
+    char size_buf[128], dsize_buf[128];
+    if (!info->has_actual_size) {
+        snprintf(dsize_buf, sizeof(dsize_buf), "unavailable");
+    } else {
+        get_human_readable_size(dsize_buf, sizeof(dsize_buf),
+                                info->actual_size);
+    }
+    get_human_readable_size(size_buf, sizeof(size_buf), info->virtual_si=
ze);
+    func_fprintf(f,
+                 "image: %s\n"
+                 "file format: %s\n"
+                 "virtual size: %s (%" PRId64 " bytes)\n"
+                 "disk size: %s\n",
+                 info->filename, info->format, size_buf,
+                 info->virtual_size,
+                 dsize_buf);
+
+    if (info->has_encrypted && info->encrypted) {
+        func_fprintf(f, "encrypted: yes\n");
+    }
+
+    if (info->has_cluster_size) {
+        func_fprintf(f, "cluster_size: %" PRId64 "\n",
+                       info->cluster_size);
+    }
+
+    if (info->has_dirty_flag && info->dirty_flag) {
+        func_fprintf(f, "cleanly shut down: no\n");
+    }
+
+    if (info->has_backing_filename) {
+        func_fprintf(f, "backing file: %s", info->backing_filename);
+        if (!info->has_full_backing_filename) {
+            func_fprintf(f, " (cannot determine actual path)");
+        } else if (strcmp(info->backing_filename,
+                          info->full_backing_filename) !=3D 0) {
+            func_fprintf(f, " (actual path: %s)", info->full_backing_fil=
ename);
+        }
+        func_fprintf(f, "\n");
+        if (info->has_backing_filename_format) {
+            func_fprintf(f, "backing file format: %s\n",
+                         info->backing_filename_format);
+        }
+    }
+
+    if (info->has_snapshots) {
+        SnapshotInfoList *elem;
+
+        func_fprintf(f, "Snapshot list:\n");
+        bdrv_snapshot_dump(func_fprintf, f, NULL);
+        func_fprintf(f, "\n");
+
+        /* Ideally bdrv_snapshot_dump() would operate on SnapshotInfoLis=
t but
+         * we convert to the block layer's native QEMUSnapshotInfo for n=
ow.
+         */
+        for (elem =3D info->snapshots; elem; elem =3D elem->next) {
+            QEMUSnapshotInfo sn =3D {
+                .vm_state_size =3D elem->value->vm_state_size,
+                .date_sec =3D elem->value->date_sec,
+                .date_nsec =3D elem->value->date_nsec,
+                .vm_clock_nsec =3D elem->value->vm_clock_sec * 100000000=
0ULL +
+                                 elem->value->vm_clock_nsec,
+            };
+
+            pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
+            pstrcpy(sn.name, sizeof(sn.name), elem->value->name);
+            bdrv_snapshot_dump(func_fprintf, f, &sn);
+            func_fprintf(f, "\n");
+        }
+    }
+
+    if (info->has_format_specific) {
+        func_fprintf(f, "Format specific information:\n");
+        bdrv_image_info_specific_dump(func_fprintf, f, info->format_spec=
ific);
+    }
+}
+
diff --git a/block/qapi.c b/block/qapi.c
index c66f949db8..1ed7ea624f 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -23,320 +23,11 @@
  */
=20
 #include "qemu/osdep.h"
-#include "block/qapi.h"
-#include "block/block_int.h"
+#include "block/bdrv_info.h"
 #include "block/throttle-groups.h"
-#include "block/write-threshold.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
-#include "qapi/qobject-output-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
-#include "qemu/cutils.h"
-
-BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs, Error **er=
rp)
-{
-    ImageInfo **p_image_info;
-    BlockDriverState *bs0;
-    BlockDeviceInfo *info;
-
-    if (!bs->drv) {
-        error_setg(errp, "Block device %s is ejected", bs->node_name);
-        return NULL;
-    }
-
-    info =3D g_malloc0(sizeof(*info));
-    info->file                   =3D g_strdup(bs->filename);
-    info->ro                     =3D bs->read_only;
-    info->drv                    =3D g_strdup(bs->drv->format_name);
-    info->encrypted              =3D bs->encrypted;
-    info->encryption_key_missing =3D false;
-
-    info->cache =3D g_new(BlockdevCacheInfo, 1);
-    *info->cache =3D (BlockdevCacheInfo) {
-        .writeback      =3D blk ? blk_enable_write_cache(blk) : true,
-        .direct         =3D !!(bs->open_flags & BDRV_O_NOCACHE),
-        .no_flush       =3D !!(bs->open_flags & BDRV_O_NO_FLUSH),
-    };
-
-    if (bs->node_name[0]) {
-        info->has_node_name =3D true;
-        info->node_name =3D g_strdup(bs->node_name);
-    }
-
-    if (bs->backing_file[0]) {
-        info->has_backing_file =3D true;
-        info->backing_file =3D g_strdup(bs->backing_file);
-    }
-
-    info->detect_zeroes =3D bs->detect_zeroes;
-
-    if (blk && blk_get_public(blk)->throttle_group_member.throttle_state=
) {
-        ThrottleConfig cfg;
-        BlockBackendPublic *blkp =3D blk_get_public(blk);
-
-        throttle_group_get_config(&blkp->throttle_group_member, &cfg);
-
-        info->bps     =3D cfg.buckets[THROTTLE_BPS_TOTAL].avg;
-        info->bps_rd  =3D cfg.buckets[THROTTLE_BPS_READ].avg;
-        info->bps_wr  =3D cfg.buckets[THROTTLE_BPS_WRITE].avg;
-
-        info->iops    =3D cfg.buckets[THROTTLE_OPS_TOTAL].avg;
-        info->iops_rd =3D cfg.buckets[THROTTLE_OPS_READ].avg;
-        info->iops_wr =3D cfg.buckets[THROTTLE_OPS_WRITE].avg;
-
-        info->has_bps_max     =3D cfg.buckets[THROTTLE_BPS_TOTAL].max;
-        info->bps_max         =3D cfg.buckets[THROTTLE_BPS_TOTAL].max;
-        info->has_bps_rd_max  =3D cfg.buckets[THROTTLE_BPS_READ].max;
-        info->bps_rd_max      =3D cfg.buckets[THROTTLE_BPS_READ].max;
-        info->has_bps_wr_max  =3D cfg.buckets[THROTTLE_BPS_WRITE].max;
-        info->bps_wr_max      =3D cfg.buckets[THROTTLE_BPS_WRITE].max;
-
-        info->has_iops_max    =3D cfg.buckets[THROTTLE_OPS_TOTAL].max;
-        info->iops_max        =3D cfg.buckets[THROTTLE_OPS_TOTAL].max;
-        info->has_iops_rd_max =3D cfg.buckets[THROTTLE_OPS_READ].max;
-        info->iops_rd_max     =3D cfg.buckets[THROTTLE_OPS_READ].max;
-        info->has_iops_wr_max =3D cfg.buckets[THROTTLE_OPS_WRITE].max;
-        info->iops_wr_max     =3D cfg.buckets[THROTTLE_OPS_WRITE].max;
-
-        info->has_bps_max_length     =3D info->has_bps_max;
-        info->bps_max_length         =3D
-            cfg.buckets[THROTTLE_BPS_TOTAL].burst_length;
-        info->has_bps_rd_max_length  =3D info->has_bps_rd_max;
-        info->bps_rd_max_length      =3D
-            cfg.buckets[THROTTLE_BPS_READ].burst_length;
-        info->has_bps_wr_max_length  =3D info->has_bps_wr_max;
-        info->bps_wr_max_length      =3D
-            cfg.buckets[THROTTLE_BPS_WRITE].burst_length;
-
-        info->has_iops_max_length    =3D info->has_iops_max;
-        info->iops_max_length        =3D
-            cfg.buckets[THROTTLE_OPS_TOTAL].burst_length;
-        info->has_iops_rd_max_length =3D info->has_iops_rd_max;
-        info->iops_rd_max_length     =3D
-            cfg.buckets[THROTTLE_OPS_READ].burst_length;
-        info->has_iops_wr_max_length =3D info->has_iops_wr_max;
-        info->iops_wr_max_length     =3D
-            cfg.buckets[THROTTLE_OPS_WRITE].burst_length;
-
-        info->has_iops_size =3D cfg.op_size;
-        info->iops_size =3D cfg.op_size;
-
-        info->has_group =3D true;
-        info->group =3D
-            g_strdup(throttle_group_get_name(&blkp->throttle_group_membe=
r));
-    }
-
-    info->write_threshold =3D bdrv_write_threshold_get(bs);
-
-    bs0 =3D bs;
-    p_image_info =3D &info->image;
-    info->backing_file_depth =3D 0;
-    while (1) {
-        Error *local_err =3D NULL;
-        bdrv_query_image_info(bs0, p_image_info, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            qapi_free_BlockDeviceInfo(info);
-            return NULL;
-        }
-
-        if (bs0->drv && bs0->backing) {
-            info->backing_file_depth++;
-            bs0 =3D bs0->backing->bs;
-            (*p_image_info)->has_backing_image =3D true;
-            p_image_info =3D &((*p_image_info)->backing_image);
-        } else {
-            break;
-        }
-
-        /* Skip automatically inserted nodes that the user isn't aware o=
f for
-         * query-block (blk !=3D NULL), but not for query-named-block-no=
des */
-        while (blk && bs0->drv && bs0->implicit) {
-            bs0 =3D backing_bs(bs0);
-            assert(bs0);
-        }
-    }
-
-    return info;
-}
-
-/*
- * Returns 0 on success, with *p_list either set to describe snapshot
- * information, or NULL because there are no snapshots.  Returns -errno =
on
- * error, with *p_list untouched.
- */
-int bdrv_query_snapshot_info_list(BlockDriverState *bs,
-                                  SnapshotInfoList **p_list,
-                                  Error **errp)
-{
-    int i, sn_count;
-    QEMUSnapshotInfo *sn_tab =3D NULL;
-    SnapshotInfoList *info_list, *cur_item =3D NULL, *head =3D NULL;
-    SnapshotInfo *info;
-
-    sn_count =3D bdrv_snapshot_list(bs, &sn_tab);
-    if (sn_count < 0) {
-        const char *dev =3D bdrv_get_device_name(bs);
-        switch (sn_count) {
-        case -ENOMEDIUM:
-            error_setg(errp, "Device '%s' is not inserted", dev);
-            break;
-        case -ENOTSUP:
-            error_setg(errp,
-                       "Device '%s' does not support internal snapshots"=
,
-                       dev);
-            break;
-        default:
-            error_setg_errno(errp, -sn_count,
-                             "Can't list snapshots of device '%s'", dev)=
;
-            break;
-        }
-        return sn_count;
-    }
-
-    for (i =3D 0; i < sn_count; i++) {
-        info =3D g_new0(SnapshotInfo, 1);
-        info->id            =3D g_strdup(sn_tab[i].id_str);
-        info->name          =3D g_strdup(sn_tab[i].name);
-        info->vm_state_size =3D sn_tab[i].vm_state_size;
-        info->date_sec      =3D sn_tab[i].date_sec;
-        info->date_nsec     =3D sn_tab[i].date_nsec;
-        info->vm_clock_sec  =3D sn_tab[i].vm_clock_nsec / 1000000000;
-        info->vm_clock_nsec =3D sn_tab[i].vm_clock_nsec % 1000000000;
-
-        info_list =3D g_new0(SnapshotInfoList, 1);
-        info_list->value =3D info;
-
-        /* XXX: waiting for the qapi to support qemu-queue.h types */
-        if (!cur_item) {
-            head =3D cur_item =3D info_list;
-        } else {
-            cur_item->next =3D info_list;
-            cur_item =3D info_list;
-        }
-
-    }
-
-    g_free(sn_tab);
-    *p_list =3D head;
-    return 0;
-}
-
-/**
- * bdrv_query_image_info:
- * @bs: block device to examine
- * @p_info: location to store image information
- * @errp: location to store error information
- *
- * Store "flat" image information in @p_info.
- *
- * "Flat" means it does *not* query backing image information,
- * i.e. (*pinfo)->has_backing_image will be set to false and
- * (*pinfo)->backing_image to NULL even when the image does in fact have
- * a backing image.
- *
- * @p_info will be set only on success. On error, store error in @errp.
- */
-void bdrv_query_image_info(BlockDriverState *bs,
-                           ImageInfo **p_info,
-                           Error **errp)
-{
-    int64_t size;
-    const char *backing_filename;
-    BlockDriverInfo bdi;
-    int ret;
-    Error *err =3D NULL;
-    ImageInfo *info;
-
-    aio_context_acquire(bdrv_get_aio_context(bs));
-
-    size =3D bdrv_getlength(bs);
-    if (size < 0) {
-        error_setg_errno(errp, -size, "Can't get image size '%s'",
-                         bs->exact_filename);
-        goto out;
-    }
-
-    info =3D g_new0(ImageInfo, 1);
-    info->filename        =3D g_strdup(bs->filename);
-    info->format          =3D g_strdup(bdrv_get_format_name(bs));
-    info->virtual_size    =3D size;
-    info->actual_size     =3D bdrv_get_allocated_file_size(bs);
-    info->has_actual_size =3D info->actual_size >=3D 0;
-    if (bdrv_is_encrypted(bs)) {
-        info->encrypted =3D true;
-        info->has_encrypted =3D true;
-    }
-    if (bdrv_get_info(bs, &bdi) >=3D 0) {
-        if (bdi.cluster_size !=3D 0) {
-            info->cluster_size =3D bdi.cluster_size;
-            info->has_cluster_size =3D true;
-        }
-        info->dirty_flag =3D bdi.is_dirty;
-        info->has_dirty_flag =3D true;
-    }
-    info->format_specific     =3D bdrv_get_specific_info(bs);
-    info->has_format_specific =3D info->format_specific !=3D NULL;
-
-    backing_filename =3D bs->backing_file;
-    if (backing_filename[0] !=3D '\0') {
-        char *backing_filename2 =3D g_malloc0(PATH_MAX);
-        info->backing_filename =3D g_strdup(backing_filename);
-        info->has_backing_filename =3D true;
-        bdrv_get_full_backing_filename(bs, backing_filename2, PATH_MAX, =
&err);
-        if (err) {
-            /* Can't reconstruct the full backing filename, so we must o=
mit
-             * this field and apply a Best Effort to this query. */
-            g_free(backing_filename2);
-            backing_filename2 =3D NULL;
-            error_free(err);
-            err =3D NULL;
-        }
-
-        /* Always report the full_backing_filename if present, even if i=
t's the
-         * same as backing_filename. That they are same is useful info. =
*/
-        if (backing_filename2) {
-            info->full_backing_filename =3D g_strdup(backing_filename2);
-            info->has_full_backing_filename =3D true;
-        }
-
-        if (bs->backing_format[0]) {
-            info->backing_filename_format =3D g_strdup(bs->backing_forma=
t);
-            info->has_backing_filename_format =3D true;
-        }
-        g_free(backing_filename2);
-    }
-
-    ret =3D bdrv_query_snapshot_info_list(bs, &info->snapshots, &err);
-    switch (ret) {
-    case 0:
-        if (info->snapshots) {
-            info->has_snapshots =3D true;
-        }
-        break;
-    /* recoverable error */
-    case -ENOMEDIUM:
-    case -ENOTSUP:
-        error_free(err);
-        break;
-    default:
-        error_propagate(errp, err);
-        qapi_free_ImageInfo(info);
-        goto out;
-    }
-
-    *p_info =3D info;
-
-out:
-    aio_context_release(bdrv_get_aio_context(bs));
-}
=20
 /* @p_info will be set only on success. */
 static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
@@ -629,245 +320,3 @@ BlockStatsList *qmp_query_blockstats(bool has_query=
_nodes,
     return head;
 }
=20
-#define NB_SUFFIXES 4
-
-static char *get_human_readable_size(char *buf, int buf_size, int64_t si=
ze)
-{
-    static const char suffixes[NB_SUFFIXES] =3D {'K', 'M', 'G', 'T'};
-    int64_t base;
-    int i;
-
-    if (size <=3D 999) {
-        snprintf(buf, buf_size, "%" PRId64, size);
-    } else {
-        base =3D 1024;
-        for (i =3D 0; i < NB_SUFFIXES; i++) {
-            if (size < (10 * base)) {
-                snprintf(buf, buf_size, "%0.1f%c",
-                         (double)size / base,
-                         suffixes[i]);
-                break;
-            } else if (size < (1000 * base) || i =3D=3D (NB_SUFFIXES - 1=
)) {
-                snprintf(buf, buf_size, "%" PRId64 "%c",
-                         ((size + (base >> 1)) / base),
-                         suffixes[i]);
-                break;
-            }
-            base =3D base * 1024;
-        }
-    }
-    return buf;
-}
-
-void bdrv_snapshot_dump(fprintf_function func_fprintf, void *f,
-                        QEMUSnapshotInfo *sn)
-{
-    char buf1[128], date_buf[128], clock_buf[128];
-    struct tm tm;
-    time_t ti;
-    int64_t secs;
-
-    if (!sn) {
-        func_fprintf(f,
-                     "%-10s%-20s%7s%20s%15s",
-                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
-    } else {
-        ti =3D sn->date_sec;
-        localtime_r(&ti, &tm);
-        strftime(date_buf, sizeof(date_buf),
-                 "%Y-%m-%d %H:%M:%S", &tm);
-        secs =3D sn->vm_clock_nsec / 1000000000;
-        snprintf(clock_buf, sizeof(clock_buf),
-                 "%02d:%02d:%02d.%03d",
-                 (int)(secs / 3600),
-                 (int)((secs / 60) % 60),
-                 (int)(secs % 60),
-                 (int)((sn->vm_clock_nsec / 1000000) % 1000));
-        func_fprintf(f,
-                     "%-10s%-20s%7s%20s%15s",
-                     sn->id_str, sn->name,
-                     get_human_readable_size(buf1, sizeof(buf1),
-                                             sn->vm_state_size),
-                     date_buf,
-                     clock_buf);
-    }
-}
-
-static void dump_qdict(fprintf_function func_fprintf, void *f, int inden=
tation,
-                       QDict *dict);
-static void dump_qlist(fprintf_function func_fprintf, void *f, int inden=
tation,
-                       QList *list);
-
-static void dump_qobject(fprintf_function func_fprintf, void *f,
-                         int comp_indent, QObject *obj)
-{
-    switch (qobject_type(obj)) {
-        case QTYPE_QNUM: {
-            QNum *value =3D qobject_to(QNum, obj);
-            char *tmp =3D qnum_to_string(value);
-            func_fprintf(f, "%s", tmp);
-            g_free(tmp);
-            break;
-        }
-        case QTYPE_QSTRING: {
-            QString *value =3D qobject_to(QString, obj);
-            func_fprintf(f, "%s", qstring_get_str(value));
-            break;
-        }
-        case QTYPE_QDICT: {
-            QDict *value =3D qobject_to(QDict, obj);
-            dump_qdict(func_fprintf, f, comp_indent, value);
-            break;
-        }
-        case QTYPE_QLIST: {
-            QList *value =3D qobject_to(QList, obj);
-            dump_qlist(func_fprintf, f, comp_indent, value);
-            break;
-        }
-        case QTYPE_QBOOL: {
-            QBool *value =3D qobject_to(QBool, obj);
-            func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "fals=
e");
-            break;
-        }
-        default:
-            abort();
-    }
-}
-
-static void dump_qlist(fprintf_function func_fprintf, void *f, int inden=
tation,
-                       QList *list)
-{
-    const QListEntry *entry;
-    int i =3D 0;
-
-    for (entry =3D qlist_first(list); entry; entry =3D qlist_next(entry)=
, i++) {
-        QType type =3D qobject_type(entry->value);
-        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
-        func_fprintf(f, "%*s[%i]:%c", indentation * 4, "", i,
-                     composite ? '\n' : ' ');
-        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
-        if (!composite) {
-            func_fprintf(f, "\n");
-        }
-    }
-}
-
-static void dump_qdict(fprintf_function func_fprintf, void *f, int inden=
tation,
-                       QDict *dict)
-{
-    const QDictEntry *entry;
-
-    for (entry =3D qdict_first(dict); entry; entry =3D qdict_next(dict, =
entry)) {
-        QType type =3D qobject_type(entry->value);
-        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
-        char *key =3D g_malloc(strlen(entry->key) + 1);
-        int i;
-
-        /* replace dashes with spaces in key (variable) names */
-        for (i =3D 0; entry->key[i]; i++) {
-            key[i] =3D entry->key[i] =3D=3D '-' ? ' ' : entry->key[i];
-        }
-        key[i] =3D 0;
-        func_fprintf(f, "%*s%s:%c", indentation * 4, "", key,
-                     composite ? '\n' : ' ');
-        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
-        if (!composite) {
-            func_fprintf(f, "\n");
-        }
-        g_free(key);
-    }
-}
-
-void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *=
f,
-                                   ImageInfoSpecific *info_spec)
-{
-    QObject *obj, *data;
-    Visitor *v =3D qobject_output_visitor_new(&obj);
-
-    visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
-    visit_complete(v, &obj);
-    data =3D qdict_get(qobject_to(QDict, obj), "data");
-    dump_qobject(func_fprintf, f, 1, data);
-    qobject_unref(obj);
-    visit_free(v);
-}
-
-void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
-                          ImageInfo *info)
-{
-    char size_buf[128], dsize_buf[128];
-    if (!info->has_actual_size) {
-        snprintf(dsize_buf, sizeof(dsize_buf), "unavailable");
-    } else {
-        get_human_readable_size(dsize_buf, sizeof(dsize_buf),
-                                info->actual_size);
-    }
-    get_human_readable_size(size_buf, sizeof(size_buf), info->virtual_si=
ze);
-    func_fprintf(f,
-                 "image: %s\n"
-                 "file format: %s\n"
-                 "virtual size: %s (%" PRId64 " bytes)\n"
-                 "disk size: %s\n",
-                 info->filename, info->format, size_buf,
-                 info->virtual_size,
-                 dsize_buf);
-
-    if (info->has_encrypted && info->encrypted) {
-        func_fprintf(f, "encrypted: yes\n");
-    }
-
-    if (info->has_cluster_size) {
-        func_fprintf(f, "cluster_size: %" PRId64 "\n",
-                       info->cluster_size);
-    }
-
-    if (info->has_dirty_flag && info->dirty_flag) {
-        func_fprintf(f, "cleanly shut down: no\n");
-    }
-
-    if (info->has_backing_filename) {
-        func_fprintf(f, "backing file: %s", info->backing_filename);
-        if (!info->has_full_backing_filename) {
-            func_fprintf(f, " (cannot determine actual path)");
-        } else if (strcmp(info->backing_filename,
-                          info->full_backing_filename) !=3D 0) {
-            func_fprintf(f, " (actual path: %s)", info->full_backing_fil=
ename);
-        }
-        func_fprintf(f, "\n");
-        if (info->has_backing_filename_format) {
-            func_fprintf(f, "backing file format: %s\n",
-                         info->backing_filename_format);
-        }
-    }
-
-    if (info->has_snapshots) {
-        SnapshotInfoList *elem;
-
-        func_fprintf(f, "Snapshot list:\n");
-        bdrv_snapshot_dump(func_fprintf, f, NULL);
-        func_fprintf(f, "\n");
-
-        /* Ideally bdrv_snapshot_dump() would operate on SnapshotInfoLis=
t but
-         * we convert to the block layer's native QEMUSnapshotInfo for n=
ow.
-         */
-        for (elem =3D info->snapshots; elem; elem =3D elem->next) {
-            QEMUSnapshotInfo sn =3D {
-                .vm_state_size =3D elem->value->vm_state_size,
-                .date_sec =3D elem->value->date_sec,
-                .date_nsec =3D elem->value->date_nsec,
-                .vm_clock_nsec =3D elem->value->vm_clock_sec * 100000000=
0ULL +
-                                 elem->value->vm_clock_nsec,
-            };
-
-            pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
-            pstrcpy(sn.name, sizeof(sn.name), elem->value->name);
-            bdrv_snapshot_dump(func_fprintf, f, &sn);
-            func_fprintf(f, "\n");
-        }
-    }
-
-    if (info->has_format_specific) {
-        func_fprintf(f, "Format specific information:\n");
-        bdrv_image_info_specific_dump(func_fprintf, f, info->format_spec=
ific);
-    }
-}
diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..bdd69d2c37 100644
--- a/hmp.c
+++ b/hmp.c
@@ -45,7 +45,7 @@
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
 #include "block/nbd.h"
-#include "block/qapi.h"
+#include "block/bdrv_info.h"
 #include "qemu-io.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/include/block/qapi.h b/include/block/bdrv_info.h
similarity index 97%
rename from include/block/qapi.h
rename to include/block/bdrv_info.h
index 83bdb098bd..6ba1441177 100644
--- a/include/block/qapi.h
+++ b/include/block/bdrv_info.h
@@ -22,8 +22,8 @@
  * THE SOFTWARE.
  */
=20
-#ifndef BLOCK_QAPI_H
-#define BLOCK_QAPI_H
+#ifndef BDRV_INFO_H
+#define BDRV_INFO_H
=20
 #include "block/block.h"
 #include "block/snapshot.h"
@@ -43,4 +43,4 @@ void bdrv_image_info_specific_dump(fprintf_function fun=
c_fprintf, void *f,
                                    ImageInfoSpecific *info_spec);
 void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
                           ImageInfo *info);
-#endif
+#endif // BDRV_INFO_H
diff --git a/monitor.c b/monitor.c
index c09fa63940..edde1c0331 100644
--- a/monitor.c
+++ b/monitor.c
@@ -73,7 +73,7 @@
 #include "qemu/option.h"
 #include "hmp.h"
 #include "qemu/thread.h"
-#include "block/qapi.h"
+#include "block/bdrv_info.h"
 #include "qapi/qapi-commands.h"
 #include "qapi/qapi-events.h"
 #include "qapi/error.h"
diff --git a/qemu-img.c b/qemu-img.c
index ad04f59565..61a5740ecc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -42,7 +42,7 @@
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
-#include "block/qapi.h"
+#include "block/bdrv_info.h"
 #include "crypto/init.h"
 #include "trace/control.h"
=20
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c39124036..72d8e82507 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -15,7 +15,7 @@
 #include "sysemu/block-backend.h"
 #include "block/block.h"
 #include "block/block_int.h" /* for info_f() */
-#include "block/qapi.h"
+#include "block/bdrv_info.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
--=20
2.19.1
