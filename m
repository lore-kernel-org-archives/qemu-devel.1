Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134AAC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C187820674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Hnn+I3u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C187820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv7J-0007Kz-UZ
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyut1-00056f-Tk
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusw-0007zf-IF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusw-0007aG-5U
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095230euoutp02fc420aa6e80171d7acbf9da117ab2921~wKkZJBHyc2946829468euoutp02R
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095230euoutp02fc420aa6e80171d7acbf9da117ab2921~wKkZJBHyc2946829468euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809950;
 bh=kaEpfdJgxugysTus+dEx0NXPx/hf91ayQqfA6XUnGeg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Hnn+I3u256eKlqTdCnOf4z5kNXUmejYUMz4nWTR4c8NSC11I/4l7jbDR5cQ2ZmxNo
 lI6wZm2S9PTmoYLX17yff8cRvN9Dqy1ujytPWRdFHbN3hz7kiY1tCJsIFIA+fYK0bQ
 u18X+jPfBuw5lh40el6s3y0rTmmtcNcncz57o364=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095230eucas1p1f99ae707ca16832509213163ad803552~wKkZAiBIb0927609276eucas1p1G;
 Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C8.EF.60698.EDE393E5; Tue,  4
 Feb 2020 09:52:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821~wKkYo4WI61139211392eucas1p2y;
 Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095230eusmtrp2c5da0868d045577f0cf3b4f2c761b149~wKkYoMPad0489204892eusmtrp2S;
 Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-15-5e393ede16c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.7A.07950.DDE393E5; Tue,  4
 Feb 2020 09:52:29 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095229eusmtip2b9dc93681c71b547844be5d731d2550b~wKkYe_gj42765927659eusmtip2Q;
 Tue,  4 Feb 2020 09:52:29 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:29 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:28 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 22/26] nvme: support multiple namespaces
Date: Tue, 4 Feb 2020 10:52:04 +0100
Message-ID: <20200204095208.269131-23-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7r37CzjDK49ELLY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGaffNjAWnH7LWNG0+RxLA+PUbYxdjJwcEgImEmdPnGbqYuTiEBJY
 wSjxc30nK4TzhVFi75SNzBDOZ0aJr9OvsMC0PNz5iREisZxRYsX5vaxwVft2fIZqOQ007OtN
 qMxORommTdvB+tkENCW2//kPZosISEu0X50EVsQs8JtRYm7jRLYuRg4OYQFridW7OUBqWARU
 JBbNX8cGYvMChf+e+s4GcYe8xOzG02A2J1B8/6oTTBA1ghInZz4Bm88MVNO8dTYzhC0hcfDF
 C7DrJAR2sUs0t51khxjkIjH/2kZmCFtY4tXxLVBxGYn/O+czQTR0M0r0ffgK1T2DUWL6su9g
 l0oAre47kwPR4CixfMFBZogwn8SNt4IQi/kkJm2bDhXmlehoE4KoVpPY0bSVcQKj8iwkZ89C
 cvYsJGcvYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZh2Tv87/nUH474/SYcYBTgY
 lXh4NRwt4oRYE8uKK3MPMUpwMCuJ8J7Xt4wT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWs
 kEB6YklqdmpqQWoRTJaJg1OqgdFHzmhl4tTAtRdW7I5R2Rg69a1MUdxadgeN8uSGzOfeaROz
 Psm0LuOTs5cLiPmasX75E3enf+eEKi7HqGVP/1y2a7c2t1BCLMvth0KFgjGaCo8ZxJwe/X87
 4X3qt5nvDU6V+nVwuFx/6FjA/Hb9zuVPb3XuftEWUPy5QNHlmkx5wKoyp7+r1imxFGckGmox
 FxUnAgDpgormNwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7p37SzjDJ6/trbY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gaff
 NjAWnH7LWNG0+RxLA+PUbYxdjJwcEgImEg93fgKzhQSWMkp83uEEEZeR+HTlIzuELSzx51oX
 WxcjF1DNR0aJ52u/MkE4pxkltt+YwgzRvZNR4vdTERCbTUBTYvuf/ywgtoiAtET71UmsIDaz
 wG9GiT99gV2MHBzCAtYSq3dzgIRZBFQkFs1fxwZi8wKF/576zgaxWF5iduNpMJsTKL5/1Qkm
 kFYhASuJ1qPcEOWCEidnPmGBmC4v0bx1NjOELSFx8MUL5gmMwrOQlM1CUjYLSdkCRuZVjCKp
 pcW56bnFRnrFibnFpXnpesn5uZsYgTG37djPLTsYu94FH2IU4GBU4uHVcLSIE2JNLCuuzD3E
 KMHBrCTCe17fMk6INyWxsiq1KD++qDQntfgQoynQbxOZpUST84HpIK8k3tDU0NzC0tDc2NzY
 zEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+PlLvt9C+20Hv+sD5Jp37Zap1lby3KGj6AS
 96XTpu2Vude5pm95zL7h6SP7J5c8VH0Nf688tD1t0uH9sV8T5U8J3bi458epdjXtQ211e7q0
 uxVWRqXdMPC1Esy/bS7l2HmbJeZyRxebluKvk9x7qw5O64i4sCcwOT5f2q9kw+InGh77eY/V
 dSuxFGckGmoxFxUnAgAaoNBwzwIAAA==
X-CMS-MailID: 20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821
X-Msg-Generator: CA
X-RootMTR: 20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds support for multiple namespaces by introducing a new 'nvme-ns'
device model. The nvme device creates a bus named from the device name
('id'). The nvme-ns devices then connect to this and registers
themselves with the nvme device.

This changes how an nvme device is created. Example with two namespaces:

  -drive file=3Dnvme0n1.img,if=3Dnone,id=3Ddisk1
  -drive file=3Dnvme0n2.img,if=3Dnone,id=3Ddisk2
  -device nvme,serial=3Ddeadbeef,id=3Dnvme0
  -device nvme-ns,drive=3Ddisk1,bus=3Dnvme0,nsid=3D1
  -device nvme-ns,drive=3Ddisk2,bus=3Dnvme0,nsid=3D2

The drive property is kept on the nvme device to keep the change
backward compatible, but the property is now optional. Specifying a
drive for the nvme device will always create the namespace with nsid 1.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/Makefile.objs |   2 +-
 hw/block/nvme-ns.c     | 158 +++++++++++++++++++++++++++
 hw/block/nvme-ns.h     |  60 +++++++++++
 hw/block/nvme.c        | 235 +++++++++++++++++++++++++----------------
 hw/block/nvme.h        |  47 ++++-----
 hw/block/trace-events  |   6 +-
 6 files changed, 389 insertions(+), 119 deletions(-)
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 28c2495a00dc..45f463462f1e 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -7,7 +7,7 @@ common-obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
 common-obj-$(CONFIG_XEN) +=3D xen-block.o
 common-obj-$(CONFIG_ECC) +=3D ecc.o
 common-obj-$(CONFIG_ONENAND) +=3D onenand.o
-common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
+common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o nvme-ns.o
 common-obj-$(CONFIG_SWIM) +=3D swim.o
=20
 obj-$(CONFIG_SH4) +=3D tc58128.o
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
new file mode 100644
index 000000000000..0e5be44486f4
--- /dev/null
+++ b/hw/block/nvme-ns.c
@@ -0,0 +1,158 @@
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "hw/block/block.h"
+#include "hw/pci/msix.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/qdev-core.h"
+
+#include "nvme.h"
+#include "nvme-ns.h"
+
+static int nvme_ns_init(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+
+    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D
+        cpu_to_le64(nvme_ns_nlbas(ns));
+
+    return 0;
+}
+
+static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, NvmeIdCtrl *=
id,
+    Error **errp)
+{
+    uint64_t perm, shared_perm;
+
+    Error *local_err =3D NULL;
+    int ret;
+
+    perm =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+    shared_perm =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED =
|
+        BLK_PERM_GRAPH_MOD;
+
+    ret =3D blk_set_perm(ns->blk, perm, shared_perm, &local_err);
+    if (ret) {
+        error_propagate_prepend(errp, local_err, "blk_set_perm: ");
+        return ret;
+    }
+
+    ns->size =3D blk_getlength(ns->blk);
+    if (ns->size < 0) {
+        error_setg_errno(errp, -ns->size, "blk_getlength");
+        return 1;
+    }
+
+    switch (n->conf.wce) {
+    case ON_OFF_AUTO_ON:
+        n->features.volatile_wc =3D 1;
+        break;
+    case ON_OFF_AUTO_OFF:
+        n->features.volatile_wc =3D 0;
+    case ON_OFF_AUTO_AUTO:
+        n->features.volatile_wc =3D blk_enable_write_cache(ns->blk);
+        break;
+    default:
+        abort();
+    }
+
+    blk_set_enable_write_cache(ns->blk, n->features.volatile_wc);
+
+    return 0;
+}
+
+static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
+{
+    if (!ns->blk) {
+        error_setg(errp, "block backend not configured");
+        return 1;
+    }
+
+    return 0;
+}
+
+int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    Error *local_err =3D NULL;
+
+    if (nvme_ns_check_constraints(ns, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+            "nvme_ns_check_constraints: ");
+        return 1;
+    }
+
+    if (nvme_ns_init_blk(n, ns, &n->id_ctrl, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_ns_init_blk: ");
+        return 1;
+    }
+
+    nvme_ns_init(ns);
+    if (nvme_register_namespace(n, ns, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_register_namespac=
e: ");
+        return 1;
+    }
+
+    return 0;
+}
+
+static void nvme_ns_realize(DeviceState *dev, Error **errp)
+{
+    NvmeNamespace *ns =3D NVME_NS(dev);
+    BusState *s =3D qdev_get_parent_bus(dev);
+    NvmeCtrl *n =3D NVME(s->parent);
+    Error *local_err =3D NULL;
+
+    if (nvme_ns_setup(n, ns, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
+        return;
+    }
+}
+
+static Property nvme_ns_props[] =3D {
+    DEFINE_NVME_NS_PROPERTIES(NvmeNamespace, params),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nvme_ns_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    dc->bus_type =3D TYPE_NVME_BUS;
+    dc->realize =3D nvme_ns_realize;
+    device_class_set_props(dc, nvme_ns_props);
+    dc->desc =3D "virtual nvme namespace";
+}
+
+static void nvme_ns_instance_init(Object *obj)
+{
+    NvmeNamespace *ns =3D NVME_NS(obj);
+    char *bootindex =3D g_strdup_printf("/namespace@%d,0", ns->params.ns=
id);
+
+    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
+        bootindex, DEVICE(obj), &error_abort);
+
+    g_free(bootindex);
+}
+
+static const TypeInfo nvme_ns_info =3D {
+    .name =3D TYPE_NVME_NS,
+    .parent =3D TYPE_DEVICE,
+    .class_init =3D nvme_ns_class_init,
+    .instance_size =3D sizeof(NvmeNamespace),
+    .instance_init =3D nvme_ns_instance_init,
+};
+
+static void nvme_ns_register_types(void)
+{
+    type_register_static(&nvme_ns_info);
+}
+
+type_init(nvme_ns_register_types)
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
new file mode 100644
index 000000000000..b564bac25f6d
--- /dev/null
+++ b/hw/block/nvme-ns.h
@@ -0,0 +1,60 @@
+#ifndef NVME_NS_H
+#define NVME_NS_H
+
+#define TYPE_NVME_NS "nvme-ns"
+#define NVME_NS(obj) \
+    OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
+
+#define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
+    DEFINE_PROP_DRIVE("drive", _state, blk), \
+    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
+
+typedef struct NvmeNamespaceParams {
+    uint32_t nsid;
+} NvmeNamespaceParams;
+
+typedef struct NvmeNamespace {
+    DeviceState  parent_obj;
+    BlockBackend *blk;
+    int32_t      bootindex;
+    int64_t      size;
+
+    NvmeIdNs            id_ns;
+    NvmeNamespaceParams params;
+} NvmeNamespace;
+
+static inline uint32_t nvme_nsid(NvmeNamespace *ns)
+{
+    if (ns) {
+        return ns->params.nsid;
+    }
+
+    return -1;
+}
+
+static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+    return id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    return nvme_ns_lbaf(ns).ds;
+}
+
+static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
+{
+    return 1 << nvme_ns_lbads(ns);
+}
+
+static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
+{
+    return ns->size >> nvme_ns_lbads(ns);
+}
+
+typedef struct NvmeCtrl NvmeCtrl;
+
+int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
+
+#endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a91c60fdc111..3a377bc56734 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -17,10 +17,11 @@
 /**
  * Usage: add options:
  *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
- *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[optio=
nal]>, \
+ *      -device nvme,serial=3D<serial>,id=3D<bus_name>, \
  *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
  *              num_queues=3D<N[optional]>, \
  *              mdts=3D<mdts[optional]>
+ *      -device nvme-ns,drive=3D<drive_id>,bus=3Dbus_name,nsid=3D1
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -28,6 +29,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/error-report.h"
 #include "hw/block/block.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
@@ -43,6 +45,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "nvme.h"
+#include "nvme-ns.h"
=20
 #define NVME_SPEC_VER 0x00010300
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
@@ -85,6 +88,17 @@ static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, vo=
id *buf, int size)
     return pci_dma_read(&n->parent_obj, addr, buf, size);
 }
=20
+static uint16_t nvme_nsid_err(NvmeCtrl *n, uint32_t nsid)
+{
+    if (nsid && nsid < n->num_namespaces) {
+        trace_nvme_dev_err_inactive_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
+    return NVME_INVALID_NSID | NVME_DNR;
+}
+
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
     return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
@@ -889,7 +903,7 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n,=
 uint64_t slba,
     uint64_t nsze =3D le64_to_cpu(ns->id_ns.nsze);
=20
     if (unlikely((slba + nlb) > nsze)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk),
+        block_acct_invalid(blk_get_stats(ns->blk),
             nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ)=
;
         trace_nvme_dev_err_invalid_lba_range(slba, nlb, nsze);
         return NVME_LBA_RANGE | NVME_DNR;
@@ -924,11 +938,12 @@ static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequ=
est *req)
=20
 static void nvme_rw_cb(NvmeRequest *req, void *opaque)
 {
+    NvmeNamespace *ns =3D req->ns;
     NvmeSQueue *sq =3D req->sq;
     NvmeCtrl *n =3D sq->ctrl;
     NvmeCQueue *cq =3D n->cq[sq->cqid];
=20
-    trace_nvme_dev_rw_cb(nvme_cid(req), req->cmd.nsid);
+    trace_nvme_dev_rw_cb(nvme_cid(req), nvme_nsid(ns));
=20
     nvme_enqueue_req_completion(cq, req);
 }
@@ -1011,10 +1026,11 @@ static void nvme_aio_cb(void *opaque, int ret)
=20
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
+    NvmeNamespace *ns =3D req->ns;
     NvmeAIO *aio =3D g_new0(NvmeAIO, 1);
=20
     *aio =3D (NvmeAIO) {
-        .blk =3D n->conf.blk,
+        .blk =3D ns->blk,
         .req =3D req,
     };
=20
@@ -1038,12 +1054,12 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, Nvm=
eCmd *cmd, NvmeRequest *req)
     req->slba =3D le64_to_cpu(rw->slba);
     req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
=20
-    trace_nvme_dev_write_zeros(nvme_cid(req), le32_to_cpu(cmd->nsid),
-        req->slba, req->nlb);
+    trace_nvme_dev_write_zeros(nvme_cid(req), nvme_nsid(ns), req->slba,
+        req->nlb);
=20
     status =3D nvme_check_bounds(n, req->slba, req->nlb, req);
     if (unlikely(status)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), BLOCK_ACCT_WRITE)=
;
+        block_acct_invalid(blk_get_stats(ns->blk), BLOCK_ACCT_WRITE);
         return status;
     }
=20
@@ -1053,7 +1069,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     aio =3D g_new0(NvmeAIO, 1);
=20
     *aio =3D (NvmeAIO) {
-        .blk =3D n->conf.blk,
+        .blk =3D ns->blk,
         .offset =3D offset,
         .len =3D count,
         .req =3D req,
@@ -1077,22 +1093,23 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
     req->slba =3D le64_to_cpu(rw->slba);
=20
-    trace_nvme_dev_rw(nvme_req_is_write(req) ? "write" : "read", req->nl=
b,
-        req->nlb << nvme_ns_lbads(req->ns), req->slba);
+    trace_nvme_dev_rw(nvme_cid(req), nvme_req_is_write(req) ? "write" : =
"read",
+        nvme_nsid(ns), req->nlb, req->nlb << nvme_ns_lbads(ns),
+        req->slba);
=20
     status =3D nvme_check_rw(n, req);
     if (status) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        block_acct_invalid(blk_get_stats(ns->blk), acct);
         return status;
     }
=20
     status =3D nvme_map(n, cmd, req);
     if (status) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        block_acct_invalid(blk_get_stats(ns->blk), acct);
         return status;
     }
=20
-    nvme_rw_aio(n->conf.blk, req->slba << nvme_ns_lbads(ns), req);
+    nvme_rw_aio(ns->blk, req->slba << nvme_ns_lbads(ns), req);
     nvme_req_set_cb(req, nvme_rw_cb, NULL);
=20
     return NVME_NO_COMPLETE;
@@ -1105,12 +1122,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
     trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
),
         cmd->opcode);
=20
-    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
-        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
-        return NVME_INVALID_NSID | NVME_DNR;
-    }
+    req->ns =3D nvme_ns(n, nsid);
=20
-    req->ns =3D &n->namespaces[nsid - 1];
+    if (unlikely(!req->ns)) {
+        return nvme_nsid_err(n, nsid);
+    }
=20
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
@@ -1256,18 +1272,24 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
Cmd *cmd, uint8_t rae,
     uint64_t units_read =3D 0, units_written =3D 0, read_commands =3D 0,
         write_commands =3D 0;
     NvmeSmartLog smart;
-    BlockAcctStats *s;
=20
     if (nsid && nsid !=3D 0xffffffff) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    s =3D blk_get_stats(n->conf.blk);
+    for (int i =3D 1; i <=3D n->num_namespaces; i++) {
+        NvmeNamespace *ns =3D nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
=20
-    units_read =3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
-    units_written =3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
-    read_commands =3D s->nr_ops[BLOCK_ACCT_READ];
-    write_commands =3D s->nr_ops[BLOCK_ACCT_WRITE];
+        BlockAcctStats *s =3D blk_get_stats(ns->blk);
+
+        units_read +=3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS=
;
+        units_written +=3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_=
BITS;
+        read_commands +=3D s->nr_ops[BLOCK_ACCT_READ];
+        write_commands +=3D s->nr_ops[BLOCK_ACCT_WRITE];
+    }
=20
     if (off > sizeof(smart)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1477,19 +1499,25 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
vmeCmd *cmd, NvmeRequest *req)
=20
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
-    NvmeNamespace *ns;
+    NvmeIdNs *id_ns, inactive =3D { 0 };
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    NvmeNamespace *ns =3D nvme_ns(n, nsid);
=20
     trace_nvme_dev_identify_ns(nsid);
=20
-    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
-        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
-        return NVME_INVALID_NSID | NVME_DNR;
+    if (unlikely(!ns)) {
+        uint16_t status =3D nvme_nsid_err(n, nsid);
+
+        if (!nvme_status_is_error(status, NVME_INVALID_FIELD)) {
+            return status;
+        }
+
+        id_ns =3D &inactive;
+    } else {
+        id_ns =3D &ns->id_ns;
     }
=20
-    ns =3D &n->namespaces[nsid - 1];
-
-    return nvme_dma(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), cmd,
+    return nvme_dma(n, (uint8_t *) id_ns, sizeof(NvmeIdNs), cmd,
         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
@@ -1505,11 +1533,11 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
, NvmeCmd *cmd,
     trace_nvme_dev_identify_ns_list(min_nsid);
=20
     list =3D g_malloc0(data_len);
-    for (i =3D 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+    for (i =3D 1; i <=3D n->num_namespaces; i++) {
+        if (i <=3D min_nsid || !nvme_ns(n, i)) {
             continue;
         }
-        list[j++] =3D cpu_to_le32(i + 1);
+        list[j++] =3D cpu_to_le32(i);
         if (j =3D=3D data_len / sizeof(uint32_t)) {
             break;
         }
@@ -1539,9 +1567,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeCmd *cmd,
=20
     trace_nvme_dev_identify_ns_descr_list(nsid);
=20
-    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
-        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
-        return NVME_INVALID_NSID | NVME_DNR;
+    if (unlikely(!nvme_ns(n, nsid))) {
+        return nvme_nsid_err(n, nsid);
     }
=20
     /*
@@ -1681,7 +1708,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         result =3D cpu_to_le32(n->features.err_rec);
         break;
     case NVME_VOLATILE_WRITE_CACHE:
-        result =3D blk_enable_write_cache(n->conf.blk);
+        result =3D cpu_to_le32(n->features.volatile_wc);
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
@@ -1735,6 +1762,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd,
=20
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
+    NvmeNamespace *ns;
+
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
@@ -1766,8 +1795,19 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
=20
         break;
     case NVME_VOLATILE_WRITE_CACHE:
-        blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
+        n->features.volatile_wc =3D dw11;
+
+        for (int i =3D 1; i <=3D n->num_namespaces; i++) {
+            ns =3D nvme_ns(n, i);
+            if (!ns) {
+                continue;
+            }
+
+            blk_set_enable_write_cache(ns->blk, dw11 & 1);
+        }
+
         break;
+
     case NVME_NUMBER_OF_QUEUES:
         if (n->qs_created) {
             return NVME_CMD_SEQ_ERROR | NVME_DNR;
@@ -1890,9 +1930,17 @@ static void nvme_process_sq(void *opaque)
=20
 static void nvme_clear_ctrl(NvmeCtrl *n)
 {
+    NvmeNamespace *ns;
     int i;
=20
-    blk_drain(n->conf.blk);
+    for (i =3D 1; i <=3D n->num_namespaces; i++) {
+        ns =3D nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        blk_drain(ns->blk);
+    }
=20
     for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->sq[i] !=3D NULL) {
@@ -1915,7 +1963,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
     n->outstanding_aers =3D 0;
     n->qs_created =3D false;
=20
-    blk_flush(n->conf.blk);
+    for (i =3D 1; i <=3D n->num_namespaces; i++) {
+        ns =3D nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        blk_flush(ns->blk);
+    }
+
     n->bar.cc =3D 0;
 }
=20
@@ -2335,8 +2391,8 @@ static int nvme_check_constraints(NvmeCtrl *n, Erro=
r **errp)
 {
     NvmeParams *params =3D &n->params;
=20
-    if (!n->conf.blk) {
-        error_setg(errp, "nvme: block backend not configured");
+    if (!n->namespace.blk && !n->parent_obj.qdev.id) {
+        error_setg(errp, "nvme: invalid 'id' parameter");
         return 1;
     }
=20
@@ -2353,22 +2409,10 @@ static int nvme_check_constraints(NvmeCtrl *n, Er=
ror **errp)
     return 0;
 }
=20
-static int nvme_init_blk(NvmeCtrl *n, Error **errp)
-{
-    blkconf_blocksizes(&n->conf);
-    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
-        false, errp)) {
-        return 1;
-    }
-
-    return 0;
-}
-
 static void nvme_init_state(NvmeCtrl *n)
 {
-    n->num_namespaces =3D 1;
+    n->num_namespaces =3D 0;
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
-    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
=20
@@ -2483,12 +2527,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
-
-
-    if (blk_enable_write_cache(n->conf.blk)) {
-        id->vwc =3D 1;
-    }
-
+    id->vwc =3D 1;
     id->sgls =3D cpu_to_le32(0x1);
=20
     strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
@@ -2509,22 +2548,25 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     n->bar.intmc =3D n->bar.intms =3D 0;
 }
=20
-static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
+int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp=
)
 {
-    int64_t bs_size;
-    NvmeIdNs *id_ns =3D &ns->id_ns;
+    uint32_t nsid =3D nvme_nsid(ns);
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg_errno(errp, -bs_size, "blk_getlength");
+    if (nsid =3D=3D 0 || nsid > NVME_MAX_NAMESPACES) {
+        error_setg(errp, "invalid nsid");
         return 1;
     }
=20
-    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-    n->ns_size =3D bs_size;
+    if (n->namespaces[nsid - 1]) {
+        error_setg(errp, "nsid must be unique");
+        return 1;
+    }
+
+    trace_nvme_dev_register_namespace(nsid);
=20
-    id_ns->ncap =3D id_ns->nuse =3D id_ns->nsze =3D
-        cpu_to_le64(nvme_ns_nlbas(n, ns));
+    n->namespaces[nsid - 1] =3D ns;
+    n->num_namespaces =3D MAX(n->num_namespaces, nsid);
+    n->id_ctrl.nn =3D cpu_to_le32(n->num_namespaces);
=20
     return 0;
 }
@@ -2532,30 +2574,31 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeN=
amespace *ns, Error **errp)
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n =3D NVME(pci_dev);
+    NvmeNamespace *ns;
     Error *local_err =3D NULL;
-    int i;
=20
     if (nvme_check_constraints(n, &local_err)) {
         error_propagate_prepend(errp, local_err, "nvme_check_constraints=
: ");
         return;
     }
=20
+    qbus_create_inplace(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS,
+        &pci_dev->qdev, n->parent_obj.qdev.id);
+
     nvme_init_state(n);
-
-    if (nvme_init_blk(n, &local_err)) {
-        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
-        return;
-    }
-
-    for (i =3D 0; i < n->num_namespaces; i++) {
-        if (nvme_init_namespace(n, &n->namespaces[i], &local_err)) {
-            error_propagate_prepend(errp, local_err, "nvme_init_namespac=
e: ");
-            return;
-        }
-    }
-
     nvme_init_pci(n, pci_dev);
     nvme_init_ctrl(n);
+
+    /* setup a namespace if the controller drive property was given */
+    if (n->namespace.blk) {
+        ns =3D &n->namespace;
+        ns->params.nsid =3D 1;
+
+        if (nvme_ns_setup(n, ns, &local_err)) {
+            error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
+            return;
+        }
+    }
 }
=20
 static void nvme_exit(PCIDevice *pci_dev)
@@ -2576,7 +2619,8 @@ static void nvme_exit(PCIDevice *pci_dev)
 }
=20
 static Property nvme_props[] =3D {
-    DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
+    DEFINE_BLOCK_PROPERTIES_BASE(NvmeCtrl, conf), \
+    DEFINE_PROP_DRIVE("drive", NvmeCtrl, namespace.blk), \
     DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2608,26 +2652,35 @@ static void nvme_instance_init(Object *obj)
 {
     NvmeCtrl *s =3D NVME(obj);
=20
-    device_add_bootindex_property(obj, &s->conf.bootindex,
-                                  "bootindex", "/namespace@1,0",
-                                  DEVICE(obj), &error_abort);
+    if (s->namespace.blk) {
+        device_add_bootindex_property(obj, &s->conf.bootindex,
+                                      "bootindex", "/namespace@1,0",
+                                      DEVICE(obj), &error_abort);
+    }
 }
=20
 static const TypeInfo nvme_info =3D {
     .name          =3D TYPE_NVME,
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(NvmeCtrl),
-    .class_init    =3D nvme_class_init,
     .instance_init =3D nvme_instance_init,
+    .class_init    =3D nvme_class_init,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
 };
=20
+static const TypeInfo nvme_bus_info =3D {
+    .name =3D TYPE_NVME_BUS,
+    .parent =3D TYPE_BUS,
+    .instance_size =3D sizeof(NvmeBus),
+};
+
 static void nvme_register_types(void)
 {
     type_register_static(&nvme_info);
+    type_register_static(&nvme_bus_info);
 }
=20
 type_init(nvme_register_types)
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 3319f8edd7e1..c3cef0f024da 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -2,6 +2,9 @@
 #define HW_NVME_H
=20
 #include "block/nvme.h"
+#include "nvme-ns.h"
+
+#define NVME_MAX_NAMESPACES 256
=20
 #define DEFINE_NVME_PROPERTIES(_state, _props) \
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
@@ -108,26 +111,6 @@ typedef struct NvmeCQueue {
     QTAILQ_HEAD(, NvmeRequest) req_list;
 } NvmeCQueue;
=20
-typedef struct NvmeNamespace {
-    NvmeIdNs        id_ns;
-} NvmeNamespace;
-
-static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
-{
-    NvmeIdNs *id_ns =3D &ns->id_ns;
-    return id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
-}
-
-static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
-{
-    return nvme_ns_lbaf(ns).ds;
-}
-
-static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
-{
-    return 1 << nvme_ns_lbads(ns);
-}
-
 typedef enum NvmeAIOOp {
     NVME_AIO_OPC_NONE         =3D 0x0,
     NVME_AIO_OPC_FLUSH        =3D 0x1,
@@ -182,6 +165,13 @@ static inline bool nvme_req_is_write(NvmeRequest *re=
q)
     }
 }
=20
+#define TYPE_NVME_BUS "nvme-bus"
+#define NVME_BUS(obj) OBJECT_CHECK(NvmeBus, (obj), TYPE_NVME_BUS)
+
+typedef struct NvmeBus {
+    BusState parent_bus;
+} NvmeBus;
+
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
@@ -191,8 +181,9 @@ typedef struct NvmeCtrl {
     MemoryRegion iomem;
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
-    BlockConf    conf;
     NvmeParams   params;
+    NvmeBus      bus;
+    BlockConf    conf;
=20
     bool        qs_created;
     uint32_t    page_size;
@@ -203,7 +194,6 @@ typedef struct NvmeCtrl {
     uint32_t    reg_size;
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
-    uint64_t    ns_size;
     uint8_t     outstanding_aers;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
@@ -219,7 +209,8 @@ typedef struct NvmeCtrl {
     QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
     int         aer_queued;
=20
-    NvmeNamespace   *namespaces;
+    NvmeNamespace   namespace;
+    NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
@@ -228,9 +219,13 @@ typedef struct NvmeCtrl {
     NvmeFeatureVal  features;
 } NvmeCtrl;
=20
-static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
+static inline NvmeNamespace *nvme_ns(NvmeCtrl *n, uint32_t nsid)
 {
-    return n->ns_size >> nvme_ns_lbads(ns);
+    if (!nsid || nsid > n->num_namespaces) {
+        return NULL;
+    }
+
+    return n->namespaces[nsid - 1];
 }
=20
 static inline uint16_t nvme_cid(NvmeRequest *req)
@@ -253,4 +248,6 @@ static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
     return req->sq->ctrl;
 }
=20
+int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp=
);
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 81d69e15fc32..aaf1fcda7923 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -29,6 +29,7 @@ hd_geometry_guess(void *blk, uint32_t cyls, uint32_t he=
ads, uint32_t secs, int t
=20
 # nvme.c
 # nvme traces for successful events
+nvme_dev_register_namespace(uint32_t nsid) "nsid %"PRIu32""
 nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
 nvme_dev_irq_pin(void) "pulsing IRQ pin"
 nvme_dev_irq_masked(void) "IRQ is masked"
@@ -38,7 +39,7 @@ nvme_dev_map_sgl(uint16_t cid, uint8_t typ, uint32_t nl=
b, uint64_t len) "cid %"P
 nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, =
uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu1=
6" aio %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
 nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t o=
ffset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offse=
t %"PRIu64" opc \"%s\" req %p"
 nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opco=
de) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
-nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, u=
int64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+nvme_dev_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb,=
 uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRI=
u32" count %"PRIu64" lba 0x%"PRIx64""
 nvme_dev_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32=
""
 nvme_dev_write_zeros(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_=
t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
 nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t=
 qsize, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sq=
id=3D%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
@@ -94,7 +95,8 @@ nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP=
 list entry is null or no
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_missing(void) "PRP2 is null and more data to b=
e transferred"
 nvme_dev_err_invalid_prp(void) "invalid PRP"
-nvme_dev_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace =
%u not within 1-%u"
+nvme_dev_err_invalid_ns(uint32_t nsid, uint32_t nn) "nsid %"PRIu32" nn %=
"PRIu32""
+nvme_dev_err_inactive_ns(uint32_t nsid, uint32_t nn) "nsid %"PRIu32" nn =
%"PRIu32""
 nvme_dev_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 nvme_dev_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PR=
Ix8""
 nvme_dev_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t li=
mit) "Invalid LBA start=3D%"PRIu64" len=3D%"PRIu64" limit=3D%"PRIu64""
--=20
2.25.0


