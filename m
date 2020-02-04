Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F9AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B239D217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vAHVMDtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B239D217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuxr-0006c3-TU
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusq-0004Zg-M7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusn-0007fm-LS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:40 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusn-0007EX-Bv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095226euoutp01457390129dedf02466ab4b0d820edc77~wKkVTC1Sn3058130581euoutp014
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095226euoutp01457390129dedf02466ab4b0d820edc77~wKkVTC1Sn3058130581euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809946;
 bh=6QaTQ9Sly84NQgbEk3NOnq1wLelERw54KcH48JfoqLs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=vAHVMDtcrD5d020gHQoX0RzK0XmCSqOeRJKWDIcHbcIf1TVyOyBMOiwS7BvRLWw4i
 VN+i7WrQZ89MhZrfbhxm0Ie3OqCr5KQ+IeeMwbYWcv7zLuESb6Zp3gGa5n+tXcwTO5
 t8Pqlt9pIoA1Jr6EauQYcywLTj2Usb24VGISNKjg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095226eucas1p1f85de176033a8b7f28f5b703150b0d5f~wKkVJmTe70923009230eucas1p18;
 Tue,  4 Feb 2020 09:52:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id CE.EB.60679.ADE393E5; Tue,  4
 Feb 2020 09:52:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095225eucas1p226336a91fb5460dddae5caa85964279f~wKkUz9nOj1194411944eucas1p22;
 Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095225eusmtrp231e9a9183c8bfa9418ab77835341cf50~wKkUzUNQk0489204892eusmtrp2I;
 Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-39-5e393edae7ce
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.6A.07950.9DE393E5; Tue,  4
 Feb 2020 09:52:25 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095225eusmtip1efa5c3696440f2376c9cb64d8196332c~wKkUre_a23103431034eusmtip1t;
 Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:25 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:24 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 16/26] nvme: refactor prp mapping
Date: Tue, 4 Feb 2020 10:51:58 +0100
Message-ID: <20200204095208.269131-17-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87q37CzjDHY281ls7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujA898gVX1zJWHJu4namBcV5NFyMnh4SAicSqFZ/Zuxi5OIQEVjBK
 7F1wnR0kISTwhVHixfd8iMRnRolVlxexwnSs3baWESKxnFHicu9KVriqjT3roZzTjBITGyew
 QDg7GSXmP94DNphNQFNi+5//LCC2iIC0RPvVSWAdzAK/GSXmNk5kA0kIAy359f4KE4jNIqAi
 sf7gMmYQm1fAWqKr7zIzxCHyErMbT4PVcwLF9686wQRRIyhxcuYTsAXMQDXNW2czQ9gSEgdf
 vIDq3cYusXqZTBcjB5DtInF1ShFEWFji1fEt7BC2jMT/nfOZQG6TEOhmlOj78JUZwpnBKDF9
 2Xc2iGZrib4zORANjhIPp81mgQjzSdx4Kwixlk9i0rbpzBBhXomONiGIajWJHU1bGScwKs9C
 cvQsJEfPQnL0AkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHp5vS/4192MO76k3SI
 UYCDUYmH9+RZizgh1sSy4srcQ4wSHMxKIrzn9S3jhHhTEiurUovy44tKc1KLDzFKc7AoifMa
 L3oZKySQnliSmp2aWpBaBJNl4uCUamC03ZNhKtbBWXHPNV7nZETG3JMTeCZOZ0jdHmC1Rkch
 VT7z5YVe7b2z7rNcvn9NvGRBx9PDm9UWCc7YlfvHoa5BWeP05pOv7+xZ1FSwLarsprnpXQPN
 yG6/9bpPTfpN7r+5ejFcPs7aSkCWR9v96rw/Alv1rB+pxR7c0SWX8vLSr1PLTd7KhdQpsRRn
 JBpqMRcVJwIA4sdjezMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xu7o37SzjDE6tMrPY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GR96
 5AuurmWsODZxO1MD47yaLkZODgkBE4m129YydjFycQgJLGWUuLD4BBNEQkbi05WP7BC2sMSf
 a11sEEUfGSU+7PnBDOGcZpRYv6oNytnJKDHz1UJmkBY2AU2J7X/+s4DYIgLSEu1XJ7GC2MwC
 vxkl/vQFgtjCQLt/vb8Cto5FQEVi/cFlYL28AtYSXX2XmSFWy0vMbjzNBmJzAsX3rwI5jwNo
 mZVE61FuiHJBiZMzn7BAjJeXaN46mxnClpA4+OIF8wRG4VlIymYhKZuFpGwBI/MqRpHU0uLc
 9NxiI73ixNzi0rx0veT83E2MwKjbduznlh2MXe+CDzEKcDAq8fBqOFrECbEmlhVX5h5ilOBg
 VhLhPa9vGSfEm5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cCEkFcSb2hqaG5haWhubG5sZqEk
 ztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXHy/L2vPj2yvv7lIPu9Wh6foFWvfrF/0V29JOr+
 nrkCG5f8FGNWSGXOKZfecpPHVzDq7z97g9CclskNK7w+ZFwQKptwj+Owy/J5oXc50usD57Zd
 e7vWQe+LzM7JfxftanpTvDdQn2PqKtvcu8ndDA+X32zbpHR73mkpgeCz14/7br6sfCX+NWOL
 EktxRqKhFnNRcSIAseurptACAAA=
X-CMS-MailID: 20200204095225eucas1p226336a91fb5460dddae5caa85964279f
X-Msg-Generator: CA
X-RootMTR: 20200204095225eucas1p226336a91fb5460dddae5caa85964279f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095225eucas1p226336a91fb5460dddae5caa85964279f
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095225eucas1p226336a91fb5460dddae5caa85964279f@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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

Refactor nvme_map_prp and allow PRPs to be located in the CMB. The logic
ensures that if some of the PRP is in the CMB, all of it must be located
there, as per the specification.

Also combine nvme_dma_{read,write}_prp into a single nvme_dma_prp that
takes an additional DMADirection parameter.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 245 +++++++++++++++++++++++++++---------------
 hw/block/nvme.h       |   2 +-
 hw/block/trace-events |   1 +
 include/block/nvme.h  |   1 +
 4 files changed, 160 insertions(+), 89 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4acfc85b56a2..334265efb21e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -58,6 +58,11 @@
=20
 static void nvme_process_sq(void *opaque);
=20
+static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
+{
+    return &n->cmbuf[addr - n->ctrl_mem.addr];
+}
+
 static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
     hwaddr low =3D n->ctrl_mem.addr;
@@ -152,138 +157,187 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQ=
ueue *cq)
     }
 }
=20
-static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_=
t prp1,
-                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
+static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector =
*iov,
+    uint64_t prp1, uint64_t prp2, uint32_t len, NvmeRequest *req)
 {
     hwaddr trans_len =3D n->page_size - (prp1 % n->page_size);
     trans_len =3D MIN(len, trans_len);
     int num_prps =3D (len >> n->page_bits) + 1;
+    uint16_t status =3D NVME_SUCCESS;
+    bool is_cmb =3D false;
+    bool prp_list_in_cmb =3D false;
+
+    trace_nvme_dev_map_prp(nvme_cid(req), req->cmd.opcode, trans_len, le=
n,
+        prp1, prp2, num_prps);
=20
     if (unlikely(!prp1)) {
         trace_nvme_dev_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->cmbsz && prp1 >=3D n->ctrl_mem.addr &&
-               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))=
 {
-        qsg->nsg =3D 0;
+    }
+
+    if (nvme_addr_is_cmb(n, prp1)) {
+        is_cmb =3D true;
+
         qemu_iovec_init(iov, num_prps);
-        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], =
trans_len);
+
+        /*
+         * PRPs do not cross page boundaries, so if the start address (h=
ere,
+         * prp1) is within the CMB, it cannot cross outside the controll=
er
+         * memory buffer range. This is ensured by
+         *
+         *   len =3D n->page_size - (addr % n->page_size)
+         *
+         * Thus, we can directly add to the iovec without risking an out=
 of
+         * bounds access. This also holds for the remaining qemu_iovec_a=
dd
+         * calls.
+         */
+        qemu_iovec_add(iov, nvme_addr_to_cmb(n, prp1), trans_len);
     } else {
         pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
         qemu_sglist_add(qsg, prp1, trans_len);
     }
+
     len -=3D trans_len;
     if (len) {
         if (unlikely(!prp2)) {
             trace_nvme_dev_err_invalid_prp2_missing();
+            status =3D NVME_INVALID_FIELD | NVME_DNR;
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
-            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
+            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
             while (len !=3D 0) {
                 uint64_t prp_ent =3D le64_to_cpu(prp_list[i]);
=20
                 if (i =3D=3D n->max_prp_ents - 1 && len > n->page_size) =
{
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1=
))) {
                         trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
+                        status =3D NVME_INVALID_FIELD | NVME_DNR;
+                        goto unmap;
+                    }
+
+                    if (prp_list_in_cmb !=3D nvme_addr_is_cmb(n, prp_ent=
)) {
+                        status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
                         goto unmap;
                     }
=20
                     i =3D 0;
                     nents =3D (len + n->page_size - 1) >> n->page_bits;
                     prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(u=
int64_t);
-                    nvme_addr_read(n, prp_ent, (void *)prp_list,
-                        prp_trans);
+                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_tr=
ans);
                     prp_ent =3D le64_to_cpu(prp_list[i]);
                 }
=20
                 if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) =
{
                     trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
+                    status =3D NVME_INVALID_FIELD | NVME_DNR;
+                    goto unmap;
+                }
+
+                if (is_cmb !=3D nvme_addr_is_cmb(n, prp_ent)) {
+                    status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
                     goto unmap;
                 }
=20
                 trans_len =3D MIN(len, n->page_size);
-                if (qsg->nsg){
-                    qemu_sglist_add(qsg, prp_ent, trans_len);
+                if (is_cmb) {
+                    qemu_iovec_add(iov, nvme_addr_to_cmb(n, prp_ent),
+                        trans_len);
                 } else {
-                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->c=
trl_mem.addr], trans_len);
+                    qemu_sglist_add(qsg, prp_ent, trans_len);
                 }
+
                 len -=3D trans_len;
                 i++;
             }
         } else {
+            if (is_cmb !=3D nvme_addr_is_cmb(n, prp2)) {
+                status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+                goto unmap;
+            }
+
             if (unlikely(prp2 & (n->page_size - 1))) {
                 trace_nvme_dev_err_invalid_prp2_align(prp2);
+                status =3D NVME_INVALID_FIELD | NVME_DNR;
                 goto unmap;
             }
-            if (qsg->nsg) {
+
+            if (is_cmb) {
+                qemu_iovec_add(iov, nvme_addr_to_cmb(n, prp2), len);
+            } else {
                 qemu_sglist_add(qsg, prp2, len);
-            } else {
-                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem=
.addr], trans_len);
             }
         }
     }
+
     return NVME_SUCCESS;
=20
- unmap:
-    qemu_sglist_destroy(qsg);
-    return NVME_INVALID_FIELD | NVME_DNR;
-}
-
-static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
-                                   uint64_t prp1, uint64_t prp2)
-{
-    QEMUSGList qsg;
-    QEMUIOVector iov;
-    uint16_t status =3D NVME_SUCCESS;
-
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-    if (qsg.nsg > 0) {
-        if (dma_buf_write(ptr, len, &qsg)) {
-            status =3D NVME_INVALID_FIELD | NVME_DNR;
-        }
-        qemu_sglist_destroy(&qsg);
+unmap:
+    if (is_cmb) {
+        qemu_iovec_destroy(iov);
     } else {
-        if (qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len) {
-            status =3D NVME_INVALID_FIELD | NVME_DNR;
-        }
-        qemu_iovec_destroy(&iov);
+        qemu_sglist_destroy(qsg);
     }
+
     return status;
 }
=20
-static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
-    uint64_t prp1, uint64_t prp2)
+static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+    uint64_t prp1, uint64_t prp2, DMADirection dir, NvmeRequest *req)
 {
     QEMUSGList qsg;
     QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
+    size_t bytes;
=20
-    trace_nvme_dev_dma_read(prp1, prp2);
-
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status =3D nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
+    if (status) {
+        return status;
     }
+
     if (qsg.nsg > 0) {
-        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+        uint64_t residual;
+
+        if (dir =3D=3D DMA_DIRECTION_TO_DEVICE) {
+            residual =3D dma_buf_write(ptr, len, &qsg);
+        } else {
+            residual =3D dma_buf_read(ptr, len, &qsg);
+        }
+
+        if (unlikely(residual)) {
             trace_nvme_dev_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
+
         qemu_sglist_destroy(&qsg);
+
+        return status;
+    }
+
+    if (dir =3D=3D DMA_DIRECTION_TO_DEVICE) {
+        bytes =3D qemu_iovec_to_buf(&iov, 0, ptr, len);
     } else {
-        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len)) {
-            trace_nvme_dev_err_invalid_dma();
-            status =3D NVME_INVALID_FIELD | NVME_DNR;
-        }
-        qemu_iovec_destroy(&iov);
+        bytes =3D qemu_iovec_from_buf(&iov, 0, ptr, len);
     }
+
+    if (unlikely(bytes !=3D len)) {
+        trace_nvme_dev_err_invalid_dma();
+        status =3D NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    qemu_iovec_destroy(&iov);
+
     return status;
 }
=20
@@ -420,16 +474,20 @@ static void nvme_rw_cb(void *opaque, int ret)
         block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
         req->status =3D NVME_INTERNAL_DEV_ERROR;
     }
-    if (req->has_sg) {
+
+    if (req->qsg.nalloc) {
         qemu_sglist_destroy(&req->qsg);
     }
+    if (req->iov.nalloc) {
+        qemu_iovec_destroy(&req->iov);
+    }
+
     nvme_enqueue_req_completion(cq, req);
 }
=20
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
-    req->has_sg =3D false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
     req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
@@ -453,7 +511,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNam=
espace *ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    req->has_sg =3D false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
     req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
@@ -485,21 +542,24 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace =
*ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
+    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req=
)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
     if (req->qsg.nsg > 0) {
-        req->has_sg =3D true;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qs=
g.size,
+            acct);
+
         req->aiocb =3D is_write ?
             dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECT=
OR_SIZE,
                           nvme_rw_cb, req) :
             dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTO=
R_SIZE,
                          nvme_rw_cb, req);
     } else {
-        req->has_sg =3D false;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->io=
v.size,
+            acct);
+
         req->aiocb =3D is_write ?
             blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme=
_rw_cb,
                             req) :
@@ -596,7 +656,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     sq->size =3D size;
     sq->cqid =3D cqid;
     sq->head =3D sq->tail =3D 0;
-    sq->io_req =3D g_new(NvmeRequest, sq->size);
+    sq->io_req =3D g_new0(NvmeRequest, sq->size);
=20
     QTAILQ_INIT(&sq->req_list);
     QTAILQ_INIT(&sq->out_req_list);
@@ -704,8 +764,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
-        prp2);
+    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
+        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
@@ -724,8 +784,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint32_t buf_len,
=20
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
-        prp2);
+    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
+        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
@@ -869,18 +929,20 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
+    NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
     trace_nvme_dev_identify_ctrl();
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctr=
l),
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
+        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
+    NvmeRequest *req)
 {
     NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(c->nsid);
@@ -896,11 +958,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeI=
dentify *c)
=20
     ns =3D &n->namespaces[nsid - 1];
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns)=
,
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
+        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
+    NvmeRequest *req)
 {
     static const int data_len =3D 4 * KiB;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -922,12 +985,14 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, =
NvmeIdentify *c)
             break;
         }
     }
-    ret =3D nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
+    ret =3D nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
+        DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
,
+    NvmeRequest *req)
 {
     static const int len =3D 4096;
=20
@@ -963,24 +1028,25 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCt=
rl *n, NvmeCmd *c)
     list->nidl =3D 0x10;
     *(uint32_t *) &list->nid[12] =3D cpu_to_be32(nsid);
=20
-    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
+    ret =3D nvme_dma_prp(n, (uint8_t *) list, len, prp1, prp2,
+        DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *re=
q)
 {
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
=20
     switch (le32_to_cpu(c->cns)) {
     case 0x00:
-        return nvme_identify_ns(n, c);
+        return nvme_identify_ns(n, c, req);
     case 0x01:
-        return nvme_identify_ctrl(n, c);
+        return nvme_identify_ctrl(n, c, req);
     case 0x02:
-        return nvme_identify_ns_list(n, c);
+        return nvme_identify_ns_list(n, c, req);
     case 0x03:
-        return nvme_identify_ns_descr_list(n, cmd);
+        return nvme_identify_ns_descr_list(n, c, req);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1039,15 +1105,16 @@ static inline uint64_t nvme_get_timestamp(const N=
vmeCtrl *n)
     return cpu_to_le64(ts.all);
 }
=20
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
-                                 sizeof(timestamp), prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp),
+        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
@@ -1099,7 +1166,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd);
+        return nvme_get_feature_timestamp(n, cmd, req);
     case NVME_INTERRUPT_COALESCING:
         result =3D cpu_to_le32(n->features.int_coalescing);
         break;
@@ -1125,15 +1192,16 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvm=
eCmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeRequest *req)
 {
     uint16_t ret;
     uint64_t timestamp;
     uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
-    ret =3D nvme_dma_write_prp(n, (uint8_t *)&timestamp,
-                                sizeof(timestamp), prp1, prp2);
+    ret =3D nvme_dma_prp(n, (uint8_t *) &timestamp, sizeof(timestamp),
+        prp1, prp2, DMA_DIRECTION_TO_DEVICE, req);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
     }
@@ -1194,7 +1262,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
             ((n->params.num_queues - 2) << 16));
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd);
+        return nvme_set_feature_timestamp(n, cmd, req);
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
@@ -1246,7 +1314,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
     case NVME_ADM_CMD_CREATE_CQ:
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
-        return nvme_identify(n, cmd);
+        return nvme_identify(n, cmd, req);
     case NVME_ADM_CMD_ABORT:
         return nvme_abort(n, cmd, req);
     case NVME_ADM_CMD_SET_FEATURES:
@@ -1282,6 +1350,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         memset(&req->cqe, 0, sizeof(req->cqe));
         req->cqe.cid =3D cmd.cid;
+        memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
=20
         status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
             nvme_admin_cmd(n, &cmd, req);
@@ -1804,7 +1873,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *p=
ci_dev)
=20
     NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 7ced5fd485a9..d27baa9d5391 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -27,11 +27,11 @@ typedef struct NvmeRequest {
     struct NvmeSQueue       *sq;
     BlockAIOCB              *aiocb;
     uint16_t                status;
-    bool                    has_sg;
     NvmeCqe                 cqe;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
     QEMUIOVector            iov;
+    NvmeCmd                 cmd;
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 9e5a4548bde0..77aa0da99ee0 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -33,6 +33,7 @@ nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ v=
ector %u"
 nvme_dev_irq_pin(void) "pulsing IRQ pin"
 nvme_dev_irq_masked(void) "IRQ is masked"
 nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PR=
Ix64" prp2=3D0x%"PRIx64""
+nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t=
 len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"=
PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64=
" num_prps %d"
 nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, u=
int64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
 nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t=
 qsize, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sq=
id=3D%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
 nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16=
_t size, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"P=
RIx64", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D=
%"PRIu16", ien=3D%d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 31eb9397d8c6..c1de92179596 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -427,6 +427,7 @@ enum NvmeStatusCodes {
     NVME_CMD_ABORT_MISSING_FUSE =3D 0x000a,
     NVME_INVALID_NSID           =3D 0x000b,
     NVME_CMD_SEQ_ERROR          =3D 0x000c,
+    NVME_INVALID_USE_OF_CMB     =3D 0x0012,
     NVME_LBA_RANGE              =3D 0x0080,
     NVME_CAP_EXCEEDED           =3D 0x0081,
     NVME_NS_NOT_READY           =3D 0x0082,
--=20
2.25.0


