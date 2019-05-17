Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C3EC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C926F20833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C926F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYbS-0005tV-3a
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:52:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTp-0007x2-Bj
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTc-0006Q0-Rv
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:41 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hRYT9-0005yH-Oi; Fri, 17 May 2019 04:44:00 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id 3B3EBC06EC;
	Fri, 17 May 2019 08:43:57 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 10:42:34 +0200
Message-Id: <20190517084234.26923-9-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517084234.26923-1-klaus@birkelund.eu>
References: <20190517084234.26923-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 8/8] nvme: add an OpenChannel 2.0 NVMe device
 (ocssd)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a new 'ocssd' block device that emulates an OpenChannel 2.0
device. The device is backed by a new 'ocssd' block backend that is
based on the raw format driver but includes a header that holds the
device geometry and write data requirements. This new block backend is
special in that the size is not specified explicitly but in terms of
sector size, number of chunks, number of parallel units, etc. This
called for the addition of the `no_size_required` field in `struct
BlockDriver` to not fail image creation when the size parameter is
missing.

The ocssd device is an individual device but shares a lot of code with
the nvme device. Thus, some core functionality of nvme/nvme.c has been
exported for use by nvme/ocssd.c.

Thank you to the following people for their contributions to the
original qemu-nvme (github.com/OpenChannelSSD/qemu-nvme) implementation.

  Matias Bj=C3=B8rling <mb@lightnvm.io>
  Javier Gonz=C3=A1lez <javier@javigon.com>
  Simon Andreas Frimann Lund <ocssd@safl.dk>
  Hans Holmberg <hans@owltronix.com>
  Jesper Devantier <contact@pseudonymous.me>
  Young Tack Jin <youngtack.jin@circuitblvd.com>

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 MAINTAINERS                     |   14 +-
 Makefile.objs                   |    1 +
 block.c                         |    2 +-
 block/Makefile.objs             |    2 +-
 block/nvme.c                    |    2 +-
 block/ocssd.c                   |  690 ++++++++
 hw/block/Makefile.objs          |    2 +-
 hw/block/{ =3D> nvme}/nvme.c      |  192 ++-
 hw/block/nvme/ocssd.c           | 2647 +++++++++++++++++++++++++++++++
 hw/block/nvme/ocssd.h           |  140 ++
 hw/block/nvme/trace-events      |  136 ++
 hw/block/trace-events           |  109 --
 include/block/block_int.h       |    3 +
 include/block/nvme.h            |   12 +-
 include/block/ocssd.h           |  231 +++
 {hw =3D> include/hw}/block/nvme.h |   61 +
 include/hw/pci/pci_ids.h        |    2 +
 qapi/block-core.json            |   47 +-
 18 files changed, 4121 insertions(+), 172 deletions(-)
 create mode 100644 block/ocssd.c
 rename hw/block/{ =3D> nvme}/nvme.c (94%)
 create mode 100644 hw/block/nvme/ocssd.c
 create mode 100644 hw/block/nvme/ocssd.h
 create mode 100644 hw/block/nvme/trace-events
 create mode 100644 include/block/ocssd.h
 rename {hw =3D> include/hw}/block/nvme.h (63%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a73a61a54654..c2e89fbabeac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1561,9 +1561,20 @@ nvme
 M: Keith Busch <keith.busch@intel.com>
 L: qemu-block@nongnu.org
 S: Supported
-F: hw/block/nvme*
+F: hw/block/nvme/nvme.c
+F: include/block/nvme.h
+F: include/hw/block/nvme/nvme.h
 F: tests/nvme-test.c
=20
+ocssd
+M: Klaus Birkelund <klaus@birkelund.eu>
+L: qemu-block@nongnu.org
+S: Supported
+F: block/ocssd.c
+F: include/block/ocssd.h
+F: hw/block/nvme/ocssd.*
+T: git https://github.com/birkelund/qemu.git ocssd
+
 megasas
 M: Hannes Reinecke <hare@suse.com>
 L: qemu-block@nongnu.org
@@ -2434,6 +2445,7 @@ M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
+F: include/block/nvme.h
=20
 Bootdevice
 M: Gonglei <arei.gonglei@huawei.com>
diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed44..32b75635dcba 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -139,6 +139,7 @@ trace-events-subdirs +=3D hw/arm
 trace-events-subdirs +=3D hw/audio
 trace-events-subdirs +=3D hw/block
 trace-events-subdirs +=3D hw/block/dataplane
+trace-events-subdirs +=3D hw/block/nvme
 trace-events-subdirs +=3D hw/char
 trace-events-subdirs +=3D hw/display
 trace-events-subdirs +=3D hw/dma
diff --git a/block.c b/block.c
index 6999aad4460b..a9189b090c5f 100644
--- a/block.c
+++ b/block.c
@@ -5617,7 +5617,7 @@ void bdrv_img_create(const char *filename, const ch=
ar *fmt,
         }
     } /* (backing_file && !(flags & BDRV_O_NO_BACKING)) */
=20
-    if (size =3D=3D -1) {
+    if (size =3D=3D -1 && !drv->no_size_required) {
         error_setg(errp, "Image creation needs a size parameter");
         goto out;
     }
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892a5281..4fc56cae3a14 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -1,4 +1,4 @@
-block-obj-y +=3D raw-format.o vmdk.o vpc.o
+block-obj-y +=3D raw-format.o ocssd.o vmdk.o vpc.o
 block-obj-$(CONFIG_QCOW1) +=3D qcow.o
 block-obj-$(CONFIG_VDI) +=3D vdi.o
 block-obj-$(CONFIG_CLOOP) +=3D cloop.o
diff --git a/block/nvme.c b/block/nvme.c
index 12d98c0d0be6..edb077ef17d5 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -278,7 +278,7 @@ static inline int nvme_translate_error(const NvmeCqe =
*c)
 {
     uint16_t status =3D (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le32_to_cpu(c->cdw0),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
diff --git a/block/ocssd.c b/block/ocssd.c
new file mode 100644
index 000000000000..260f9f81b3a2
--- /dev/null
+++ b/block/ocssd.c
@@ -0,0 +1,690 @@
+/*
+ * BlockDriver implementation for "ocssd" format driver
+ *
+ * Based on the "raw" format driver (raw-format.c).
+ *
+ * Copyright (c) 2019 CNEX Labs, Inc.
+ * Copyright (C) 2010-2016 Red Hat, Inc.
+ * Copyright (C) 2010, Blue Swirl <blauwirbel@gmail.com>
+ * Copyright (C) 2009, Anthony Liguori <aliguori@us.ibm.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to
+ * deal in the Software without restriction, including without limitatio=
n the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, =
and/or
+ * sell copies of the Software, and to permit persons to whom the Softwa=
re is
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
LL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER D=
EALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/option.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+
+#include "hw/block/nvme/ocssd.h"
+
+typedef struct BDRVOcssdState {
+    OcssdFormatHeader hdr;
+    OcssdIdentity *namespaces;
+    uint64_t size, real_size;
+} BDRVOcssdState;
+
+static QemuOptsList ocssd_create_opts =3D {
+    .name =3D "ocssd-create-opts",
+    .head =3D QTAILQ_HEAD_INITIALIZER(ocssd_create_opts.head),
+    .desc =3D {
+        {
+            .name =3D "num_grp",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "number of groups (default: 2)"
+        },
+        {
+            .name =3D "num_pu",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "number of parallel units per group (default: 4)"
+        },
+        {
+            .name =3D "num_chk",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "number of chunks per parallel unit (defaut: 60)"
+        },
+        {
+            .name =3D "num_sec",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "number of sectors per chunk (default: 4096)"
+        },
+        {
+            .name =3D "sec_size",
+            .type =3D QEMU_OPT_SIZE,
+            .help =3D "sector size (default: 4096)"
+        },
+        {
+            .name =3D "md_size",
+            .type =3D QEMU_OPT_SIZE,
+            .help =3D "metadata size (default: 16)"
+        },
+        {
+            .name =3D "num_ns",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "number of namespaces (default: 1)",
+        },
+        {
+            .name =3D "mccap",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "media and controller capabilities (default: 0x1)"=
,
+        },
+        {
+            .name =3D "wit",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "wear-level index delta threshold (default: 10)",
+        },
+        {
+            .name =3D "ws_min",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "minimum write size (default: 4)",
+        },
+        {
+            .name =3D "ws_opt",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "optimal write size (default: 8)",
+        },
+        {
+            .name =3D "mw_cunits",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "cache minimum write size units (default: 24)",
+        },
+        {
+            .name =3D "pe_cycles",
+            .type =3D QEMU_OPT_NUMBER,
+            .help =3D "program/erase cycles per chunk (default: 1000)",
+        },
+        { /* end of list */ }
+    }
+};
+
+static int ocssd_reopen_prepare(BDRVReopenState *reopen_state,
+    BlockReopenQueue *queue, Error **errp)
+{
+    assert(reopen_state !=3D NULL);
+    assert(reopen_state->bs !=3D NULL);
+    return 0;
+}
+
+static int coroutine_fn ocssd_co_preadv(BlockDriverState *bs, uint64_t o=
ffset,
+    uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    BDRVOcssdState *s =3D bs->opaque;
+
+    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+
+    /*
+     * Return predefined (deterministic) data for reads that are out of =
bounds
+     * of the real physical size of the device. See ocssd_getlength for =
why
+     * reads might be issued out of bounds.
+     */
+    if (offset > s->real_size || s->real_size - offset < bytes) {
+        return qemu_iovec_memset(qiov, 0, 0x0, bytes);
+    }
+
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn ocssd_co_pwritev(BlockDriverState *bs, uint64_t =
offset,
+    uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    void *buf =3D NULL;
+    BlockDriver *drv;
+    QEMUIOVector local_qiov;
+    int ret;
+
+    if (bs->probed && offset < BLOCK_PROBE_BUF_SIZE && bytes) {
+        /*
+         * Handling partial writes would be a pain - so we just
+         * require that guests have 512-byte request alignment if
+         * probing occurred
+         */
+        QEMU_BUILD_BUG_ON(BLOCK_PROBE_BUF_SIZE !=3D 512);
+        QEMU_BUILD_BUG_ON(BDRV_SECTOR_SIZE !=3D 512);
+        assert(offset =3D=3D 0 && bytes >=3D BLOCK_PROBE_BUF_SIZE);
+
+        buf =3D qemu_try_blockalign(bs->file->bs, 512);
+        if (!buf) {
+            ret =3D -ENOMEM;
+            goto fail;
+        }
+
+        ret =3D qemu_iovec_to_buf(qiov, 0, buf, 512);
+        if (ret !=3D 512) {
+            ret =3D -EINVAL;
+            goto fail;
+        }
+
+        drv =3D bdrv_probe_all(buf, 512, NULL);
+        if (drv !=3D bs->drv) {
+            ret =3D -EPERM;
+            goto fail;
+        }
+
+        /*
+         * Use the checked buffer, a malicious guest might be overwritin=
g its
+         * original buffer in the background.
+         */
+        qemu_iovec_init(&local_qiov, qiov->niov + 1);
+        qemu_iovec_add(&local_qiov, buf, 512);
+        qemu_iovec_concat(&local_qiov, qiov, 512, qiov->size - 512);
+        qiov =3D &local_qiov;
+    }
+
+    BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+    ret =3D bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+
+fail:
+    if (qiov =3D=3D &local_qiov) {
+        qemu_iovec_destroy(&local_qiov);
+    }
+    qemu_vfree(buf);
+    return ret;
+}
+
+static int coroutine_fn ocssd_co_block_status(BlockDriverState *bs,
+    bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum, int64_=
t *map,
+    BlockDriverState **file)
+{
+    *pnum =3D bytes;
+    *file =3D bs->file->bs;
+    *map =3D offset;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
+}
+
+static int coroutine_fn ocssd_co_pwrite_zeroes(BlockDriverState *bs,
+    int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+static int coroutine_fn ocssd_co_pdiscard(BlockDriverState *bs, int64_t =
offset,
+    int bytes)
+{
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
+}
+
+static int64_t ocssd_getlength(BlockDriverState *bs)
+{
+    /*
+     * Return the size of the full physical address space. It may be lar=
ger
+     * than the real size due to the LBA address format. For reads, pred=
efined
+     * (deterministic) data is returned for addresses that are out of bo=
unds of
+     * the real size (see ocssd_co_preadv).
+     */
+
+    BDRVOcssdState *s =3D bs->opaque;
+    return s->size;
+}
+
+static BlockMeasureInfo *ocssd_measure(QemuOpts *opts, BlockDriverState =
*in_bs,
+    Error **errp)
+{
+    BlockMeasureInfo *info;
+    int64_t required;
+
+    if (in_bs) {
+        required =3D bdrv_getlength(in_bs);
+        if (required < 0) {
+            error_setg_errno(errp, -required, "Unable to get image size"=
);
+            return NULL;
+        }
+    } else {
+        required =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE=
, 0),
+            BDRV_SECTOR_SIZE);
+    }
+
+    info =3D g_new(BlockMeasureInfo, 1);
+    info->required =3D required;
+
+    /* unallocated sectors count towards the file size in ocssd images *=
/
+    info->fully_allocated =3D info->required;
+    return info;
+}
+
+static int ocssd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    return bdrv_get_info(bs->file->bs, bdi);
+}
+
+static ImageInfoSpecificOcssdNS *ocssd_get_namespace_info(
+    OcssdIdentity *ns)
+{
+    ImageInfoSpecificOcssdNS *info =3D g_new0(ImageInfoSpecificOcssdNS, =
1);
+
+    *info =3D (ImageInfoSpecificOcssdNS) {
+        .num_grp =3D ns->geo.num_grp,
+        .num_pu =3D ns->geo.num_pu,
+        .num_chk =3D ns->geo.num_chk,
+        .num_sec =3D ns->geo.clba,
+    };
+
+    return info;
+}
+
+static ImageInfoSpecific *ocssd_get_specific_info(BlockDriverState *bs,
+    Error **errp)
+{
+    BDRVOcssdState *s =3D bs->opaque;
+    ImageInfoSpecific *spec_info;
+    ImageInfoSpecificOcssdNSList **next;
+
+    spec_info =3D g_new0(ImageInfoSpecific, 1);
+    *spec_info =3D (ImageInfoSpecific){
+        .type  =3D IMAGE_INFO_SPECIFIC_KIND_OCSSD,
+        .u.ocssd.data =3D g_new0(ImageInfoSpecificOcssd, 1),
+    };
+
+    *spec_info->u.ocssd.data =3D (ImageInfoSpecificOcssd){
+        .num_ns =3D s->hdr.num_ns,
+        .sector_size =3D s->hdr.sector_size,
+        .metadata_size =3D s->hdr.md_size,
+    };
+
+    next =3D &spec_info->u.ocssd.data->namespaces;
+    for (int i =3D 0; i < s->hdr.num_ns; i++) {
+        *next =3D g_new0(ImageInfoSpecificOcssdNSList, 1);
+        (*next)->value =3D ocssd_get_namespace_info(&s->namespaces[i]);
+        (*next)->next =3D NULL;
+        next =3D &(*next)->next;
+    }
+
+    return spec_info;
+}
+
+static void ocssd_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    if (bs->probed) {
+        /*
+         * To make it easier to protect the first sector, any probed
+         * image is restricted to read-modify-write on sub-sector
+         * operations.
+         */
+        bs->bl.request_alignment =3D BDRV_SECTOR_SIZE;
+    }
+}
+
+static int coroutine_fn ocssd_co_truncate(BlockDriverState *bs, int64_t =
offset,
+    PreallocMode prealloc, Error **errp)
+{
+    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
+}
+
+static void ocssd_eject(BlockDriverState *bs, bool eject_flag)
+{
+    bdrv_eject(bs->file->bs, eject_flag);
+}
+
+static void ocssd_lock_medium(BlockDriverState *bs, bool locked)
+{
+    bdrv_lock_medium(bs->file->bs, locked);
+}
+
+static int ocssd_co_ioctl(BlockDriverState *bs, unsigned long int req,
+    void *buf)
+{
+    return bdrv_co_ioctl(bs->file->bs, req, buf);
+}
+
+static int ocssd_has_zero_init(BlockDriverState *bs)
+{
+    return bdrv_has_zero_init(bs->file->bs);
+}
+
+static int coroutine_fn ocssd_co_create_opts(const char *filename,
+    QemuOpts *opts, Error **errp)
+{
+    BlockBackend *blk =3D NULL;
+    BlockDriverState *bs =3D NULL;
+    Error *local_err =3D NULL;
+    OcssdFormatHeader hdr;
+    OcssdIdentity id;
+    OcssdIdLBAF lbaf;
+    OcssdAddrF addrf;
+    OcssdChunkDescriptor *chk;
+    OcssdChunkAcctDescriptor *acct;
+    uint8_t wit;
+    uint16_t num_grp, num_pu;
+    uint32_t num_chk, num_sec, mccap, ws_min, ws_opt, mw_cunits, pe_cycl=
es;
+    uint64_t sec_size, md_size, num_ns, logpage_size, acct_size;
+    uint64_t chks_total, secs_total, usable_size, ns_size, size, offset;
+    int ret;
+
+    num_grp =3D qemu_opt_get_number(opts, "num_grp", 2);
+    num_pu =3D qemu_opt_get_number(opts, "num_pu", 8);
+    num_chk =3D qemu_opt_get_number(opts, "num_chk", 60);
+    num_sec =3D qemu_opt_get_number(opts, "num_sec", 4096);
+    num_ns =3D qemu_opt_get_number(opts, "num_ns", 1);
+    mccap =3D qemu_opt_get_number(opts, "mccap", 0x1);
+    wit =3D qemu_opt_get_number(opts, "wit", 10);
+    ws_min =3D qemu_opt_get_number(opts, "ws_min", 4);
+    ws_opt =3D qemu_opt_get_number(opts, "ws_opt", 8);
+    mw_cunits =3D qemu_opt_get_number(opts, "mw_cunits", 24);
+    pe_cycles =3D qemu_opt_get_number(opts, "pe_cycles", 1000);
+
+    sec_size =3D qemu_opt_get_size(opts, "sec_size", 4096);
+    md_size =3D qemu_opt_get_size(opts, "md_size", 16);
+
+    chks_total =3D num_grp * num_pu * num_chk;
+    logpage_size =3D QEMU_ALIGN_UP(chks_total * sizeof(OcssdChunkDescrip=
tor),
+        sec_size);
+    acct_size =3D QEMU_ALIGN_UP(chks_total * sizeof(OcssdChunkAcctDescri=
ptor),
+        sec_size);
+
+    secs_total =3D chks_total * num_sec;
+
+    /*
+     * The ocssd format begins with a 4k format header. Namespaces are l=
aid out
+     * contiguously in sections after the header.
+     *
+     * A namespace section consists of a 4k OcssdIdentify block, an acco=
unting
+     * region and a chunk info region. The accounting and chunk info reg=
ions
+     * are of variable size (in multiples of the sector size). Then come=
s a
+     * data section that contains a region dedicated to data dn a region=
 for
+     * metadata afterwards.
+     *
+     *     [Format header          ] 4096 bytes
+     *     [OCSSD identity/geometry] 4096 bytes
+     *     [Accounting             ] sector_size * n
+     *     [Chunk info             ] sector_size * m
+     *     [Namespace data         ] sector_size * k
+     *     [Namespace meta data    ] md_size * k
+     *
+     * , where 'n' is the number of sectors required to hold accounting
+     * information on all chunks, 'm' is the number of sectors required =
to hold
+     * chunk information and 'k' is the number of available LBAs.
+     *
+     */
+
+    usable_size =3D secs_total * (sec_size + md_size);
+    ns_size =3D usable_size + sizeof(OcssdIdentity) + acct_size + logpag=
e_size;
+
+    size =3D sizeof(OcssdFormatHeader) + ns_size * num_ns;
+
+    qemu_opt_set_number(opts, "size", size, errp);
+
+    ret =3D bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    bs =3D bdrv_open(filename, NULL, NULL,
+        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (bs =3D=3D NULL) {
+        ret =3D -EIO;
+        goto fail;
+    }
+
+    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ret =3D blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    blk_set_allow_write_beyond_eof(blk, true);
+
+    ret =3D blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    /*
+     * Calculate an "optimal" LBA address format that uses as few bits a=
s
+     * possible.
+     */
+    lbaf =3D (OcssdIdLBAF) {
+        .sec_len =3D 32 - clz32(num_sec - 1),
+        .chk_len =3D 32 - clz32(num_chk - 1),
+        .pu_len  =3D 32 - clz32(num_pu - 1),
+        .grp_len =3D 32 - clz32(num_grp - 1),
+    };
+
+    ocssd_ns_optimal_addrf(&addrf, &lbaf);
+
+    hdr =3D (OcssdFormatHeader) {
+        .magic =3D OCSSD_MAGIC,
+        .version =3D 0x1,
+        .num_ns =3D num_ns,
+        .md_size =3D md_size,
+        .sector_size =3D sec_size,
+        .ns_size =3D ns_size,
+        .pe_cycles =3D pe_cycles,
+        .lbaf =3D lbaf,
+    };
+
+    ret =3D blk_pwrite(blk, 0, &hdr, sizeof(OcssdFormatHeader), 0);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    offset =3D sizeof(OcssdFormatHeader);
+    for (int i =3D 0; i < num_ns; i++) {
+        id =3D (OcssdIdentity) {
+            .ver.major =3D 2,
+            .ver.minor =3D 0,
+            .lbaf =3D lbaf,
+            .mccap =3D mccap,
+            .wit =3D wit,
+            .geo =3D (OcssdIdGeo) {
+                .num_grp =3D num_grp,
+                .num_pu  =3D num_pu,
+                .num_chk =3D num_chk,
+                .clba    =3D num_sec,
+            },
+            .wrt =3D (OcssdIdWrt) {
+                .ws_min    =3D ws_min,
+                .ws_opt    =3D ws_opt,
+                .mw_cunits =3D mw_cunits,
+            },
+            .perf =3D (OcssdIdPerf) {
+                .trdt =3D cpu_to_le32(70000),
+                .trdm =3D cpu_to_le32(100000),
+                .tprt =3D cpu_to_le32(1900000),
+                .tprm =3D cpu_to_le32(3500000),
+                .tbet =3D cpu_to_le32(3000000),
+                .tbem =3D cpu_to_le32(3000000),
+            },
+        };
+
+        ret =3D blk_pwrite(blk, offset, &id, sizeof(OcssdIdentity), 0);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        offset +=3D sizeof(OcssdIdentity);
+
+        acct =3D g_malloc0(acct_size);
+        ret =3D blk_pwrite(blk, offset, acct, acct_size, 0);
+        g_free(acct);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        offset +=3D acct_size;
+
+        chk =3D g_malloc0(logpage_size);
+        for (int i =3D 0; i < chks_total; i++) {
+            chk[i].state =3D OCSSD_CHUNK_FREE;
+            chk[i].type =3D OCSSD_CHUNK_TYPE_SEQUENTIAL;
+            chk[i].wear_index =3D 0;
+            chk[i].slba =3D (i / (num_chk * num_pu)) << addrf.grp_offset
+                | (i % (num_chk * num_pu) / num_chk) << addrf.pu_offset
+                | (i % num_chk) << addrf.chk_offset;
+            chk[i].cnlb =3D num_sec;
+            chk[i].wp =3D 0;
+        }
+
+        ret =3D blk_pwrite(blk, offset, chk, logpage_size, 0);
+        g_free(chk);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        offset +=3D logpage_size + usable_size;
+    }
+
+    ret =3D blk_truncate(blk, size, PREALLOC_MODE_OFF, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+fail:
+    bdrv_unref(bs);
+    return ret;
+}
+
+static int ocssd_open(BlockDriverState *bs, QDict *options, int flags,
+    Error **errp)
+{
+    BDRVOcssdState *s =3D bs->opaque;
+    OcssdIdLBAF *lbaf;
+    int ret;
+    int64_t len;
+    uint64_t nblks;
+
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    bs->sg =3D bs->file->bs->sg;
+    bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
+    bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+            bs->file->bs->supported_zero_flags);
+
+    len =3D bdrv_getlength(bs->file->bs);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "could not get image size");
+        return len;
+    }
+    s->real_size =3D len;
+
+    ret =3D bdrv_pread(bs->file, 0, &s->hdr, sizeof(OcssdFormatHeader));
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * Calculate the size according to the address space. This is return=
ed from
+     * ocssd_getlength. See ocssd_getlength and ocssd_co_preadv.
+     */
+    lbaf =3D &s->hdr.lbaf;
+    nblks =3D 1 << (lbaf->grp_len + lbaf->pu_len + lbaf->chk_len +
+        lbaf->sec_len);
+    s->size =3D s->hdr.num_ns * nblks * (s->hdr.sector_size + s->hdr.md_=
size);
+
+    s->namespaces =3D g_new0(OcssdIdentity, s->hdr.num_ns);
+
+    for (int i =3D 0; i < s->hdr.num_ns; i++) {
+        ret =3D bdrv_pread(bs->file, s->hdr.sector_size + i * s->hdr.ns_=
size,
+            &s->namespaces[i], sizeof(OcssdIdentity));
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static int ocssd_probe(const uint8_t *buf, int buf_size, const char *fil=
ename)
+{
+    const OcssdFormatHeader *hdr =3D (const void *) buf;
+
+    if (buf_size < sizeof(*hdr)) {
+        return 0;
+    }
+
+    if (hdr->magic =3D=3D OCSSD_MAGIC && hdr->version =3D=3D 1) {
+        return 100;
+    }
+
+    return 0;
+}
+
+static int ocssd_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
+{
+    return bdrv_probe_blocksizes(bs->file->bs, bsz);
+}
+
+static int ocssd_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
+{
+    return bdrv_probe_geometry(bs->file->bs, geo);
+}
+
+static int coroutine_fn ocssd_co_copy_range_from(BlockDriverState *bs,
+    BdrvChild *src, uint64_t src_offset, BdrvChild *dst, uint64_t dst_of=
fset,
+    uint64_t bytes, BdrvRequestFlags read_flags, BdrvRequestFlags write_=
flags)
+{
+    return bdrv_co_copy_range_from(bs->file, src_offset, dst, dst_offset=
,
+        bytes, read_flags, write_flags);
+}
+
+static int coroutine_fn ocssd_co_copy_range_to(BlockDriverState *bs,
+    BdrvChild *src, uint64_t src_offset, BdrvChild *dst, uint64_t dst_of=
fset,
+    uint64_t bytes, BdrvRequestFlags read_flags, BdrvRequestFlags write_=
flags)
+{
+    return bdrv_co_copy_range_to(src, src_offset, bs->file, dst_offset, =
bytes,
+        read_flags, write_flags);
+}
+
+BlockDriver bdrv_ocssd =3D {
+    .format_name   =3D "ocssd",
+    .instance_size =3D sizeof(BDRVOcssdState),
+
+    .bdrv_probe          =3D &ocssd_probe,
+    .bdrv_open           =3D &ocssd_open,
+    .bdrv_reopen_prepare =3D &ocssd_reopen_prepare,
+    .bdrv_child_perm     =3D bdrv_filter_default_perms,
+
+    .bdrv_co_create_opts     =3D &ocssd_co_create_opts,
+    .bdrv_co_preadv          =3D &ocssd_co_preadv,
+    .bdrv_co_pwritev         =3D &ocssd_co_pwritev,
+    .bdrv_co_pwrite_zeroes   =3D &ocssd_co_pwrite_zeroes,
+    .bdrv_co_pdiscard        =3D &ocssd_co_pdiscard,
+    .bdrv_co_block_status    =3D &ocssd_co_block_status,
+    .bdrv_co_copy_range_from =3D &ocssd_co_copy_range_from,
+    .bdrv_co_copy_range_to   =3D &ocssd_co_copy_range_to,
+    .bdrv_co_truncate        =3D &ocssd_co_truncate,
+    .bdrv_co_ioctl           =3D &ocssd_co_ioctl,
+
+    .bdrv_getlength         =3D &ocssd_getlength,
+    .bdrv_measure           =3D &ocssd_measure,
+    .bdrv_get_info          =3D &ocssd_get_info,
+    .bdrv_get_specific_info =3D &ocssd_get_specific_info,
+    .bdrv_refresh_limits    =3D &ocssd_refresh_limits,
+    .bdrv_probe_blocksizes  =3D &ocssd_probe_blocksizes,
+    .bdrv_probe_geometry    =3D &ocssd_probe_geometry,
+    .bdrv_eject             =3D &ocssd_eject,
+    .bdrv_lock_medium       =3D &ocssd_lock_medium,
+    .bdrv_has_zero_init     =3D &ocssd_has_zero_init,
+
+    .create_opts =3D &ocssd_create_opts,
+
+    .no_size_required =3D true,
+};
+
+static void bdrv_ocssd_init(void)
+{
+    bdrv_register(&bdrv_ocssd);
+}
+
+block_init(bdrv_ocssd_init);
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index f5f643f0cc06..724bf20df90a 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -7,7 +7,7 @@ common-obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
 common-obj-$(CONFIG_XEN) +=3D xen-block.o
 common-obj-$(CONFIG_ECC) +=3D ecc.o
 common-obj-$(CONFIG_ONENAND) +=3D onenand.o
-common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
+common-obj-$(CONFIG_NVME_PCI) +=3D nvme/nvme.o nvme/ocssd.o
=20
 obj-$(CONFIG_SH4) +=3D tc58128.o
=20
diff --git a/hw/block/nvme.c b/hw/block/nvme/nvme.c
similarity index 94%
rename from hw/block/nvme.c
rename to hw/block/nvme/nvme.c
index 5cd593806701..0ad102e487db 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme/nvme.c
@@ -48,15 +48,13 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
-#include "qemu/log.h"
-#include "hw/block/block.h"
+#include "hw/block/nvme.h"
 #include "hw/pci/msix.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
=20
 #include "trace.h"
-#include "nvme.h"
=20
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
 #define NVME_TEMPERATURE 0x143
@@ -64,13 +62,6 @@
 #define NVME_AERL 3
 #define NVME_OP_ABORTED 0xff
=20
-#define NVME_GUEST_ERR(trace, fmt, ...) \
-    do { \
-        (trace_##trace)(__VA_ARGS__); \
-        qemu_log_mask(LOG_GUEST_ERROR, #trace \
-            " in %s: " fmt "\n", __func__, ## __VA_ARGS__); \
-    } while (0)
-
 static void nvme_process_sq(void *opaque);
=20
 static inline uint8_t nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
@@ -79,7 +70,7 @@ static inline uint8_t nvme_addr_is_cmb(NvmeCtrl *n, hwa=
ddr addr)
         addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size));
 }
=20
-static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
+void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
     if (nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
@@ -90,13 +81,14 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
void *buf, int size)
     pci_dma_read(&n->parent_obj, addr, buf, size);
 }
=20
-static void nvme_addr_write(NvmeCtrl *n, hwaddr addr, void *buf, int siz=
e)
+void nvme_addr_write(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->cmbsz && addr >=3D n->ctrl_mem.addr &&
-                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size=
))) {
+    if (nvme_addr_is_cmb(n, addr)) {
         memcpy((void *)&n->cmbuf[addr - n->ctrl_mem.addr], buf, size);
+
         return;
     }
+
     pci_dma_write(&n->parent_obj, addr, buf, size);
 }
=20
@@ -377,6 +369,93 @@ static void dma_to_cmb(NvmeCtrl *n, QEMUSGList *qsg,=
 QEMUIOVector *iov)
     }
 }
=20
+static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
+    uint64_t prp1, uint64_t prp2, NvmeRequest *req)
+{
+    QEMUSGList qsg;
+    uint16_t err =3D NVME_SUCCESS;
+
+    err =3D nvme_map_prp(n, &qsg, prp1, prp2, len, req);
+    if (err) {
+        return err;
+    }
+
+    if (req->is_cmb) {
+        QEMUIOVector iov;
+
+        qemu_iovec_init(&iov, qsg.nsg);
+        dma_to_cmb(n, &qsg, &iov);
+
+        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len)) {
+            trace_nvme_err_invalid_dma();
+            err =3D NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        qemu_iovec_destroy(&iov);
+
+        return err;
+    }
+
+    if (unlikely(dma_buf_write(ptr, len, &qsg))) {
+        trace_nvme_err_invalid_dma();
+        err =3D NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    qemu_sglist_destroy(&qsg);
+
+    return err;
+}
+
+static uint16_t nvme_dma_write_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
+    NvmeSglDescriptor sgl, NvmeRequest *req)
+{
+    QEMUSGList qsg;
+    uint16_t err =3D NVME_SUCCESS;
+
+    err =3D nvme_map_sgl(n, &qsg, sgl, len, req);
+    if (err) {
+        return err;
+    }
+
+    if (req->is_cmb) {
+        QEMUIOVector iov;
+
+        qemu_iovec_init(&iov, qsg.nsg);
+        dma_to_cmb(n, &qsg, &iov);
+
+        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len)) {
+            trace_nvme_err_invalid_dma();
+            err =3D NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        qemu_iovec_destroy(&iov);
+
+        return err;
+    }
+
+    if (unlikely(dma_buf_write(ptr, len, &qsg))) {
+        trace_nvme_err_invalid_dma();
+        err =3D NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    qemu_sglist_destroy(&qsg);
+
+    return err;
+}
+
+uint16_t nvme_dma_write(NvmeCtrl *n, uint8_t *ptr, uint32_t len, NvmeCmd=
 *cmd,
+    NvmeRequest *req)
+{
+    if (cmd->psdt) {
+        return nvme_dma_write_sgl(n, ptr, len, cmd->dptr.sgl, req);
+    }
+
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
+
+    return nvme_dma_write_prp(n, ptr, len, prp1, prp2, req);
+}
+
 static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
     uint64_t prp1, uint64_t prp2, NvmeRequest *req)
 {
@@ -414,7 +493,7 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_=
t *ptr, uint32_t len,
     return err;
 }
=20
-static uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
+uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     NvmeSglDescriptor sgl, NvmeCmd *cmd, NvmeRequest *req)
 {
     QEMUSGList qsg;
@@ -451,7 +530,7 @@ static uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_=
t *ptr, uint32_t len,
     return err;
 }
=20
-static uint16_t nvme_dma_read(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+uint16_t nvme_dma_read(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     NvmeCmd *cmd, NvmeRequest *req)
 {
     if (cmd->psdt) {
@@ -477,12 +556,12 @@ static void nvme_blk_req_destroy(NvmeBlockBackendRe=
quest *blk_req)
     g_free(blk_req);
 }
=20
-static void nvme_blk_req_put(NvmeCtrl *n, NvmeBlockBackendRequest *blk_r=
eq)
+void nvme_blk_req_put(NvmeCtrl *n, NvmeBlockBackendRequest *blk_req)
 {
     nvme_blk_req_destroy(blk_req);
 }
=20
-static NvmeBlockBackendRequest *nvme_blk_req_get(NvmeCtrl *n, NvmeReques=
t *req,
+NvmeBlockBackendRequest *nvme_blk_req_get(NvmeCtrl *n, NvmeRequest *req,
     QEMUSGList *qsg)
 {
     NvmeBlockBackendRequest *blk_req =3D g_malloc0(sizeof(*blk_req));
@@ -519,7 +598,8 @@ static uint16_t nvme_blk_setup(NvmeCtrl *n, NvmeNames=
pace *ns, QEMUSGList *qsg,
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req,
+    NvmeBlockSetupFn blk_setup)
 {
     NvmeNamespace *ns =3D req->ns;
     uint16_t err;
@@ -547,7 +627,7 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
         }
     }
=20
-    err =3D nvme_blk_setup(n, ns, &qsg, ns->blk_offset, unit_len, req);
+    err =3D blk_setup(n, ns, &qsg, ns->blk_offset, unit_len, req);
     if (err) {
         return err;
     }
@@ -576,8 +656,7 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
             qemu_sglist_add(&qsg, le64_to_cpu(cmd->mptr), meta_len);
         }
=20
-        err =3D nvme_blk_setup(n, ns, &qsg, ns->blk_offset_md, meta_unit=
_len,
-            req);
+        err =3D blk_setup(n, ns, &qsg, ns->blk_offset_md, meta_unit_len,=
 req);
         if (err) {
             return err;
         }
@@ -624,7 +703,7 @@ static void nvme_post_cqes(void *opaque)
     }
 }
=20
-static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
+void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
=20
@@ -634,8 +713,8 @@ static void nvme_enqueue_req_completion(NvmeCQueue *c=
q, NvmeRequest *req)
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
 }
=20
-static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
-    uint8_t event_info, uint8_t log_page)
+void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type, uint8_t event_i=
nfo,
+    uint8_t log_page)
 {
     NvmeAsyncEvent *event;
=20
@@ -693,8 +772,7 @@ static void nvme_process_aers(void *opaque)
         n->outstanding_aers--;
=20
         req =3D n->aer_reqs[n->outstanding_aers];
-
-        result =3D (NvmeAerResult *) &req->cqe.result;
+        result =3D (NvmeAerResult *) &req->cqe.cdw0;
         result->event_type =3D event->result.event_type;
         result->event_info =3D event->result.event_info;
         result->log_page =3D event->result.log_page;
@@ -709,7 +787,7 @@ static void nvme_process_aers(void *opaque)
     }
 }
=20
-static void nvme_rw_cb(void *opaque, int ret)
+void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeBlockBackendRequest *blk_req =3D opaque;
     NvmeRequest *req =3D blk_req->req;
@@ -789,7 +867,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_rw_check_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest=
 *req)
+uint16_t nvme_rw_check_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeNamespace *ns =3D req->ns;
     NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
@@ -851,7 +929,7 @@ static void nvme_blk_submit_cmb(NvmeCtrl *n, NvmeBloc=
kBackendRequest *blk_req,
     }
 }
=20
-static uint16_t nvme_blk_submit_io(NvmeCtrl *n, NvmeRequest *req,
+uint16_t nvme_blk_submit_io(NvmeCtrl *n, NvmeRequest *req,
     BlockCompletionFunc *cb)
 {
     NvmeBlockBackendRequest *blk_req;
@@ -882,7 +960,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, Nv=
meRequest *req)
     trace_nvme_rw(req->is_write ? "write" : "read", nlb,
         nlb << nvme_ns_lbads(req->ns), slba);
=20
-    int err =3D nvme_blk_map(n, cmd, req);
+    int err =3D nvme_blk_map(n, cmd, req, nvme_blk_setup);
     if (err) {
         return err;
     }
@@ -890,7 +968,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, Nv=
meRequest *req)
     return nvme_blk_submit_io(n, req, nvme_rw_cb);
 }
=20
-static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeRwCmd *rw;
     int err;
@@ -1233,7 +1311,7 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
     }
 }
=20
-static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
@@ -1284,11 +1362,11 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvm=
eCmd *cmd, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    req->cqe.result =3D result;
+    req->cqe.cdw0 =3D result;
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
@@ -1319,8 +1397,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
                                 ((dw11 >> 16) & 0xFFFF) + 1,
                                 n->params.num_queues - 1,
                                 n->params.num_queues - 1);
-        req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
-                                     ((n->params.num_queues - 2) << 16))=
;
+        req->cqe.cdw0 =3D cpu_to_le32((n->params.num_queues - 2) |
+                                   ((n->params.num_queues - 2) << 16));
         break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
@@ -1340,7 +1418,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
+void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
 {
     n->aer_mask &=3D ~(1 << event_type);
     if (!QSIMPLEQ_EMPTY(&n->aer_queue)) {
@@ -1423,8 +1501,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
md *cmd, uint32_t buf_len,
     return nvme_dma_read(n, (uint8_t *) &fw_log + off, trans_len, cmd, r=
eq);
 }
=20
-
-static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
@@ -1486,7 +1563,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     uint16_t sqid =3D cmd->cdw10 & 0xffff;
     uint16_t cid =3D (cmd->cdw10 >> 16) & 0xffff;
=20
-    req->cqe.result =3D 1;
+    req->cqe.cdw0 =3D 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1502,7 +1579,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
=20
         nvme_addr_read(n, addr, (void *) &abort_cmd, sizeof(abort_cmd));
         if (abort_cmd.cid =3D=3D cid) {
-            req->cqe.result =3D 0;
+            req->cqe.cdw0 =3D 0;
             new =3D QTAILQ_FIRST(&sq->req_list);
             QTAILQ_REMOVE(&sq->req_list, new, entry);
             QTAILQ_INSERT_TAIL(&sq->out_req_list, new, entry);
@@ -1525,7 +1602,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *r=
eq)
+uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     switch (cmd->opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
@@ -1591,8 +1668,8 @@ static void nvme_process_sq(void *opaque)
=20
         nvme_init_req(n, &cmd, req);
=20
-        status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
-            nvme_admin_cmd(n, &cmd, req);
+        status =3D sq->sqid ? n->io_cmd(n, &cmd, req) :
+            n->admin_cmd(n, &cmd, req);
         if (status !=3D NVME_NO_COMPLETE) {
             req->status =3D status;
             nvme_enqueue_req_completion(cq, req);
@@ -2071,7 +2148,7 @@ static int nvme_check_constraints(NvmeCtrl *n, Erro=
r **errp)
     return 0;
 }
=20
-static int nvme_init_blk(NvmeCtrl *n, Error **errp)
+int nvme_init_blk(NvmeCtrl *n, Error **errp)
 {
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
@@ -2082,7 +2159,7 @@ static int nvme_init_blk(NvmeCtrl *n, Error **errp)
     return 0;
 }
=20
-static int nvme_init_state(NvmeCtrl *n, Error **errp)
+int nvme_init_state(NvmeCtrl *n, Error **errp)
 {
     int64_t bs_size;
     Error *local_err =3D NULL;
@@ -2143,7 +2220,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *p=
ci_dev)
         PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
 }
=20
-static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
+void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
 {
     uint8_t *pci_conf =3D pci_dev->config;
=20
@@ -2166,7 +2243,7 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *p=
ci_dev)
     }
 }
=20
-static void nvme_init_ctrl(NvmeCtrl *n)
+void nvme_init_ctrl(NvmeCtrl *n)
 {
     NvmeIdCtrl *id =3D &n->id_ctrl;
     NvmeParams *params =3D &n->params;
@@ -2235,7 +2312,7 @@ static uint64_t nvme_ns_calc_blks(NvmeCtrl *n, Nvme=
Namespace *ns)
     return n->ns_size / (nvme_ns_lbads_bytes(ns) + nvme_ns_ms(ns));
 }
=20
-static void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns)
+void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns)
 {
     NvmeParams *params =3D &n->params;
=20
@@ -2298,6 +2375,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     NvmeCtrl *n =3D NVME(pci_dev);
     Error *local_err =3D NULL;
=20
+    n->admin_cmd =3D nvme_admin_cmd;
+    n->io_cmd =3D nvme_io_cmd;
+
     if (nvme_check_constraints(n, &local_err)) {
         error_propagate_prepend(errp, local_err, "nvme_check_constraints=
: ");
         return;
@@ -2323,10 +2403,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     }
 }
=20
-static void nvme_exit(PCIDevice *pci_dev)
+void nvme_free_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 {
-    NvmeCtrl *n =3D NVME(pci_dev);
-
     nvme_clear_ctrl(n);
     g_free(n->namespaces);
     g_free(n->cq);
@@ -2338,9 +2416,17 @@ static void nvme_exit(PCIDevice *pci_dev)
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
     }
+
     msix_uninit_exclusive_bar(pci_dev);
 }
=20
+static void nvme_exit(PCIDevice *pci_dev)
+{
+    NvmeCtrl *n =3D NVME(pci_dev);
+
+    nvme_free_ctrl(n, pci_dev);
+}
+
 static Property nvme_props[] =3D {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
     DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
diff --git a/hw/block/nvme/ocssd.c b/hw/block/nvme/ocssd.c
new file mode 100644
index 000000000000..c2e45edfa9b8
--- /dev/null
+++ b/hw/block/nvme/ocssd.c
@@ -0,0 +1,2647 @@
+/*
+ * QEMU OpenChannel 2.0 Controller
+ *
+ * Copyright (c) 2019 CNEX Labs, Inc.
+ *
+ * Written by Klaus Birkelund Abildgaard Jensen <klaus@birkelund.eu>
+ *
+ * Thank you to the following people for their contributions to the orig=
inal
+ * qemu-nvme (github.com/OpenChannelSSD/qemu-nvme) implementation.
+ *
+ *   Matias Bj=C3=B8rling <mb@lightnvm.io>
+ *   Javier Gonz=C3=A1lez <javier@javigon.com>
+ *   Simon Andreas Frimann Lund <ocssd@safl.dk>
+ *   Hans Holmberg <hans@owltronix.com>
+ *   Jesper Devantier <contact@pseudonymous.me>
+ *   Young Tack Jin <youngtack.jin@circuitblvd.com>
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ */
+
+/*
+ * This device emulates an OpenChannel 2.0 compliant NVMe controller.
+ *
+ * Reference docs: http://lightnvm.io/docs/OCSSD-2_0-20180129.pdf
+ *
+ *
+ * Usage
+ * -----
+ *
+ * The device must have a backing file to store its data. An initialized=
 OCSSD
+ * backing file must be created using qemu-img:
+ *
+ *   qemu-img create -f ocssd -o num_grp=3D2,num_pu=3D4,num_chk=3D60 ocs=
sd.img
+ *
+ * Besides the geometry options (num_{grp,pu,chk,sec}), qemu-img also su=
pports
+ * options related to write characteristics (ws_min, ws_opt and mw_cunit=
s) and
+ * lbads and ms sizes. These options can also be overwritten as paramete=
rs to
+ * the device. Issue
+ *
+ *   qemu-img create -f ocssd -o help
+ *
+ * to see the full list of supported options.
+ *
+ * To add the OCSSD NVMe device, extend the QEMU arguments with somethin=
g like
+ *
+ *   -blockdev ocssd,node-name=3Docssd01,file.driver=3Dfile,file.filenam=
e=3Docssd.img
+ *   -device nvme,drive=3Docssd01,serial=3Ddeadbeef,id=3Docssd01
+ *
+ * All of the standard nvme device options are supported, except 'ms', w=
hich is
+ * configured at image creation time.
+ *
+ * Additional advanced -device options.
+ *
+ *   mccap=3D<int>        : Media and Controller Capabilities (MCCAP). O=
R'ed
+ *                        value of the following:
+ *                          multiple resets                 0x2
+ *                          early resets (non-standard)     0x4
+ *   ws_min=3D<int>       : Mininum write size for device in sectors.
+ *   ws_opt=3D<int>       : Optimal write size for device in sectors.
+ *   mw_cunits=3D<int>    : Cache minimum write size units. If DULBE is =
enabled,
+ *                        an error will be reported if reads are within =
this
+ *                        window.
+ *   wit=3D<int>          : Wear-level index delta threshold.
+ *   chunkinfo=3D<file>   : Overwrite chunk states from file.
+ *   resetfail=3D<file>   : Reset fail injection configuration file.
+ *   writefail=3D<file>   : Write fail injection configuration file.
+ *   early_reset        : Allow early resets (reset open chunks).
+ *
+ * NOTE: mccap, ws_min, ws_opt, mw_cunits and wit defaults to whatever w=
as
+ * defined at image creation time.
+ *
+ * The emulated device maintains a Chunk Info Log Page on the backing bl=
ock
+ * device. When the device is brought up any state will be restored. The
+ * restored chunk states may be overwritten using the `chunkinfo` parame=
ter. An
+ * example chunk state file follows (note the use of the '*' wildcard to=
 match
+ * all groups, punits or chunks).
+ *
+ *     # "reset" all chunks
+ *     ns=3D1 group=3D* punit=3D* chunk=3D* state=3DFREE type=3DSEQUENTI=
AL pe_cycles=3D0
+ *
+ *     # first chunk on all luns has type random
+ *     ns=3D1 group=3D* punit=3D* chunk=3D0 type=3DRANDOM
+ *
+ *     # add an open chunk
+ *     ns=3D1 group=3D0 punit=3D0 chunk=3D1 state=3DOPEN type=3DSEQ wp=3D=
0x800
+ *
+ *     # add a closed chunk
+ *     ns=3D1 group=3D0 punit=3D0 chunk=3D2 state=3DCLOSED type=3DSEQ wp=
=3D0x1000
+ *
+ *     # add an offline chunk
+ *     ns=3D1 group=3D0 punit=3D0 chunk=3D3 state=3DOFFLINE type=3DSEQ
+ *
+ *
+ * The `resetfail` and `writefail` QEMU parameters can be used to do
+ * probabilistic error injection. The parameters points to text files an=
d they
+ * also support the '*' wildcard.
+ *
+ * Write error injection is done per sector.
+ *
+ *     # always fail writes for this sector
+ *     ns=3D1 group=3D0 punit=3D3 chunk=3D0 sectr=3D53 prob=3D100
+ *
+ *
+ * Reset error injection is done per chunk, so exclude the `sec` paramet=
er.
+ *
+ *     # always fail resets for this chunk
+ *     ns=3D1 group=3D0 punit=3D3 chunk=3D0 prob=3D100
+ *
+ *
+ * You probably want to make sure the following options are enabled in t=
he
+ * kernel you are going to use.
+ *
+ *     CONFIG_BLK_DEV_INTEGRITY=3Dy
+ *     CONFIG_HOTPLUG_PCI_PCIE=3Dy
+ *     CONFIG_HOTPLUG_PCI_ACPI=3Dy
+ *
+ *
+ * It is assumed that when using vector write requests, then the LBAs fo=
r
+ * different chunks are laid out contiguously and sorted with increasing
+ * addresses.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/sysemu.h"
+#include "qapi/error.h"
+
+#include "trace.h"
+#include "ocssd.h"
+
+/* #define OCSSD_CTRL_DEBUG */
+
+#ifdef OCSSD_CTRL_DEBUG
+#define _dprintf(fmt, ...) \
+    do { \
+        fprintf(stderr, "ocssd: " fmt, ## __VA_ARGS__); \
+    } while (0)
+
+static inline void _dprint_lba(OcssdCtrl *o, OcssdNamespace *ons, uint64=
_t lba)
+{
+    OcssdAddrF *addrf =3D &ons->addrf;
+
+    uint8_t group, punit;
+    uint16_t chunk;
+    uint32_t sectr;
+
+    group =3D _group(addrf, lba);
+    punit =3D _punit(addrf, lba);
+    chunk =3D _chunk(addrf, lba);
+    sectr =3D _sectr(addrf, lba);
+
+    _dprintf("lba 0x%016"PRIx64" group %"PRIu8" punit %"PRIu8" chunk %"P=
RIu16
+        " sectr %"PRIu32"\n", lba, group, punit, chunk, sectr);
+}
+
+static inline void _dprint_vector_rw(OcssdCtrl *o, NvmeRequest *req)
+{
+    OcssdNamespace *ons =3D _ons(o, req->ns->id);
+    _dprintf("vector %s request: cid %d nlb %d\n",
+        req->is_write ? "write" : "read", req->cqe.cid, req->nlb);
+    _dprintf("lba list:\n");
+    for (uint16_t i =3D 0; i < req->nlb; i++) {
+        _dprint_lba(o, ons, _vlba(req, i));
+    }
+}
+#else
+static void _dprint_lba(OcssdCtrl *o, OcssdNamespace *ons, uint64_t lba)=
 {}
+static void _dprint_vector_rw(OcssdCtrl *o, NvmeRequest *req) {}
+#endif
+
+
+static inline bool _is_write(NvmeRequest *req)
+{
+    return req->cmd.opcode =3D=3D OCSSD_CMD_VECT_WRITE || nvme_rw_is_wri=
te(req);
+}
+
+static inline bool _is_vector_request(NvmeRequest *req)
+{
+    switch (req->cmd.opcode) {
+    case OCSSD_CMD_VECT_RESET:
+    case OCSSD_CMD_VECT_WRITE:
+    case OCSSD_CMD_VECT_READ:
+    case OCSSD_CMD_VECT_COPY:
+        return true;
+    }
+
+    return false;
+}
+
+static inline OcssdNamespace *_ons(OcssdCtrl *o, uint32_t nsid)
+{
+    if (unlikely(nsid =3D=3D 0 || nsid > o->nvme.params.num_ns)) {
+        return NULL;
+    }
+
+    return &o->namespaces[nsid - 1];
+}
+
+static inline uint64_t _sectr(OcssdAddrF *addrf, uint64_t lba)
+{
+    return (lba & addrf->sec_mask) >> addrf->sec_offset;
+}
+
+static inline uint64_t _chunk(OcssdAddrF *addrf, uint64_t lba)
+{
+    return (lba & addrf->chk_mask) >> addrf->chk_offset;
+}
+
+static inline uint64_t _punit(OcssdAddrF *addrf, uint64_t lba)
+{
+    return (lba & addrf->pu_mask) >> addrf->pu_offset;
+}
+
+static inline uint64_t _group(OcssdAddrF *addrf, uint64_t lba)
+{
+    return (lba & addrf->grp_mask) >> addrf->grp_offset;
+}
+
+static inline uint64_t _make_lba(OcssdAddrF *addrf, uint16_t group,
+    uint16_t punit, uint32_t chunk, uint32_t sectr)
+{
+    return sectr << addrf->sec_offset
+        | chunk << addrf->chk_offset
+        | punit << addrf->pu_offset
+        | group << addrf->grp_offset;
+}
+
+static inline int _valid(OcssdCtrl *o, OcssdNamespace *ons, uint64_t lba=
)
+{
+    OcssdIdGeo *geo =3D &ons->id.geo;
+    OcssdAddrF *addrf =3D &ons->addrf;
+
+    return _sectr(addrf, lba) < geo->clba &&
+        _chunk(addrf, lba) < geo->num_chk &&
+        _punit(addrf, lba) < geo->num_pu &&
+        _group(addrf, lba) < geo->num_grp;
+}
+
+static inline uint64_t _sectr_idx(OcssdCtrl *o, OcssdNamespace *ons,
+    uint64_t lba)
+{
+    OcssdAddrF *addrf =3D &ons->addrf;
+
+    return _sectr(addrf, lba) +
+        _chunk(addrf, lba) * ons->secs_per_chk +
+        _punit(addrf, lba) * ons->secs_per_pu +
+        _group(addrf, lba) * ons->secs_per_grp;
+}
+
+static inline uint64_t _chk_idx(OcssdCtrl *o, OcssdNamespace *ons,
+    uint64_t lba)
+{
+    OcssdIdGeo *geo =3D &ons->id.geo;
+    OcssdAddrF *addrf =3D &ons->addrf;
+
+    return _chunk(addrf, lba) +
+        _punit(addrf, lba) * geo->num_chk +
+        _group(addrf, lba) * ons->chks_per_grp;
+}
+
+static inline uint64_t _vlba(NvmeRequest *req, uint16_t n)
+{
+    return req->nlb > 1 ? ((uint64_t *) req->slba)[n] : req->slba;
+}
+
+static inline void _sglist_to_iov(NvmeCtrl *n, QEMUSGList *qsg,
+    QEMUIOVector *iov)
+{
+    for (int i =3D 0; i < qsg->nsg; i++) {
+        qemu_iovec_add(iov, (void *) qsg->sg[i].base, qsg->sg[i].len);
+    }
+}
+
+/*
+ * _sglist_copy_from copies `len` bytes from the `idx`'th scatter gather=
 entry
+ * at `offset` in the `to` QEMUSGList into the `to` QEMUSGList. `idx` an=
d
+ * `offset` are updated to mark the position in `to` at which the functi=
on
+ * reached `len` bytes.
+ */
+static void _sglist_copy_from(QEMUSGList *to, QEMUSGList *from, int *idx=
,
+    size_t *offset, size_t len)
+{
+    dma_addr_t curr_addr, curr_len;
+
+    while (len) {
+        curr_addr =3D from->sg[*idx].base + *offset;
+        curr_len =3D from->sg[*idx].len - *offset;
+
+        curr_len =3D MIN(curr_len, len);
+
+        if (to) {
+            qemu_sglist_add(to, curr_addr, curr_len);
+        }
+
+        *offset +=3D curr_len;
+        len -=3D curr_len;
+
+        if (*offset =3D=3D from->sg[*idx].len) {
+            *offset =3D 0;
+            (*idx)++;
+        }
+    }
+}
+
+static inline bool _wi_outside_threshold(OcssdNamespace *ons,
+    OcssdChunkDescriptor *chk)
+{
+    return chk->wear_index < ons->wear_index_avg - ons->id.wit ||
+        chk->wear_index > ons->wear_index_avg + ons->id.wit;
+}
+
+static inline uint8_t _calc_wi(OcssdCtrl *o, uint32_t pe_cycles)
+{
+    return (pe_cycles * 255) / o->hdr.pe_cycles;
+}
+
+static OcssdChunkDescriptor *_get_chunk(OcssdCtrl *o, OcssdNamespace *on=
s,
+    uint64_t lba)
+{
+    if (!_valid(o, ons, lba)) {
+        return NULL;
+    }
+
+    return &ons->info.descr[_chk_idx(o, ons, lba)];
+}
+
+static OcssdChunkAcctDescriptor *_get_chunk_acct(OcssdCtrl *o,
+    OcssdNamespace *ons, uint64_t lba)
+{
+    if (!_valid(o, ons, lba)) {
+        return NULL;
+    }
+
+    return &ons->acct.descr[_chk_idx(o, ons, lba)];
+}
+
+static void _get_lba_list(OcssdCtrl *o, hwaddr addr, uint64_t **lbal,
+    NvmeRequest *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    uint32_t len =3D req->nlb * sizeof(uint64_t);
+
+    if (req->nlb > 1) {
+        *lbal =3D g_malloc_n(req->nlb, sizeof(uint64_t));
+        nvme_addr_read(n, addr, *lbal, len);
+    } else {
+        *lbal =3D (uint64_t *) addr;
+    }
+}
+
+static inline OcssdChunkState _str_to_chunk_state(char *s)
+{
+    if (!strcmp(s, "FREE")) {
+        return OCSSD_CHUNK_FREE;
+    }
+
+    if (!strcmp(s, "OFFLINE")) {
+        return OCSSD_CHUNK_OFFLINE;
+    }
+
+    if (!strcmp(s, "OPEN")) {
+        return OCSSD_CHUNK_OPEN;
+    }
+
+    if (!strcmp(s, "CLOSED")) {
+        return OCSSD_CHUNK_CLOSED;
+    }
+
+    return -1;
+}
+
+static inline OcssdChunkType _str_to_chunk_type(char *s)
+{
+    if (!strcmp(s, "SEQ") || !strcmp(s, "SEQUENTIAL")) {
+        return OCSSD_CHUNK_TYPE_SEQUENTIAL;
+    }
+
+    if (!strcmp(s, "RAN") || !strcmp(s, "RANDOM")) {
+        return OCSSD_CHUNK_TYPE_RANDOM;
+    }
+
+    return -1;
+}
+
+static int _parse_string(const char *s, const char *k, char **v)
+{
+    char *p =3D strstr(s, k);
+    if (!p) {
+        return 0;
+    }
+
+    return sscanf(p + strlen(k), "%ms", v);
+}
+
+static int _parse_uint8(const char *s, const char *k, uint8_t *v)
+{
+    char *p =3D strstr(s, k);
+    if (!p) {
+        return 0;
+    }
+
+    return sscanf(p + strlen(k), "0x%"SCNx8, v) ||
+        sscanf(p + strlen(k), "%"SCNu8, v);
+}
+
+static int _parse_uint16(const char *s, const char *k, uint16_t *v)
+{
+    char *p =3D strstr(s, k);
+    if (!p) {
+        return 0;
+    }
+
+    return sscanf(p + strlen(k), "0x%"SCNx16, v) ||
+        sscanf(p + strlen(k), "%"SCNu16, v);
+}
+
+static int _parse_uint32(const char *s, const char *k, uint32_t *v)
+{
+    char *p =3D strstr(s, k);
+    if (!p) {
+        return 0;
+    }
+
+    return sscanf(p + strlen(k), "0x%"SCNx32, v) ||
+        sscanf(p + strlen(k), "%"SCNu32, v);
+}
+
+static int _parse_uint64(const char *s, const char *k, uint64_t *v)
+{
+    char *p =3D strstr(s, k);
+    if (!p) {
+        return 0;
+    }
+
+    return sscanf(p + strlen(k), "0x%"SCNx64, v) ||
+        sscanf(p + strlen(k), "%"SCNu64, v);
+}
+
+static bool _parse_wildcard(const char *s, const char *k)
+{
+    char *v;
+    bool found =3D false;
+    if (!_parse_string(s, k, &v)) {
+        return false;
+    }
+
+    if (strcmp(v, "*") =3D=3D 0) {
+        found =3D true;
+    }
+
+    free(v);
+
+    return found;
+}
+
+static int _parse_lba_part_uint16(const char *s, const char *k,
+    uint16_t *bgn, uint16_t *end, uint16_t end_defval)
+{
+    if (!bgn || !end) {
+        return 1;
+    }
+
+    if (_parse_wildcard(s, k)) {
+        *bgn =3D 0;
+        *end =3D end_defval;
+
+        return 1;
+    }
+
+    if (!_parse_uint16(s, k, bgn)) {
+        return 0;
+    }
+
+    *end =3D *bgn + 1;
+
+    return 1;
+}
+
+static int _parse_lba_part_uint32(const char *s, const char *k,
+    uint32_t *bgn, uint32_t *end, uint32_t end_defval)
+{
+    if (!bgn || !end) {
+        return 1;
+    }
+
+    if (_parse_wildcard(s, k)) {
+        *bgn =3D 0;
+        *end =3D end_defval;
+
+        return 1;
+    }
+
+    if (!_parse_uint32(s, k, bgn)) {
+        return 0;
+    }
+
+    *end =3D *bgn + 1;
+
+    return 1;
+}
+
+static int _parse_lba_parts(OcssdIdGeo *geo, const char *s,
+    uint16_t *grp_bgn, uint16_t *grp_end, uint16_t *pu_bgn,
+    uint16_t *pu_end, uint32_t *chk_bgn, uint32_t *chk_end,
+    uint32_t *sec_bgn, uint32_t *sec_end, Error **errp)
+{
+    if (!_parse_lba_part_uint16(s, "group=3D", grp_bgn, grp_end, geo->nu=
m_grp)) {
+        error_setg(errp, "could not parse group");
+        return 0;
+    }
+
+    if (!_parse_lba_part_uint16(s, "punit=3D", pu_bgn, pu_end, geo->num_=
pu)) {
+        error_setg(errp, "could not parse punit");
+        return 0;
+    }
+
+    if (!_parse_lba_part_uint32(s, "chunk=3D", chk_bgn, chk_end, geo->nu=
m_chk)) {
+        error_setg(errp, "could not parse chunk");
+        return 0;
+    }
+
+    if (!_parse_lba_part_uint32(s, "sectr=3D", sec_bgn, sec_end, geo->cl=
ba)) {
+        error_setg(errp, "could not parse sectr");
+        return 0;
+    }
+
+    return 1;
+}
+
+static int _parse_and_update_reset_error_injection(OcssdCtrl *o, const c=
har *s,
+    Error **errp)
+{
+    OcssdNamespace *ons;
+    OcssdIdGeo *geo;
+    uint16_t group, group_end, punit, punit_end;
+    uint32_t nsid, chunk, chunk_end;
+    uint64_t idx;
+    uint8_t prob;
+    Error *local_err =3D NULL;
+
+    size_t slen =3D strlen(s);
+    if (slen =3D=3D 1 || (slen > 1 && s[0] =3D=3D '#')) {
+        return 0;
+    }
+
+    if (!_parse_uint32(s, "ns=3D", &nsid)) {
+        error_setg(errp, "could not parse namespace id");
+        return 1;
+    }
+
+    ons =3D &o->namespaces[nsid - 1];
+    geo =3D &ons->id.geo;
+
+    if (!_parse_lba_parts(geo, s, &group, &group_end, &punit, &punit_end=
,
+        &chunk, &chunk_end, NULL, NULL, &local_err)) {
+        error_propagate_prepend(errp, local_err, "could not parse chunk =
slba");
+        return 1;
+    }
+
+    if (!_parse_uint8(s, "prob=3D", &prob)) {
+        error_setg(errp, "could not parse probability");
+        return 1;
+    }
+
+    if (prob > 100) {
+        error_setg(errp, "invalid probability");
+        return 1;
+    }
+
+    for (uint16_t g =3D group; g < group_end; g++) {
+        for (uint16_t p =3D punit; p < punit_end; p++) {
+            for (uint32_t c =3D chunk; c < chunk_end; c++) {
+                idx =3D _chk_idx(o, ons, _make_lba(&ons->addrf, g, p, c,=
 0));
+                ons->resetfail[idx] =3D prob;
+            }
+        }
+    }
+
+    return 0;
+}
+
+static int _parse_and_update_write_error_injection(OcssdCtrl *o, const c=
har *s,
+    Error **errp)
+{
+    OcssdNamespace *ons;
+    OcssdIdGeo *geo;
+    uint16_t group, group_end, punit, punit_end;
+    uint32_t nsid, chunk, chunk_end, sectr, sectr_end;
+    uint64_t sectr_idx;
+    uint8_t prob;
+    Error *local_err =3D NULL;
+
+    size_t slen =3D strlen(s);
+    if (slen =3D=3D 1 || (slen > 1 && s[0] =3D=3D '#')) {
+        return 0;
+    }
+
+    if (!_parse_uint32(s, "ns=3D", &nsid)) {
+        error_setg(errp, "could not parse namespace id");
+        return 1;
+    }
+
+    ons =3D &o->namespaces[nsid - 1];
+    geo =3D &ons->id.geo;
+
+    if (!_parse_lba_parts(geo, s, &group, &group_end, &punit, &punit_end=
,
+        &chunk, &chunk_end, &sectr, &sectr_end, &local_err)) {
+        error_propagate_prepend(errp, local_err, "could not parse lba");
+        return 1;
+    }
+
+    if (!_parse_uint8(s, "prob=3D", &prob)) {
+        error_setg(errp, "could not parse probability");
+        return 1;
+    }
+
+    if (prob > 100) {
+        error_setg(errp, "invalid probability");
+        return 1;
+    }
+
+    for (uint16_t g =3D group; g < group_end; g++) {
+        for (uint16_t p =3D punit; p < punit_end; p++) {
+            for (uint32_t c =3D chunk; c < chunk_end; c++) {
+                for (uint32_t s =3D sectr; s < sectr_end; s++) {
+                    sectr_idx =3D _sectr_idx(o, ons, _make_lba(
+                        &ons->addrf, g, p, c, s));
+                    ons->writefail[sectr_idx] =3D prob;
+                }
+            }
+        }
+    }
+
+    return 0;
+}
+
+static int _parse_and_update_chunk_info(OcssdCtrl *o, const char *s,
+    Error **errp)
+{
+    char *v;
+    OcssdChunkDescriptor *chk;
+    OcssdChunkAcctDescriptor *chk_acct;
+    OcssdNamespace *ons;
+    OcssdIdGeo *geo;
+    uint16_t group, group_end, punit, punit_end;
+    uint32_t nsid, chunk, chunk_end, pe_cycles;
+    uint64_t cnlb, wp, slba;
+    int state =3D 0, type =3D 0;
+    bool cnlb_parsed =3D false, wp_parsed =3D false, pe_cycles_parsed =3D=
 false;
+    bool state_parsed =3D false, type_parsed =3D false;
+    Error *local_err =3D NULL;
+
+    size_t slen =3D strlen(s);
+    if (slen =3D=3D 1 || (slen > 1 && s[0] =3D=3D '#')) {
+        return 0;
+    }
+
+    if (!_parse_uint32(s, "ns=3D", &nsid)) {
+        error_setg(errp, "could not parse namespace id");
+        return 1;
+    }
+
+    ons =3D &o->namespaces[nsid - 1];
+    geo =3D &ons->id.geo;
+
+    if (!_parse_lba_parts(geo, s, &group, &group_end, &punit, &punit_end=
,
+        &chunk, &chunk_end, NULL, NULL, &local_err)) {
+        error_propagate_prepend(errp, local_err, "could not parse chunk =
slba");
+        return 1;
+    }
+
+    if (_parse_string(s, "state=3D", &v)) {
+        state_parsed =3D true;
+        state =3D _str_to_chunk_state(v);
+        free(v);
+
+        if (state < 0) {
+            error_setg(errp, "invalid chunk state");
+            return 1;
+        }
+    }
+
+    if (_parse_string(s, "type=3D", &v)) {
+        type_parsed =3D true;
+        type =3D _str_to_chunk_type(v);
+        free(v);
+
+        if (type < 0) {
+            error_setg(errp, "invalid chunk type");
+            return 1;
+        }
+    }
+
+    if (_parse_uint64(s, "cnlb=3D", &cnlb)) {
+        cnlb_parsed =3D true;
+    }
+
+    if (_parse_uint64(s, "wp=3D", &wp)) {
+        wp_parsed =3D true;
+    }
+
+    if (_parse_uint32(s, "pe_cycles=3D", &pe_cycles)) {
+        pe_cycles =3D true;
+    }
+
+    if (state_parsed) {
+        if (state =3D=3D OCSSD_CHUNK_OFFLINE && wp_parsed) {
+            error_setg(errp, "invalid wp; state is offline");
+            return 1;
+        }
+    }
+
+    if (type_parsed) {
+        if (type =3D=3D OCSSD_CHUNK_TYPE_RANDOM && wp_parsed) {
+            error_setg(errp, "invalid wp; type has random write capabili=
ty");
+            return 1;
+        }
+    }
+
+    for (uint16_t g =3D group; g < group_end; g++) {
+        for (uint16_t p =3D punit; p < punit_end; p++) {
+            for (uint32_t c =3D chunk; c < chunk_end; c++) {
+                slba =3D _make_lba(&ons->addrf, g, p, c, 0);
+                chk =3D _get_chunk(o, ons, slba);
+                chk_acct =3D _get_chunk_acct(o, ons, slba);
+                if (!chk) {
+                    error_setg(errp, "invalid lba");
+                    return 1;
+                }
+
+                if (state_parsed) {
+                    /*
+                     * Reset the wear index and pe_cycles to zero if the
+                     * persisted state is OFFLINE and we move to another=
 state.
+                     * If the number of pe_cycles is also changed, it wi=
ll be
+                     * updated subsequently.
+                     */
+                    if (chk->state =3D=3D OCSSD_CHUNK_OFFLINE &&
+                        state !=3D OCSSD_CHUNK_OFFLINE) {
+                        chk->wear_index =3D 0;
+                        chk_acct->pe_cycles =3D 0;
+                    }
+
+                    if (state =3D=3D OCSSD_CHUNK_OFFLINE) {
+                        chk->wp =3D UINT64_MAX;
+                    }
+
+                    if (state =3D=3D OCSSD_CHUNK_FREE) {
+                        chk->wp =3D 0;
+                    }
+
+                    chk->state =3D state;
+                }
+
+                if (type_parsed) {
+                    chk->type =3D type;
+                    if (chk->type =3D=3D OCSSD_CHUNK_TYPE_RANDOM) {
+                        chk->wp =3D UINT64_MAX;
+                    }
+                }
+
+                if (cnlb_parsed) {
+                    chk->cnlb =3D cnlb;
+                    if (chk->cnlb > ons->id.geo.clba) {
+                        error_setg(errp, "invalid chunk cnlb");
+                        return 1;
+                    }
+
+                    if (chk->cnlb !=3D ons->id.geo.clba) {
+                        chk->type |=3D OCSSD_CHUNK_TYPE_SHRINKED;
+                    }
+                }
+
+                if (wp_parsed) {
+                    chk->wp =3D wp;
+                    if (chk->wp > chk->cnlb) {
+                        error_setg(errp, "invalid chunk wp");
+                        return 1;
+                    }
+                }
+
+                if (pe_cycles_parsed) {
+                    if (pe_cycles > o->hdr.pe_cycles) {
+                        error_setg(errp, "invalid number of pe_cycles");
+                        return 1;
+                    }
+
+                    chk->wear_index =3D _calc_wi(o, pe_cycles);
+                    chk_acct->pe_cycles =3D pe_cycles;
+                }
+            }
+        }
+    }
+
+    return 0;
+}
+
+static int ocssd_load_write_error_injection_from_file(OcssdCtrl *o,
+    const char *fname, Error **errp)
+{
+    ssize_t n;
+    size_t len =3D 0;
+    int line_num =3D 0;
+    char *line;
+    Error *local_err =3D NULL;
+    FILE *fp;
+
+    fp =3D fopen(fname, "r");
+    if (!fp) {
+        error_setg_errno(errp, errno,
+            "could not open write error injection file (%s): ", fname);
+        return 1;
+    }
+
+    while ((n =3D getline(&line, &len, fp)) !=3D -1) {
+        line_num++;
+        if (_parse_and_update_write_error_injection(o, line, &local_err)=
) {
+            error_propagate_prepend(errp, local_err,
+                "could not parse write error injection (line %d): ", lin=
e_num);
+            return 1;
+        }
+    }
+
+    fclose(fp);
+
+    return 0;
+}
+
+static int ocssd_load_reset_error_injection_from_file(OcssdCtrl *o,
+    const char *fname, Error **errp)
+{
+    ssize_t n;
+    size_t len =3D 0;
+    int line_num =3D 0;
+    char *line;
+    Error *local_err =3D NULL;
+    FILE *fp;
+
+    fp =3D fopen(fname, "r");
+    if (!fp) {
+        error_setg_errno(errp, errno,
+            "could not open reset error injection file (%s): ", fname);
+        return 1;
+    }
+
+    while ((n =3D getline(&line, &len, fp)) !=3D -1) {
+        line_num++;
+        if (_parse_and_update_reset_error_injection(o, line, &local_err)=
) {
+            error_propagate_prepend(errp, local_err,
+                "could not parse reset error injection (line %d): ", lin=
e_num);
+            return 1;
+        }
+    }
+
+    fclose(fp);
+
+    return 0;
+}
+
+static int ocssd_load_chunk_info_from_file(OcssdCtrl *o, const char *fna=
me,
+    Error **errp)
+{
+    ssize_t n;
+    size_t len =3D 0;
+    int line_num =3D 0;
+    char *line;
+    Error *local_err =3D NULL;
+    FILE *fp;
+
+    fp =3D fopen(fname, "r");
+    if (!fp) {
+        error_setg_errno(errp, errno, "could not open chunk info file");
+        return 1;
+    }
+
+    while ((n =3D getline(&line, &len, fp)) !=3D -1) {
+        line_num++;
+        if (_parse_and_update_chunk_info(o, line, &local_err)) {
+            error_propagate_prepend(errp, local_err,
+                "could not parse chunk info (line %d): ", line_num);
+            return 1;
+        }
+    }
+
+    fclose(fp);
+
+    return 0;
+}
+
+static void ocssd_ns_commit_chunk_acct(OcssdCtrl *o, OcssdNamespace *ons=
,
+    NvmeRequest *req, OcssdChunkDescriptor *chk,
+    OcssdChunkAcctDescriptor *chk_acct)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, NULL);
+
+    blk_req->blk_offset =3D ons->acct.blk_offset;
+
+    qemu_iovec_init(&blk_req->iov, 1);
+    if (chk) {
+        qemu_iovec_add(&blk_req->iov, chk_acct,
+            sizeof(OcssdChunkAcctDescriptor));
+        blk_req->blk_offset +=3D _chk_idx(o, ons, chk->slba) *
+            sizeof(OcssdChunkAcctDescriptor);
+    } else {
+        qemu_iovec_add(&blk_req->iov, ons->acct.descr, ons->acct.size);
+    }
+
+    QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+        blk_req->iov.size, BLOCK_ACCT_WRITE);
+
+    blk_req->aiocb =3D blk_aio_pwritev(n->conf.blk, blk_req->blk_offset,
+        &blk_req->iov, 0, nvme_rw_cb, blk_req);
+}
+
+static void ocssd_ns_commit_chunk_state(OcssdCtrl *o, OcssdNamespace *on=
s,
+    NvmeRequest *req, OcssdChunkDescriptor *chk)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, NULL);
+
+    blk_req->blk_offset =3D ons->info.blk_offset;
+
+    qemu_iovec_init(&blk_req->iov, 1);
+    if (chk) {
+        qemu_iovec_add(&blk_req->iov, chk, sizeof(OcssdChunkDescriptor))=
;
+        blk_req->blk_offset +=3D _chk_idx(o, ons, chk->slba) *
+            sizeof(OcssdChunkDescriptor);
+    } else {
+        qemu_iovec_add(&blk_req->iov, ons->info.descr, ons->info.size);
+    }
+
+    QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+        blk_req->iov.size, BLOCK_ACCT_WRITE);
+
+    blk_req->aiocb =3D blk_aio_pwritev(n->conf.blk, blk_req->blk_offset,
+        &blk_req->iov, 0, nvme_rw_cb, blk_req);
+}
+
+static int ocssd_ns_load_chunk_acct(OcssdCtrl *o, OcssdNamespace *ons)
+{
+    BlockBackend *blk =3D o->nvme.conf.blk;
+    return blk_pread(blk, ons->acct.blk_offset, ons->acct.descr,
+        ons->acct.size);
+}
+
+static int ocssd_ns_load_chunk_info(OcssdCtrl *o, OcssdNamespace *ons)
+{
+    BlockBackend *blk =3D o->nvme.conf.blk;
+    return blk_pread(blk, ons->info.blk_offset, ons->info.descr,
+        ons->info.size);
+}
+
+static uint16_t ocssd_do_get_chunk_info(OcssdCtrl *o, NvmeCmd *cmd,
+    uint32_t buf_len, uint64_t off, NvmeRequest *req)
+{
+    uint8_t *log_page;
+    uint32_t log_len, trans_len;
+
+    OcssdNamespace *ons =3D _ons(o, le32_to_cpu(cmd->nsid));
+    if (!ons) {
+        trace_ocssd_err(req->cqe.cid, "chunk info requires nsid",
+            NVME_INVALID_FIELD | NVME_DNR);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    log_len =3D ons->chks_total * sizeof(OcssdChunkDescriptor);
+
+    if (off > log_len) {
+        trace_ocssd_err(req->cqe.cid, "invalid log page offset",
+            NVME_INVALID_FIELD | NVME_DNR);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(log_len - off, buf_len);
+    log_page =3D (uint8_t *) ons->info.descr + off;
+
+    return nvme_dma_read(&o->nvme, log_page, trans_len, cmd, req);
+}
+
+static uint16_t ocssd_do_get_chunk_notification(OcssdCtrl *o, NvmeCmd *c=
md,
+    uint32_t buf_len, uint64_t off, uint8_t rae, NvmeRequest *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+
+    uint8_t *log_page;
+    uint32_t log_len, trans_len;
+
+    log_len =3D OCSSD_MAX_CHUNK_NOTIFICATIONS * sizeof(OcssdChunkNotific=
ation);
+
+    if (off > log_len) {
+        trace_ocssd_err(req->cqe.cid, "invalid log page offset",
+            NVME_INVALID_FIELD | NVME_DNR);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(log_len - off, buf_len);
+    log_page =3D (uint8_t *) &o->notifications[off];
+
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_VENDOR_SPECIFIC);
+    }
+
+    return nvme_dma_read(&o->nvme, log_page, trans_len, cmd, req);
+}
+
+static void ocssd_add_chunk_notification(OcssdCtrl *o, OcssdNamespace *o=
ns,
+    uint64_t lba, uint16_t state, uint8_t mask, uint16_t nlb)
+{
+    NvmeNamespace *ns =3D ons->ns;
+    OcssdChunkNotification *notice;
+
+    notice =3D &o->notifications[o->notifications_index];
+    notice->nc =3D cpu_to_le64(++(o->notifications_count));
+    notice->lba =3D cpu_to_le64(lba);
+    notice->nsid =3D cpu_to_le32(ns->id);
+    notice->state =3D cpu_to_le16(state);
+    notice->mask =3D mask;
+    notice->nlb =3D cpu_to_le16(nlb);
+
+    o->notifications_index =3D (o->notifications_index + 1) %
+        OCSSD_MAX_CHUNK_NOTIFICATIONS;
+}
+
+static uint16_t ocssd_rw_check_chunk_read(OcssdCtrl *o, NvmeCmd *cmd,
+    NvmeRequest *req, uint64_t lba)
+{
+    NvmeNamespace *ns =3D req->ns;
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+    OcssdAddrF *addrf =3D &ons->addrf;
+    OcssdIdWrt *wrt =3D &ons->id.wrt;
+
+    OcssdChunkDescriptor *chk;
+    uint64_t sectr, mw_cunits, wp;
+    uint8_t state;
+
+    chk =3D _get_chunk(o, ons, lba);
+    if (!chk) {
+        trace_ocssd_err_invalid_chunk(req->cqe.cid,
+            lba & ~ons->addrf.sec_mask);
+        return NVME_DULB;
+    }
+
+    sectr =3D _sectr(addrf, lba);
+    mw_cunits =3D wrt->mw_cunits;
+    wp =3D chk->wp;
+    state =3D chk->state;
+
+    if (chk->type =3D=3D OCSSD_CHUNK_TYPE_RANDOM) {
+        /*
+         * For OCSSD_CHUNK_TYPE_RANDOM it is sufficient to ensure that t=
he
+         * chunk is OPEN and that we are reading a valid address.
+         */
+        if (state !=3D OCSSD_CHUNK_OPEN || sectr >=3D chk->cnlb) {
+            trace_ocssd_err_invalid_chunk_state(req->cqe.cid,
+                lba & ~(ons->addrf.sec_mask), chk->state);
+            return NVME_DULB;
+        }
+
+        return NVME_SUCCESS;
+    }
+
+    if (state =3D=3D OCSSD_CHUNK_CLOSED && sectr < wp) {
+        return NVME_SUCCESS;
+    }
+
+    if (state =3D=3D OCSSD_CHUNK_OPEN) {
+        if (wp < mw_cunits) {
+            return NVME_DULB;
+        }
+
+        if (sectr < (wp - mw_cunits)) {
+            return NVME_SUCCESS;
+        }
+    }
+
+    return NVME_DULB;
+}
+
+static uint16_t ocssd_rw_check_chunk_write(OcssdCtrl *o, NvmeCmd *cmd,
+    uint64_t lba, uint32_t ws, NvmeRequest *req)
+{
+    OcssdChunkDescriptor *chk;
+    NvmeNamespace *ns =3D req->ns;
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+
+    OcssdIdWrt *wrt =3D &ons->id.wrt;
+
+    chk =3D _get_chunk(o, ons, lba);
+    if (!chk) {
+        trace_ocssd_err_invalid_chunk(req->cqe.cid,
+            lba & ~ons->addrf.sec_mask);
+        return NVME_WRITE_FAULT | NVME_DNR;
+    }
+
+    uint32_t start_sectr =3D lba & ons->addrf.sec_mask;
+    uint32_t end_sectr =3D start_sectr + ws;
+
+    /* check if we are at all allowed to write to the chunk */
+    if (chk->state =3D=3D OCSSD_CHUNK_OFFLINE ||
+        chk->state =3D=3D OCSSD_CHUNK_CLOSED) {
+        trace_ocssd_err_invalid_chunk_state(req->cqe.cid,
+            lba & ~(ons->addrf.sec_mask), chk->state);
+        return NVME_WRITE_FAULT | NVME_DNR;
+    }
+
+    if (end_sectr > chk->cnlb) {
+        trace_ocssd_err_out_of_bounds(req->cqe.cid, end_sectr, chk->cnlb=
);
+        return NVME_WRITE_FAULT | NVME_DNR;
+    }
+
+
+    if (chk->type =3D=3D OCSSD_CHUNK_TYPE_RANDOM) {
+        return NVME_SUCCESS;
+    }
+
+    if (ws < wrt->ws_min || (ws % wrt->ws_min) !=3D 0) {
+        trace_ocssd_err_write_constraints(req->cqe.cid, ws, wrt->ws_min)=
;
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* check that the write begins at the current wp */
+    if (start_sectr !=3D chk->wp) {
+        trace_ocssd_err_out_of_order(req->cqe.cid, start_sectr, chk->wp)=
;
+        return OCSSD_OUT_OF_ORDER_WRITE | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t ocssd_rw_check_vector_read_req(OcssdCtrl *o, NvmeCmd *cm=
d,
+    NvmeRequest *req, uint64_t *dulbe)
+{
+    uint16_t status;
+
+    assert(dulbe);
+
+    for (int i =3D 0; i < req->nlb; i++) {
+        status =3D ocssd_rw_check_chunk_read(o, cmd, req, _vlba(req, i))=
;
+
+        if (status) {
+            if (nvme_is_error(status, NVME_DULB)) {
+                *dulbe |=3D (1 << i);
+                continue;
+            }
+
+            return status;
+        }
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t ocssd_rw_check_vector_write_req(OcssdCtrl *o, NvmeCmd *c=
md,
+    NvmeRequest *req)
+{
+    NvmeNamespace *ns =3D req->ns;
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+    OcssdAddrF *addrf =3D &ons->addrf;
+
+    uint64_t prev_lba =3D _vlba(req, 0);
+    uint64_t prev_chk_idx =3D _chk_idx(o, ons, prev_lba);
+    uint32_t sectr =3D _sectr(addrf, prev_lba);
+    uint16_t ws =3D 1, status;
+
+    for (uint16_t i =3D 1; i < req->nlb; i++) {
+        uint64_t lba =3D _vlba(req, i);
+        uint64_t chk_idx =3D _chk_idx(o, ons, lba);
+
+        /*
+         * It is assumed that LBAs for different chunks are laid out
+         * contiguously and sorted with increasing addresses.
+         */
+        if (prev_chk_idx !=3D chk_idx) {
+            status =3D ocssd_rw_check_chunk_write(o, cmd, prev_lba, ws, =
req);
+            if (status) {
+                req->cqe.res64 =3D cpu_to_le64((1 << req->nlb) - 1);
+                return status;
+            }
+
+            prev_lba =3D lba;
+            prev_chk_idx =3D chk_idx;
+            sectr =3D _sectr(addrf, prev_lba);
+            ws =3D 1;
+
+            continue;
+        }
+
+        if (++sectr !=3D _sectr(addrf, lba)) {
+            return OCSSD_OUT_OF_ORDER_WRITE | NVME_DNR;
+        }
+
+        ws++;
+    }
+
+    return ocssd_rw_check_chunk_write(o, cmd, prev_lba, ws, req);
+}
+
+static uint16_t ocssd_rw_check_scalar_req(OcssdCtrl *o, NvmeCmd *cmd,
+    NvmeRequest *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    uint16_t status;
+
+    status =3D nvme_rw_check_req(n, cmd, req);
+    if (status) {
+        trace_ocssd_err(req->cqe.cid, "nvme_rw_check_req", status);
+        return status;
+    }
+
+    if (req->is_write) {
+        return ocssd_rw_check_chunk_write(o, cmd, req->slba, req->nlb, r=
eq);
+    }
+
+    for (uint16_t i =3D 0; i < req->nlb; i++) {
+        status =3D ocssd_rw_check_chunk_read(o, cmd, req, req->slba + i)=
;
+        if (nvme_is_error(status, NVME_DULB)) {
+            if (NVME_ERR_REC_DULBE(n->features.err_rec)) {
+                return NVME_DULB | NVME_DNR;
+            }
+
+            break;
+        }
+
+        return status;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t ocssd_rw_check_vector_req(OcssdCtrl *o, NvmeCmd *cmd,
+    NvmeRequest *req, uint64_t *dulbe)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    uint16_t status;
+
+    status =3D nvme_rw_check_req(n, cmd, req);
+    if (status) {
+        trace_ocssd_err(req->cqe.cid, "nvme_rw_check_req", status);
+        return status;
+    }
+
+    if (req->is_write) {
+        return ocssd_rw_check_vector_write_req(o, cmd, req);
+    }
+
+    return ocssd_rw_check_vector_read_req(o, cmd, req, dulbe);
+}
+
+static uint16_t ocssd_blk_setup_scalar(NvmeCtrl *n, NvmeNamespace *ns,
+    QEMUSGList *qsg, uint64_t blk_offset, uint32_t unit_len, NvmeRequest=
 *req)
+{
+    OcssdCtrl *o =3D OCSSD(n);
+    OcssdNamespace *ons =3D _ons(o, req->ns->id);
+
+    NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, qsg);
+    if (!blk_req) {
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "nvme_blk_req_get: %=
s",
+            "could not allocate memory");
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    blk_req->slba =3D req->slba;
+    blk_req->nlb =3D req->nlb;
+    blk_req->blk_offset =3D blk_offset + _sectr_idx(o, ons, req->slba) *
+        unit_len;
+
+    QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t ocssd_blk_setup_vector(NvmeCtrl *n, NvmeNamespace *ns,
+    QEMUSGList *qsg, uint64_t blk_offset, uint32_t unit_len, NvmeRequest=
 *req)
+{
+    OcssdCtrl *o =3D OCSSD(n);
+    OcssdNamespace *ons =3D _ons(o, req->ns->id);
+
+    size_t curr_byte =3D 0;
+    uint64_t lba, chk_idx, prev_chk_idx;
+    int curr_sge =3D 0;
+
+    NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, NULL);
+    pci_dma_sglist_init(&blk_req->qsg, &n->parent_obj, 1);
+
+    /*
+     * Similar to ocssd_rw_check_vector_write_req, it is assumed that LB=
As for
+     * different chunks are laid out contiguously and sorted with increa=
sing
+     * addresses. Thus, split request into multiple NvmeBlockBackendRequ=
est for
+     * each chunk involved unconditionally, even if the last sector of c=
hunk N
+     * has address K and the first address of chunk N+1 has address K+1 =
and
+     * would be contiguous on the block backend. The invariant that a si=
ngle
+     * NvmeBlockBackendRequest corresponds to at most one chunk is used =
in
+     * e.g. write error injection.
+     */
+
+    lba =3D _vlba(req, 0);
+    prev_chk_idx =3D _chk_idx(o, ons, lba);
+
+    blk_req->blk_offset =3D blk_offset + _sectr_idx(o, ons, lba) * unit_=
len;
+    blk_req->slba =3D lba;
+    blk_req->nlb =3D 1;
+
+    QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    for (uint16_t i =3D 1; i < req->nlb; i++) {
+        lba =3D _vlba(req, i);
+        chk_idx =3D _chk_idx(o, ons, lba);
+
+        if (prev_chk_idx !=3D chk_idx) {
+            _sglist_copy_from(&blk_req->qsg, qsg, &curr_sge, &curr_byte,
+                blk_req->nlb * unit_len);
+
+            blk_req =3D nvme_blk_req_get(n, req, NULL);
+            if (!blk_req) {
+                NVME_GUEST_ERR(nvme_err_internal_dev_error,
+                    "nvme_blk_req_get: %s", "could not allocate memory")=
;
+                return NVME_INTERNAL_DEV_ERROR;
+            }
+
+            pci_dma_sglist_init(&blk_req->qsg, &n->parent_obj, 1);
+
+            blk_req->blk_offset =3D blk_offset + _sectr_idx(o, ons, lba)=
 *
+                unit_len;
+            blk_req->slba =3D lba;
+
+            QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry=
);
+
+            prev_chk_idx =3D chk_idx;
+        }
+
+        blk_req->nlb++;
+    }
+
+    _sglist_copy_from(&blk_req->qsg, qsg, &curr_sge, &curr_byte,
+        blk_req->nlb * unit_len);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t ocssd_do_chunk_reset(OcssdCtrl *o, OcssdNamespace *ons,
+    uint64_t lba, hwaddr mptr, NvmeRequest *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    OcssdChunkDescriptor *chk;
+    OcssdChunkAcctDescriptor *chk_acct;
+    uint8_t p;
+
+    chk =3D _get_chunk(o, ons, lba);
+    if (!chk) {
+        trace_ocssd_err_invalid_chunk(req->cqe.cid,
+            lba & ~ons->addrf.sec_mask);
+        return OCSSD_INVALID_RESET | NVME_DNR;
+    }
+
+    if (chk->state & OCSSD_CHUNK_RESETABLE) {
+        switch (chk->state) {
+        case OCSSD_CHUNK_FREE:
+            trace_ocssd_notice_double_reset(req->cqe.cid, lba);
+
+            if (!(ons->id.mccap & OCSSD_IDENTITY_MCCAP_MULTIPLE_RESETS))=
 {
+                return OCSSD_INVALID_RESET | NVME_DNR;
+            }
+
+            break;
+
+        case OCSSD_CHUNK_OPEN:
+            trace_ocssd_notice_early_reset(req->cqe.cid, lba, chk->wp);
+            if (!(ons->id.mccap & OCSSD_IDENTITY_MCCAP_EARLY_RESET)) {
+                return OCSSD_INVALID_RESET | NVME_DNR;
+            }
+
+            break;
+        }
+
+        if (ons->resetfail) {
+            p =3D ons->resetfail[_chk_idx(o, ons, lba)];
+
+            if (p =3D=3D 100 || (rand() % 100) < p) {
+                chk->state =3D OCSSD_CHUNK_OFFLINE;
+                chk->wp =3D UINT64_MAX;
+                trace_ocssd_inject_reset_err(req->cqe.cid, p, lba);
+                return OCSSD_INVALID_RESET | NVME_DNR;
+            }
+        }
+
+        chk->state =3D OCSSD_CHUNK_FREE;
+
+        if (chk->type =3D=3D OCSSD_CHUNK_TYPE_SEQUENTIAL) {
+            chk->wp =3D 0;
+
+            chk_acct =3D _get_chunk_acct(o, ons, lba);
+
+            if (chk_acct->pe_cycles < o->hdr.pe_cycles) {
+                chk_acct->pe_cycles++;
+
+                ons->wear_index_total++;
+                ons->wear_index_avg =3D ons->wear_index_total / ons->chk=
s_total;
+
+                chk->wear_index =3D _calc_wi(o, chk_acct->pe_cycles);
+
+                if (_wi_outside_threshold(ons, chk)) {
+                    ocssd_add_chunk_notification(o, ons, chk->slba,
+                        OCSSD_CHUNK_NOTIFICATION_STATE_WLI,
+                        OCSSD_CHUNK_NOTIFICATION_MASK_CHUNK, 0);
+
+                    nvme_enqueue_event(n, NVME_AER_TYPE_VENDOR_SPECIFIC,=
 0x0,
+                        OCSSD_CHUNK_NOTIFICATION);
+                }
+            }
+
+            if (chk->wear_index =3D=3D 255) {
+                chk->state =3D OCSSD_CHUNK_OFFLINE;
+            }
+
+            ocssd_ns_commit_chunk_acct(o, ons, req, chk, chk_acct);
+        }
+
+        if (mptr) {
+            nvme_addr_write(n, mptr, chk, sizeof(*chk));
+        }
+
+        ocssd_ns_commit_chunk_state(o, ons, req, chk);
+
+        return NVME_SUCCESS;
+    }
+
+    trace_ocssd_err_offline_chunk(req->cqe.cid, lba);
+
+    return OCSSD_OFFLINE_CHUNK | NVME_DNR;
+}
+
+static uint16_t ocssd_do_advance_wp(OcssdCtrl *o, OcssdNamespace *ons,
+    uint64_t lba, uint16_t nlb, NvmeRequest *req)
+{
+    OcssdChunkDescriptor *chk;
+
+    trace_ocssd_advance_wp(req->cqe.cid, lba, nlb);
+    _dprint_lba(o, ons, lba);
+
+    chk =3D _get_chunk(o, ons, lba);
+    if (!chk) {
+        NVME_GUEST_ERR(ocssd_err_invalid_chunk,
+            "invalid chunk; cid %d slba 0x%lx", req->cqe.cid,
+            lba & ~ons->addrf.sec_mask);
+        return NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+    }
+
+    if (chk->state =3D=3D OCSSD_CHUNK_FREE) {
+        chk->state =3D OCSSD_CHUNK_OPEN;
+    }
+
+    if (chk->type =3D=3D OCSSD_CHUNK_TYPE_RANDOM) {
+        goto commit;
+    }
+
+    if (chk->state !=3D OCSSD_CHUNK_OPEN) {
+        NVME_GUEST_ERR(ocssd_err_invalid_chunk_state,
+            "invalid chunk state; cid %d slba 0x%lx state 0x%x",
+            req->cqe.cid, lba, chk->state);
+        return NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+    }
+
+    chk->wp +=3D nlb;
+    if (chk->wp =3D=3D chk->cnlb) {
+        chk->state =3D OCSSD_CHUNK_CLOSED;
+    }
+
+commit:
+    ocssd_ns_commit_chunk_state(o, ons, req, chk);
+
+    return NVME_SUCCESS;
+}
+
+static void ocssd_dsm_cb(void *opaque, int ret)
+{
+    NvmeBlockBackendRequest *blk_req =3D opaque;
+    NvmeRequest *req =3D blk_req->req;
+    NvmeSQueue *sq =3D req->sq;
+    NvmeCtrl *n =3D sq->ctrl;
+    NvmeCQueue *cq =3D n->cq[sq->cqid];
+    NvmeNamespace *ns =3D req->ns;
+
+    OcssdCtrl *o =3D OCSSD(n);
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+
+    uint16_t status;
+
+    QTAILQ_REMOVE(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    if (!ret) {
+        status =3D ocssd_do_chunk_reset(o, ons, blk_req->slba, 0x0, req)=
;
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "ocssd_do_chunk_reset", status=
);
+            req->status =3D status;
+            goto out;
+        }
+    } else {
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "block request faile=
d: %s",
+            strerror(-ret));
+        req->status =3D NVME_INTERNAL_DEV_ERROR;
+    }
+
+out:
+    if (QTAILQ_EMPTY(&req->blk_req_tailq)) {
+        nvme_enqueue_req_completion(cq, req);
+    }
+
+    nvme_blk_req_put(n, blk_req);
+}
+
+
+static uint16_t ocssd_dsm(OcssdCtrl *o, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    NvmeNamespace *ns =3D req->ns;
+    NvmeDsmCmd *dsm =3D (NvmeDsmCmd *) cmd;
+
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+
+    uint16_t status;
+
+    if (dsm->attributes & NVME_DSMGMT_AD) {
+        NvmeBlockBackendRequest *blk_req;
+        OcssdChunkDescriptor *chk;
+
+        uint16_t nr =3D (dsm->nr & 0xff) + 1;
+        uint8_t lbads =3D nvme_ns_lbads(ns);
+
+        NvmeDsmRange range[nr];
+
+        status =3D nvme_dma_write(n, (uint8_t *) range, sizeof(range), c=
md, req);
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "nvme_dma_write", status);
+            return status;
+        }
+
+        for (int i =3D 0; i < nr; i++) {
+            chk =3D _get_chunk(o, ons, range[i].slba);
+
+            if (!chk) {
+                trace_ocssd_err_invalid_chunk(req->cqe.cid,
+                    range[i].slba & ~ons->addrf.sec_mask);
+                return OCSSD_INVALID_RESET | NVME_DNR;
+            }
+
+            if (range[i].nlb !=3D chk->cnlb) {
+                trace_ocssd_err(req->cqe.cid, "invalid reset size",
+                    NVME_LBA_RANGE);
+                return NVME_LBA_RANGE | NVME_DNR;
+            }
+
+            blk_req =3D nvme_blk_req_get(n, req, NULL);
+            if (!blk_req) {
+                NVME_GUEST_ERR(nvme_err_internal_dev_error,
+                    "nvme_blk_req_get: %s", "could not allocate memory")=
;
+                return NVME_INTERNAL_DEV_ERROR;
+            }
+
+            blk_req->slba =3D range[i].slba;
+
+            QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry=
);
+
+            blk_req->aiocb =3D blk_aio_pdiscard(n->conf.blk,
+                ns->blk_offset + _sectr_idx(o, ons, range[i].slba),
+                range[i].nlb << lbads,
+                ocssd_dsm_cb, blk_req);
+        }
+
+        return NVME_NO_COMPLETE;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static void ocssd_reset_cb(void *opaque, int ret)
+{
+    NvmeBlockBackendRequest *blk_req =3D opaque;
+    NvmeRequest *req =3D blk_req->req;
+    NvmeSQueue *sq =3D req->sq;
+    NvmeCtrl *n =3D sq->ctrl;
+    NvmeCQueue *cq =3D n->cq[sq->cqid];
+    NvmeNamespace *ns =3D req->ns;
+
+    OcssdCtrl *o =3D OCSSD(n);
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+
+    hwaddr mptr;
+    uint16_t status;
+
+    QTAILQ_REMOVE(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    if (!ret) {
+        /*
+         * blk_req->nlb has been hijacked to store the index that this e=
ntry
+         * held in the LBA list, so use that to calculate the MPTR offse=
t.
+         */
+        mptr =3D req->mptr ? req->mptr +
+            blk_req->nlb * sizeof(OcssdChunkDescriptor) : 0x0;
+        status =3D ocssd_do_chunk_reset(o, ons, blk_req->slba, mptr, req=
);
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "ocssd_do_chunk_reset", status=
);
+            req->status =3D status;
+            goto out;
+        }
+    } else {
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "block request faile=
d: %s",
+            strerror(-ret));
+        req->status =3D NVME_INTERNAL_DEV_ERROR;
+    }
+
+out:
+    if (QTAILQ_EMPTY(&req->blk_req_tailq)) {
+        nvme_enqueue_req_completion(cq, req);
+    }
+
+    nvme_blk_req_put(n, blk_req);
+}
+
+static uint16_t ocssd_reset(OcssdCtrl *o, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    OcssdRwCmd *rst =3D (OcssdRwCmd *) cmd;
+    OcssdNamespace *ons =3D _ons(o, req->ns->id);
+    hwaddr lbal_addr =3D le64_to_cpu(rst->lbal);
+    uint16_t nlb =3D le16_to_cpu(rst->nlb) + 1;
+    uint8_t lbads =3D nvme_ns_lbads(req->ns);
+    uint16_t status =3D NVME_NO_COMPLETE;
+    uint64_t *lbal;
+
+    trace_ocssd_reset(req->cqe.cid, nlb);
+
+    req->nlb =3D nlb;
+    req->mptr =3D le64_to_cpu(cmd->mptr);
+
+    _get_lba_list(o, lbal_addr, &lbal, req);
+    req->slba =3D (uint64_t) lbal;
+
+    /*
+     * The resetting of multiple chunks is done asynchronously, so hijac=
k
+     * blk_req->nlb to store the LBAL index which is required for the ca=
llback
+     * to know the index in MPTR at which to store the updated chunk
+     * descriptor.
+     */
+    for (int i =3D 0; i < nlb; i++) {
+        OcssdChunkDescriptor *chk;
+        NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, NU=
LL);
+        if (!blk_req) {
+            NVME_GUEST_ERR(nvme_err_internal_dev_error, "nvme_blk_req_ge=
t: %s",
+                "could not allocate memory");
+            status =3D NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+            goto out;
+        }
+
+        blk_req->slba =3D _vlba(req, i);
+        blk_req->nlb =3D i;
+
+        chk =3D _get_chunk(o, ons, blk_req->slba);
+        if (!chk) {
+            trace_ocssd_err_invalid_chunk(req->cqe.cid,
+                blk_req->slba & ~ons->addrf.sec_mask);
+            status =3D OCSSD_INVALID_RESET | NVME_DNR;
+            goto out;
+        }
+
+        QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
+
+        blk_req->aiocb =3D blk_aio_pdiscard(n->conf.blk,
+            req->ns->blk_offset + (_sectr_idx(o, ons, blk_req->slba) << =
lbads),
+            chk->cnlb << lbads, ocssd_reset_cb, blk_req);
+    }
+
+out:
+    if (req->nlb > 1) {
+        g_free((uint64_t *) req->slba);
+    }
+
+    return status;
+}
+
+static uint16_t ocssd_maybe_write_error_inject(OcssdCtrl *o,
+    NvmeBlockBackendRequest *blk_req)
+{
+    NvmeRequest *req =3D blk_req->req;
+    NvmeNamespace *ns =3D req->ns;
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+    OcssdChunkDescriptor *chk;
+    uint8_t p;
+    uint64_t cidx, slba =3D blk_req->slba;
+
+    if (!ons->writefail || !req->is_write) {
+        return NVME_SUCCESS;
+    }
+
+    for (uint16_t i =3D 0; i < blk_req->nlb; i++) {
+        p =3D ons->writefail[_sectr_idx(o, ons, slba + i)];
+
+        if (p && (p =3D=3D 100 || (rand() % 100) < p)) {
+            trace_ocssd_inject_write_err(req->cqe.cid, p, slba + i);
+
+            chk =3D _get_chunk(o, ons, slba);
+            if (!chk) {
+                NVME_GUEST_ERR(ocssd_err_invalid_chunk,
+                    "invalid chunk; cid %d addr 0x%lx", req->cqe.cid,
+                    slba & ~ons->addrf.sec_mask);
+                return NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+            }
+
+            cidx =3D _chk_idx(o, ons, slba + i);
+            chk->state =3D OCSSD_CHUNK_CLOSED;
+
+            ocssd_ns_commit_chunk_state(o, ons, req, chk);
+            ons->resetfail[cidx] =3D 100;
+
+            if (_is_vector_request(req)) {
+                for (uint16_t j =3D 0; j < req->nlb; j++) {
+                    if (cidx =3D=3D _chk_idx(o, ons, slba)) {
+                        bitmap_set(&req->cqe.res64, j, 1);
+                    }
+                }
+            }
+
+            return OCSSD_CHUNK_EARLY_CLOSE | NVME_DNR;
+        }
+    }
+
+    return NVME_SUCCESS;
+}
+
+static void ocssd_rwc_aio_complete(OcssdCtrl *o,
+    NvmeBlockBackendRequest *blk_req, int ret)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    NvmeRequest *req =3D blk_req->req;
+    NvmeNamespace *ns =3D req->ns;
+    OcssdNamespace *ons =3D &o->namespaces[ns->id - 1];
+    uint16_t status;
+
+    if (!ret) {
+        block_acct_done(blk_get_stats(n->conf.blk), &blk_req->acct);
+
+        if (req->is_write && blk_req->blk_offset >=3D ns->blk_offset &&
+            blk_req->blk_offset < ns->blk_offset_md) {
+
+            /*
+             * We know that each NvmeBlockBackendRequest corresponds to =
a write
+             * to at most one chunk (one contiguous write). This way, we=
 can
+             * allow a write to a single chunk to fail (while leaving th=
e write
+             * pointer intact), but allow writes to other chunks to proc=
eed.
+             */
+            status =3D ocssd_maybe_write_error_inject(o, blk_req);
+            if (!status) {
+                status =3D ocssd_do_advance_wp(o, ons, blk_req->slba,
+                    blk_req->nlb, req);
+            }
+
+            /*
+             * An internal device error trumps all other errors, but the=
re is
+             * no way of triaging other errors, so only set an error if =
one has
+             * not already been set.
+             */
+            if (status) {
+                if (nvme_is_error(status, NVME_INTERNAL_DEV_ERROR)) {
+                    NVME_GUEST_ERR(nvme_err_internal_dev_error, "%s",
+                        "internal device error");
+                    req->status =3D status;
+                }
+
+                if (!req->status) {
+                    req->status =3D status;
+                }
+            }
+        }
+    } else {
+        block_acct_failed(blk_get_stats(n->conf.blk), &blk_req->acct);
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "block request faile=
d: %s",
+            strerror(-ret));
+        req->status =3D NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+    }
+}
+
+static void ocssd_copy_out_cb(void *opaque, int ret)
+{
+    NvmeBlockBackendRequest *blk_req =3D opaque;
+    NvmeRequest *req =3D blk_req->req;
+    NvmeSQueue *sq =3D req->sq;
+    NvmeCtrl *n =3D sq->ctrl;
+    NvmeCQueue *cq =3D n->cq[sq->cqid];
+
+    OcssdCtrl *o =3D OCSSD(n);
+    hwaddr addr;
+
+    trace_ocssd_copy_out_cb(req->cqe.cid, req->ns->id);
+
+    QTAILQ_REMOVE(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    ocssd_rwc_aio_complete(o, blk_req, ret);
+    nvme_blk_req_put(n, blk_req);
+
+    if (QTAILQ_EMPTY(&req->blk_req_tailq)) {
+        /* free the bounce buffers */
+        addr =3D req->cmd.cdw12;
+        addr =3D (addr << 32) | req->cmd.cdw13;
+        g_free((void *) addr);
+        g_free((void *) req->cmd.mptr);
+
+        nvme_enqueue_req_completion(cq, req);
+    }
+}
+
+static void ocssd_copy_in_cb(void *opaque, int ret)
+{
+    NvmeBlockBackendRequest *blk_req =3D opaque;
+    NvmeRequest *req =3D blk_req->req;
+    NvmeSQueue *sq =3D req->sq;
+    NvmeCtrl *n =3D sq->ctrl;
+    NvmeCQueue *cq =3D n->cq[sq->cqid];
+    NvmeNamespace *ns =3D req->ns;
+
+    OcssdCtrl *o =3D OCSSD(n);
+    OcssdCopyCmd *cpy =3D (OcssdCopyCmd *) &req->cmd;
+
+    hwaddr addr =3D le64_to_cpu(cpy->dlbal);
+    uint64_t *dlbal;
+    size_t unit_len =3D nvme_ns_lbads_bytes(ns);
+    size_t unit_len_meta =3D nvme_ns_ms(ns);
+    uint16_t status;
+
+    QEMUSGList qsg;
+
+    QTAILQ_REMOVE(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    trace_ocssd_copy_in_cb(req->cqe.cid, req->ns->id);
+
+    if (!ret) {
+        block_acct_done(blk_get_stats(n->conf.blk), &blk_req->acct);
+    } else {
+        block_acct_failed(blk_get_stats(n->conf.blk), &blk_req->acct);
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "block request faile=
d: %s",
+            strerror(-ret));
+        req->status =3D NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+    }
+
+    nvme_blk_req_put(n, blk_req);
+
+    if (QTAILQ_EMPTY(&req->blk_req_tailq)) {
+        _get_lba_list(o, addr, &dlbal, req);
+        req->slba =3D (uint64_t) dlbal;
+
+        /* second phase of copy is a write */
+        req->is_write =3D true;
+
+        status =3D ocssd_rw_check_vector_req(o, &req->cmd, req, NULL);
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "ocssd_rw_check_vector_req",
+                status);
+            goto out;
+        }
+
+        addr =3D req->cmd.cdw12;
+        addr =3D (addr << 32) | req->cmd.cdw13;
+
+        pci_dma_sglist_init(&qsg, &n->parent_obj, 1);
+        qemu_sglist_add(&qsg, addr, req->nlb * unit_len);
+
+        status =3D ocssd_blk_setup_vector(n, ns, &qsg, ns->blk_offset, u=
nit_len,
+            req);
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "ocssd_blk_setup_vector", stat=
us);
+            goto out_sglist_destroy;
+        }
+
+        if (n->params.ms) {
+            qsg.nsg =3D 0;
+            qsg.size =3D 0;
+
+            qemu_sglist_add(&qsg, req->cmd.mptr, req->nlb * unit_len_met=
a);
+
+            status =3D ocssd_blk_setup_vector(n, ns, &qsg, ns->blk_offse=
t_md,
+                unit_len_meta, req);
+            if (status) {
+                trace_ocssd_err(req->cqe.cid, "ocssd_blk_setup_vector", =
status);
+                goto out_sglist_destroy;
+            }
+        }
+
+        QTAILQ_FOREACH(blk_req, &req->blk_req_tailq, tailq_entry) {
+            qemu_iovec_init(&blk_req->iov, blk_req->qsg.nsg);
+            _sglist_to_iov(n, &blk_req->qsg, &blk_req->iov);
+
+            block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+                blk_req->iov.size, BLOCK_ACCT_WRITE);
+
+            blk_req->aiocb =3D blk_aio_pwritev(n->conf.blk, blk_req->blk=
_offset,
+                &blk_req->iov, 0, ocssd_copy_out_cb, blk_req);
+        }
+
+out_sglist_destroy:
+        qemu_sglist_destroy(&qsg);
+
+out:
+        if (req->nlb > 1) {
+            g_free(dlbal);
+        }
+
+        if (status !=3D NVME_SUCCESS) {
+            req->status =3D status;
+            nvme_enqueue_req_completion(cq, req);
+        }
+    }
+}
+
+static uint16_t ocssd_copy(OcssdCtrl *o, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    NvmeNamespace *ns =3D req->ns;
+    OcssdCopyCmd *cpy =3D (OcssdCopyCmd *) cmd;
+    NvmeBlockBackendRequest *blk_req;
+
+    hwaddr addr =3D 0x0;
+    uint64_t *lbal;
+    uint64_t dulbe =3D 0;
+    size_t unit_len =3D nvme_ns_lbads_bytes(ns);
+    size_t unit_len_meta =3D nvme_ns_ms(ns);
+    uint16_t status;
+
+    trace_ocssd_copy(req->cqe.cid, req->nlb);
+
+    if (req->nlb > OCSSD_CMD_MAX_LBAS) {
+        trace_ocssd_err(req->cqe.cid, "OCSSD_CMD_MAX_LBAS exceeded",
+            NVME_INVALID_FIELD | NVME_DNR);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    _get_lba_list(o, le64_to_cpu(cpy->lbal), &lbal, req);
+    req->slba =3D (uint64_t) lbal;
+
+    status =3D ocssd_rw_check_vector_req(o, cmd, req, &dulbe);
+    if (status) {
+        trace_ocssd_err(req->cqe.cid, "ocssd_rw_check_vector_req",
+            status);
+        goto out;
+    }
+
+    if (NVME_ERR_REC_DULBE(n->features.err_rec)) {
+        for (uint32_t i =3D 0; i < req->nlb; i++) {
+            if (dulbe & (1 << i)) {
+                status =3D NVME_DULB | NVME_DNR;
+                goto out;
+            }
+        }
+    }
+
+    /*
+     * For now, use bounce buffers to do the copy. Store the bounce buff=
er
+     * addresses in the unused cdw12/cdw13 and mptr fields so it can be
+     * referred to in the callback.
+     */
+    addr =3D (hwaddr) g_malloc_n(req->nlb, unit_len);
+    req->cmd.cdw12 =3D addr >> 32;
+    req->cmd.cdw13 =3D addr & 0xffffffff;
+
+    QEMUSGList qsg;
+    pci_dma_sglist_init(&qsg, &n->parent_obj, 1);
+    qemu_sglist_add(&qsg, addr, req->nlb * unit_len);
+
+    status =3D ocssd_blk_setup_vector(n, ns, &qsg, ns->blk_offset, unit_=
len,
+        req);
+    if (status) {
+        trace_ocssd_err(req->cqe.cid, "ocssd_blk_setup_vector", status);
+        goto out_sglist_destroy;
+    }
+
+    if (n->params.ms) {
+        req->cmd.mptr  =3D (hwaddr) g_malloc_n(req->nlb, unit_len_meta);
+
+        qsg.nsg =3D 0;
+        qsg.size =3D 0;
+
+        qemu_sglist_add(&qsg, req->cmd.mptr, req->nlb * unit_len_meta);
+
+        status =3D ocssd_blk_setup_vector(n, ns, &qsg, ns->blk_offset_md=
,
+            unit_len_meta, req);
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "ocssd_blk_setup_vector", stat=
us);
+            goto out_sglist_destroy;
+        }
+    }
+
+    QTAILQ_FOREACH(blk_req, &req->blk_req_tailq, tailq_entry) {
+        qemu_iovec_init(&blk_req->iov, blk_req->qsg.nsg);
+        _sglist_to_iov(n, &blk_req->qsg, &blk_req->iov);
+
+        block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+            blk_req->iov.size, BLOCK_ACCT_READ);
+
+        blk_req->aiocb =3D blk_aio_preadv(n->conf.blk, blk_req->blk_offs=
et,
+            &blk_req->iov, 0, ocssd_copy_in_cb, blk_req);
+    }
+
+out_sglist_destroy:
+    qemu_sglist_destroy(&qsg);
+
+out:
+    if (req->nlb > 1) {
+        g_free(lbal);
+    }
+
+    if (status) {
+        g_free((void *) addr);
+        g_free((void *) req->cmd.mptr);
+        return status;
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
+
+static void ocssd_rw_cb(void *opaque, int ret)
+{
+    NvmeBlockBackendRequest *blk_req =3D opaque;
+    NvmeRequest *req =3D blk_req->req;
+    NvmeSQueue *sq =3D req->sq;
+    NvmeCtrl *n =3D sq->ctrl;
+    NvmeCQueue *cq =3D n->cq[sq->cqid];
+
+    OcssdCtrl *o =3D OCSSD(n);
+
+    trace_ocssd_rw_cb(req->cqe.cid, req->ns->id);
+
+    QTAILQ_REMOVE(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    ocssd_rwc_aio_complete(o, blk_req, ret);
+    nvme_blk_req_put(n, blk_req);
+
+    if (QTAILQ_EMPTY(&req->blk_req_tailq)) {
+        trace_nvme_enqueue_req_completion(req->cqe.cid, cq->cqid);
+        nvme_enqueue_req_completion(cq, req);
+    }
+}
+
+static uint16_t ocssd_rw(OcssdCtrl *o, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    OcssdRwCmd *orw =3D (OcssdRwCmd *) cmd;
+
+    uint64_t dulbe =3D 0;
+    uint64_t *lbal;
+    uint64_t lbal_addr =3D le64_to_cpu(orw->lbal);
+    uint16_t status =3D NVME_SUCCESS;
+
+    if (req->nlb > OCSSD_CMD_MAX_LBAS) {
+        trace_ocssd_err(req->cqe.cid, "OCSSD_CMD_MAX_LBAS exceeded",
+            NVME_INVALID_FIELD | NVME_DNR);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    _get_lba_list(o, lbal_addr, &lbal, req);
+    req->slba =3D (uint64_t) lbal;
+
+    _dprint_vector_rw(o, req);
+
+    status =3D ocssd_rw_check_vector_req(o, cmd, req, &dulbe);
+    if (status) {
+        trace_ocssd_err(req->cqe.cid, "ocssd_rw_check_vector_req", statu=
s);
+        goto out;
+    }
+
+    if (!req->is_write && NVME_ERR_REC_DULBE(n->features.err_rec)) {
+        for (uint32_t i =3D 0; i < req->nlb; i++) {
+            if (dulbe & (1 << i)) {
+                status =3D NVME_DULB | NVME_DNR;
+                goto out;
+            }
+        }
+    }
+
+    status =3D nvme_blk_map(n, cmd, req, ocssd_blk_setup_vector);
+    if (status) {
+        trace_ocssd_err(req->cqe.cid, "nvme_blk_map", status);
+        goto out;
+    }
+
+out:
+    if (req->nlb > 1) {
+        g_free((uint64_t *) req->slba);
+    }
+
+    if (status) {
+        return status;
+    }
+
+    return nvme_blk_submit_io(n, req, ocssd_rw_cb);
+}
+
+static uint16_t ocssd_geometry(OcssdCtrl *o, NvmeCmd *cmd, NvmeRequest *=
req)
+{
+    OcssdNamespace *ons;
+
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    if (unlikely(nsid =3D=3D 0 || nsid > o->nvme.params.num_ns)) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    ons =3D &o->namespaces[nsid - 1];
+
+    return nvme_dma_read(&o->nvme, (uint8_t *) &ons->id, sizeof(OcssdIde=
ntity),
+        cmd, req);
+}
+
+static uint16_t ocssd_get_log(OcssdCtrl *o, NvmeCmd *cmd, NvmeRequest *r=
eq)
+{
+    NvmeCtrl *n =3D &o->nvme;
+
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
+    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint16_t lid =3D dw10 & 0xff;
+    uint8_t  rae =3D (dw10 >> 15) & 0x1;
+    uint32_t numdl, numdu, len;
+    uint64_t off, lpol, lpou;
+
+    numdl =3D (dw10 >> 16);
+    numdu =3D (dw11 & 0xffff);
+    lpol =3D dw12;
+    lpou =3D dw13;
+
+    len =3D (((numdu << 16) | numdl) + 1) << 2;
+    off =3D (lpou << 32ULL) | lpol;
+
+    switch (lid) {
+    case OCSSD_CHUNK_INFO:
+        return ocssd_do_get_chunk_info(o, cmd, len, off, req);
+    case OCSSD_CHUNK_NOTIFICATION:
+        return ocssd_do_get_chunk_notification(o, cmd, len, off, rae, re=
q);
+    default:
+        return nvme_get_log(n, cmd, req);
+    }
+}
+
+static uint16_t ocssd_get_feature(OcssdCtrl *o, NvmeCmd *cmd, NvmeReques=
t *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+
+    trace_ocssd_getfeat(dw10);
+
+    switch (dw10) {
+    case OCSSD_MEDIA_FEEDBACK:
+        req->cqe.cdw0 =3D cpu_to_le32(o->features.media_feedback);
+        break;
+    default:
+        return nvme_get_feature(n, cmd, req);
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t ocssd_set_feature(OcssdCtrl *o, NvmeCmd *cmd, NvmeReques=
t *req)
+{
+    NvmeCtrl *n =3D &o->nvme;
+
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+
+    trace_ocssd_setfeat(dw10, dw11);
+
+    switch (dw10) {
+    case NVME_ERROR_RECOVERY:
+        n->features.err_rec =3D dw11;
+        break;
+    case OCSSD_MEDIA_FEEDBACK:
+        o->features.media_feedback =3D dw11;
+        break;
+    default:
+        return nvme_set_feature(n, cmd, req);
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t ocssd_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *=
req)
+{
+    OcssdCtrl *o =3D OCSSD(n);
+
+    switch (cmd->opcode) {
+    case NVME_ADM_CMD_SET_FEATURES:
+        return ocssd_set_feature(o, cmd, req);
+    case NVME_ADM_CMD_GET_FEATURES:
+        return ocssd_get_feature(o, cmd, req);
+    case OCSSD_ADM_CMD_GEOMETRY:
+        return ocssd_geometry(o, cmd, req);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return ocssd_get_log(o, cmd, req);
+    default:
+        return nvme_admin_cmd(n, cmd, req);
+    }
+}
+
+static uint16_t ocssd_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    OcssdCtrl *o =3D OCSSD(n);
+    NvmeRwCmd *rw;
+    uint16_t status;
+
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+
+    if (unlikely(nsid =3D=3D 0 || nsid > n->params.num_ns)) {
+        trace_nvme_err_invalid_ns(nsid, n->params.num_ns);
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    trace_ocssd_io_cmd(req->cqe.cid, nsid, cmd->opcode);
+
+    req->ns =3D &n->namespaces[nsid - 1];
+
+    switch (cmd->opcode) {
+    case NVME_CMD_READ:
+    case NVME_CMD_WRITE:
+        rw =3D (NvmeRwCmd *) cmd;
+
+        req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
+        req->is_write =3D nvme_rw_is_write(req);
+        req->slba =3D le64_to_cpu(rw->slba);
+
+        trace_nvme_rw(req->is_write ? "write" : "read", req->nlb,
+            req->nlb << nvme_ns_lbads(req->ns), req->slba);
+
+        status =3D ocssd_rw_check_scalar_req(o, cmd, req);
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "ocssd_rw_check_scalar_req", s=
tatus);
+            return status;
+        }
+
+        status =3D nvme_blk_map(n, cmd, req, ocssd_blk_setup_scalar);
+        if (status) {
+            trace_ocssd_err(req->cqe.cid, "nvme_blk_map", status);
+            return status;
+        }
+
+        return nvme_blk_submit_io(n, req, ocssd_rw_cb);
+
+    case NVME_CMD_DSM:
+        return ocssd_dsm(o, cmd, req);
+
+    case OCSSD_CMD_VECT_READ:
+    case OCSSD_CMD_VECT_WRITE:
+        rw =3D (NvmeRwCmd *) cmd;
+
+        req->nlb =3D le16_to_cpu(rw->nlb) + 1;
+        req->is_write =3D _is_write(req);
+
+        trace_ocssd_rw(req->cqe.cid, nsid, req->cmd.opcode, req->nlb);
+
+        return ocssd_rw(o, cmd, req);
+
+    case OCSSD_CMD_VECT_COPY:
+        rw =3D (NvmeRwCmd *) cmd;
+        req->nlb =3D le16_to_cpu(rw->nlb) + 1;
+
+        /* first phase of copy is a read */
+        req->is_write =3D false;
+
+        return ocssd_copy(o, cmd, req);
+
+    case OCSSD_CMD_VECT_RESET:
+        return ocssd_reset(o, cmd, req);
+
+    default:
+        return nvme_io_cmd(n, cmd, req);
+    }
+}
+
+static uint64_t ocssd_ns_calc_blks(OcssdCtrl *o, OcssdNamespace *ons)
+{
+    NvmeNamespace *ns =3D ons->ns;
+    return o->hdr.ns_size / (nvme_ns_lbads_bytes(ns) + nvme_ns_ms(ns));
+}
+
+static uint64_t ocssd_ns_calc_info_size(OcssdCtrl *o,
+    OcssdNamespace *ons)
+{
+    OcssdIdGeo *geo =3D &ons->id.geo;
+    uint64_t chks_total =3D geo->num_grp * geo->num_pu * geo->num_chk;
+
+    return QEMU_ALIGN_UP(chks_total * sizeof(OcssdChunkDescriptor),
+        o->hdr.sector_size);
+}
+
+static uint64_t ocssd_ns_calc_acct_size(OcssdCtrl *o, OcssdNamespace *on=
s)
+{
+    OcssdIdGeo *geo =3D &ons->id.geo;
+    uint64_t chks_total =3D geo->num_grp * geo->num_pu * geo->num_chk;
+
+    return QEMU_ALIGN_UP(chks_total * sizeof(OcssdChunkAcctDescriptor),
+        o->hdr.sector_size);
+}
+
+static void ocssd_free_namespace(OcssdCtrl *o, OcssdNamespace *ons)
+{
+    g_free(ons->info.descr);
+    g_free(ons->acct.descr);
+    g_free(ons->resetfail);
+    g_free(ons->writefail);
+}
+
+static void ocssd_free_namespaces(OcssdCtrl *o)
+{
+    for (int i =3D 0; i < o->hdr.num_ns; i++) {
+        ocssd_free_namespace(o, &o->namespaces[i]);
+    }
+}
+
+static int ocssd_init_namespace(OcssdCtrl *o, OcssdNamespace *ons,
+    Error **errp)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    NvmeNamespace *ns =3D ons->ns;
+    NvmeIdNs *id_ns =3D &ons->ns->id_ns;
+    OcssdParams *params =3D &o->params;
+    BlockBackend *blk =3D n->conf.blk;
+    OcssdIdentity *id =3D &ons->id;
+    OcssdIdGeo *geo =3D &id->geo;
+    OcssdAddrF *addrf =3D &ons->addrf;
+    Error *local_err =3D NULL;
+
+    int ret;
+
+    nvme_ns_init_identify(n, id_ns);
+
+    /*
+     * In addition to checking if the device has the NVME_QUIRK_LIGHTNVM=
 quirk,
+     * the Linux NVMe driver also checks if the first byte of the
+     * vendor specific area in the identify namespace structure is set t=
o 0x1.
+     *
+     * This is non-standard and Linux specific.
+     */
+    id_ns->vs[0] =3D 0x1;
+
+    ret =3D blk_pread(blk, ns->blk_offset, id, sizeof(OcssdIdentity));
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+            "could not read namespace identity structure: ");
+        return 1;
+    }
+    ns->blk_offset +=3D sizeof(OcssdIdentity);
+
+    if (params->ws_min !=3D UINT32_MAX) {
+        id->wrt.ws_min =3D cpu_to_le32(params->ws_min);
+    }
+
+    if (params->ws_opt !=3D UINT32_MAX) {
+        id->wrt.ws_opt =3D cpu_to_le32(params->ws_opt);
+    }
+
+    if (params->mw_cunits !=3D UINT32_MAX) {
+        id->wrt.mw_cunits =3D cpu_to_le32(params->mw_cunits);
+    }
+
+    if (params->mccap !=3D UINT32_MAX) {
+        id->mccap =3D params->mccap;
+    }
+
+    if (params->early_reset) {
+        id->mccap |=3D OCSSD_IDENTITY_MCCAP_EARLY_RESET;
+    }
+
+    if (params->wit !=3D UINT8_MAX) {
+        id->wit =3D params->wit;
+    }
+
+    id_ns->lbaf[0].lbads =3D 63 - clz64(o->hdr.sector_size);
+    id_ns->lbaf[0].ms =3D o->hdr.md_size;
+    id_ns->nlbaf =3D 0;
+    id_ns->flbas =3D 0;
+    id_ns->mc =3D o->hdr.md_size ? 0x2 : 0;
+
+    ons->acct.size =3D ocssd_ns_calc_acct_size(o, ons);
+    ons->acct.descr =3D g_malloc0(ons->acct.size);
+    ons->acct.blk_offset =3D ns->blk_offset;
+    ns->blk_offset +=3D ons->acct.size;
+
+    ons->info.size =3D ocssd_ns_calc_info_size(o, ons);
+    ons->info.descr =3D g_malloc0(ons->info.size);
+    ons->info.blk_offset =3D ns->blk_offset;
+    ns->blk_offset +=3D ons->info.size;
+
+    ns->ns_blks =3D ocssd_ns_calc_blks(o, ons);
+    ns->ns_blks -=3D (sizeof(OcssdIdentity) + ons->info.size) /
+        nvme_ns_lbads_bytes(ns);
+
+    ns->blk_offset_md =3D ns->blk_offset + nvme_ns_lbads_bytes(ns) * ns-=
>ns_blks;
+
+    ons->chks_per_grp =3D geo->num_chk * geo->num_pu;
+    ons->chks_total   =3D ons->chks_per_grp * geo->num_grp;
+    ons->secs_per_chk =3D geo->clba;
+    ons->secs_per_pu  =3D ons->secs_per_chk * geo->num_chk;
+    ons->secs_per_grp =3D ons->secs_per_pu  * geo->num_pu;
+    ons->secs_total   =3D ons->secs_per_grp * geo->clba;
+
+    ocssd_ns_optimal_addrf(addrf, &id->lbaf);
+
+    /*
+     * Size of device (NSZE) is the entire address space (though some sp=
ace is
+     * not usable).
+     */
+    id_ns->nuse =3D id_ns->nsze =3D
+        1ULL << (id->lbaf.sec_len + id->lbaf.chk_len +
+            id->lbaf.pu_len + id->lbaf.grp_len);
+
+    /*
+     * Namespace capacity (NCAP) is set to the actual usable size in log=
ical
+     * blocks.
+     */
+    id_ns->ncap =3D ns->ns_blks;
+
+    ret =3D ocssd_ns_load_chunk_info(o, ons);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not load chunk info");
+        return 1;
+    }
+
+    ret =3D ocssd_ns_load_chunk_acct(o, ons);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not load chunk acct");
+        return 1;
+    }
+
+    if (params->chunkinfo_fname) {
+        if (ocssd_load_chunk_info_from_file(o, params->chunkinfo_fname,
+            &local_err)) {
+            error_propagate_prepend(errp, local_err,
+                "could not load chunk info from file");
+            return 1;
+        }
+
+        for (int i =3D 0; i < o->hdr.num_ns; i++) {
+            ret =3D blk_pwrite(o->nvme.conf.blk, ons->info.blk_offset,
+                ons->info.descr, ons->info.size, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "could not commit chunk inf=
o");
+                return 1;
+            }
+
+            ret =3D blk_pwrite(o->nvme.conf.blk, ons->acct.blk_offset,
+                ons->acct.descr, ons->acct.size, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "could not commit chunk acc=
t");
+                return 1;
+            }
+        }
+    }
+
+    for (int i =3D 0; i < ons->chks_total; i++) {
+        OcssdChunkDescriptor *cnk =3D &ons->info.descr[i];
+        ons->wear_index_total +=3D cnk->wear_index;
+    }
+
+    ons->wear_index_avg =3D ons->wear_index_total / ons->chks_total;
+
+    ons->resetfail =3D NULL;
+    if (params->resetfail_fname) {
+        ons->resetfail =3D g_malloc0_n(ons->chks_total, sizeof(*ons->res=
etfail));
+        if (!ons->resetfail) {
+            error_setg_errno(errp, ENOMEM, "could not allocate memory");
+            return 1;
+        }
+
+        if (ocssd_load_reset_error_injection_from_file(o,
+            params->resetfail_fname, &local_err)) {
+            error_propagate_prepend(errp, local_err,
+                "could not load reset error injection from file");
+            return 1;
+        }
+    }
+
+    ons->writefail =3D NULL;
+    if (params->writefail_fname) {
+        ons->writefail =3D g_malloc0_n(ons->secs_total, sizeof(*ons->wri=
tefail));
+        if (!ons->writefail) {
+            error_setg_errno(errp, ENOMEM, "could not allocate memory");
+            return 1;
+        }
+
+        if (ocssd_load_write_error_injection_from_file(o,
+            params->writefail_fname, &local_err)) {
+            error_propagate_prepend(errp, local_err,
+                "could not load write error injection from file");
+            return 1;
+        }
+
+        /*
+         * We fail resets for a chunk after a write failure to it, so ma=
ke sure
+         * to allocate the resetfailure buffer if it has not been alread=
y.
+         */
+        if (!ons->resetfail) {
+            ons->resetfail =3D g_malloc0_n(ons->chks_total,
+                sizeof(*ons->resetfail));
+        }
+    }
+
+    return 0;
+}
+
+static int ocssd_init_namespaces(OcssdCtrl *o, Error **errp)
+{
+    NvmeCtrl *n =3D &o->nvme;
+    Error *local_err =3D NULL;
+
+    n->namespaces =3D g_new0(NvmeNamespace, o->hdr.num_ns);
+    o->namespaces =3D g_new0(OcssdNamespace, o->hdr.num_ns);
+    for (int i =3D 0; i < o->hdr.num_ns; i++) {
+        OcssdNamespace *ons =3D &o->namespaces[i];
+        NvmeNamespace *ns =3D ons->ns =3D &n->namespaces[i];
+
+        ns->id =3D i + 1;
+        ns->blk_offset =3D o->hdr.sector_size + i * o->hdr.ns_size;
+
+        if (ocssd_init_namespace(o, ons, &local_err)) {
+            error_propagate_prepend(errp, local_err,
+                "init namespaces failed: ");
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static void ocssd_realize(PCIDevice *pci_dev, Error **errp)
+{
+    int ret;
+
+    OcssdCtrl *o =3D OCSSD(pci_dev);
+    NvmeCtrl *n =3D &o->nvme;
+    NvmeIdCtrl *id_ctrl =3D &n->id_ctrl;
+    Error *local_err =3D NULL;
+
+    n->namespaces =3D NULL;
+    n->admin_cmd =3D ocssd_admin_cmd;
+    n->io_cmd =3D ocssd_io_cmd;
+
+    if (nvme_init_blk(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_init_blk failed: =
");
+        return;
+    }
+
+    ret =3D blk_pread(n->conf.blk, 0, &o->hdr, sizeof(OcssdFormatHeader)=
);
+    if (ret < 0) {
+        error_setg(errp, "could not read block format header");
+        return;
+    }
+
+    n->params.num_ns =3D o->hdr.num_ns;
+    n->params.ms =3D o->hdr.md_size;
+
+    if (nvme_init_state(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_init_state failed=
: ");
+        return;
+    }
+
+    nvme_init_pci(n, pci_dev);
+
+    pci_config_set_vendor_id(pci_dev->config, PCI_VENDOR_ID_CNEX);
+    pci_config_set_device_id(pci_dev->config, 0x1f1f);
+
+    ocssd_init_namespaces(o, errp);
+
+    nvme_init_ctrl(n);
+
+    n->id_ctrl.oncs |=3D cpu_to_le16(NVME_ONCS_DSM);
+
+    strpadcpy((char *)id_ctrl->mn, sizeof(id_ctrl->mn),
+        "QEMU NVM Express LightNVM Controller", ' ');
+}
+
+static void ocssd_exit(PCIDevice *pci_dev)
+{
+    OcssdCtrl *o =3D OCSSD(pci_dev);
+
+    ocssd_free_namespaces(o);
+    nvme_free_ctrl(&o->nvme, pci_dev);
+}
+
+static Property ocssd_props[] =3D {
+    DEFINE_BLOCK_PROPERTIES(OcssdCtrl, nvme.conf),
+    DEFINE_NVME_PROPERTIES(OcssdCtrl, nvme.params),
+    DEFINE_OCSSD_PROPERTIES(OcssdCtrl, params),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription ocssd_vmstate =3D {
+    .name =3D "ocssd",
+    .unmigratable =3D 1,
+};
+
+static void ocssd_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(oc);
+
+    pc->realize =3D ocssd_realize;
+    pc->exit =3D ocssd_exit;
+    pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
+    pc->vendor_id =3D PCI_VENDOR_ID_CNEX;
+    pc->device_id =3D 0x1f1f;
+    pc->revision =3D 2;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc =3D "OpenChannel 2.0 NVMe";
+    dc->props =3D ocssd_props;
+    dc->vmsd =3D &ocssd_vmstate;
+}
+
+static void ocssd_instance_init(Object *obj)
+{
+    OcssdCtrl *s =3D OCSSD(obj);
+
+    device_add_bootindex_property(obj, &s->nvme.conf.bootindex,
+                                  "bootindex", "/namespace@1,0",
+                                  DEVICE(obj), &error_abort);
+}
+
+static const TypeInfo ocssd_info =3D {
+    .name          =3D TYPE_OCSSD,
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(OcssdCtrl),
+    .class_init    =3D ocssd_class_init,
+    .instance_init =3D ocssd_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void ocssd_register_types(void)
+{
+    type_register_static(&ocssd_info);
+}
+
+type_init(ocssd_register_types)
diff --git a/hw/block/nvme/ocssd.h b/hw/block/nvme/ocssd.h
new file mode 100644
index 000000000000..31dadc0a1034
--- /dev/null
+++ b/hw/block/nvme/ocssd.h
@@ -0,0 +1,140 @@
+/*
+ * QEMU OpenChannel 2.0 Controller
+ *
+ * Copyright (c) 2019 CNEX Labs, Inc.
+ *
+ * Thank you to the following people for their contributions to the orig=
inal
+ * qemu-nvme (github.com/OpenChannelSSD/qemu-nvme) implementation.
+ *
+ *   Matias Bj=C3=B8rling <mb@lightnvm.io>
+ *   Javier Gonz=C3=A1lez <javier@javigon.com>
+ *   Simon Andreas Frimann Lund <ocssd@safl.dk>
+ *   Hans Holmberg <hans@owltronix.com>
+ *   Jesper Devantier <contact@pseudonymous.me>
+ *   Young Tack Jin <youngtack.jin@circuitblvd.com>
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ */
+
+#ifndef HW_NVME_OCSSD_H
+#define HW_NVME_OCSSD_H
+
+#include "block/ocssd.h"
+#include "hw/block/nvme.h"
+
+#define TYPE_OCSSD "ocssd"
+#define OCSSD(obj) \
+        OBJECT_CHECK(OcssdCtrl, (obj), TYPE_OCSSD)
+
+#define OCSSD_MAX_CHUNK_NOTIFICATIONS 64
+
+#define DEFINE_OCSSD_PROPERTIES(_state, _props) \
+    DEFINE_PROP_UINT32("mccap", _state, _props.mccap, UINT32_MAX), \
+    DEFINE_PROP_UINT32("ws_min", _state, _props.ws_min, UINT32_MAX), \
+    DEFINE_PROP_UINT32("ws_opt", _state, _props.ws_opt, UINT32_MAX), \
+    DEFINE_PROP_UINT32("mw_cunits", _state, _props.mw_cunits, UINT32_MAX=
), \
+    DEFINE_PROP_UINT8("wit", _state, _props.wit, UINT8_MAX), \
+    DEFINE_PROP_BOOL("early_reset", _state, _props.early_reset, true), \
+    DEFINE_PROP_STRING("resetfail", _state, _props.resetfail_fname), \
+    DEFINE_PROP_STRING("writefail", _state, _props.writefail_fname), \
+    DEFINE_PROP_STRING("chunkinfo", _state, _props.chunkinfo_fname)
+
+typedef struct OcssdParams {
+    /* qemu configurable device characteristics */
+    uint32_t mccap;
+    uint32_t ws_min;
+    uint32_t ws_opt;
+    uint32_t mw_cunits;
+    uint8_t  wit;
+    bool     early_reset;
+
+    char *chunkinfo_fname;
+    char *resetfail_fname;
+    char *writefail_fname;
+} OcssdParams;
+
+#define OCSSD_CMD_MAX_LBAS 64
+
+typedef struct OcssdAddrF {
+    uint64_t grp_mask;
+    uint64_t pu_mask;
+    uint64_t chk_mask;
+    uint64_t sec_mask;
+    uint8_t  grp_offset;
+    uint8_t  pu_offset;
+    uint8_t  chk_offset;
+    uint8_t  sec_offset;
+} OcssdAddrF;
+
+typedef struct OcssdChunkAcctDescriptor {
+    uint32_t pe_cycles;
+} OcssdChunkAcctDescriptor;
+
+typedef struct OcssdChunkAcct {
+    uint64_t blk_offset;
+    uint64_t size;
+
+    OcssdChunkAcctDescriptor *descr;
+} OcssdChunkAcct;
+
+typedef struct OcssdChunkInfo {
+    uint64_t blk_offset;
+    uint64_t size;
+
+    OcssdChunkDescriptor *descr;
+} OcssdChunkInfo;
+
+typedef struct OcssdNamespace {
+    NvmeNamespace *ns;
+
+    OcssdIdentity id;
+    OcssdAddrF    addrf;
+
+    /* reset and write fail error probabilities indexed by namespace */
+    uint8_t *resetfail;
+    uint8_t *writefail;
+
+    /* derived values (convenience) */
+    uint32_t chks_per_grp;
+    uint32_t chks_total;
+    uint32_t secs_per_chk;
+    uint32_t secs_per_pu;
+    uint32_t secs_per_grp;
+    uint32_t secs_total;
+
+    /* wear index tracking */
+    uint8_t  wear_index_avg;
+    uint64_t wear_index_total;
+
+    OcssdChunkInfo info;
+    OcssdChunkAcct acct;
+} OcssdNamespace;
+
+typedef struct OcssdCtrl {
+    NvmeCtrl nvme;
+
+    OcssdFormatHeader hdr;
+    OcssdParams       params;
+    OcssdNamespace    *namespaces;
+    OcssdFeatureVal   features;
+
+    uint64_t notifications_count;
+    uint16_t notifications_index;
+    uint16_t notifications_max;
+    OcssdChunkNotification notifications[OCSSD_MAX_CHUNK_NOTIFICATIONS];
+} OcssdCtrl;
+
+static inline void ocssd_ns_optimal_addrf(OcssdAddrF *addrf, OcssdIdLBAF=
 *lbaf)
+{
+    addrf->sec_offset =3D 0;
+    addrf->chk_offset =3D lbaf->sec_len;
+    addrf->pu_offset  =3D lbaf->sec_len + lbaf->chk_len;
+    addrf->grp_offset =3D lbaf->sec_len + lbaf->chk_len + lbaf->pu_len;
+
+    addrf->grp_mask =3D ((1 << lbaf->grp_len) - 1) << addrf->grp_offset;
+    addrf->pu_mask  =3D ((1 << lbaf->pu_len)  - 1) << addrf->pu_offset;
+    addrf->chk_mask =3D ((1 << lbaf->chk_len) - 1) << addrf->chk_offset;
+    addrf->sec_mask =3D ((1 << lbaf->sec_len) - 1) << addrf->sec_offset;
+}
+
+#endif /* HW_NVME_OCSSD_H */
diff --git a/hw/block/nvme/trace-events b/hw/block/nvme/trace-events
new file mode 100644
index 000000000000..444c75e34c59
--- /dev/null
+++ b/hw/block/nvme/trace-events
@@ -0,0 +1,136 @@
+# nvme.c
+# nvme traces for successful events
+nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
+nvme_irq_pin(void) "pulsing IRQ pin"
+nvme_irq_masked(void) "IRQ is masked"
+nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
+nvme_map_prp(uint8_t cmd_opcode, uint64_t trans_len, uint32_t len, uint6=
4_t prp1, uint64_t prp2, int num_prps) "cmd_opcode=3D0x%"PRIx8", trans_le=
n=3D%"PRIu64", len=3D%"PRIu32", prp1=3D0x%"PRIx64", prp2=3D0x%"PRIx64", n=
um_prps=3D%d"
+nvme_map_sgl(uint16_t cid, uint64_t typ, uint16_t nlb, uint64_t len) "ci=
d %"PRIu16" type %"PRIu64" nlb %"PRIu16" len %"PRIu64""
+nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
+nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx6=
4", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"P=
RIu16", ien=3D%d"
+nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
+nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
+nvme_identify_ctrl(void) "identify controller"
+nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
+nvme_identify_ns_list(uint16_t ns) "identify namespace list, nsid=3D%"PR=
Iu16""
+nvme_identify_ns_descriptor_list(uint16_t ns) "identify namespace descri=
ptor list, nsid=3D%"PRIu16""
+nvme_getfeat(uint32_t fid) "fid %"PRIu32""
+nvme_setfeat(uint32_t fid, uint32_t val) "fid %"PRIu32" val %"PRIu32""
+nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
+nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d=
"
+nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
+nvme_get_log(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
+nvme_process_aers(void) "processing aers"
+nvme_aer(uint16_t cid) "cid %"PRIu16""
+nvme_aer_aerl_exceeded(void) "aerl exceeded"
+nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PR=
Ix8""
+nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%=
"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid) "cid %"PRIu16" =
cqid %"PRIu16""
+nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x=
%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
+nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
+nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
+nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
+nvme_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue attributes=3D0x=
%"PRIx64""
+nvme_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue add=
ress=3D0x%"PRIx64""
+nvme_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue add=
ress=3D0x%"PRIx64""
+nvme_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n submission queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
+nvme_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n completion queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
+nvme_mmio_start_success(void) "setting controller enable bit succeeded"
+nvme_mmio_stopped(void) "cleared controller enable bit"
+nvme_mmio_shutdown_set(void) "shutdown bit set"
+nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+
+# nvme traces for error conditions
+nvme_err(uint16_t cid, const char *s, uint16_t status) "cid %"PRIu16" \"=
%s\" status 0x%"PRIx16""
+nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
+nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
+nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
+nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be tr=
ansferred"
+nvme_err_invalid_prp(void) "invalid PRP"
+nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u n=
ot within 1-%u"
+nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
+nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8"=
"
+nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit)=
 "Invalid LBA start=3D%"PRIu64" len=3D%"PRIu64" limit=3D%"PRIu64""
+nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion=
, sid=3D%"PRIu16""
+nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submissi=
on queue, invalid cqid=3D%"PRIu16""
+nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submissi=
on queue, invalid sqid=3D%"PRIu16""
+nvme_err_invalid_create_sq_size(uint16_t qsize) "failed creating submiss=
ion queue, invalid qsize=3D%"PRIu16""
+nvme_err_invalid_create_sq_addr(uint64_t addr) "failed creating submissi=
on queue, addr=3D0x%"PRIx64""
+nvme_err_invalid_create_sq_qflags(uint16_t qflags) "failed creating subm=
ission queue, qflags=3D%"PRIu16""
+nvme_err_invalid_del_cq_cqid(uint16_t cqid) "failed deleting completion =
queue, cqid=3D%"PRIu16""
+nvme_err_invalid_del_cq_notempty(uint16_t cqid) "failed deleting complet=
ion queue, it is not empty, cqid=3D%"PRIu16""
+nvme_err_invalid_create_cq_cqid(uint16_t cqid) "failed creating completi=
on queue, cqid=3D%"PRIu16""
+nvme_err_invalid_create_cq_size(uint16_t size) "failed creating completi=
on queue, size=3D%"PRIu16""
+nvme_err_invalid_create_cq_addr(uint64_t addr) "failed creating completi=
on queue, addr=3D0x%"PRIx64""
+nvme_err_invalid_create_cq_vector(uint16_t vector) "failed creating comp=
letion queue, vector=3D%"PRIu16""
+nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating comp=
letion queue, qflags=3D%"PRIu16""
+nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D0x%=
"PRIx16""
+nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%"PRI=
x32""
+nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D0x=
%"PRIx32""
+nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid=
 0x%"PRIx16""
+nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are no=
n-admin completion queues"
+nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are no=
n-admin submission queues"
+nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the adm=
in submission queue address is null"
+nvme_err_startfail_nbaracq(void) "nvme_start_ctrl failed because the adm=
in completion queue address is null"
+nvme_err_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin submission queue address is misaligned: 0x%"PRIx64""
+nvme_err_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin completion queue address is misaligned: 0x%"PRIx64""
+nvme_err_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too small: log2size=3D%u, m=
in=3D%u"
+nvme_err_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too large: log2size=3D%u, m=
ax=3D%u"
+nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
+nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
+nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
+nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
+nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin submission queue size is zero"
+nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin completion queue size is zero"
+nvme_err_startfail(void) "setting controller enable bit failed"
+nvme_err_internal_dev_error(const char *reason) "%s"
+
+# Traces for undefined behavior
+nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit alig=
ned, offset=3D0x%"PRIx64""
+nvme_ub_mmiowr_toosmall(uint64_t offset, unsigned size) "MMIO write smal=
ler than 32 bits, offset=3D0x%"PRIx64", size=3D%u"
+nvme_ub_mmiowr_intmask_with_msix(void) "undefined access to interrupt ma=
sk set when MSI-X is enabled"
+nvme_ub_mmiowr_ro_csts(void) "attempted to set a read only bit of contro=
ller status"
+nvme_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.NSSR=
O but CAP.NSSRS is zero (not supported)"
+nvme_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem reset =
but CAP.NSSRS is zero (not supported)"
+nvme_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBLOC w=
hen CMBSZ is zero, ignored"
+nvme_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBSZ, i=
gnored"
+nvme_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO wri=
te, offset=3D0x%"PRIx64", data=3D0x%"PRIx64""
+nvme_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit align=
ed, offset=3D0x%"PRIx64""
+nvme_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-bits=
, offset=3D0x%"PRIx64""
+nvme_ub_mmiord_invalid_ofs(uint64_t offset) "MMIO read beyond last regis=
ter, offset=3D0x%"PRIx64", returning 0"
+nvme_ub_db_wr_misaligned(uint64_t offset) "doorbell write not 32-bit ali=
gned, offset=3D0x%"PRIx64", ignoring"
+nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write =
for nonexistent queue, cqid=3D%"PRIu32", ignoring"
+nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completio=
n queue doorbell write value beyond queue size, cqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
+nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write =
for nonexistent queue, sqid=3D%"PRIu32", ignoring"
+nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submissio=
n queue doorbell write value beyond queue size, sqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
+
+# ocssd traces
+ocssd_rw(uint16_t cid, uint32_t nsid, uint16_t opcode, uint16_t nlb) "ci=
d %"PRIu16" nsid %"PRIu32" opcode 0x%"PRIx16" nlb %"PRIu16""
+ocssd_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+ocssd_copy(uint16_t cid, uint16_t nlb) "cid %"PRIu16" nlb %"PRIu16""
+ocssd_copy_in_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu=
32""
+ocssd_copy_out_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRI=
u32""
+ocssd_getfeat(uint32_t fid) "fid %"PRIu32""
+ocssd_setfeat(uint32_t fid, uint32_t val) "fid %"PRIu32" val %"PRIu32""
+ocssd_addr(uint16_t cid, char *lba) "cid %"PRIu16" %s"
+ocssd_advance_wp(uint16_t cid, uint64_t lba, uint16_t nlb) "cid %"PRIu16=
" lba 0x%"PRIx64" nlb %"PRIu16""
+ocssd_reset(uint16_t cid, uint16_t nlb) "cid %"PRIu16" nlb 0x%"PRIu16""
+ocssd_inject_write_err(uint16_t cid, uint8_t p, uint64_t lba) "cid %"PRI=
u16" p %"PRIu8" lba 0x%"PRIx64""
+ocssd_inject_reset_err(uint16_t cid, uint8_t p, uint64_t lba) "cid %"PRI=
u16" p %"PRIu8" lba 0x%"PRIx64""
+ocssd_io_cmd(uint16_t cid, uint32_t nsid, uint16_t opcode) "cid %"PRIu16=
" nsid %"PRIu32" opcode 0x%"PRIx16""
+
+# ocssd traces (notices)
+ocssd_notice_double_reset(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba=
 0x%"PRIx64""
+ocssd_notice_early_reset(uint16_t cid, uint64_t lba, uint64_t wp) "cid %=
"PRIu16" lba 0x%"PRIx64" wp %"PRIu64""
+
+# ocssd traces (error conditions)
+ocssd_err(uint16_t cid, const char *s, uint16_t err) "cid %"PRIu16" \"%s=
\" err 0x%"PRIx16""
+ocssd_err_invalid_chunk(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba 0=
x%"PRIx64""
+ocssd_err_invalid_chunk_state(uint16_t cid, uint64_t lba, uint8_t state)=
 "cid %"PRIu16" lba 0x%"PRIx64" state 0x%"PRIx8""
+ocssd_err_offline_chunk(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba 0=
x%"PRIx64""
+ocssd_err_write_constraints(uint16_t cid, uint16_t nlb, uint32_t ws_min)=
 "cid %"PRIu16" nlb %"PRIu16" ws_min %"PRIu32""
+ocssd_err_out_of_bounds(uint16_t cid, uint32_t sectr, uint64_t cnlb) "ci=
d %"PRIu16" sectr %"PRIu32" cnlb %"PRIu64""
+ocssd_err_out_of_order(uint16_t cid, uint32_t sectr, uint64_t wp) "cid %=
"PRIu16" sectr %"PRIu32" wp %"PRIu64""
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 3324aac41dbb..98b36f60dcd6 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -29,115 +29,6 @@ virtio_blk_submit_multireq(void *vdev, void *mrb, int=
 start, int num_reqs, uint6
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p=
 LCHS %d %d %d"
 hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t sec=
s, int trans) "blk %p CHS %u %u %u trans %d"
=20
-# nvme.c
-# nvme traces for successful events
-nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
-nvme_irq_pin(void) "pulsing IRQ pin"
-nvme_irq_masked(void) "IRQ is masked"
-nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
-nvme_map_prp(uint8_t cmd_opcode, uint64_t trans_len, uint32_t len, uint6=
4_t prp1, uint64_t prp2, int num_prps) "cmd_opcode=3D0x%"PRIx8", trans_le=
n=3D%"PRIu64", len=3D%"PRIu32", prp1=3D0x%"PRIx64", prp2=3D0x%"PRIx64", n=
um_prps=3D%d"
-nvme_map_sgl(uint16_t cid, uint64_t typ, uint16_t nlb, uint64_t len) "ci=
d %"PRIu16" type %"PRIu64" nlb %"PRIu16" len %"PRIu64""
-nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
-nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
-nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
-nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx6=
4", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"P=
RIu16", ien=3D%d"
-nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
-nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
-nvme_identify_ctrl(void) "identify controller"
-nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
-nvme_identify_ns_list(uint16_t ns) "identify namespace list, nsid=3D%"PR=
Iu16""
-nvme_identify_ns_descriptor_list(uint16_t ns) "identify namespace descri=
ptor list, nsid=3D%"PRIu16""
-nvme_getfeat(uint32_t fid) "fid 0x%"PRIx32""
-nvme_setfeat(uint32_t fid, uint32_t val) "fid 0x%"PRIx32" val 0x%"PRIx32=
""
-nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
-nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d=
"
-nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
-nvme_get_log(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
-nvme_process_aers(void) "processing aers"
-nvme_aer(uint16_t cid) "cid %"PRIu16""
-nvme_aer_aerl_exceeded(void) "aerl exceeded"
-nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PR=
Ix8""
-nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%=
"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
-nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid) "cid %"PRIu16" =
cqid %"PRIu16""
-nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x=
%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
-nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
-nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
-nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
-nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
-nvme_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue attributes=3D0x=
%"PRIx64""
-nvme_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue add=
ress=3D0x%"PRIx64""
-nvme_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue add=
ress=3D0x%"PRIx64""
-nvme_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n submission queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
-nvme_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n completion queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
-nvme_mmio_start_success(void) "setting controller enable bit succeeded"
-nvme_mmio_stopped(void) "cleared controller enable bit"
-nvme_mmio_shutdown_set(void) "shutdown bit set"
-nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
-
-# nvme traces for error conditions
-nvme_err(uint16_t cid, const char *s, uint16_t status) "cid %"PRIu16" \"=
%s\" status 0x%"PRIx16""
-nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
-nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
-nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
-nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be tr=
ansferred"
-nvme_err_invalid_prp(void) "invalid PRP"
-nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u n=
ot within 1-%u"
-nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
-nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8"=
"
-nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit)=
 "Invalid LBA start=3D%"PRIu64" len=3D%"PRIu64" limit=3D%"PRIu64""
-nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion=
, sid=3D%"PRIu16""
-nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submissi=
on queue, invalid cqid=3D%"PRIu16""
-nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submissi=
on queue, invalid sqid=3D%"PRIu16""
-nvme_err_invalid_create_sq_size(uint16_t qsize) "failed creating submiss=
ion queue, invalid qsize=3D%"PRIu16""
-nvme_err_invalid_create_sq_addr(uint64_t addr) "failed creating submissi=
on queue, addr=3D0x%"PRIx64""
-nvme_err_invalid_create_sq_qflags(uint16_t qflags) "failed creating subm=
ission queue, qflags=3D%"PRIu16""
-nvme_err_invalid_del_cq_cqid(uint16_t cqid) "failed deleting completion =
queue, cqid=3D%"PRIu16""
-nvme_err_invalid_del_cq_notempty(uint16_t cqid) "failed deleting complet=
ion queue, it is not empty, cqid=3D%"PRIu16""
-nvme_err_invalid_create_cq_cqid(uint16_t cqid) "failed creating completi=
on queue, cqid=3D%"PRIu16""
-nvme_err_invalid_create_cq_size(uint16_t size) "failed creating completi=
on queue, size=3D%"PRIu16""
-nvme_err_invalid_create_cq_addr(uint64_t addr) "failed creating completi=
on queue, addr=3D0x%"PRIx64""
-nvme_err_invalid_create_cq_vector(uint16_t vector) "failed creating comp=
letion queue, vector=3D%"PRIu16""
-nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating comp=
letion queue, qflags=3D%"PRIu16""
-nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D0x%=
"PRIx16""
-nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%"PRI=
x32""
-nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D0x=
%"PRIx32""
-nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid=
 0x%"PRIx16""
-nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are no=
n-admin completion queues"
-nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are no=
n-admin submission queues"
-nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the adm=
in submission queue address is null"
-nvme_err_startfail_nbaracq(void) "nvme_start_ctrl failed because the adm=
in completion queue address is null"
-nvme_err_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin submission queue address is misaligned: 0x%"PRIx64""
-nvme_err_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin completion queue address is misaligned: 0x%"PRIx64""
-nvme_err_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too small: log2size=3D%u, m=
in=3D%u"
-nvme_err_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too large: log2size=3D%u, m=
ax=3D%u"
-nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
-nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
-nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
-nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
-nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin submission queue size is zero"
-nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin completion queue size is zero"
-nvme_err_startfail(void) "setting controller enable bit failed"
-nvme_err_internal_dev_error(const char *reason) "%s"
-
-# Traces for undefined behavior
-nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit alig=
ned, offset=3D0x%"PRIx64""
-nvme_ub_mmiowr_toosmall(uint64_t offset, unsigned size) "MMIO write smal=
ler than 32 bits, offset=3D0x%"PRIx64", size=3D%u"
-nvme_ub_mmiowr_intmask_with_msix(void) "undefined access to interrupt ma=
sk set when MSI-X is enabled"
-nvme_ub_mmiowr_ro_csts(void) "attempted to set a read only bit of contro=
ller status"
-nvme_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.NSSR=
O but CAP.NSSRS is zero (not supported)"
-nvme_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem reset =
but CAP.NSSRS is zero (not supported)"
-nvme_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBLOC w=
hen CMBSZ is zero, ignored"
-nvme_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBSZ, i=
gnored"
-nvme_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO wri=
te, offset=3D0x%"PRIx64", data=3D0x%"PRIx64""
-nvme_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit align=
ed, offset=3D0x%"PRIx64""
-nvme_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-bits=
, offset=3D0x%"PRIx64""
-nvme_ub_mmiord_invalid_ofs(uint64_t offset) "MMIO read beyond last regis=
ter, offset=3D0x%"PRIx64", returning 0"
-nvme_ub_db_wr_misaligned(uint64_t offset) "doorbell write not 32-bit ali=
gned, offset=3D0x%"PRIx64", ignoring"
-nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write =
for nonexistent queue, cqid=3D%"PRIu32", ignoring"
-nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completio=
n queue doorbell write value beyond queue size, cqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
-nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write =
for nonexistent queue, sqid=3D%"PRIu32", ignoring"
-nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submissio=
n queue doorbell write value beyond queue size, sqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
-
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "=
%s d%up%u"
 xen_block_connect(const char *type, uint32_t disk, uint32_t partition) "=
%s d%up%u"
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 94d45c970894..0dced3ca7f08 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -120,6 +120,9 @@ struct BlockDriver {
     /* Set if a driver can support backing files */
     bool supports_backing;
=20
+    /* Set if a driver does not require a size parameter */
+    bool no_size_required;
+
     /* For handling image reopen for split or non-split files */
     int (*bdrv_reopen_prepare)(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue, Error **errp);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 583b61a76570..392fc7f087c0 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -461,8 +461,13 @@ typedef struct NvmeAerResult {
 } NvmeAerResult;
=20
 typedef struct NvmeCqe {
-    uint32_t    result;
-    uint32_t    rsvd;
+    union {
+        struct {
+            uint32_t cdw0;
+            uint32_t rsvd;
+        };
+        uint64_t res64;
+    };
     uint16_t    sq_head;
     uint16_t    sq_id;
     uint16_t    cid;
@@ -520,6 +525,7 @@ enum NvmeStatusCodes {
     NVME_E2E_REF_ERROR          =3D 0x0284,
     NVME_CMP_FAILURE            =3D 0x0285,
     NVME_ACCESS_DENIED          =3D 0x0286,
+    NVME_DULB                   =3D 0x0287,
     NVME_MORE                   =3D 0x2000,
     NVME_DNR                    =3D 0x4000,
     NVME_NO_COMPLETE            =3D 0xffff,
@@ -722,6 +728,8 @@ typedef struct NvmeFeatureVal {
 #define NVME_INTC_THR(intc)     (intc & 0xff)
 #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
=20
+#define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                =3D 0x1,
     NVME_POWER_MANAGEMENT           =3D 0x2,
diff --git a/include/block/ocssd.h b/include/block/ocssd.h
new file mode 100644
index 000000000000..b3174a687401
--- /dev/null
+++ b/include/block/ocssd.h
@@ -0,0 +1,231 @@
+/*
+ * QEMU OpenChannel 2.0 Controller
+ *
+ * Copyright (c) 2019 CNEX Labs, Inc.
+ *
+ * Thank you to the following people for their contributions to the orig=
inal
+ * qemu-nvme (github.com/OpenChannelSSD/qemu-nvme) implementation.
+ *
+ *   Matias Bj=C3=B8rling <mb@lightnvm.io>
+ *   Javier Gonz=C3=A1lez <javier@javigon.com>
+ *   Simon Andreas Frimann Lund <ocssd@safl.dk>
+ *   Hans Holmberg <hans@owltronix.com>
+ *   Jesper Devantier <contact@pseudonymous.me>
+ *   Young Tack Jin <youngtack.jin@circuitblvd.com>
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ */
+
+#ifndef BLOCK_OCSSD_H
+#define BLOCK_OCSSD_H
+
+#include "block/nvme.h"
+
+#define OCSSD_MAGIC ('O' << 24 | 'C' << 16 | '2' << 8 | '0')
+
+enum OcssdAdminCommands {
+    OCSSD_ADM_CMD_GEOMETRY =3D 0xe2,
+};
+
+enum OcssdIoCommands {
+    OCSSD_CMD_VECT_RESET =3D 0x90,
+    OCSSD_CMD_VECT_WRITE =3D 0x91,
+    OCSSD_CMD_VECT_READ  =3D 0x92,
+    OCSSD_CMD_VECT_COPY  =3D 0x93,
+};
+
+typedef enum OcssdChunkState {
+    OCSSD_CHUNK_FREE    =3D 1 << 0,
+    OCSSD_CHUNK_CLOSED  =3D 1 << 1,
+    OCSSD_CHUNK_OPEN    =3D 1 << 2,
+    OCSSD_CHUNK_OFFLINE =3D 1 << 3,
+} OcssdChunkState;
+
+#define OCSSD_CHUNK_RESETABLE \
+    (OCSSD_CHUNK_FREE | OCSSD_CHUNK_CLOSED | OCSSD_CHUNK_OPEN)
+
+typedef enum OcssdChunkType {
+    OCSSD_CHUNK_TYPE_SEQUENTIAL =3D 1 << 0,
+    OCSSD_CHUNK_TYPE_RANDOM     =3D 1 << 1,
+    OCSSD_CHUNK_TYPE_SHRINKED   =3D 1 << 4,
+} OcssdChunkType;
+
+enum OcssdStatusCodes {
+    OCSSD_LBAL_SGL_LENGTH_INVALID =3D 0x01c1,
+
+    OCSSD_WRITE_NEXT_UNIT         =3D 0x02f0,
+    OCSSD_CHUNK_EARLY_CLOSE       =3D 0x02f1,
+    OCSSD_OUT_OF_ORDER_WRITE      =3D 0x02f2,
+    OCSSD_OFFLINE_CHUNK           =3D 0x02c0,
+    OCSSD_INVALID_RESET           =3D 0x02c1,
+};
+
+typedef struct OcssdFeatureVal {
+    uint32_t media_feedback;
+} OcssdFeatureVal;
+
+#define OCSSD_MEDIA_FEEDBACK_VHECC(media_feedback) (media_feedback & 0x2=
)
+#define OCSSD_MEDIA_FEEDBACK_HECC(media_feedback)  (media_feedback & 0x1=
)
+
+enum OcssdFeatureIds {
+    OCSSD_MEDIA_FEEDBACK =3D 0xca,
+};
+
+typedef struct OcssdChunkDescriptor {
+    uint8_t  state;
+    uint8_t  type;
+    uint8_t  wear_index;
+    uint8_t  rsvd7[5];
+    uint64_t slba;
+    uint64_t cnlb;
+    uint64_t wp;
+} OcssdChunkDescriptor;
+
+enum OcssdChunkNotificationState {
+    OCSSD_CHUNK_NOTIFICATION_STATE_LOW       =3D 1 << 0,
+    OCSSD_CHUNK_NOTIFICATION_STATE_MID       =3D 1 << 1,
+    OCSSD_CHUNK_NOTIFICATION_STATE_HIGH      =3D 1 << 2,
+    OCSSD_CHUNK_NOTIFICATION_STATE_UNREC     =3D 1 << 3,
+    OCSSD_CHUNK_NOTIFICATION_STATE_REFRESHED =3D 1 << 4,
+    OCSSD_CHUNK_NOTIFICATION_STATE_WLI       =3D 1 << 8
+};
+
+enum OcssdChunkNotificationMask {
+    OCSSD_CHUNK_NOTIFICATION_MASK_SECTOR =3D 1 << 0,
+    OCSSD_CHUNK_NOTIFICATION_MASK_CHUNK  =3D 1 << 1,
+    OCSSD_CHUNK_NOTIFICATION_MASK_PUNIT  =3D 1 << 2
+};
+
+typedef struct OcssdChunkNotification {
+    uint64_t    nc;
+    uint64_t    lba;
+    uint32_t    nsid;
+    uint16_t    state;
+    uint8_t     mask;
+    uint8_t     rsvd31[9];
+    uint16_t    nlb;
+    uint8_t     rsvd63[30];
+} OcssdChunkNotification;
+
+typedef struct OcssdRwCmd {
+    uint16_t    opcode:8;
+    uint16_t    fuse:2;
+    uint16_t    rsvd1:4;
+    uint16_t    psdt:2;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint64_t    rsvd2;
+    uint64_t    metadata;
+    NvmeCmdDptr dptr;
+    uint64_t    lbal;
+    uint16_t    nlb;
+    uint16_t    control;
+    uint32_t    rsvd3;
+    uint64_t    rsvd4;
+} OcssdRwCmd;
+
+typedef struct OcssdCopyCmd {
+    uint16_t    opcode:8;
+    uint16_t    fuse:2;
+    uint16_t    rsvd1:4;
+    uint16_t    psdt:2;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint64_t    rsvd2;
+    uint64_t    metadata;
+    NvmeCmdDptr dptr;
+    uint64_t    lbal;
+    uint16_t    nlb;
+    uint16_t    control;
+    uint32_t    rsvd3;
+    uint64_t    dlbal;
+} OcssdCopyCmd;
+
+typedef struct OcssdIdGeo {
+    uint16_t num_grp;
+    uint16_t num_pu;
+    uint32_t num_chk;
+    uint32_t clba;
+    uint8_t  rsvd63[52];
+} OcssdIdGeo;
+
+typedef struct OcssdIdWrt {
+    uint32_t ws_min;
+    uint32_t ws_opt;
+    uint32_t mw_cunits;
+    uint8_t  rsvd63[52];
+} OcssdIdWrt;
+
+typedef struct OcssdIdPerf {
+    uint32_t trdt;
+    uint32_t trdm;
+    uint32_t tprt;
+    uint32_t tprm;
+    uint32_t tbet;
+    uint32_t tbem;
+    uint8_t  rsvd63[40];
+} OcssdIdPerf;
+
+typedef struct OcssdIdLBAF {
+    uint8_t grp_len;
+    uint8_t pu_len;
+    uint8_t chk_len;
+    uint8_t sec_len;
+    uint8_t rsvd7[4];
+} OcssdIdLBAF;
+
+typedef struct OcssdFormatHeader {
+    uint32_t    magic;
+    uint32_t    version;
+    uint32_t    num_ns;
+    uint32_t    md_size;
+    uint64_t    sector_size;
+    uint64_t    ns_size;
+    uint32_t    pe_cycles;
+    OcssdIdLBAF lbaf;
+    uint8_t     rsvd4095[4052];
+} OcssdFormatHeader;
+
+typedef struct OcssdIdentity {
+    struct {
+        uint8_t major;
+        uint8_t minor;
+    } ver;
+    uint8_t     rsvd1[6];
+    OcssdIdLBAF lbaf;
+    uint32_t    mccap;
+    uint8_t     rsvd2[12];
+    uint8_t     wit;
+    uint8_t     rsvd3[31];
+    OcssdIdGeo  geo;
+    OcssdIdWrt  wrt;
+    OcssdIdPerf perf;
+    uint8_t     rsvd4[3840];
+} OcssdIdentity;
+
+enum OcssdIdentityMccap {
+    OCSSD_IDENTITY_MCCAP_MULTIPLE_RESETS =3D 0x1 << 1,
+
+    /* OCSSD 2.0 spec de-facto extension */
+    OCSSD_IDENTITY_MCCAP_EARLY_RESET =3D 0x1 << 2,
+};
+
+enum OcssdLogPage {
+    OCSSD_CHUNK_INFO         =3D 0xCA,
+    OCSSD_CHUNK_NOTIFICATION =3D 0xD0,
+};
+
+static inline void _ocssd_check_sizes(void)
+{
+    QEMU_BUILD_BUG_ON(sizeof(OcssdIdLBAF)            !=3D 8);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdIdGeo)             !=3D 64);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdIdWrt)             !=3D 64);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdIdPerf)            !=3D 64);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdRwCmd)             !=3D 64);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdIdentity)          !=3D 4096);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdChunkDescriptor)   !=3D 32);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdChunkNotification) !=3D 64);
+    QEMU_BUILD_BUG_ON(sizeof(OcssdFormatHeader)      !=3D 4096);
+}
+
+#endif
diff --git a/hw/block/nvme.h b/include/hw/block/nvme.h
similarity index 63%
rename from hw/block/nvme.h
rename to include/hw/block/nvme.h
index 7e1e026d90e6..db8ea0b6d8ac 100644
--- a/hw/block/nvme.h
+++ b/include/hw/block/nvme.h
@@ -1,7 +1,17 @@
 #ifndef HW_NVME_H
 #define HW_NVME_H
=20
+#include "qemu/log.h"
 #include "block/nvme.h"
+#include "hw/block/block.h"
+#include "hw/pci/pci.h"
+
+#define NVME_GUEST_ERR(trace, fmt, ...) \
+    do { \
+        (trace_##trace)(__VA_ARGS__); \
+        qemu_log_mask(LOG_GUEST_ERROR, #trace \
+            " in %s: " fmt "\n", __func__, ## __VA_ARGS__); \
+    } while (0)
=20
 #define DEFINE_NVME_PROPERTIES(_state, _props) \
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
@@ -49,6 +59,7 @@ typedef struct NvmeRequest {
=20
     uint64_t slba;
     uint16_t nlb;
+    hwaddr   mptr;
     uint16_t status;
     bool     is_cmb;
     bool     is_write;
@@ -139,8 +150,14 @@ typedef struct NvmeCtrl {
     NvmeCQueue      admin_cq;
     NvmeFeatureVal  features;
     NvmeIdCtrl      id_ctrl;
+
+    uint16_t (*admin_cmd)(struct NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req);
+    uint16_t (*io_cmd)(struct NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *re=
q);
 } NvmeCtrl;
=20
+typedef uint16_t (*NvmeBlockSetupFn)(NvmeCtrl *n, NvmeNamespace *ns,
+    QEMUSGList *qsg, uint64_t blk_offset, uint32_t unit_len, NvmeRequest=
 *req);
+
 static inline bool nvme_rw_is_write(NvmeRequest *req)
 {
     return req->cmd.opcode =3D=3D NVME_CMD_WRITE;
@@ -169,4 +186,48 @@ static inline uint16_t nvme_ns_ms(NvmeNamespace *ns)
     return le16_to_cpu(id->lbaf[NVME_ID_NS_FLBAS_INDEX(id->flbas)].ms);
 }
=20
+void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size);
+void nvme_addr_write(NvmeCtrl *n, hwaddr addr, void *buf, int size);
+
+uint16_t nvme_dma_read(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+    NvmeCmd *cmd, NvmeRequest *req);
+uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+    NvmeSglDescriptor sgl, NvmeCmd *cmd, NvmeRequest *req);
+uint16_t nvme_dma_write(NvmeCtrl *n, uint8_t *ptr, uint32_t len, NvmeCmd=
 *cmd,
+    NvmeRequest *req);
+
+void nvme_rw_cb(void *opaque, int ret);
+uint16_t nvme_rw_check_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req);
+
+void nvme_clear_events(NvmeCtrl *n, uint8_t event_type);
+void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type, uint8_t event_i=
nfo,
+    uint8_t log_page);
+
+void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req);
+
+NvmeBlockBackendRequest *nvme_blk_req_get(NvmeCtrl *n, NvmeRequest *req,
+    QEMUSGList *qsg);
+void nvme_blk_req_put(NvmeCtrl *n, NvmeBlockBackendRequest *blk_req);
+
+uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req,
+    NvmeBlockSetupFn blk_setup);
+uint16_t nvme_blk_submit_io(NvmeCtrl *n, NvmeRequest *req,
+    BlockCompletionFunc *cb);
+
+uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req);
+
+uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req);
+uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req);
+uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req);
+uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req);
+
+void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns);
+
+int nvme_init_blk(NvmeCtrl *n, Error **errp);
+int nvme_init_state(NvmeCtrl *n, Error **errp);
+void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev);
+void nvme_init_ctrl(NvmeCtrl *n);
+
+void nvme_free_ctrl(NvmeCtrl *n, PCIDevice *pci_dev);
+
 #endif /* HW_NVME_H */
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 0abe27a53a38..ece1f37cbe01 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -273,4 +273,6 @@
=20
 #define PCI_VENDOR_ID_NVIDIA             0x10de
=20
+#define PCI_VENDOR_ID_CNEX               0x1d1d
+
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0b4..5e13808530c3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -113,6 +113,44 @@
       'extents': ['ImageInfo']
   } }
=20
+##
+# @ImageInfoSpecificOcssd:
+#
+# @num-ns: number of namespaces
+#
+# @namespaces: List of namespsaces
+#
+# Since: 4.1
+##
+{ 'struct': 'ImageInfoSpecificOcssd',
+  'data': {
+      'num-ns': 'int',
+      'sector-size': 'int',
+      'metadata-size': 'int',
+      'namespaces': ['ImageInfoSpecificOcssdNS']
+  } }
+
+##
+# @ImageInfoSpecificOcssdNS:
+#
+# @num-grp: number of groups
+#
+# @num-pu: number of parallel units per group
+#
+# @num-chk: number of chunks per parallel unit
+#
+# @num-sec: number of sectors per chunk
+#
+# Since: 3.1
+##
+{ 'struct': 'ImageInfoSpecificOcssdNS',
+  'data': {
+      'num-grp': 'int',
+      'num-pu': 'int',
+      'num-chk': 'int',
+      'num-sec': 'int'
+  } }
+
 ##
 # @ImageInfoSpecific:
 #
@@ -124,6 +162,7 @@
   'data': {
       'qcow2': 'ImageInfoSpecificQCow2',
       'vmdk': 'ImageInfoSpecificVmdk',
+      'ocssd': 'ImageInfoSpecificOcssd',
       # If we need to add block driver specific parameters for
       # LUKS in future, then we'll subclass QCryptoBlockInfoLUKS
       # to define a ImageInfoSpecificLUKS
@@ -282,7 +321,7 @@
 # @drv: the name of the block format used to open the backing device. As=
 of
 #       0.14.0 this can be: 'blkdebug', 'bochs', 'cloop', 'cow', 'dmg',
 #       'file', 'file', 'ftp', 'ftps', 'host_cdrom', 'host_device',
-#       'http', 'https', 'luks', 'nbd', 'parallels', 'qcow',
+#       'http', 'https', 'luks', 'nbd', 'ocssd', 'parallels', 'qcow',
 #       'qcow2', 'raw', 'vdi', 'vmdk', 'vpc', 'vvfat'
 #       2.2: 'archipelago' added, 'cow' dropped
 #       2.3: 'host_floppy' deprecated
@@ -290,6 +329,7 @@
 #       2.6: 'luks' added
 #       2.8: 'replication' added, 'tftp' dropped
 #       2.9: 'archipelago' dropped
+#       4.1: 'ocssd' added
 #
 # @backing_file: the name of the backing file (for copy-on-write)
 #
@@ -2815,8 +2855,8 @@
   'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',
             'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
             'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks=
',
-            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'q=
cow',
-            'qcow2', 'qed', 'quorum', 'raw', 'rbd',
+            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'ocssd', 'paral=
lels',
+            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
             { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)'=
 },
             'sheepdog',
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'v=
xhs' ] }
@@ -3917,6 +3957,7 @@
       'null-aio':   'BlockdevOptionsNull',
       'null-co':    'BlockdevOptionsNull',
       'nvme':       'BlockdevOptionsNVMe',
+      'ocssd':      'BlockdevOptionsGenericFormat',
       'parallels':  'BlockdevOptionsGenericFormat',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsQcow',
--=20
2.21.0


