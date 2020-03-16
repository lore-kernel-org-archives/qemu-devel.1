Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE5D20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE5D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt2x-0005pn-HQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlL-0000Uf-MG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlI-0005Fq-6E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:39 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDql8-00023u-PB; Mon, 16 Mar 2020 10:30:27 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id BA3CEBF9AA;
 Mon, 16 Mar 2020 14:29:49 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 28/42] nvme: verify validity of prp lists in the cmb
Date: Mon, 16 Mar 2020 07:29:14 -0700
Message-Id: <20200316142928.153431-29-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Before this patch the device already supported this, but it did not
check for the validity of it nor announced the support in the LISTS
field.

If some of the PRPs in a PRP list are in the CMB, then ALL entries must
be there. This patch makes sure that is verified as well as properly
announcing support for PRP lists in the CMB.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 850087aac967..eecfad694bf8 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -210,6 +210,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, QEMUIOVector *iov,
     trans_len =3D MIN(len, trans_len);
     int num_prps =3D (len >> n->page_bits) + 1;
     uint16_t status;
+    bool prp_list_in_cmb =3D false;
=20
     trace_nvme_dev_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
                            num_prps);
@@ -237,11 +238,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGLis=
t *qsg, QEMUIOVector *iov,
             status =3D NVME_INVALID_FIELD | NVME_DNR;
             goto unmap;
         }
+
         if (len > n->page_size) {
             uint64_t prp_list[n->max_prp_ents];
             uint32_t nents, prp_trans;
             int i =3D 0;
=20
+            if (nvme_addr_is_cmb(n, prp2)) {
+                prp_list_in_cmb =3D true;
+            }
+
             nents =3D (len + n->page_size - 1) >> n->page_bits;
             prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(uint64_t)=
;
             nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
@@ -255,6 +261,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, QEMUIOVector *iov,
                         goto unmap;
                     }
=20
+                    if (prp_list_in_cmb !=3D nvme_addr_is_cmb(n, prp_ent=
)) {
+                        status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+                        goto unmap;
+                    }
+
                     i =3D 0;
                     nents =3D (len + n->page_size - 1) >> n->page_bits;
                     prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(u=
int64_t);
@@ -274,6 +285,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, QEMUIOVector *iov,
                 if (status) {
                     goto unmap;
                 }
+
                 len -=3D trans_len;
                 i++;
             }
@@ -1931,7 +1943,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *p=
ci_dev)
=20
     NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
--=20
2.25.1


