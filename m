Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF1B206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GyhtX0Dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF1B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwY3-00031C-Ad
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZG-00021Y-9r
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZA-0007RU-Tb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvZ9-00071n-0Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130949euoutp02812a888e2017b982a3d26939aa921a5e~hx8QbK73z0729207292euoutp026
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130949euoutp02812a888e2017b982a3d26939aa921a5e~hx8QbK73z0729207292euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760989;
 bh=dF+FLAZ6JN9Bpkyg+erq19TP68rLQkh+OO1SKyTQ4jE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=GyhtX0DjQ8e8BVVMGHbnhYfqZFp6W3vCNvksv+0z8klJ3jSd8x4ROad5sSbyRNqnK
 lvWhc3rJrKEJTmxo1C7dG1RK5wzel0vH3Lv5uLrbcvAfgTcnKssJQD9AJsvYxkgBKz
 daj4SKHu08UPf5aOYN8VGLyIzOvHQM7eZiMeW2Wk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191219130949eucas1p1ea6614045f6d013e993b64cef7e99293~hx8QLCeJ-1260812608eucas1p1l;
 Thu, 19 Dec 2019 13:09:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 7D.05.60679.D967BFD5; Thu, 19
 Dec 2019 13:09:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130948eucas1p2cfed0da65071fd76446daecbb217e86e~hx8Pu2LQX1986419864eucas1p2a;
 Thu, 19 Dec 2019 13:09:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130948eusmtrp228b8b58dbb4a0b111116445fb1a238b3~hx8PuT9zb3120131201eusmtrp2X;
 Thu, 19 Dec 2019 13:09:48 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-f5-5dfb769db418
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.BE.07950.C967BFD5; Thu, 19
 Dec 2019 13:09:48 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130948eusmtip1260ea9e26d1284d79df8223de628d4e3~hx8PmD-lH3187731877eusmtip1K;
 Thu, 19 Dec 2019 13:09:48 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:48 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:47 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 21/24] nvme: support multiple namespaces
Date: Thu, 19 Dec 2019 14:09:18 +0100
Message-ID: <20191219130921.309264-22-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87pzy37HGvQ1C1ts7m9ntJh06Bqj
 xZKLqRbzbilbzHrXzmZxvHcHiwObx6ZVnWwed67tYfN4cm0zk8f7fVfZAliiuGxSUnMyy1KL
 9O0SuDK63h1mKdj7jrHi4RLDBsYz2xm7GDk5JARMJDYen8LexcjFISSwglHix4sHzBDOF0aJ
 zXf+MUE4nxklmt6eZ4JpuffmIVTVckaJ1r7DrHBVvQees0A4Zxglbk1exQjh7GKUePfkPwtI
 P5uApsT2PxC2iIC0RPvVSWDtzALXGSUO/b7IDpIQFrCWOD+hiRXEZhFQlfi16znYvbxA8emT
 l0DdLi+x9dsnsBpOoPiW3ttQNYISJ2c+AVvADFTTvHU2M4QtIXHwxQuwwyUEVrFLzGpaygox
 yEXi+tt/zBC2sMSr41vYIWwZif875zNBNHQzSvR9+ArVPYNRYvqy72xdjBxAjrVE35kciAZH
 ifYpu5ggwnwSN94KQizmk5i0bTozRJhXoqNNCKJaTWJH01bGCYzKs5CcPQvJ2bOQnL2AkXkV
 o3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYIo5/e/4lx2Mu/4kHWIU4GBU4uF9kfw7Vog1
 say4MvcQowQHs5II7+2On7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0t
 SC2CyTJxcEo1MFqddpk+lyPadvHm4h1F5w8/1L8zw/yfQZjpyeXTDoeebFdimsIc1LBUyGPz
 4rKHf8VCLqR0vcs/LVkrzndJP97a/LnSRZ/WtNtlT840Oy5/cSEjc16E+cErxp0964/Ya/NM
 PnN+E2PK+r112bM56h7K32zeqxA5Z5P0xtifpdae8nXyjpKXApRYijMSDbWYi4oTAae0y68t
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7pzyn7HGqzrMLXY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBE6dkU5ZeWpCpk
 5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV0vTvMUrD3HWPFwyWG
 DYxntjN2MXJySAiYSNx785C5i5GLQ0hgKaPE9JnH2SASMhKfrnxkh7CFJf5c62KDKPrIKHHi
 yy6ojjOMErc6eplAqoQEdjFKfOmJB7HZBDQltv/5zwJiiwhIS7RfncQK0sAscJ1R4tDvi2Bj
 hQWsJc5PaGIFsVkEVCV+7XoOdhMvUHz65CVQ98lLbP32CayGEyi+pfc2I8QyK4nHPz+yQNQL
 Spyc+QTMZgaqb946mxnClpA4+OIF8wRG4VlIymYhKZuFpGwBI/MqRpHU0uLc9NxiI73ixNzi
 0rx0veT83E2MwCjbduznlh2MXe+CDzEKcDAq8fA6pP2OFWJNLCuuzD3EKMHBrCTCe7vjZ6wQ
 b0piZVVqUX58UWlOavEhRlOg5yYyS4km5wMTQF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0
 xJLU7NTUgtQimD4mDk6pBsasPeJ2cwL+fvnYxJGYuyb/3wWbDTvUNhyeceSj39s5p+dvnvOh
 o8tQ7fDHg7KPJu7t/lgU3bz8QYjm2asvrURPPT4dm/539q+OjlVPfbcfctmnYKq176+MSdrp
 Ld35YnwOB56WGksrfkk89yHQNINpV/vFqscszAzmPSELDPJvV2/Q47Pq+e2txFKckWioxVxU
 nAgANj1jr8gCAAA=
X-CMS-MailID: 20191219130948eucas1p2cfed0da65071fd76446daecbb217e86e
X-Msg-Generator: CA
X-RootMTR: 20191219130948eucas1p2cfed0da65071fd76446daecbb217e86e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130948eucas1p2cfed0da65071fd76446daecbb217e86e
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130948eucas1p2cfed0da65071fd76446daecbb217e86e@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
X-Mailman-Approved-At: Thu, 19 Dec 2019 08:56:47 -0500
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
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
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
 hw/block/nvme-ns.c     | 158 ++++++++++++++++++++++++++++
 hw/block/nvme-ns.h     |  60 +++++++++++
 hw/block/nvme.c        | 229 +++++++++++++++++++++++++----------------
 hw/block/nvme.h        |  47 ++++-----
 hw/block/trace-events  |   6 +-
 6 files changed, 386 insertions(+), 116 deletions(-)
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
index 000000000000..36deedee07a6
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
+    dc->props =3D nvme_ns_props;
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
index b3fca3c4ea58..e1bf9bf3798b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -17,10 +17,11 @@
 /**
  * Usage: add options:
  *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
- *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[optio=
nal]>, \
+ *      -device nvme,serial=3D<serial>,id=3D<id[optional]>, \
  *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
  *              num_queues=3D<N[optional]>, \
  *              mdts=3D<mdts[optional]>
+ *      -device nvme-ns,drive=3D<drive_id>,bus=3Dnvme0,nsid=3D1
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
@@ -86,6 +89,17 @@ static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, vo=
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
@@ -912,7 +926,7 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n,=
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
@@ -947,11 +961,12 @@ static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequ=
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
@@ -1034,7 +1049,8 @@ static void nvme_aio_cb(void *opaque, int ret)
=20
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeAIO *aio =3D nvme_aio_new(n->conf.blk, 0x0, 0, NULL, NULL, req, =
NULL);
+    NvmeNamespace *ns =3D req->ns;
+    NvmeAIO *aio =3D nvme_aio_new(ns->blk, 0x0, 0, NULL, NULL, req, NULL=
);
=20
     nvme_req_register_aio(req, aio, NVME_AIO_OPC_FLUSH);
     nvme_aio(aio);
@@ -1056,19 +1072,19 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, Nvm=
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
     offset =3D req->slba << nvme_ns_lbads(ns);
     count =3D req->nlb << nvme_ns_lbads(ns);
=20
-    aio =3D nvme_aio_new(n->conf.blk, offset, count, NULL, NULL, req, NU=
LL);
+    aio =3D nvme_aio_new(ns->blk, offset, count, NULL, NULL, req, NULL);
=20
     nvme_req_register_aio(req, aio, NVME_AIO_OPC_WRITE_ZEROES);
     nvme_aio(aio);
@@ -1088,22 +1104,23 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd=
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
@@ -1115,12 +1132,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
=20
     trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
), cmd->opcode);
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
@@ -1266,18 +1282,24 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
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
+
+        BlockAcctStats *s =3D blk_get_stats(ns->blk);
=20
-    units_read =3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
-    units_written =3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
-    read_commands =3D s->nr_ops[BLOCK_ACCT_READ];
-    write_commands =3D s->nr_ops[BLOCK_ACCT_WRITE];
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
@@ -1487,19 +1509,25 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
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
-    }
+    if (unlikely(!ns)) {
+        uint16_t status =3D nvme_nsid_err(n, nsid);
+
+        if (!nvme_status_is_error(status, NVME_INVALID_FIELD)) {
+            return status;
+        }
=20
-    ns =3D &n->namespaces[nsid - 1];
+        id_ns =3D &inactive;
+    } else {
+        id_ns =3D &ns->id_ns;
+    }
=20
-    return nvme_dma(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), cmd,
+    return nvme_dma(n, (uint8_t *) id_ns, sizeof(NvmeIdNs), cmd,
         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
@@ -1515,11 +1543,11 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
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
@@ -1549,9 +1577,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
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
@@ -1691,7 +1718,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         result =3D cpu_to_le32(n->features.err_rec);
         break;
     case NVME_VOLATILE_WRITE_CACHE:
-        result =3D blk_enable_write_cache(n->conf.blk);
+        result =3D cpu_to_le32(n->features.volatile_wc);
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
@@ -1745,6 +1772,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl=
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
@@ -1776,8 +1805,19 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
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
@@ -1902,9 +1942,17 @@ static void nvme_process_sq(void *opaque)
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
@@ -1927,7 +1975,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
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
@@ -2347,8 +2403,8 @@ static int nvme_check_constraints(NvmeCtrl *n, Erro=
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
@@ -2365,22 +2421,10 @@ static int nvme_check_constraints(NvmeCtrl *n, Er=
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
@@ -2495,12 +2539,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
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
@@ -2521,22 +2560,25 @@ static void nvme_init_ctrl(NvmeCtrl *n)
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
+
+    if (nsid =3D=3D 0 || nsid > NVME_MAX_NAMESPACES) {
+        error_setg(errp, "invalid nsid");
+        return 1;
+    }
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg_errno(errp, -bs_size, "blk_getlength");
+    if (n->namespaces[nsid - 1]) {
+        error_setg(errp, "nsid must be unique");
         return 1;
     }
=20
-    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-    n->ns_size =3D bs_size;
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
@@ -2544,30 +2586,31 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeN=
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
+    nvme_init_pci(n, pci_dev);
+    nvme_init_ctrl(n);
=20
-    if (nvme_init_blk(n, &local_err)) {
-        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
-        return;
-    }
+    /* setup a namespace if the controller drive property was given */
+    if (n->namespace.blk) {
+        ns =3D &n->namespace;
+        ns->params.nsid =3D 1;
=20
-    for (i =3D 0; i < n->num_namespaces; i++) {
-        if (nvme_init_namespace(n, &n->namespaces[i], &local_err)) {
-            error_propagate_prepend(errp, local_err, "nvme_init_namespac=
e: ");
+        if (nvme_ns_setup(n, ns, &local_err)) {
+            error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
             return;
         }
     }
-
-    nvme_init_pci(n, pci_dev);
-    nvme_init_ctrl(n);
 }
=20
 static void nvme_exit(PCIDevice *pci_dev)
@@ -2588,7 +2631,8 @@ static void nvme_exit(PCIDevice *pci_dev)
 }
=20
 static Property nvme_props[] =3D {
-    DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
+    DEFINE_BLOCK_PROPERTIES_BASE(NvmeCtrl, conf), \
+    DEFINE_PROP_DRIVE("drive", NvmeCtrl, namespace.blk), \
     DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2620,26 +2664,35 @@ static void nvme_instance_init(Object *obj)
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
index 2fe3e7b415c2..8a6eec72d81d 100644
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
@@ -100,26 +103,6 @@ typedef struct NvmeCQueue {
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
@@ -174,6 +157,13 @@ static inline bool nvme_req_is_write(NvmeRequest *re=
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
@@ -183,8 +173,9 @@ typedef struct NvmeCtrl {
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
@@ -195,7 +186,6 @@ typedef struct NvmeCtrl {
     uint32_t    reg_size;
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
-    uint64_t    ns_size;
     uint8_t     outstanding_aers;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
@@ -211,7 +201,8 @@ typedef struct NvmeCtrl {
     QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
     int         aer_queued;
=20
-    NvmeNamespace   *namespaces;
+    NvmeNamespace   namespace;
+    NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
@@ -220,9 +211,13 @@ typedef struct NvmeCtrl {
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
@@ -245,4 +240,6 @@ static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
     return req->sq->ctrl;
 }
=20
+int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp=
);
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 8901cf087ee2..02f301aa05a8 100644
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
@@ -93,7 +94,8 @@ nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP=
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
2.24.1


