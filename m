Received: from eggs.gnu.org ([2001:4830:134:3::10]:35282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNk-0005pH-PH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNg-0002vz-W4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:54:59 +0100
Message-Id: <1489416908-3771-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/12] block: Drop unmaintained 'archipelago'
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The driver has failed to build since commit da34e65, in qemu 2.6,
due to a missing include of qapi/error.h for error_setg().
Since no one has complained in three releases, it is easier to
remove the dead code than to keep it around, especially since it
is not being built by default and therefore prone to bitrot.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 MAINTAINERS                      |    8 -
 block/Makefile.objs              |    2 -
 block/archipelago.c              | 1079 --------------------------------------
 configure                        |   43 --
 qapi/block-core.json             |   33 +-
 tests/qemu-iotests/025           |    2 +-
 tests/qemu-iotests/common        |    6 -
 tests/qemu-iotests/common.filter |    4 +-
 tests/qemu-iotests/common.rc     |    8 -
 9 files changed, 4 insertions(+), 1181 deletions(-)
 delete mode 100644 block/archipelago.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e3edd04..bf1aafb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1674,14 +1674,6 @@ S: Supported
 F: block/ssh.c
 T: git git://github.com/codyprime/qemu-kvm-jtc.git block
 
-ARCHIPELAGO
-M: Chrysostomos Nanakos <chris@include.gr>
-M: Jeff Cody <jcody@redhat.com>
-L: qemu-block@nongnu.org
-S: Maintained
-F: block/archipelago.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
-
 CURL
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
diff --git a/block/Makefile.objs b/block/Makefile.objs
index c6bd14e..de96f8ee 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -19,7 +19,6 @@ block-obj-$(CONFIG_LIBNFS) += nfs.o
 block-obj-$(CONFIG_CURL) += curl.o
 block-obj-$(CONFIG_RBD) += rbd.o
 block-obj-$(CONFIG_GLUSTERFS) += gluster.o
-block-obj-$(CONFIG_ARCHIPELAGO) += archipelago.o
 block-obj-$(CONFIG_LIBSSH2) += ssh.o
 block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
@@ -41,7 +40,6 @@ gluster.o-cflags   := $(GLUSTERFS_CFLAGS)
 gluster.o-libs     := $(GLUSTERFS_LIBS)
 ssh.o-cflags       := $(LIBSSH2_CFLAGS)
 ssh.o-libs         := $(LIBSSH2_LIBS)
-archipelago.o-libs := $(ARCHIPELAGO_LIBS)
 block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
 dmg-bz2.o-libs     := $(BZIP2_LIBS)
 qcow.o-libs        := -lz
diff --git a/block/archipelago.c b/block/archipelago.c
deleted file mode 100644
index 2449cfc..0000000
--- a/block/archipelago.c
+++ /dev/null
@@ -1,1079 +0,0 @@
-/*
- * QEMU Block driver for Archipelago
- *
- * Copyright (C) 2014 Chrysostomos Nanakos <cnanakos@grnet.gr>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-/*
- * VM Image on Archipelago volume is specified like this:
- *
- * file.driver=archipelago,file.volume=<volumename>
- * [,file.mport=<mapperd_port>[,file.vport=<vlmcd_port>]
- * [,file.segment=<segment_name>]]
- *
- * or
- *
- * file=archipelago:<volumename>[/mport=<mapperd_port>[:vport=<vlmcd_port>][:
- * segment=<segment_name>]]
- *
- * 'archipelago' is the protocol.
- *
- * 'mport' is the port number on which mapperd is listening. This is optional
- * and if not specified, QEMU will make Archipelago to use the default port.
- *
- * 'vport' is the port number on which vlmcd is listening. This is optional
- * and if not specified, QEMU will make Archipelago to use the default port.
- *
- * 'segment' is the name of the shared memory segment Archipelago stack
- * is using. This is optional and if not specified, QEMU will make Archipelago
- * to use the default value, 'archipelago'.
- *
- * Examples:
- *
- * file.driver=archipelago,file.volume=my_vm_volume
- * file.driver=archipelago,file.volume=my_vm_volume,file.mport=123
- * file.driver=archipelago,file.volume=my_vm_volume,file.mport=123,
- *  file.vport=1234
- * file.driver=archipelago,file.volume=my_vm_volume,file.mport=123,
- *  file.vport=1234,file.segment=my_segment
- *
- * or
- *
- * file=archipelago:my_vm_volume
- * file=archipelago:my_vm_volume/mport=123
- * file=archipelago:my_vm_volume/mport=123:vport=1234
- * file=archipelago:my_vm_volume/mport=123:vport=1234:segment=my_segment
- *
- */
-
-#include "qemu/osdep.h"
-#include "qemu/cutils.h"
-#include "block/block_int.h"
-#include "qemu/error-report.h"
-#include "qemu/thread.h"
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
-#include "qemu/atomic.h"
-
-#include <xseg/xseg.h>
-#include <xseg/protocol.h>
-
-#define MAX_REQUEST_SIZE    524288
-
-#define ARCHIPELAGO_OPT_VOLUME      "volume"
-#define ARCHIPELAGO_OPT_SEGMENT     "segment"
-#define ARCHIPELAGO_OPT_MPORT       "mport"
-#define ARCHIPELAGO_OPT_VPORT       "vport"
-#define ARCHIPELAGO_DFL_MPORT       1001
-#define ARCHIPELAGO_DFL_VPORT       501
-
-#define archipelagolog(fmt, ...) \
-    do {                         \
-        fprintf(stderr, "archipelago\t%-24s: " fmt, __func__, ##__VA_ARGS__); \
-    } while (0)
-
-typedef enum {
-    ARCHIP_OP_READ,
-    ARCHIP_OP_WRITE,
-    ARCHIP_OP_FLUSH,
-    ARCHIP_OP_VOLINFO,
-    ARCHIP_OP_TRUNCATE,
-} ARCHIPCmd;
-
-typedef struct ArchipelagoAIOCB {
-    BlockAIOCB common;
-    struct BDRVArchipelagoState *s;
-    QEMUIOVector *qiov;
-    ARCHIPCmd cmd;
-    int status;
-    int64_t size;
-    int64_t ret;
-} ArchipelagoAIOCB;
-
-typedef struct BDRVArchipelagoState {
-    ArchipelagoAIOCB *event_acb;
-    char *volname;
-    char *segment_name;
-    uint64_t size;
-    /* Archipelago specific */
-    struct xseg *xseg;
-    struct xseg_port *port;
-    xport srcport;
-    xport sport;
-    xport mportno;
-    xport vportno;
-    QemuMutex archip_mutex;
-    QemuCond archip_cond;
-    bool is_signaled;
-    /* Request handler specific */
-    QemuThread request_th;
-    QemuCond request_cond;
-    QemuMutex request_mutex;
-    bool th_is_signaled;
-    bool stopping;
-} BDRVArchipelagoState;
-
-typedef struct ArchipelagoSegmentedRequest {
-    size_t count;
-    size_t total;
-    int ref;
-    int failed;
-} ArchipelagoSegmentedRequest;
-
-typedef struct AIORequestData {
-    const char *volname;
-    off_t offset;
-    size_t size;
-    uint64_t bufidx;
-    int ret;
-    int op;
-    ArchipelagoAIOCB *aio_cb;
-    ArchipelagoSegmentedRequest *segreq;
-} AIORequestData;
-
-static void qemu_archipelago_complete_aio(void *opaque);
-
-static void init_local_signal(struct xseg *xseg, xport sport, xport srcport)
-{
-    if (xseg && (sport != srcport)) {
-        xseg_init_local_signal(xseg, srcport);
-        sport = srcport;
-    }
-}
-
-static void archipelago_finish_aiocb(AIORequestData *reqdata)
-{
-    if (reqdata->aio_cb->ret != reqdata->segreq->total) {
-        reqdata->aio_cb->ret = -EIO;
-    } else if (reqdata->aio_cb->ret == reqdata->segreq->total) {
-        reqdata->aio_cb->ret = 0;
-    }
-    aio_bh_schedule_oneshot(
-                        bdrv_get_aio_context(reqdata->aio_cb->common.bs),
-                        qemu_archipelago_complete_aio, reqdata
-                        );
-}
-
-static int wait_reply(struct xseg *xseg, xport srcport, struct xseg_port *port,
-                      struct xseg_request *expected_req)
-{
-    struct xseg_request *req;
-    xseg_prepare_wait(xseg, srcport);
-    void *psd = xseg_get_signal_desc(xseg, port);
-    while (1) {
-        req = xseg_receive(xseg, srcport, X_NONBLOCK);
-        if (req) {
-            if (req != expected_req) {
-                archipelagolog("Unknown received request\n");
-                xseg_put_request(xseg, req, srcport);
-            } else if (!(req->state & XS_SERVED)) {
-                return -1;
-            } else {
-                break;
-            }
-        }
-        xseg_wait_signal(xseg, psd, 100000UL);
-    }
-    xseg_cancel_wait(xseg, srcport);
-    return 0;
-}
-
-static void xseg_request_handler(void *state)
-{
-    BDRVArchipelagoState *s = (BDRVArchipelagoState *) state;
-    void *psd = xseg_get_signal_desc(s->xseg, s->port);
-    qemu_mutex_lock(&s->request_mutex);
-
-    while (!s->stopping) {
-        struct xseg_request *req;
-        void *data;
-        xseg_prepare_wait(s->xseg, s->srcport);
-        req = xseg_receive(s->xseg, s->srcport, X_NONBLOCK);
-        if (req) {
-            AIORequestData *reqdata;
-            ArchipelagoSegmentedRequest *segreq;
-            xseg_get_req_data(s->xseg, req, (void **)&reqdata);
-
-            switch (reqdata->op) {
-            case ARCHIP_OP_READ:
-                data = xseg_get_data(s->xseg, req);
-                segreq = reqdata->segreq;
-                segreq->count += req->serviced;
-
-                qemu_iovec_from_buf(reqdata->aio_cb->qiov, reqdata->bufidx,
-                                    data,
-                                    req->serviced);
-
-                xseg_put_request(s->xseg, req, s->srcport);
-
-                if (atomic_fetch_dec(&segreq->ref) == 1) {
-                    if (!segreq->failed) {
-                        reqdata->aio_cb->ret = segreq->count;
-                        archipelago_finish_aiocb(reqdata);
-                        g_free(segreq);
-                    } else {
-                        g_free(segreq);
-                        g_free(reqdata);
-                    }
-                } else {
-                    g_free(reqdata);
-                }
-                break;
-            case ARCHIP_OP_WRITE:
-            case ARCHIP_OP_FLUSH:
-                segreq = reqdata->segreq;
-                segreq->count += req->serviced;
-                xseg_put_request(s->xseg, req, s->srcport);
-
-                if (atomic_fetch_dec(&segreq->ref) == 1) {
-                    if (!segreq->failed) {
-                        reqdata->aio_cb->ret = segreq->count;
-                        archipelago_finish_aiocb(reqdata);
-                        g_free(segreq);
-                    } else {
-                        g_free(segreq);
-                        g_free(reqdata);
-                    }
-                } else {
-                    g_free(reqdata);
-                }
-                break;
-            case ARCHIP_OP_VOLINFO:
-            case ARCHIP_OP_TRUNCATE:
-                s->is_signaled = true;
-                qemu_cond_signal(&s->archip_cond);
-                break;
-            }
-        } else {
-            xseg_wait_signal(s->xseg, psd, 100000UL);
-        }
-        xseg_cancel_wait(s->xseg, s->srcport);
-    }
-
-    s->th_is_signaled = true;
-    qemu_cond_signal(&s->request_cond);
-    qemu_mutex_unlock(&s->request_mutex);
-    qemu_thread_exit(NULL);
-}
-
-static int qemu_archipelago_xseg_init(BDRVArchipelagoState *s)
-{
-    if (xseg_initialize()) {
-        archipelagolog("Cannot initialize XSEG\n");
-        goto err_exit;
-    }
-
-    s->xseg = xseg_join("posix", s->segment_name,
-                        "posixfd", NULL);
-    if (!s->xseg) {
-        archipelagolog("Cannot join XSEG shared memory segment\n");
-        goto err_exit;
-    }
-    s->port = xseg_bind_dynport(s->xseg);
-    s->srcport = s->port->portno;
-    init_local_signal(s->xseg, s->sport, s->srcport);
-    return 0;
-
-err_exit:
-    return -1;
-}
-
-static int qemu_archipelago_init(BDRVArchipelagoState *s)
-{
-    int ret;
-
-    ret = qemu_archipelago_xseg_init(s);
-    if (ret < 0) {
-        error_report("Cannot initialize XSEG. Aborting...");
-        goto err_exit;
-    }
-
-    qemu_cond_init(&s->archip_cond);
-    qemu_mutex_init(&s->archip_mutex);
-    qemu_cond_init(&s->request_cond);
-    qemu_mutex_init(&s->request_mutex);
-    s->th_is_signaled = false;
-    qemu_thread_create(&s->request_th, "xseg_io_th",
-                       (void *) xseg_request_handler,
-                       (void *) s, QEMU_THREAD_JOINABLE);
-
-err_exit:
-    return ret;
-}
-
-static void qemu_archipelago_complete_aio(void *opaque)
-{
-    AIORequestData *reqdata = (AIORequestData *) opaque;
-    ArchipelagoAIOCB *aio_cb = (ArchipelagoAIOCB *) reqdata->aio_cb;
-
-    aio_cb->common.cb(aio_cb->common.opaque, aio_cb->ret);
-    aio_cb->status = 0;
-
-    qemu_aio_unref(aio_cb);
-    g_free(reqdata);
-}
-
-static void xseg_find_port(char *pstr, const char *needle, xport *aport)
-{
-    const char *a;
-    char *endptr = NULL;
-    unsigned long port;
-    if (strstart(pstr, needle, &a)) {
-        if (strlen(a) > 0) {
-            port = strtoul(a, &endptr, 10);
-            if (strlen(endptr)) {
-                *aport = -2;
-                return;
-            }
-            *aport = (xport) port;
-        }
-    }
-}
-
-static void xseg_find_segment(char *pstr, const char *needle,
-                              char **segment_name)
-{
-    const char *a;
-    if (strstart(pstr, needle, &a)) {
-        if (strlen(a) > 0) {
-            *segment_name = g_strdup(a);
-        }
-    }
-}
-
-static void parse_filename_opts(const char *filename, Error **errp,
-                                char **volume, char **segment_name,
-                                xport *mport, xport *vport)
-{
-    const char *start;
-    char *tokens[4], *ds;
-    int idx;
-    xport lmport = NoPort, lvport = NoPort;
-
-    strstart(filename, "archipelago:", &start);
-
-    ds = g_strdup(start);
-    tokens[0] = strtok(ds, "/");
-    tokens[1] = strtok(NULL, ":");
-    tokens[2] = strtok(NULL, ":");
-    tokens[3] = strtok(NULL, "\0");
-
-    if (!strlen(tokens[0])) {
-        error_setg(errp, "volume name must be specified first");
-        g_free(ds);
-        return;
-    }
-
-    for (idx = 1; idx < 4; idx++) {
-        if (tokens[idx] != NULL) {
-            if (strstart(tokens[idx], "mport=", NULL)) {
-                xseg_find_port(tokens[idx], "mport=", &lmport);
-            }
-            if (strstart(tokens[idx], "vport=", NULL)) {
-                xseg_find_port(tokens[idx], "vport=", &lvport);
-            }
-            if (strstart(tokens[idx], "segment=", NULL)) {
-                xseg_find_segment(tokens[idx], "segment=", segment_name);
-            }
-        }
-    }
-
-    if ((lmport == -2) || (lvport == -2)) {
-        error_setg(errp, "mport and/or vport must be set");
-        g_free(ds);
-        return;
-    }
-    *volume = g_strdup(tokens[0]);
-    *mport = lmport;
-    *vport = lvport;
-    g_free(ds);
-}
-
-static void archipelago_parse_filename(const char *filename, QDict *options,
-                                       Error **errp)
-{
-    const char *start;
-    char *volume = NULL, *segment_name = NULL;
-    xport mport = NoPort, vport = NoPort;
-
-    if (qdict_haskey(options, ARCHIPELAGO_OPT_VOLUME)
-            || qdict_haskey(options, ARCHIPELAGO_OPT_SEGMENT)
-            || qdict_haskey(options, ARCHIPELAGO_OPT_MPORT)
-            || qdict_haskey(options, ARCHIPELAGO_OPT_VPORT)) {
-        error_setg(errp, "volume/mport/vport/segment and a file name may not"
-                         " be specified at the same time");
-        return;
-    }
-
-    if (!strstart(filename, "archipelago:", &start)) {
-        error_setg(errp, "File name must start with 'archipelago:'");
-        return;
-    }
-
-    if (!strlen(start) || strstart(start, "/", NULL)) {
-        error_setg(errp, "volume name must be specified");
-        return;
-    }
-
-    parse_filename_opts(filename, errp, &volume, &segment_name, &mport, &vport);
-
-    if (volume) {
-        qdict_put(options, ARCHIPELAGO_OPT_VOLUME, qstring_from_str(volume));
-        g_free(volume);
-    }
-    if (segment_name) {
-        qdict_put(options, ARCHIPELAGO_OPT_SEGMENT,
-                  qstring_from_str(segment_name));
-        g_free(segment_name);
-    }
-    if (mport != NoPort) {
-        qdict_put(options, ARCHIPELAGO_OPT_MPORT, qint_from_int(mport));
-    }
-    if (vport != NoPort) {
-        qdict_put(options, ARCHIPELAGO_OPT_VPORT, qint_from_int(vport));
-    }
-}
-
-static QemuOptsList archipelago_runtime_opts = {
-    .name = "archipelago",
-    .head = QTAILQ_HEAD_INITIALIZER(archipelago_runtime_opts.head),
-    .desc = {
-        {
-            .name = ARCHIPELAGO_OPT_VOLUME,
-            .type = QEMU_OPT_STRING,
-            .help = "Name of the volume image",
-        },
-        {
-            .name = ARCHIPELAGO_OPT_SEGMENT,
-            .type = QEMU_OPT_STRING,
-            .help = "Name of the Archipelago shared memory segment",
-        },
-        {
-            .name = ARCHIPELAGO_OPT_MPORT,
-            .type = QEMU_OPT_NUMBER,
-            .help = "Archipelago mapperd port number"
-        },
-        {
-            .name = ARCHIPELAGO_OPT_VPORT,
-            .type = QEMU_OPT_NUMBER,
-            .help = "Archipelago vlmcd port number"
-
-        },
-        { /* end of list */ }
-    },
-};
-
-static int qemu_archipelago_open(BlockDriverState *bs,
-                                 QDict *options,
-                                 int bdrv_flags,
-                                 Error **errp)
-{
-    int ret = 0;
-    const char *volume, *segment_name;
-    QemuOpts *opts;
-    Error *local_err = NULL;
-    BDRVArchipelagoState *s = bs->opaque;
-
-    opts = qemu_opts_create(&archipelago_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto err_exit;
-    }
-
-    s->mportno = qemu_opt_get_number(opts, ARCHIPELAGO_OPT_MPORT,
-                                     ARCHIPELAGO_DFL_MPORT);
-    s->vportno = qemu_opt_get_number(opts, ARCHIPELAGO_OPT_VPORT,
-                                     ARCHIPELAGO_DFL_VPORT);
-
-    segment_name = qemu_opt_get(opts, ARCHIPELAGO_OPT_SEGMENT);
-    if (segment_name == NULL) {
-        s->segment_name = g_strdup("archipelago");
-    } else {
-        s->segment_name = g_strdup(segment_name);
-    }
-
-    volume = qemu_opt_get(opts, ARCHIPELAGO_OPT_VOLUME);
-    if (volume == NULL) {
-        error_setg(errp, "archipelago block driver requires the 'volume'"
-                   " option");
-        ret = -EINVAL;
-        goto err_exit;
-    }
-    s->volname = g_strdup(volume);
-
-    /* Initialize XSEG, join shared memory segment */
-    ret = qemu_archipelago_init(s);
-    if (ret < 0) {
-        error_setg(errp, "cannot initialize XSEG and join shared "
-                   "memory segment");
-        goto err_exit;
-    }
-
-    qemu_opts_del(opts);
-    return 0;
-
-err_exit:
-    g_free(s->volname);
-    g_free(s->segment_name);
-    qemu_opts_del(opts);
-    return ret;
-}
-
-static void qemu_archipelago_close(BlockDriverState *bs)
-{
-    int r, targetlen;
-    char *target;
-    struct xseg_request *req;
-    BDRVArchipelagoState *s = bs->opaque;
-
-    s->stopping = true;
-
-    qemu_mutex_lock(&s->request_mutex);
-    while (!s->th_is_signaled) {
-        qemu_cond_wait(&s->request_cond,
-                       &s->request_mutex);
-    }
-    qemu_mutex_unlock(&s->request_mutex);
-    qemu_thread_join(&s->request_th);
-    qemu_cond_destroy(&s->request_cond);
-    qemu_mutex_destroy(&s->request_mutex);
-
-    qemu_cond_destroy(&s->archip_cond);
-    qemu_mutex_destroy(&s->archip_mutex);
-
-    targetlen = strlen(s->volname);
-    req = xseg_get_request(s->xseg, s->srcport, s->vportno, X_ALLOC);
-    if (!req) {
-        archipelagolog("Cannot get XSEG request\n");
-        goto err_exit;
-    }
-    r = xseg_prep_request(s->xseg, req, targetlen, 0);
-    if (r < 0) {
-        xseg_put_request(s->xseg, req, s->srcport);
-        archipelagolog("Cannot prepare XSEG close request\n");
-        goto err_exit;
-    }
-
-    target = xseg_get_target(s->xseg, req);
-    memcpy(target, s->volname, targetlen);
-    req->size = req->datalen;
-    req->offset = 0;
-    req->op = X_CLOSE;
-
-    xport p = xseg_submit(s->xseg, req, s->srcport, X_ALLOC);
-    if (p == NoPort) {
-        xseg_put_request(s->xseg, req, s->srcport);
-        archipelagolog("Cannot submit XSEG close request\n");
-        goto err_exit;
-    }
-
-    xseg_signal(s->xseg, p);
-    wait_reply(s->xseg, s->srcport, s->port, req);
-
-    xseg_put_request(s->xseg, req, s->srcport);
-
-err_exit:
-    g_free(s->volname);
-    g_free(s->segment_name);
-    xseg_quit_local_signal(s->xseg, s->srcport);
-    xseg_leave_dynport(s->xseg, s->port);
-    xseg_leave(s->xseg);
-}
-
-static int qemu_archipelago_create_volume(Error **errp, const char *volname,
-                                          char *segment_name,
-                                          uint64_t size, xport mportno,
-                                          xport vportno)
-{
-    int ret, targetlen;
-    struct xseg *xseg = NULL;
-    struct xseg_request *req;
-    struct xseg_request_clone *xclone;
-    struct xseg_port *port;
-    xport srcport = NoPort, sport = NoPort;
-    char *target;
-
-    /* Try default values if none has been set */
-    if (mportno == (xport) -1) {
-        mportno = ARCHIPELAGO_DFL_MPORT;
-    }
-
-    if (vportno == (xport) -1) {
-        vportno = ARCHIPELAGO_DFL_VPORT;
-    }
-
-    if (xseg_initialize()) {
-        error_setg(errp, "Cannot initialize XSEG");
-        return -1;
-    }
-
-    xseg = xseg_join("posix", segment_name,
-                     "posixfd", NULL);
-
-    if (!xseg) {
-        error_setg(errp, "Cannot join XSEG shared memory segment");
-        return -1;
-    }
-
-    port = xseg_bind_dynport(xseg);
-    srcport = port->portno;
-    init_local_signal(xseg, sport, srcport);
-
-    req = xseg_get_request(xseg, srcport, mportno, X_ALLOC);
-    if (!req) {
-        error_setg(errp, "Cannot get XSEG request");
-        return -1;
-    }
-
-    targetlen = strlen(volname);
-    ret = xseg_prep_request(xseg, req, targetlen,
-                            sizeof(struct xseg_request_clone));
-    if (ret < 0) {
-        error_setg(errp, "Cannot prepare XSEG request");
-        goto err_exit;
-    }
-
-    target = xseg_get_target(xseg, req);
-    if (!target) {
-        error_setg(errp, "Cannot get XSEG target.");
-        goto err_exit;
-    }
-    memcpy(target, volname, targetlen);
-    xclone = (struct xseg_request_clone *) xseg_get_data(xseg, req);
-    memset(xclone->target, 0 , XSEG_MAX_TARGETLEN);
-    xclone->targetlen = 0;
-    xclone->size = size;
-    req->offset = 0;
-    req->size = req->datalen;
-    req->op = X_CLONE;
-
-    xport p = xseg_submit(xseg, req, srcport, X_ALLOC);
-    if (p == NoPort) {
-        error_setg(errp, "Could not submit XSEG request");
-        goto err_exit;
-    }
-    xseg_signal(xseg, p);
-
-    ret = wait_reply(xseg, srcport, port, req);
-    if (ret < 0) {
-        error_setg(errp, "wait_reply() error.");
-    }
-
-    xseg_put_request(xseg, req, srcport);
-    xseg_quit_local_signal(xseg, srcport);
-    xseg_leave_dynport(xseg, port);
-    xseg_leave(xseg);
-    return ret;
-
-err_exit:
-    xseg_put_request(xseg, req, srcport);
-    xseg_quit_local_signal(xseg, srcport);
-    xseg_leave_dynport(xseg, port);
-    xseg_leave(xseg);
-    return -1;
-}
-
-static int qemu_archipelago_create(const char *filename,
-                                   QemuOpts *options,
-                                   Error **errp)
-{
-    int ret = 0;
-    uint64_t total_size = 0;
-    char *volname = NULL, *segment_name = NULL;
-    const char *start;
-    xport mport = NoPort, vport = NoPort;
-
-    if (!strstart(filename, "archipelago:", &start)) {
-        error_setg(errp, "File name must start with 'archipelago:'");
-        return -1;
-    }
-
-    if (!strlen(start) || strstart(start, "/", NULL)) {
-        error_setg(errp, "volume name must be specified");
-        return -1;
-    }
-
-    parse_filename_opts(filename, errp, &volname, &segment_name, &mport,
-                        &vport);
-    total_size = ROUND_UP(qemu_opt_get_size_del(options, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-
-    if (segment_name == NULL) {
-        segment_name = g_strdup("archipelago");
-    }
-
-    /* Create an Archipelago volume */
-    ret = qemu_archipelago_create_volume(errp, volname, segment_name,
-                                         total_size, mport,
-                                         vport);
-
-    g_free(volname);
-    g_free(segment_name);
-    return ret;
-}
-
-static const AIOCBInfo archipelago_aiocb_info = {
-    .aiocb_size = sizeof(ArchipelagoAIOCB),
-};
-
-static int archipelago_submit_request(BDRVArchipelagoState *s,
-                                        uint64_t bufidx,
-                                        size_t count,
-                                        off_t offset,
-                                        ArchipelagoAIOCB *aio_cb,
-                                        ArchipelagoSegmentedRequest *segreq,
-                                        int op)
-{
-    int ret, targetlen;
-    char *target;
-    void *data = NULL;
-    struct xseg_request *req;
-    AIORequestData *reqdata = g_new(AIORequestData, 1);
-
-    targetlen = strlen(s->volname);
-    req = xseg_get_request(s->xseg, s->srcport, s->vportno, X_ALLOC);
-    if (!req) {
-        archipelagolog("Cannot get XSEG request\n");
-        goto err_exit2;
-    }
-    ret = xseg_prep_request(s->xseg, req, targetlen, count);
-    if (ret < 0) {
-        archipelagolog("Cannot prepare XSEG request\n");
-        goto err_exit;
-    }
-    target = xseg_get_target(s->xseg, req);
-    if (!target) {
-        archipelagolog("Cannot get XSEG target\n");
-        goto err_exit;
-    }
-    memcpy(target, s->volname, targetlen);
-    req->size = count;
-    req->offset = offset;
-
-    switch (op) {
-    case ARCHIP_OP_READ:
-        req->op = X_READ;
-        break;
-    case ARCHIP_OP_WRITE:
-        req->op = X_WRITE;
-        break;
-    case ARCHIP_OP_FLUSH:
-        req->op = X_FLUSH;
-        break;
-    }
-    reqdata->volname = s->volname;
-    reqdata->offset = offset;
-    reqdata->size = count;
-    reqdata->bufidx = bufidx;
-    reqdata->aio_cb = aio_cb;
-    reqdata->segreq = segreq;
-    reqdata->op = op;
-
-    xseg_set_req_data(s->xseg, req, reqdata);
-    if (op == ARCHIP_OP_WRITE) {
-        data = xseg_get_data(s->xseg, req);
-        if (!data) {
-            archipelagolog("Cannot get XSEG data\n");
-            goto err_exit;
-        }
-        qemu_iovec_to_buf(aio_cb->qiov, bufidx, data, count);
-    }
-
-    xport p = xseg_submit(s->xseg, req, s->srcport, X_ALLOC);
-    if (p == NoPort) {
-        archipelagolog("Could not submit XSEG request\n");
-        goto err_exit;
-    }
-    xseg_signal(s->xseg, p);
-    return 0;
-
-err_exit:
-    g_free(reqdata);
-    xseg_put_request(s->xseg, req, s->srcport);
-    return -EIO;
-err_exit2:
-    g_free(reqdata);
-    return -EIO;
-}
-
-static int archipelago_aio_segmented_rw(BDRVArchipelagoState *s,
-                                        size_t count,
-                                        off_t offset,
-                                        ArchipelagoAIOCB *aio_cb,
-                                        int op)
-{
-    int ret, segments_nr;
-    size_t pos = 0;
-    ArchipelagoSegmentedRequest *segreq;
-
-    segreq = g_new0(ArchipelagoSegmentedRequest, 1);
-
-    if (op == ARCHIP_OP_FLUSH) {
-        segments_nr = 1;
-    } else {
-        segments_nr = (int)(count / MAX_REQUEST_SIZE) + \
-                      ((count % MAX_REQUEST_SIZE) ? 1 : 0);
-    }
-    segreq->total = count;
-    atomic_mb_set(&segreq->ref, segments_nr);
-
-    while (segments_nr > 1) {
-        ret = archipelago_submit_request(s, pos,
-                                            MAX_REQUEST_SIZE,
-                                            offset + pos,
-                                            aio_cb, segreq, op);
-
-        if (ret < 0) {
-            goto err_exit;
-        }
-        count -= MAX_REQUEST_SIZE;
-        pos += MAX_REQUEST_SIZE;
-        segments_nr--;
-    }
-    ret = archipelago_submit_request(s, pos, count, offset + pos,
-                                     aio_cb, segreq, op);
-
-    if (ret < 0) {
-        goto err_exit;
-    }
-    return 0;
-
-err_exit:
-    segreq->failed = 1;
-    if (atomic_fetch_sub(&segreq->ref, segments_nr) == segments_nr) {
-        g_free(segreq);
-    }
-    return ret;
-}
-
-static BlockAIOCB *qemu_archipelago_aio_rw(BlockDriverState *bs,
-                                           int64_t sector_num,
-                                           QEMUIOVector *qiov,
-                                           int nb_sectors,
-                                           BlockCompletionFunc *cb,
-                                           void *opaque,
-                                           int op)
-{
-    ArchipelagoAIOCB *aio_cb;
-    BDRVArchipelagoState *s = bs->opaque;
-    int64_t size, off;
-    int ret;
-
-    aio_cb = qemu_aio_get(&archipelago_aiocb_info, bs, cb, opaque);
-    aio_cb->cmd = op;
-    aio_cb->qiov = qiov;
-
-    aio_cb->ret = 0;
-    aio_cb->s = s;
-    aio_cb->status = -EINPROGRESS;
-
-    off = sector_num * BDRV_SECTOR_SIZE;
-    size = nb_sectors * BDRV_SECTOR_SIZE;
-    aio_cb->size = size;
-
-    ret = archipelago_aio_segmented_rw(s, size, off,
-                                       aio_cb, op);
-    if (ret < 0) {
-        goto err_exit;
-    }
-    return &aio_cb->common;
-
-err_exit:
-    error_report("qemu_archipelago_aio_rw(): I/O Error");
-    qemu_aio_unref(aio_cb);
-    return NULL;
-}
-
-static BlockAIOCB *qemu_archipelago_aio_readv(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque)
-{
-    return qemu_archipelago_aio_rw(bs, sector_num, qiov, nb_sectors, cb,
-                                   opaque, ARCHIP_OP_READ);
-}
-
-static BlockAIOCB *qemu_archipelago_aio_writev(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque)
-{
-    return qemu_archipelago_aio_rw(bs, sector_num, qiov, nb_sectors, cb,
-                                   opaque, ARCHIP_OP_WRITE);
-}
-
-static int64_t archipelago_volume_info(BDRVArchipelagoState *s)
-{
-    uint64_t size;
-    int ret, targetlen;
-    struct xseg_request *req;
-    struct xseg_reply_info *xinfo;
-    AIORequestData *reqdata = g_new(AIORequestData, 1);
-
-    const char *volname = s->volname;
-    targetlen = strlen(volname);
-    req = xseg_get_request(s->xseg, s->srcport, s->mportno, X_ALLOC);
-    if (!req) {
-        archipelagolog("Cannot get XSEG request\n");
-        goto err_exit2;
-    }
-    ret = xseg_prep_request(s->xseg, req, targetlen,
-                            sizeof(struct xseg_reply_info));
-    if (ret < 0) {
-        archipelagolog("Cannot prepare XSEG request\n");
-        goto err_exit;
-    }
-    char *target = xseg_get_target(s->xseg, req);
-    if (!target) {
-        archipelagolog("Cannot get XSEG target\n");
-        goto err_exit;
-    }
-    memcpy(target, volname, targetlen);
-    req->size = req->datalen;
-    req->offset = 0;
-    req->op = X_INFO;
-
-    reqdata->op = ARCHIP_OP_VOLINFO;
-    reqdata->volname = volname;
-    xseg_set_req_data(s->xseg, req, reqdata);
-
-    xport p = xseg_submit(s->xseg, req, s->srcport, X_ALLOC);
-    if (p == NoPort) {
-        archipelagolog("Cannot submit XSEG request\n");
-        goto err_exit;
-    }
-    xseg_signal(s->xseg, p);
-    qemu_mutex_lock(&s->archip_mutex);
-    while (!s->is_signaled) {
-        qemu_cond_wait(&s->archip_cond, &s->archip_mutex);
-    }
-    s->is_signaled = false;
-    qemu_mutex_unlock(&s->archip_mutex);
-
-    xinfo = (struct xseg_reply_info *) xseg_get_data(s->xseg, req);
-    size = xinfo->size;
-    xseg_put_request(s->xseg, req, s->srcport);
-    g_free(reqdata);
-    s->size = size;
-    return size;
-
-err_exit:
-    xseg_put_request(s->xseg, req, s->srcport);
-err_exit2:
-    g_free(reqdata);
-    return -EIO;
-}
-
-static int64_t qemu_archipelago_getlength(BlockDriverState *bs)
-{
-    BDRVArchipelagoState *s = bs->opaque;
-
-    return archipelago_volume_info(s);
-}
-
-static int qemu_archipelago_truncate(BlockDriverState *bs, int64_t offset)
-{
-    int ret, targetlen;
-    struct xseg_request *req;
-    BDRVArchipelagoState *s = bs->opaque;
-    AIORequestData *reqdata = g_new(AIORequestData, 1);
-
-    const char *volname = s->volname;
-    targetlen = strlen(volname);
-    req = xseg_get_request(s->xseg, s->srcport, s->mportno, X_ALLOC);
-    if (!req) {
-        archipelagolog("Cannot get XSEG request\n");
-        goto err_exit2;
-    }
-
-    ret = xseg_prep_request(s->xseg, req, targetlen, 0);
-    if (ret < 0) {
-        archipelagolog("Cannot prepare XSEG request\n");
-        goto err_exit;
-    }
-    char *target = xseg_get_target(s->xseg, req);
-    if (!target) {
-        archipelagolog("Cannot get XSEG target\n");
-        goto err_exit;
-    }
-    memcpy(target, volname, targetlen);
-    req->offset = offset;
-    req->op = X_TRUNCATE;
-
-    reqdata->op = ARCHIP_OP_TRUNCATE;
-    reqdata->volname = volname;
-
-    xseg_set_req_data(s->xseg, req, reqdata);
-
-    xport p = xseg_submit(s->xseg, req, s->srcport, X_ALLOC);
-    if (p == NoPort) {
-        archipelagolog("Cannot submit XSEG request\n");
-        goto err_exit;
-    }
-
-    xseg_signal(s->xseg, p);
-    qemu_mutex_lock(&s->archip_mutex);
-    while (!s->is_signaled) {
-        qemu_cond_wait(&s->archip_cond, &s->archip_mutex);
-    }
-    s->is_signaled = false;
-    qemu_mutex_unlock(&s->archip_mutex);
-    xseg_put_request(s->xseg, req, s->srcport);
-    g_free(reqdata);
-    return 0;
-
-err_exit:
-    xseg_put_request(s->xseg, req, s->srcport);
-err_exit2:
-    g_free(reqdata);
-    return -EIO;
-}
-
-static QemuOptsList qemu_archipelago_create_opts = {
-    .name = "archipelago-create-opts",
-    .head = QTAILQ_HEAD_INITIALIZER(qemu_archipelago_create_opts.head),
-    .desc = {
-        {
-            .name = BLOCK_OPT_SIZE,
-            .type = QEMU_OPT_SIZE,
-            .help = "Virtual disk size"
-        },
-        { /* end of list */ }
-    }
-};
-
-static BlockAIOCB *qemu_archipelago_aio_flush(BlockDriverState *bs,
-        BlockCompletionFunc *cb, void *opaque)
-{
-    return qemu_archipelago_aio_rw(bs, 0, NULL, 0, cb, opaque,
-                                   ARCHIP_OP_FLUSH);
-}
-
-static BlockDriver bdrv_archipelago = {
-    .format_name         = "archipelago",
-    .protocol_name       = "archipelago",
-    .instance_size       = sizeof(BDRVArchipelagoState),
-    .bdrv_parse_filename = archipelago_parse_filename,
-    .bdrv_file_open      = qemu_archipelago_open,
-    .bdrv_close          = qemu_archipelago_close,
-    .bdrv_create         = qemu_archipelago_create,
-    .bdrv_getlength      = qemu_archipelago_getlength,
-    .bdrv_truncate       = qemu_archipelago_truncate,
-    .bdrv_aio_readv      = qemu_archipelago_aio_readv,
-    .bdrv_aio_writev     = qemu_archipelago_aio_writev,
-    .bdrv_aio_flush      = qemu_archipelago_aio_flush,
-    .bdrv_has_zero_init  = bdrv_has_zero_init_1,
-    .create_opts         = &qemu_archipelago_create_opts,
-};
-
-static void bdrv_archipelago_init(void)
-{
-    bdrv_register(&bdrv_archipelago);
-}
-
-block_init(bdrv_archipelago_init);
diff --git a/configure b/configure
index 6c21975..b05c376 100755
--- a/configure
+++ b/configure
@@ -301,7 +301,6 @@ glusterfs=""
 glusterfs_xlator_opt="no"
 glusterfs_discard="no"
 glusterfs_zerofill="no"
-archipelago="no"
 gtk=""
 gtkabi=""
 gtk_gl="no"
@@ -1101,10 +1100,6 @@ for opt do
   ;;
   --enable-glusterfs) glusterfs="yes"
   ;;
-  --disable-archipelago) archipelago="no"
-  ;;
-  --enable-archipelago) archipelago="yes"
-  ;;
   --disable-virtio-blk-data-plane|--enable-virtio-blk-data-plane)
       echo "$0: $opt is obsolete, virtio-blk data-plane is always on" >&2
   ;;
@@ -1396,7 +1391,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
-  archipelago     Archipelago backend
   tpm             TPM support
   libssh2         ssh block device support
   numa            libnuma support
@@ -3466,37 +3460,6 @@ EOF
   fi
 fi
 
-##########################################
-# archipelago probe
-if test "$archipelago" != "no" ; then
-    cat > $TMPC <<EOF
-#include <stdio.h>
-#include <xseg/xseg.h>
-#include <xseg/protocol.h>
-int main(void) {
-    xseg_initialize();
-    return 0;
-}
-EOF
-    archipelago_libs=-lxseg
-    if compile_prog "" "$archipelago_libs"; then
-        archipelago="yes"
-        libs_tools="$archipelago_libs $libs_tools"
-        libs_softmmu="$archipelago_libs $libs_softmmu"
-
-	echo "WARNING: Please check the licenses of QEMU and libxseg carefully."
-	echo "GPLv3 versions of libxseg may not be compatible with QEMU's"
-	echo "license and therefore prevent redistribution."
-	echo
-	echo "To disable Archipelago, use --disable-archipelago"
-    else
-      if test "$archipelago" = "yes" ; then
-        feature_not_found "Archipelago backend support" "Install libxseg devel"
-      fi
-      archipelago="no"
-    fi
-fi
-
 
 ##########################################
 # glusterfs probe
@@ -5099,7 +5062,6 @@ echo "coroutine backend $coroutine"
 echo "coroutine pool    $coroutine_pool"
 echo "debug stack usage $debug_stack_usage"
 echo "GlusterFS support $glusterfs"
-echo "Archipelago support $archipelago"
 echo "gcov              $gcov_tool"
 echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
@@ -5640,11 +5602,6 @@ if test "$glusterfs_zerofill" = "yes" ; then
   echo "CONFIG_GLUSTERFS_ZEROFILL=y" >> $config_host_mak
 fi
 
-if test "$archipelago" = "yes" ; then
-  echo "CONFIG_ARCHIPELAGO=m" >> $config_host_mak
-  echo "ARCHIPELAGO_LIBS=$archipelago_libs" >> $config_host_mak
-fi
-
 if test "$libssh2" = "yes" ; then
   echo "CONFIG_LIBSSH2=m" >> $config_host_mak
   echo "LIBSSH2_CFLAGS=$libssh2_cflags" >> $config_host_mak
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9bb7f4a..786b39e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -251,6 +251,7 @@
 #       2.5: 'host_floppy' dropped
 #       2.6: 'luks' added
 #       2.8: 'replication' added, 'tftp' dropped
+#       2.9: 'archipelago' dropped
 #
 # @backing_file: #optional the name of the backing file (for copy-on-write)
 #
@@ -2129,7 +2130,7 @@
 # Since: 2.0
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'archipelago', 'blkdebug', 'blkverify', 'bochs', 'cloop',
+  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
@@ -2343,35 +2344,6 @@
 
 
 ##
-# @BlockdevOptionsArchipelago:
-#
-# Driver specific block device options for Archipelago.
-#
-# @volume:              Name of the Archipelago volume image
-#
-# @mport:               #optional The port number on which mapperd is
-#                       listening. This is optional
-#                       and if not specified, QEMU will make Archipelago
-#                       use the default port (1001).
-#
-# @vport:               #optional The port number on which vlmcd is
-#                       listening. This is optional
-#                       and if not specified, QEMU will make Archipelago
-#                       use the default port (501).
-#
-# @segment:             #optional The name of the shared memory segment
-#                       Archipelago stack is using. This is optional
-#                       and if not specified, QEMU will make Archipelago
-#                       use the default value, 'archipelago'.
-# Since: 2.2
-##
-{ 'struct': 'BlockdevOptionsArchipelago',
-  'data': { 'volume': 'str',
-            '*mport': 'int',
-            '*vport': 'int',
-            '*segment': 'str' } }
-
-##
 # @BlockdevOptionsSsh:
 #
 # @server:              host address
@@ -2884,7 +2856,6 @@
             '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
   'discriminator': 'driver',
   'data': {
-      'archipelago':'BlockdevOptionsArchipelago',
       'blkdebug':   'BlockdevOptionsBlkdebug',
       'blkverify':  'BlockdevOptionsBlkverify',
       'bochs':      'BlockdevOptionsGenericFormat',
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index c41370f..f5e672e 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 _supported_fmt raw qcow2 qed
-_supported_proto file sheepdog rbd nfs archipelago
+_supported_proto file sheepdog rbd nfs
 _supported_os Linux
 
 echo "=== Creating image"
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index b6274be..4d5650d 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -156,7 +156,6 @@ check options
     -nbd                test nbd
     -ssh                test ssh
     -nfs                test nfs
-    -archipelago        test archipelago
     -luks               test luks
     -xdiff              graphical mode diff
     -nocache            use O_DIRECT on backing file
@@ -271,11 +270,6 @@ testlist options
             xpand=false
             ;;
 
-        -archipelago)
-            IMGPROTO=archipelago
-            xpand=false
-            ;;
-
         -nocache)
             CACHEMODE="none"
             CACHEMODE_IS_DEFAULT=false
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 4befd86..1040013 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -112,7 +112,6 @@ _filter_img_create()
         -e "s# block_size=[0-9]\\+##g" \
         -e "s# block_state_zero=\\(on\\|off\\)##g" \
         -e "s# log_size=[0-9]\\+##g" \
-        -e "s/archipelago:a/TEST_DIR\//g" \
         -e "s# refcount_bits=[0-9]\\+##g" \
         -e "s# key-secret=[a-zA-Z0-9]\\+##g"
 }
@@ -136,8 +135,7 @@ _filter_img_info()
         -e "/lazy_refcounts: \\(on\\|off\\)/d" \
         -e "/block_size: [0-9]\\+/d" \
         -e "/block_state_zero: \\(on\\|off\\)/d" \
-        -e "/log_size: [0-9]\\+/d" \
-        -e "s/archipelago:a/TEST_DIR\//g"
+        -e "/log_size: [0-9]\\+/d"
 }
 
 # filter out offsets and file names from qemu-img map
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 08065dc..7d4781d 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -70,8 +70,6 @@ if [ "$IMGOPTSSYNTAX" = "true" ]; then
     elif [ "$IMGPROTO" = "nfs" ]; then
         TEST_DIR="$DRIVER,file.driver=nfs,file.filename=nfs://127.0.0.1/$TEST_DIR"
         TEST_IMG=$TEST_DIR/t.$IMGFMT
-    elif [ "$IMGPROTO" = "archipelago" ]; then
-        TEST_IMG="$DRIVER,file.driver=archipelago,file.volume=:at.$IMGFMT"
     else
         TEST_IMG="$DRIVER,file.driver=$IMGPROTO,file.filename=$TEST_DIR/t.$IMGFMT"
     fi
@@ -87,8 +85,6 @@ else
     elif [ "$IMGPROTO" = "nfs" ]; then
         TEST_DIR="nfs://127.0.0.1/$TEST_DIR"
         TEST_IMG=$TEST_DIR/t.$IMGFMT
-    elif [ "$IMGPROTO" = "archipelago" ]; then
-        TEST_IMG="archipelago:at.$IMGFMT"
     else
         TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
     fi
@@ -215,10 +211,6 @@ _cleanup_test_img()
             rbd --no-progress rm "$TEST_DIR/t.$IMGFMT" > /dev/null
             ;;
 
-        archipelago)
-            vlmc remove "at.$IMGFMT" > /dev/null
-            ;;
-
         sheepdog)
             collie vdi delete "$TEST_DIR/t.$IMGFMT"
             ;;
-- 
1.8.3.1
