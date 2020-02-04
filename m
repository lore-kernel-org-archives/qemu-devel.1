Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F01C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5B1218AC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G202EMMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5B1218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuyq-00008e-OE
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusc-0003vg-KD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusa-0007Bi-VR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:26 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusa-00079T-Mc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:24 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095223euoutp020383608e450e88fbec25088a031368d1~wKkS55SCh2946329463euoutp02J
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095223euoutp020383608e450e88fbec25088a031368d1~wKkS55SCh2946329463euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809943;
 bh=FMUMksoVuW42zOJxa9ra9OheT1DFBhUe56tSEsyA1t0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=G202EMMb0sIN2Y8Dm0sA3SRe6CBdMInFP5m3AL3wD9uX5qAQu1hBcapGPdNV1Ouv4
 CsMK847jb1CbOKdSKUxLwSsAy3Tgm+I0ddPH7+v334AeOHKsQmvyVPKE4L/gcAxw8g
 D0HQ8NoGP/WN6/Ag1gC7kjc8tDhDz9C0TO7vL/WQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095223eucas1p1ea924c3af0e3e0403a37c17ca90f1d05~wKkSrXpPS0922609226eucas1p1K;
 Tue,  4 Feb 2020 09:52:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id EC.EB.60679.7DE393E5; Tue,  4
 Feb 2020 09:52:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095223eucas1p281b4ef7c8f4170d8a42da3b4aea9e166~wKkSUYXKn0111101111eucas1p2c;
 Tue,  4 Feb 2020 09:52:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095223eusmtrp268bc0490913d4dd6b027ec9c4c401c6e~wKkSOOeIJ0487104871eusmtrp2e;
 Tue,  4 Feb 2020 09:52:23 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-2e-5e393ed7121c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id A4.CC.08375.7DE393E5; Tue,  4
 Feb 2020 09:52:23 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095222eusmtip2ad727820cb824afd9efc82116239e2c4~wKkSFJ3eH2738327383eusmtip2Q;
 Tue,  4 Feb 2020 09:52:22 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:22 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:22 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 12/26] nvme: add missing mandatory features
Date: Tue, 4 Feb 2020 10:51:54 +0100
Message-ID: <20200204095208.269131-13-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87rX7SzjDCbelLPY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGaevT2EraDaqeLF1P3MDY796FyMnh4SAiUTz+V7GLkYuDiGBFYwS
 q14sYodwvjBKtD28wwRSJSTwmVFi2ZRsmI6VDVOgOpYzSiz8dZEJwgEqOvb5EQuEc5pR4tu6
 O4wQ7TsZJe7s5Aex2QQ0Jbb/+c8CYosISEu0X53ECtLALPCbUWJu40Q2kISwgJ3E2m8tYLtZ
 BFQkNvW8BhvEK2At8ef8Y2aIO+QlZjeeBqvnBIrvX3WCCaJGUOLkzCdgC5iBapq3zmaGsCUk
 Dr54wQyyTEJgG7vE/u5NUINcJLave8gGYQtLvDq+hR3ClpH4v3M+E0RDN6NE34evUN0zGCWm
 L/sO1MEB5FhL9J3JgTAdJQ5ddIMw+SRuvBWE2MsnMWnbdGaIMK9ER5sQxHQ1iR1NWxknMCrP
 QnL1LCRXz0Jy9QJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiB6eb0v+NfdjDu+pN0
 iFGAg1GJh/fkWYs4IdbEsuLK3EOMEhzMSiK85/Ut44R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
 Gi96GSskkJ5YkpqdmlqQWgSTZeLglGpgZN60ftEGwUOryqeXfZ9jH/7jxPlaxajdwReuH3Fi
 stp3Z4MhU4ytFou12/JYR14VZ8nC6VWWJ6fejNyfGdDdW3vs3amSj3ohnK38v15+MdW5HaXY
 uvFRfn/kQZ6Nf3fP2/z2fWrm3lvuNnuYV8xp2VVxbp60TXmL71THB5s21znP/JryOLkjS4ml
 OCPRUIu5qDgRACmW1rUzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7rX7SzjDO69Z7HY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gaev
 T2EraDaqeLF1P3MDY796FyMnh4SAicTKhimMXYxcHEICSxkllmyZzgaRkJH4dOUjO4QtLPHn
 WhdYXEjgI6PEvU8yEA2nGSWOPbrKBuHsZJRo/3cbrIpNQFNi+5//LCC2iIC0RPvVSawgNrPA
 b0aJP32BILawgJ3E2m8tTCA2i4CKxKae14wgNq+AtcSf84+ZITbLS8xuPA02kxMovn/VCaB6
 DqBlVhKtR7khygUlTs58wgIxXl6ieetsZghbQuLgixfMExiFZyEpm4WkbBaSsgWMzKsYRVJL
 i3PTc4sN9YoTc4tL89L1kvNzNzECY27bsZ+bdzBe2hh8iFGAg1GJh/eCnUWcEGtiWXFl7iFG
 CQ5mJRHe8/qWcUK8KYmVValF+fFFpTmpxYcYTYF+m8gsJZqcD0wHeSXxhqaG5haWhubG5sZm
 FkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGGNP5TbfPWi61WNurMV+8crLR/mtFqT+PfbL
 YIXAb6bu3r08aUZXZuQqPWzuqNjLwnxz7okO7uM5T5884l3Jv8fTMOjgZa8Sty/pb2+EuAg4
 ng1qL1mnqx72YTKP+edz+4U2auzujTT4fK4x83pHvFejSPmL7e/nq6vUvuVfOaW0pEPpxInV
 iUosxRmJhlrMRcWJALac3gTPAgAA
X-CMS-MailID: 20200204095223eucas1p281b4ef7c8f4170d8a42da3b4aea9e166
X-Msg-Generator: CA
X-RootMTR: 20200204095223eucas1p281b4ef7c8f4170d8a42da3b4aea9e166
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095223eucas1p281b4ef7c8f4170d8a42da3b4aea9e166
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095223eucas1p281b4ef7c8f4170d8a42da3b4aea9e166@eucas1p2.samsung.com>
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

Add support for returning a resonable response to Get/Set Features of
mandatory features.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 57 ++++++++++++++++++++++++++++++++++++++++---
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  3 ++-
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a186d95df020..3267ee2de47a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1008,7 +1008,15 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t result;
=20
+    trace_nvme_dev_getfeat(nvme_cid(req), dw10);
+
     switch (dw10) {
+    case NVME_ARBITRATION:
+        result =3D cpu_to_le32(n->features.arbitration);
+        break;
+    case NVME_POWER_MANAGEMENT:
+        result =3D cpu_to_le32(n->features.power_mgmt);
+        break;
     case NVME_TEMPERATURE_THRESHOLD:
         result =3D 0;
=20
@@ -1029,6 +1037,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
             break;
         }
=20
+        break;
+    case NVME_ERROR_RECOVERY:
+        result =3D cpu_to_le32(n->features.err_rec);
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
@@ -1041,6 +1052,19 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
+    case NVME_INTERRUPT_COALESCING:
+        result =3D cpu_to_le32(n->features.int_coalescing);
+        break;
+    case NVME_INTERRUPT_VECTOR_CONF:
+        if ((dw11 & 0xffff) > n->params.num_queues) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        result =3D cpu_to_le32(n->features.int_vector_config[dw11 & 0xff=
ff]);
+        break;
+    case NVME_WRITE_ATOMICITY:
+        result =3D cpu_to_le32(n->features.write_atomicity);
+        break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         result =3D cpu_to_le32(n->features.async_config);
         break;
@@ -1076,6 +1100,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
+    trace_nvme_dev_setfeat(nvme_cid(req), dw10, dw11);
+
     switch (dw10) {
     case NVME_TEMPERATURE_THRESHOLD:
         if (NVME_TEMP_TMPSEL(dw11)) {
@@ -1116,6 +1142,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
+    case NVME_ARBITRATION:
+    case NVME_POWER_MANAGEMENT:
+    case NVME_ERROR_RECOVERY:
+    case NVME_INTERRUPT_COALESCING:
+    case NVME_INTERRUPT_VECTOR_CONF:
+    case NVME_WRITE_ATOMICITY:
+        return NVME_FEAT_NOT_CHANGABLE | NVME_DNR;
     default:
         trace_nvme_dev_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1689,6 +1722,21 @@ static void nvme_init_state(NvmeCtrl *n)
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
     n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+
+    /*
+     * There is no limit on the number of commands that the controller m=
ay
+     * launch at one time from a particular Submission Queue.
+     */
+    n->features.arbitration =3D 0x7;
+
+    n->features.int_vector_config =3D g_malloc0_n(n->params.num_queues,
+        sizeof(*n->features.int_vector_config));
+
+    /* disable coalescing (not supported) */
+    for (int i =3D 0; i < n->params.num_queues; i++) {
+        n->features.int_vector_config[i] =3D i | (1 << 16);
+    }
+
     n->aer_reqs =3D g_new0(NvmeRequest *, n->params.aerl + 1);
 }
=20
@@ -1782,15 +1830,17 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
=20
+
+    if (blk_enable_write_cache(n->conf.blk)) {
+        id->vwc =3D 1;
+    }
+
     strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
     pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
=20
     id->psd[0].mp =3D cpu_to_le16(0x9c4);
     id->psd[0].enlat =3D cpu_to_le32(0x10);
     id->psd[0].exlat =3D cpu_to_le32(0x4);
-    if (blk_enable_write_cache(n->conf.blk)) {
-        id->vwc =3D 1;
-    }
=20
     n->bar.cap =3D 0;
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
@@ -1861,6 +1911,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
+    g_free(n->features.int_vector_config);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 3952c36774cf..4cf39961989d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -41,6 +41,8 @@ nvme_dev_del_cq(uint16_t cqid) "deleted completion queu=
e, sqid=3D%"PRIu16""
 nvme_dev_identify_ctrl(void) "identify controller"
 nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
 nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%=
"PRIu16""
+nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx=
32""
+nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16=
" fid 0x%"PRIx32" val 0x%"PRIx32""
 nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write=
 cache, result=3D%s"
 nvme_dev_getfeat_numq(int result) "get feature number of queues, result=3D=
%d"
 nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a24be047a311..09419ed499d0 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -445,7 +445,8 @@ enum NvmeStatusCodes {
     NVME_FW_REQ_RESET           =3D 0x010b,
     NVME_INVALID_QUEUE_DEL      =3D 0x010c,
     NVME_FID_NOT_SAVEABLE       =3D 0x010d,
-    NVME_FID_NOT_NSID_SPEC      =3D 0x010f,
+    NVME_FEAT_NOT_CHANGABLE     =3D 0x010e,
+    NVME_FEAT_NOT_NSID_SPEC     =3D 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  =3D 0x0110,
     NVME_CONFLICTING_ATTRS      =3D 0x0180,
     NVME_INVALID_PROT_INFO      =3D 0x0181,
--=20
2.25.0


