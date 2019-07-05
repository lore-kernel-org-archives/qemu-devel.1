Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9671C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDB7218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDB7218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIcT-0000Nv-11
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZZ-0005Gz-Lb
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZX-0005k5-UF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:23:57 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZV-0005fm-1a; Fri, 05 Jul 2019 03:23:53 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id D78D1BF644;
 Fri,  5 Jul 2019 07:23:50 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:18 +0200
Message-Id: <20190705072333.17171-2-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 01/16] nvme: simplify namespace code
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
Cc: kwolf@redhat.com, matt.fitzpatrick@oakgatetech.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device model currently only supports a single namespace and also
specifically sets num_namespaces to 1. Take this into account and
simplify the code.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 26 +++++++-------------------
 hw/block/nvme.h |  2 +-
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 36d6a8bb3a3e..28ebaf1368b1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -424,7 +424,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
-    ns =3D &n->namespaces[nsid - 1];
+    ns =3D &n->namespace;
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, ns, cmd, req);
@@ -670,7 +670,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
-    ns =3D &n->namespaces[nsid - 1];
+    ns =3D &n->namespace;
=20
     return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns)=
,
         prp1, prp2);
@@ -1306,8 +1306,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
 {
     NvmeCtrl *n =3D NVME(pci_dev);
     NvmeIdCtrl *id =3D &n->id_ctrl;
+    NvmeIdNs *id_ns =3D &n->namespace.id_ns;
=20
-    int i;
     int64_t bs_size;
     uint8_t *pci_conf;
=20
@@ -1347,7 +1347,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
     n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
=20
-    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->num_queues);
=20
@@ -1416,20 +1415,10 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     }
=20
-    for (i =3D 0; i < n->num_namespaces; i++) {
-        NvmeNamespace *ns =3D &n->namespaces[i];
-        NvmeIdNs *id_ns =3D &ns->id_ns;
-        id_ns->nsfeat =3D 0;
-        id_ns->nlbaf =3D 0;
-        id_ns->flbas =3D 0;
-        id_ns->mc =3D 0;
-        id_ns->dpc =3D 0;
-        id_ns->dps =3D 0;
-        id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-        id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
-    }
+    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
+        cpu_to_le64(n->ns_size >>
+            id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)].ds);
 }
=20
 static void nvme_exit(PCIDevice *pci_dev)
@@ -1437,7 +1426,6 @@ static void nvme_exit(PCIDevice *pci_dev)
     NvmeCtrl *n =3D NVME(pci_dev);
=20
     nvme_clear_ctrl(n);
-    g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 557194ee1954..40cedb1ec932 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -83,7 +83,7 @@ typedef struct NvmeCtrl {
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
=20
     char            *serial;
-    NvmeNamespace   *namespaces;
+    NvmeNamespace   namespace;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
--=20
2.20.1


