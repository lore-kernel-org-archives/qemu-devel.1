Received: from eggs.gnu.org ([2001:4830:134:3::10]:39346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrTb-0000AA-8g
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrTY-00036U-R3
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:15:35 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Sun, 11 Jun 2017 04:14:27 +0300
Message-Id: <20170611011427.6713-3-el13635@mail.ntua.gr>
In-Reply-To: <20170611011427.6713-1-el13635@mail.ntua.gr>
References: <20170611011427.6713-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC v2 2/2] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

block/throttle.c uses existing I/O throttle infrastructure inside a
block filter driver. I/O operations are intercepted in the filter's
read/write coroutines, and referred to block/throttle-groups.c

The driver can be used with the command
-drive driver=3Dthrottle,file.filename=3Dfoo.qcow2,iops-total=3D...
The configuration flags and semantics are identical to the hardcoded
throttling ones.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/Makefile.objs             |   1 +
 block/throttle-groups.c         |  16 +-
 block/throttle.c                | 364 ++++++++++++++++++++++++++++++++++=
++++++
 include/block/throttle-groups.h |   6 +-
 include/qemu/throttle-options.h |  60 ++++---
 5 files changed, 419 insertions(+), 28 deletions(-)
 create mode 100644 block/throttle.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index ea955302c8..bb811a4d01 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -25,6 +25,7 @@ block-obj-y +=3D accounting.o dirty-bitmap.o
 block-obj-y +=3D write-threshold.o
 block-obj-y +=3D backup.o
 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
+block-obj-y +=3D throttle.o
=20
 block-obj-y +=3D crypto.o
=20
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index d8bf990ccb..9008b73cc9 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -29,11 +29,11 @@
 #include "qemu/thread.h"
 #include "sysemu/qtest.h"
=20
-
-static QemuMutex throttle_groups_lock;
-static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =3D
+QemuMutex throttle_groups_lock;
+QTAILQ_HEAD(throttle_groups_head, ThrottleGroup) throttle_groups =3D
     QTAILQ_HEAD_INITIALIZER(throttle_groups);
=20
+
 /* Increments the reference count of a ThrottleGroup given its name.
  *
  * If no ThrottleGroup is found with the given name a new one is
@@ -117,7 +117,7 @@ const char *throttle_group_get_name(ThrottleGroupMemb=
er *tgm)
  * @tgm: the current ThrottleGroupMember
  * @ret: the next ThrottleGroupMember in the sequence
  */
-static ThrottleGroupMember *throttle_group_next_tgm(ThrottleGroupMember =
*tgm)
+ThrottleGroupMember *throttle_group_next_tgm(ThrottleGroupMember *tgm)
 {
     ThrottleState *ts =3D tgm->throttle_state;
     ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
@@ -229,7 +229,7 @@ static bool throttle_group_schedule_timer(ThrottleGro=
upMember *tgm,
  * @tgm:       the current ThrottleGroupMember
  * @is_write:  the type of operation (read/write)
  */
-static void schedule_next_request(ThrottleGroupMember *tgm, bool is_writ=
e)
+void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
 {
     ThrottleState *ts =3D tgm->throttle_state;
     ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
@@ -358,7 +358,7 @@ void throttle_group_get_config(ThrottleGroupMember *t=
gm, ThrottleConfig *cfg)
  * @tgm:       the ThrottleGroupMember whose request had been throttled
  * @is_write:  the type of operation (read/write)
  */
-static void timer_cb(ThrottleGroupMember *tgm, bool is_write)
+void timer_cb(ThrottleGroupMember *tgm, bool is_write)
 {
     ThrottleState *ts =3D tgm->throttle_state;
     ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
@@ -383,12 +383,12 @@ static void timer_cb(ThrottleGroupMember *tgm, bool=
 is_write)
     }
 }
=20
-static void read_timer_cb(void *opaque)
+void read_timer_cb(void *opaque)
 {
     timer_cb(opaque, false);
 }
=20
-static void write_timer_cb(void *opaque)
+void write_timer_cb(void *opaque)
 {
     timer_cb(opaque, true);
 }
diff --git a/block/throttle.c b/block/throttle.c
new file mode 100644
index 0000000000..6be5d3de59
--- /dev/null
+++ b/block/throttle.c
@@ -0,0 +1,364 @@
+/*
+ * QEMU block throttling filter driver infrastructure
+ *
+ * Copyright (C) Nodalink, EURL. 2014
+ * Copyright (C) Igalia, S.L. 2015
+ *
+ * Authors:
+ *   Beno=C3=AEt Canet <benoit.canet@nodalink.com>
+ *   Alberto Garcia <berto@igalia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "block/throttle-groups.h"
+#include "qemu/throttle-options.h"
+#include "qapi/error.h"
+
+
+static QemuOptsList throttle_opts =3D {
+    .name =3D "throttle",
+    .head =3D QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
+    .desc =3D {
+        {
+            .name =3D QEMU_OPT_IOPS_TOTAL,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "limit total I/O operations per second",
+        },{
+            .name =3D QEMU_OPT_IOPS_READ,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "limit read operations per second",
+        },{
+            .name =3D QEMU_OPT_IOPS_WRITE,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "limit write operations per second",
+        },{
+            .name =3D QEMU_OPT_BPS_TOTAL,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "limit total bytes per second",
+        },{
+            .name =3D QEMU_OPT_BPS_READ,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "limit read bytes per second",
+        },{
+            .name =3D QEMU_OPT_BPS_WRITE,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "limit write bytes per second",
+        },{
+            .name =3D QEMU_OPT_IOPS_TOTAL_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "I/O operations burst",
+        },{
+            .name =3D QEMU_OPT_IOPS_READ_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "I/O operations read burst",
+        },{
+            .name =3D QEMU_OPT_IOPS_WRITE_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "I/O operations write burst",
+        },{
+            .name =3D QEMU_OPT_BPS_TOTAL_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "total bytes burst",
+        },{
+            .name =3D QEMU_OPT_BPS_READ_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "total bytes read burst",
+        },{
+            .name =3D QEMU_OPT_BPS_WRITE_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "total bytes write burst",
+        },{
+            .name =3D QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "length of the iopstotalmax burst period, in secon=
ds",
+        },{
+            .name =3D QEMU_OPT_IOPS_READ_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "length of the iopsreadmax burst period, in second=
s",
+        },{
+            .name =3D QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "length of the iopswritemax burst period, in secon=
ds",
+        },{
+            .name =3D QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "length of the bpstotalmax burst period, in second=
s",
+        },{
+            .name =3D QEMU_OPT_BPS_READ_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "length of the bpsreadmax burst period, in seconds=
",
+        },{
+            .name =3D QEMU_OPT_BPS_WRITE_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "length of the bpswritemax burst period, in second=
s",
+        },{
+            .name =3D QEMU_OPT_IOPS_SIZE,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "when limiting by iops max size of an I/O in bytes=
",
+        },
+        {
+            .name =3D QEMU_OPT_THROTTLE_GROUP_NAME,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "throttle group name",
+        },
+        { /* end of list */ }
+    },
+};
+
+static int throttle_open(BlockDriverState *bs, QDict *options,
+                            int flags, Error **errp)
+{
+    int ret =3D 0;
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    Error *local_err =3D NULL;
+    QemuOpts *opts =3D NULL;
+    const char *group_name =3D NULL;
+
+    bs->file =3D bdrv_open_child(NULL, options, "file",
+                                           bs, &child_file, false, &loca=
l_err);
+
+    if (local_err) {
+        ret =3D -EINVAL;
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    qdict_flatten(options);
+    opts =3D qemu_opts_create(&throttle_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret =3D -EINVAL;
+        goto fin;
+    }
+
+    group_name =3D qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
+    if (!group_name) {
+        group_name =3D bdrv_get_device_or_node_name(bs);
+        if (!strlen(group_name)) {
+            error_setg(&local_err,
+                       "A group name must be specified for this device."=
);
+            error_propagate(errp, local_err);
+            ret =3D -EINVAL;
+            goto fin;
+        }
+    }
+
+    tgm->aio_context =3D bdrv_get_aio_context(bs);
+    throttle_group_register_tgm(tgm, group_name);
+    ThrottleState *ts =3D tgm->throttle_state;
+    ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
+    ThrottleConfig *throttle_cfg =3D &ts->cfg;
+
+
+    qemu_mutex_lock(&tg->lock);
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL)) {
+        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ)) {
+        throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE)) {
+        throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL)) {
+        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ)) {
+        throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE)) {
+        throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX)) {
+        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX)) {
+        throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX)) {
+        throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX)) {
+        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX)) {
+        throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX)) {
+        throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH)) {
+        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX_LENGTH)) {
+        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH)) {
+        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH)) {
+        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1)=
;
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH)) {
+        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH)) {
+        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1)=
;
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_SIZE)) {
+        throttle_cfg->op_size =3D
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_SIZE, 0);
+    }
+
+    if (!throttle_is_valid(throttle_cfg, &local_err)) {
+        error_propagate(errp, local_err);
+        throttle_group_unregister_tgm(tgm);
+        ret =3D -EINVAL;
+        goto fin;
+    }
+
+    qemu_mutex_unlock(&tg->lock);
+
+    qemu_co_queue_init(&tgm->throttled_reqs[0]);
+    qemu_co_queue_init(&tgm->throttled_reqs[1]);
+
+fin:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static void throttle_close(BlockDriverState *bs)
+{
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    throttle_group_unregister_tgm(tgm);
+    return;
+}
+
+
+static int64_t throttle_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+
+static int coroutine_fn throttle_co_preadv(BlockDriverState *bs, uint64_=
t offset,
+                                            uint64_t bytes, QEMUIOVector=
 *qiov,
+                                            int flags)
+{
+
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, false);
+
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs, uint64=
_t offset,
+                                            uint64_t bytes, QEMUIOVector=
 *qiov,
+                                            int flags)
+{
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
+        int64_t offset, int bytes)
+{
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+
+    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+}
+
+static int throttle_co_flush(BlockDriverState *bs)
+{
+    return bdrv_co_flush(bs->file->bs);
+}
+
+static void throttle_detach_aio_context(BlockDriverState *bs)
+{
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    throttle_timers_detach_aio_context(&tgm->throttle_timers);
+}
+
+static void throttle_attach_aio_context(BlockDriverState *bs,
+                                    AioContext *new_context)
+{
+    ThrottleGroupMember *tgm =3D bs->opaque;
+    throttle_timers_attach_aio_context(&tgm->throttle_timers, new_contex=
t);
+}
+static BlockDriver bdrv_throttle =3D {
+    .format_name                        =3D   "throttle",
+    .protocol_name                      =3D   "throttle",
+    .instance_size                      =3D   sizeof(ThrottleGroupMember=
),
+
+    .bdrv_file_open                     =3D   throttle_open,
+    .bdrv_close                         =3D   throttle_close,
+    .bdrv_co_flush                      =3D   throttle_co_flush,
+
+    .bdrv_child_perm                    =3D   bdrv_filter_default_perms,
+
+    .bdrv_getlength                     =3D   throttle_getlength,
+
+    .bdrv_co_preadv                     =3D   throttle_co_preadv,
+    .bdrv_co_pwritev                    =3D   throttle_co_pwritev,
+
+    .bdrv_co_pwrite_zeroes              =3D   throttle_co_pwrite_zeroes,
+    .bdrv_co_pdiscard                   =3D   throttle_co_pdiscard,
+
+    .bdrv_recurse_is_first_non_filter   =3D   bdrv_recurse_is_first_non_=
filter,
+
+    .bdrv_attach_aio_context            =3D   throttle_attach_aio_contex=
t,
+    .bdrv_detach_aio_context            =3D   throttle_detach_aio_contex=
t,
+
+    .is_filter                          =3D   true,
+};
+
+static void bdrv_throttle_init(void)
+{
+    bdrv_register(&bdrv_throttle);
+}
+
+block_init(bdrv_throttle_init);
diff --git a/include/block/throttle-groups.h b/include/block/throttle-gro=
ups.h
index 487b2da461..67b6c69fe4 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -44,5 +44,9 @@ void throttle_group_restart_tgm(ThrottleGroupMember *tg=
m);
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMem=
ber *tgm,
                                                         unsigned int byt=
es,
                                                         bool is_write);
-
+ThrottleGroupMember *throttle_group_next_tgm(ThrottleGroupMember *tgm);
+void schedule_next_request(struct ThrottleGroupMember *tgm, bool is_writ=
e);
+void timer_cb(ThrottleGroupMember *tgm, bool is_write);
+void read_timer_cb(void *opaque);
+void write_timer_cb(void *opaque);
 #endif
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opti=
ons.h
index 3133d1ca40..3528a8f4a2 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -10,81 +10,103 @@
 #ifndef THROTTLE_OPTIONS_H
 #define THROTTLE_OPTIONS_H
=20
+#define QEMU_OPT_IOPS_TOTAL "iops-total"
+#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
+#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
+#define QEMU_OPT_IOPS_READ "iops-read"
+#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
+#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
+#define QEMU_OPT_IOPS_WRITE "iops-write"
+#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
+#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
+#define QEMU_OPT_BPS_TOTAL "bps-total"
+#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
+#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
+#define QEMU_OPT_BPS_READ "bps-read"
+#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
+#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
+#define QEMU_OPT_BPS_WRITE "bps-write"
+#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
+#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
+#define QEMU_OPT_IOPS_SIZE "iops-size"
+#define QEMU_OPT_THROTTLE_GROUP_NAME "throttle-group"
+
+#define THROTTLE_OPT_PREFIX "throttling."
 #define THROTTLE_OPTS \
           { \
-            .name =3D "throttling.iops-total",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "limit total I/O operations per second",\
         },{ \
-            .name =3D "throttling.iops-read",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "limit read operations per second",\
         },{ \
-            .name =3D "throttling.iops-write",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "limit write operations per second",\
         },{ \
-            .name =3D "throttling.bps-total",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "limit total bytes per second",\
         },{ \
-            .name =3D "throttling.bps-read",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "limit read bytes per second",\
         },{ \
-            .name =3D "throttling.bps-write",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "limit write bytes per second",\
         },{ \
-            .name =3D "throttling.iops-total-max",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "I/O operations burst",\
         },{ \
-            .name =3D "throttling.iops-read-max",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "I/O operations read burst",\
         },{ \
-            .name =3D "throttling.iops-write-max",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "I/O operations write burst",\
         },{ \
-            .name =3D "throttling.bps-total-max",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "total bytes burst",\
         },{ \
-            .name =3D "throttling.bps-read-max",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "total bytes read burst",\
         },{ \
-            .name =3D "throttling.bps-write-max",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "total bytes write burst",\
         },{ \
-            .name =3D "throttling.iops-total-max-length",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENGTH=
,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "length of the iops-total-max burst period, in sec=
onds",\
         },{ \
-            .name =3D "throttling.iops-read-max-length",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGTH,=
\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "length of the iops-read-max burst period, in seco=
nds",\
         },{ \
-            .name =3D "throttling.iops-write-max-length",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENGTH=
,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "length of the iops-write-max burst period, in sec=
onds",\
         },{ \
-            .name =3D "throttling.bps-total-max-length",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGTH,=
\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "length of the bps-total-max burst period, in seco=
nds",\
         },{ \
-            .name =3D "throttling.bps-read-max-length",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "length of the bps-read-max burst period, in secon=
ds",\
         },{ \
-            .name =3D "throttling.bps-write-max-length",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGTH,=
\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "length of the bps-write-max burst period, in seco=
nds",\
         },{ \
-            .name =3D "throttling.iops-size",\
+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,\
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "when limiting by iops max size of an I/O in bytes=
",\
         }
--=20
2.11.0
