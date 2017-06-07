Received: from eggs.gnu.org ([2001:4830:134:3::10]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIagg-0003xZ-9R
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIagc-0004CZ-SZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:07:50 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:35434)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIagc-00046q-8q
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:07:46 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed,  7 Jun 2017 16:06:19 +0300
Message-Id: <20170607130619.1545-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, stefanha@gmail.com, Manos Pitsidianakis <el13635@mail.ntua.gr>

This is part of my work for my GSOC project this summer.=20

I am not sure if the count parameter in  bdrv_co_pwrite_zeros and=20
bdrv_co_pdiscard refers to sectors or bytes. Should this be handled diffe=
rently?

The driver can only be instantiated in the command line for now like in t=
he
following examples:
-drive driver=3Dthrottle,file.filename=3Dfoo.qcow2,iops-total=3D100,
iops-total-max=3D2000,iops-total-max-length=3D60,throttle-group=3Dfoobar
-drive driver=3Dthrottle,file.filename=3Dfoo.qcow2,iops-total=3D100,
throttle-group=3Dfoobar

This commit copies throttle group infrastructure from
block/throttle-groups.c to block/throttle.c to be used as a block filter
driver.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/Makefile.objs      |   1 +
 block/throttle.c         | 747 +++++++++++++++++++++++++++++++++++++++++=
++++++
 include/block/throttle.h |  59 ++++
 3 files changed, 807 insertions(+)
 create mode 100644 block/throttle.c
 create mode 100644 include/block/throttle.h

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
diff --git a/block/throttle.c b/block/throttle.c
new file mode 100644
index 0000000000..e4536a09ed
--- /dev/null
+++ b/block/throttle.c
@@ -0,0 +1,747 @@
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
+#include "sysemu/block-backend.h"
+#include "block/throttle-groups.h"
+#include "qemu/queue.h"
+#include "qemu/thread.h"
+#include "sysemu/qtest.h"
+#include "monitor/monitor.h"
+#include "qapi/error.h"
+#include "block/throttle.h"
+#include "qapi/qmp/qdict.h"
+
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
+
+static QemuMutex throttle_groups_lock;
+static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =3D
+    QTAILQ_HEAD_INITIALIZER(throttle_groups);
+
+static QemuOptsList throttle_opts =3D {
+    .name =3D "throttle",
+    .head =3D QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
+    .desc =3D {
+        {
+            .name =3D QEMU_OPT_IOPS_TOTAL,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-total",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_TOTAL_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-total-max",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-total-max-length",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_READ,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-read",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_READ_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-read-max",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_READ_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-read-max-length",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_WRITE,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-write",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_WRITE_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-write-max",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-write-max-length",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_TOTAL,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "trottling.bps-total",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_TOTAL_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "trottling.bps-total-max",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "trottling.bps-total-max-length",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_READ,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.bps-read",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_READ_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.bps-read-max",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_READ_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.bps-read-max-length",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_WRITE,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.bps-write",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_WRITE_MAX,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.bps-write-max",
+        },
+        {
+            .name =3D QEMU_OPT_BPS_WRITE_MAX_LENGTH,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.bps-write-max-length",
+        },
+        {
+            .name =3D QEMU_OPT_IOPS_SIZE,
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "throttling.iops-size",
+        },
+        {
+            .name =3D QEMU_OPT_THROTTLE_GROUP_NAME,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Throttle group name",
+        },
+            { /* end of list */ }
+        },
+};
+
+/* Return the next BDRVThrottleNodeState in the round-robin sequence,
+ * simulating a circular list.
+ *
+ * This assumes that tg->lock is held.
+ *
+ * @s: the current BlockDriverstate's BDRVThrottleNodeState
+ * @ret: the next BDRVThrottleNodeState in the sequence
+ */
+static BDRVThrottleNodeState *throttle_group_next_bds(BDRVThrottleNodeSt=
ate *s)
+{
+    ThrottleGroup *tg =3D s->throttle_group;
+    BDRVThrottleNodeState *next =3D QLIST_NEXT(s, round_robin);
+
+    if (!next) {
+        next =3D QLIST_FIRST(&tg->head);
+    }
+
+    return next;
+}
+
+/*
+ * Return whether a BlockDriverState has pending requests.
+ *
+ * This assumes that tg->lock is held.
+ *
+ * @s: the BlockDriverState's BDRVThrottleNodeState
+ * @is_write:  the type of operation (read/write)
+ * @ret:       whether the BDRVThrottleNodeState has pending requests.
+ */
+static inline bool bds_has_pending_reqs(BDRVThrottleNodeState *s,
+                                        bool is_write)
+{
+    return s->pending_reqs[is_write];
+}
+
+/* Return the next BlockDriverState in the round-robin sequence with pen=
ding
+ * I/O requests.
+ *
+ * This assumes that tg->lock is held.
+ *
+ * @bs:        the current BlockDriverState's BDRVThrottleNodeState
+ * @is_write:  the type of operation (read/write)
+ * @ret:       the next BDRVThrottleNodeState with pending requests, or =
bs if
+ * there is none.
+ */
+static BDRVThrottleNodeState *next_throttle_token(BDRVThrottleNodeState =
*s,
+                                                    bool is_write)
+{
+    ThrottleGroup *tg =3D s->throttle_group;
+    BDRVThrottleNodeState *token, *start;
+
+    start =3D token =3D tg->tokens[is_write];
+
+    /* get next bs round in round robin style */
+    token =3D throttle_group_next_bds(token);
+    while (token !=3D start && !bds_has_pending_reqs(token, is_write)) {
+        token =3D throttle_group_next_bds(token);
+    }
+
+    /* If no IO are queued for scheduling on the next round robin token
+     * then decide the token is the current bs because chances are
+     * the current bs get the current request queued.
+     */
+    if (token =3D=3D start && !bds_has_pending_reqs(token, is_write)) {
+        token =3D s;
+    }
+
+    /* Either we return the original BB, or one with pending requests */
+    assert(token =3D=3D s || bds_has_pending_reqs(token, is_write));
+
+    return token;
+}
+
+/* Increments the reference count of a ThrottleGroup given its name.
+ *
+ * If no ThrottleGroup is found with the given name a new one is
+ * created.
+ *
+ * @name: the name of the ThrottleGroup
+ * @ret:  the ThrottleState member of the ThrottleGroup
+ */
+static ThrottleState *bdrv_throttle_group_incref(const char *name)
+{
+    ThrottleGroup *tg =3D NULL;
+    ThrottleGroup *iter;
+
+    qemu_mutex_lock(&throttle_groups_lock);
+
+    /* Look for an existing group with that name */
+    QTAILQ_FOREACH(iter, &throttle_groups, list) {
+        if (!strcmp(name, iter->name)) {
+            tg =3D iter;
+            break;
+        }
+    }
+
+    /* Create a new one if not found */
+    if (!tg) {
+        tg =3D g_new0(ThrottleGroup, 1);
+        tg->name =3D g_strdup(name);
+        qemu_mutex_init(&tg->lock);
+        throttle_init(&tg->ts);
+        QLIST_INIT(&tg->head);
+
+        QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
+    }
+
+    tg->refcount++;
+
+    qemu_mutex_unlock(&throttle_groups_lock);
+
+    return &tg->ts;
+}
+
+/* Decrease the reference count of a ThrottleGroup.
+ *
+ * When the reference count reaches zero the ThrottleGroup is
+ * destroyed.
+ *
+ * @ts:  The ThrottleGroup to unref, given by its ThrottleState member
+ */
+static void bdrv_throttle_group_unref(ThrottleState *ts)
+{
+    ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
+
+    qemu_mutex_lock(&throttle_groups_lock);
+    if (--tg->refcount =3D=3D 0) {
+        QTAILQ_REMOVE(&throttle_groups, tg, list);
+        qemu_mutex_destroy(&tg->lock);
+        g_free(tg->name);
+        g_free(tg);
+    }
+    qemu_mutex_unlock(&throttle_groups_lock);
+}
+
+
+/* Check if the next I/O request for a BDRVThrottleNodeState needs to be
+ * throttled or not. If there's no timer set in this group, set one and
+ * update the token accordingly.
+ *
+ * This assumes that tg->lock is held.
+ *
+ * @s:        the current BDRVThrottleNodeState
+ * @is_write:   the type of operation (read/write)
+ * @ret:        whether the I/O request needs to be throttled or not
+ */
+static bool throttle_group_schedule_timer(BDRVThrottleNodeState *s,
+                                                    bool is_write)
+{
+    ThrottleGroup *tg =3D s->throttle_group;
+    ThrottleTimers *tt =3D &s->throttle_timers;
+    ThrottleState *ts =3D &tg->ts;
+    bool must_wait;
+
+    if (s->io_limits_disabled) {
+        return false;
+    }
+
+    /* Check if any of the timers in this group is already armed */
+    if (tg->any_timer_armed[is_write]) {
+        return true;
+    }
+
+    must_wait =3D throttle_schedule_timer(ts, tt, is_write);
+
+    /* If a timer just got armed, set s as the current token */
+    if (must_wait) {
+        tg->tokens[is_write] =3D s;
+        tg->any_timer_armed[is_write] =3D true;
+    }
+
+    return must_wait;
+}
+
+/* Look for the next pending I/O request and schedule it.
+ *
+ * This assumes that tg->lock is held.
+ *
+ * @bs:       the current BlockDriverState
+ * @is_write:  the type of operation (read/write)
+ */
+static void schedule_next_request(BlockDriverState *bs, bool is_write)
+{
+    BDRVThrottleNodeState *s =3D bs->opaque, *token =3D NULL;
+    ThrottleGroup *tg =3D s->throttle_group;
+    bool must_wait;
+
+    /* Check if there's any pending request to schedule next */
+    token =3D next_throttle_token(s, is_write);
+    if (!bds_has_pending_reqs(token, is_write)) {
+        return;
+    }
+
+    /* Set a timer for the request if it needs to be throttled */
+    must_wait =3D throttle_group_schedule_timer(token, is_write);
+
+    /* If it doesn't have to wait, queue it for immediate execution */
+    if (!must_wait) {
+        /* Give preference to requests from the current BDS */
+        if (qemu_in_coroutine() &&
+            qemu_co_queue_next(&s->throttled_reqs[is_write])) {
+            token =3D s;
+        } else {
+            ThrottleTimers *tt =3D &token->throttle_timers;
+            int64_t now =3D qemu_clock_get_ns(tt->clock_type);
+            timer_mod(tt->timers[is_write], now + 1);
+            tg->any_timer_armed[is_write] =3D true;
+        }
+        tg->tokens[is_write] =3D token;
+    }
+}
+
+/* ThrottleTimers callback. This wakes up a request that was waiting
+ * because it had been throttled.
+ *
+ * @bs:       the BlockDriverState whose request had been throttled
+ * @is_write:  the type of operation (read/write)
+ */
+static void timer_cb(BlockDriverState *bs, bool is_write)
+{
+    BDRVThrottleNodeState *s =3D bs->opaque;
+    ThrottleGroup *tg =3D s->throttle_group;
+    bool empty_queue;
+
+    /* The timer has just been fired, so we can update the flag */
+    qemu_mutex_lock(&tg->lock);
+    tg->any_timer_armed[is_write] =3D false;
+    qemu_mutex_unlock(&tg->lock);
+
+    /* Run the request that was waiting for this timer */
+    aio_context_acquire(bdrv_get_aio_context(bs));
+    empty_queue =3D !qemu_co_enter_next(&s->throttled_reqs[is_write]);
+    aio_context_release(bdrv_get_aio_context(bs));
+
+    /* If the request queue was empty then we have to take care of
+     * scheduling the next one */
+    if (empty_queue) {
+        qemu_mutex_lock(&tg->lock);
+        schedule_next_request(bs, is_write);
+        qemu_mutex_unlock(&tg->lock);
+    }
+}
+
+static void read_timer_cb(void *opaque)
+{
+    timer_cb(opaque, false);
+}
+
+static void write_timer_cb(void *opaque)
+{
+    timer_cb(opaque, true);
+}
+
+/* Unregister a BlockDriverState from its group, removing it from the li=
st,
+ * destroying the timers and setting the throttle_state pointer to NULL.
+ *
+ * The BlockDriverState must not have pending throttled requests, so the=
 caller
+ * has to drain them first.
+ *
+ * The group will be destroyed if it's empty after this operation.
+ *
+ * @bs: the BlockDriverState to remove
+ */
+static void throttle_node_unregister_bs(BlockDriverState *bs)
+{
+    BDRVThrottleNodeState *s =3D bs->opaque;
+    ThrottleGroup *tg =3D s->throttle_group;
+    int i;
+
+    assert(s->pending_reqs[0] =3D=3D 0 && s->pending_reqs[1] =3D=3D 0);
+    assert(qemu_co_queue_empty(&s->throttled_reqs[0]));
+    assert(qemu_co_queue_empty(&s->throttled_reqs[1]));
+
+    qemu_mutex_lock(&tg->lock);
+    for (i =3D 0; i < 2; i++) {
+        if (tg->tokens[i] =3D=3D s) {
+            BDRVThrottleNodeState *token =3D throttle_group_next_bds(s);
+            /* Take care of the case where this is the last BlockDriverS=
tate in
+             * the group */
+            if (token =3D=3D s) {
+                token =3D NULL;
+            }
+            tg->tokens[i] =3D token;
+        }
+    }
+
+    /* remove the current BDS from the list */
+    QLIST_REMOVE(s, round_robin);
+    throttle_timers_destroy(&s->throttle_timers);
+    qemu_mutex_unlock(&tg->lock);
+
+    bdrv_throttle_group_unref(&tg->ts);
+    s->throttle_state =3D NULL;
+}
+
+
+/* Register a BlockDriverState in the throttling group, also initializin=
g its
+ * timers and updating its throttle_state pointer to point to it. If a
+ * throttling group with that name does not exist yet, it will be create=
d.
+ *
+ * @bs:       the BlockDriverState to insert
+ * @groupname: the name of the group
+ */
+static void throttle_node_register_bs(BlockDriverState *bs,
+                                      const char *groupname)
+{
+    int i;
+    BDRVThrottleNodeState *s =3D bs->opaque;
+    ThrottleState *ts =3D bdrv_throttle_group_incref(groupname);
+    ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
+    int clock_type =3D QEMU_CLOCK_REALTIME;
+
+    if (qtest_enabled()) {
+        /* For testing block IO throttling only */
+        clock_type =3D QEMU_CLOCK_VIRTUAL;
+    }
+
+    s->throttle_state =3D ts;
+    s->throttle_group =3D tg;
+
+    qemu_mutex_lock(&tg->lock);
+    /* If the ThrottleGroup is new set this BlockDriverState as the toke=
n */
+    for (i =3D 0; i < 2; i++) {
+        if (!tg->tokens[i]) {
+            tg->tokens[i] =3D s;
+        }
+    }
+
+    QLIST_INSERT_HEAD(&tg->head, s, round_robin);
+    throttle_timers_init(&s->throttle_timers,
+                         bdrv_get_aio_context(bs),
+                         clock_type,
+                         read_timer_cb,
+                         write_timer_cb,
+                         bs);
+    qemu_mutex_unlock(&tg->lock);
+}
+
+static int throttle_open(BlockDriverState *bs, QDict *options,
+                            int flags, Error **errp)
+{
+    int ret =3D 0;
+    BDRVThrottleNodeState *s =3D bs->opaque;
+    Error *local_err =3D NULL;
+    QemuOpts *opts =3D NULL;
+    const char *groupname =3D NULL;
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
+        goto open_ret;
+    }
+
+    groupname =3D qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
+    if (!groupname) {
+        groupname =3D bdrv_get_device_or_node_name(bs);
+        if (!groupname) {
+            error_setg(&local_err,
+                       "A group name must be specified for this device."=
);
+            error_propagate(errp, local_err);
+            ret =3D -EINVAL;
+            goto open_ret;
+        }
+    }
+
+    throttle_node_register_bs(bs, groupname);
+    ThrottleConfig *throttle_cfg =3D &s->throttle_state->cfg;
+
+    throttle_config_init(throttle_cfg);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_READ, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE, 0);
+
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX, 0);
+
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
+        qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
+
+    throttle_cfg->op_size =3D
+        qemu_opt_get_number(opts, QEMU_OPT_IOPS_SIZE, 0);
+
+    if (!throttle_is_valid(throttle_cfg, &local_err)) {
+        error_propagate(errp, local_err);
+        throttle_node_unregister_bs(bs);
+        ret =3D -EINVAL;
+        goto open_ret;
+    }
+
+    qemu_co_queue_init(&s->throttled_reqs[0]);
+    qemu_co_queue_init(&s->throttled_reqs[1]);
+
+    throttle_timers_attach_aio_context(&s->throttle_timers,
+                                       bdrv_get_aio_context(bs));
+
+open_ret:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static void throttle_close(BlockDriverState *bs)
+{
+    throttle_node_unregister_bs(bs);
+    return;
+}
+
+
+static int64_t throttle_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);;
+}
+
+/* Check if an I/O request needs to be throttled, wait and set a timer
+ * if necessary, and schedule the next request using a round robin
+ * algorithm.
+ *
+ * @bs:       the current BlockDriverState
+ * @bytes:     the number of bytes for this I/O
+ * @is_write:  the type of operation (read/write)
+ */
+static void coroutine_fn throttle_co_io_limits_intercept(BlockDriverStat=
e *bs,
+                                                    unsigned int bytes,
+                                                    bool is_write)
+{
+    bool must_wait;
+    BDRVThrottleNodeState *s =3D bs->opaque, *token;
+    ThrottleGroup *tg =3D s->throttle_group;
+    qemu_mutex_lock(&tg->lock);
+
+    /* First we check if this I/O has to be throttled. */
+    token =3D next_throttle_token(s, is_write);
+    must_wait =3D throttle_group_schedule_timer(token, is_write);
+
+    /* Wait if there's a timer set or queued requests of this type */
+    if (must_wait || s->pending_reqs[is_write]) {
+        s->pending_reqs[is_write]++;
+        qemu_mutex_unlock(&tg->lock);
+        qemu_co_queue_wait(&s->throttled_reqs[is_write], NULL);
+        qemu_mutex_lock(&tg->lock);
+        s->pending_reqs[is_write]--;
+    }
+
+    /* The I/O will be executed, so do the accounting */
+    throttle_account(s->throttle_state, is_write, bytes);
+
+    /* Schedule the next request */
+    schedule_next_request(bs, is_write);
+
+    qemu_mutex_unlock(&tg->lock);
+}
+
+static int coroutine_fn throttle_co_preadv(BlockDriverState *bs, uint64_=
t offset,
+                                            uint64_t bytes, QEMUIOVector=
 *qiov,
+                                            int flags)
+{
+
+    throttle_co_io_limits_intercept(bs, bytes, false);
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
+    throttle_co_io_limits_intercept(bs, bytes, true);
+
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int count, BdrvRequestFlags flags)
+{
+    throttle_co_io_limits_intercept(bs, count, true);
+
+    return bdrv_co_pwrite_zeroes(bs->file, offset, count, flags);
+}
+
+static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
+        int64_t offset, int count)
+{
+    throttle_co_io_limits_intercept(bs, count, true);
+
+    return bdrv_co_pdiscard(bs->file->bs, offset, count);
+}
+
+static int throttle_co_flush(BlockDriverState *bs)
+{
+    return bdrv_co_flush(bs->file->bs);
+}
+
+static void throttle_detach_aio_context(BlockDriverState *bs)
+{
+    BDRVThrottleNodeState *s =3D bs->opaque;
+    throttle_timers_detach_aio_context(&s->throttle_timers);
+}
+
+static void throttle_attach_aio_context(BlockDriverState *bs,
+                                    AioContext *new_context)
+{
+    BDRVThrottleNodeState *s =3D bs->opaque;
+    throttle_timers_attach_aio_context(&s->throttle_timers, new_context)=
;
+}
+static BlockDriver bdrv_throttle =3D {
+    .format_name                        =3D   "throttle",
+    .protocol_name                      =3D   "throttle",
+    .instance_size                      =3D   sizeof(BDRVThrottleNodeSta=
te),
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
+    .is_filter                          =3D true,
+};
+
+static void bdrv_throttle_init(void)
+{
+    qemu_mutex_init(&throttle_groups_lock);
+    bdrv_register(&bdrv_throttle);
+}
+
+block_init(bdrv_throttle_init);
diff --git a/include/block/throttle.h b/include/block/throttle.h
new file mode 100644
index 0000000000..fed24f02a6
--- /dev/null
+++ b/include/block/throttle.h
@@ -0,0 +1,59 @@
+/* The ThrottleGroup structure (with its ThrottleState) is shared
+ * among different BlockDriverStates and it's independent from
+ * AioContext, so in order to use it from different threads it needs
+ * its own locking.
+ *
+ * This locking is however handled internally in block/throttle.c so it'=
s
+ * transparent to outside users.
+ *
+ * The whole ThrottleGroup structure is private and invisible to
+ * outside users, that only use it through its ThrottleState.
+ *
+ * In addition to the ThrottleGroup structure, BlockDriverState has
+ * fields that need to be accessed by other members of the group and
+ * therefore also need to be protected by this lock. Once a
+ * BlockDriverState is registered in a group those fields can be accesse=
d
+ * by other threads any time.
+ *
+ * Again, all this is handled internally in block/throttle.c and is most=
ly
+ * transparent to the outside. The 'throttle_timers' field however has a=
n
+ * additional constraint because it may be temporarily invalid (see for =
example
+ * bdrv_set_aio_context()). Therefore block/throttle.c will access some
+ * other BlockDriverState's timers only after verifying that that BDS ha=
s
+ * throttled requests in the queue.
+ */
+
+typedef struct ThrottleGroup {
+    char *name; /* This is constant during the lifetime of the group */
+
+    QemuMutex lock; /* This lock protects the following four fields */
+    ThrottleState ts;
+    QLIST_HEAD(, BDRVThrottleNodeState) head;
+    struct BDRVThrottleNodeState *tokens[2];
+    bool any_timer_armed[2];
+
+    /* These two are protected by the global throttle_groups_lock */
+    unsigned refcount;
+    QTAILQ_ENTRY(ThrottleGroup) list;
+} ThrottleGroup;
+
+typedef struct BDRVThrottleNodeState {
+    ThrottleGroup *throttle_group;
+
+    /* I/O throttling has its own locking, but also some fields are
+     * protected by the AioContext lock.
+     */
+
+    /* Protected by AioContext lock.  */
+    CoQueue      throttled_reqs[2];
+
+    /* Nonzero if the I/O limits are currently being ignored; generally
+     * it is zero.  */
+    unsigned int io_limits_disabled;
+
+    ThrottleState *throttle_state;
+    ThrottleTimers throttle_timers;
+    unsigned       pending_reqs[2];
+    QLIST_ENTRY(BDRVThrottleNodeState) round_robin;
+
+} BDRVThrottleNodeState;
--=20
2.11.0
