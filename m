Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F41EC3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D6120737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D6120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObDp-0006MH-9w
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOazK-0003Oi-AS
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOazJ-000352-3u
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:30 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOazF-0002ki-9Z; Wed, 15 Apr 2020 01:53:25 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id EF176BFE03;
 Wed, 15 Apr 2020 05:52:33 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 43/48] nvme: add support for sgl bit bucket descriptor
Date: Wed, 15 Apr 2020 07:51:35 +0200
Message-Id: <20200415055140.466900-44-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
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
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

This adds support for SGL descriptor type 0x1 (bit bucket descriptor).
See the NVM Express v1.3d specification, Section 4.4 ("Scatter Gather
List (SGL)").

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a19085e605e7..f295f027b8e2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -375,6 +375,10 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUS=
GList *qsg,
         uint8_t type =3D NVME_SGL_TYPE(segment[i].type);
=20
         switch (type) {
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
+            if (nvme_req_is_write(req)) {
+                continue;
+            }
         case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
             break;
         case NVME_SGL_DESCR_TYPE_SEGMENT:
@@ -385,6 +389,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSG=
List *qsg,
         }
=20
         dlen =3D le32_to_cpu(segment[i].len);
+
         if (!dlen) {
             continue;
         }
@@ -405,6 +410,11 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUS=
GList *qsg,
         }
=20
         trans_len =3D MIN(*len, dlen);
+
+        if (type =3D=3D NVME_SGL_DESCR_TYPE_BIT_BUCKET) {
+            goto next;
+        }
+
         addr =3D le64_to_cpu(segment[i].addr);
=20
         if (UINT64_MAX - addr < dlen) {
@@ -416,6 +426,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSG=
List *qsg,
             return status;
         }
=20
+next:
         *len -=3D trans_len;
     }
=20
@@ -486,7 +497,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList =
*qsg, QEMUIOVector *iov,
         seg_len =3D le32_to_cpu(sgld->len);
=20
         /* check the length of the (Last) Segment descriptor */
-        if (!seg_len || seg_len & 0xf) {
+        if ((!seg_len || seg_len & 0xf) &&
+            (NVME_SGL_TYPE(sgld->type) !=3D NVME_SGL_DESCR_TYPE_BIT_BUCK=
ET)) {
             return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
         }
=20
@@ -523,19 +535,27 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGLis=
t *qsg, QEMUIOVector *iov,
=20
         last_sgld =3D &segment[nsgld - 1];
=20
-        /* if the segment ends with a Data Block, then we are done */
-        if (NVME_SGL_TYPE(last_sgld->type) =3D=3D NVME_SGL_DESCR_TYPE_DA=
TA_BLOCK) {
+        /*
+         * If the segment ends with a Data Block or Bit Bucket Descripto=
r Type,
+         * then we are done.
+         */
+        switch (NVME_SGL_TYPE(last_sgld->type)) {
+        case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
             status =3D nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &l=
en, req);
             if (status) {
                 goto unmap;
             }
=20
             goto out;
+
+        default:
+            break;
         }
=20
         /*
-         * If the last descriptor was not a Data Block, then the current
-         * segment must not be a Last Segment.
+         * If the last descriptor was not a Data Block or Bit Bucket, th=
en the
+         * current segment must not be a Last Segment.
          */
         if (NVME_SGL_TYPE(sgld->type) =3D=3D NVME_SGL_DESCR_TYPE_LAST_SE=
GMENT) {
             status =3D NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
@@ -2537,7 +2557,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAM=
P);
=20
-    id->sgls =3D cpu_to_le32(NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT);
+    id->sgls =3D cpu_to_le32(NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT |
+                           NVME_CTRL_SGLS_BITBUCKET);
=20
     pstrcpy((char *) id->subnqn, sizeof(id->subnqn), "nqn.2019-08.org.qe=
mu:");
     pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
--=20
2.26.0


