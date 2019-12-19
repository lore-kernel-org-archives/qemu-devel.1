Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86E4206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="npkyC3Xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86E4206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwVm-0006NH-Dj
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYq-0001a2-HZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYm-0006Qo-DN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYl-0006LV-9q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130941euoutp02f6d9cbd734bc851c4e62e1c9bce384cf~hx8JKCOL00697606976euoutp02J
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130941euoutp02f6d9cbd734bc851c4e62e1c9bce384cf~hx8JKCOL00697606976euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760981;
 bh=5UQOfKX8qZ5W4+K3MBe9SIoakU25B3AxfwP8CBm10wM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=npkyC3XnQLpKFOOH6mD2BcBE/FN1dsCBc9D6fkZm99t0EkBw36G5B24fj8j3d7Nr8
 g9/Xnhg3C/unWYh7DMkaMef9LZh28gsPoSMa9Y0HDj5AHJzKd5fiDcLC1u81VPSZAy
 R1ruc99icNPK/4YM7qpHr7wxPF11dG5cLTLNXMNM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191219130941eucas1p1cc504b58f0206eabcb490351d127643a~hx8JA_uED1798017980eucas1p1y;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 76.5F.60698.5967BFD5; Thu, 19
 Dec 2019 13:09:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130941eucas1p13cd0170cd47303f6be82e254d536892e~hx8IuFXuv1459314593eucas1p1G;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130941eusmtrp2e7ffd2791d9ea68df09526cb1adf79ef~hx8ItgcS13097130971eusmtrp2M;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-60-5dfb7695ab0b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F4.4D.08375.5967BFD5; Thu, 19
 Dec 2019 13:09:41 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130941eusmtip2d418e98dd341004c696ac0ded57dbb96~hx8ImGCpO2556225562eusmtip2a;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:40 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:40 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 10/24] nvme: add support for the get log page command
Date: Thu, 19 Dec 2019 14:09:07 +0100
Message-ID: <20191219130921.309264-11-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7pTy37HGkx/q26xub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4Mr4sGISe0GLe8WUA3tYGhjXWXQxcnJICJhItBzvYupi5OIQEljBKLFg+mZGCOcLo8TW
 pbOhMp8ZJU7suckK0/K94Qw7RGI5o8TNt2cQqm71nmGBcM4AOTO2Qzm7GCWufv3LBtLPJqAp
 sf3PfxYQW0RAWqL96iRWkCJmgeuMEod+X2QHSQgLeEjcP3MbzGYRUJXonbkdrJlXwFri0ZGV
 TBCHyEts/fYJ7ChOoPiW3tuMEDWCEidnPgFbwAxU07x1NjOELSFx8MULZpBlEgLL2CUWHtjE
 DjHIReL2jjdQ3wlLvDq+BSouI/F/53wmiIZuRom+D1+humcwSkxf9h3oJA4gx1qi70wOhOko
 8XWKFoTJJ3HjrSDEXj6JSdumM0OEeSU62oQgpqtJ7GjayjiBUXkWkqtnIbl6FpKrFzAyr2IU
 Ty0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhML6f/Hf+6g3Hfn6RDjAIcjEo8vA5pv2OFWBPL
 iitzDzFKcDArifDe7vgZK8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILU
 IpgsEwenVAPjXKEJpef7N16K7lFc+bW+RHvH7iMv9nReWi0VwX3z+Zf1h9VuyQgd2Kfl+dVD
 u8YstzHSVMeOl/WLirBJ1XH9BweuhH46+X6H6QHvyMWP/617deWzQ4z41iOHeEL4VyY/WfrM
 aPOGa53631oYPz+ReHjUcVaIqCCn/JznmRyVT7WCBH/UPPuqpMRSnJFoqMVcVJwIALMaRRgr
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7pTy37HGnR9F7bY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBE6dkU5ZeWpCpk
 5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV8WDGJvaDFvWLKgT0s
 DYzrLLoYOTkkBEwkvjecYQexhQSWMkocP5EAEZeR+HTlIzuELSzx51oXWxcjF1DNR0aJsxOe
 QDlnGCWmth1igejexSjx718SiM0moCmx/c9/sLiIgLRE+9VJrCANzALXGSUO/b4INlZYwEPi
 /pnbYDaLgKpE78ztbCA2r4C1xKMjK5kgVstLbP32iRXE5gSKb+m9zQixzEri8c+PLBD1ghIn
 Zz4Bs5mB6pu3zmaGsCUkDr54wTyBUXgWkrJZSMpmISlbwMi8ilEktbQ4Nz232FCvODG3uDQv
 XS85P3cTIzDCth37uXkH46WNwYcYBTgYlXh4Xyb/jhViTSwrrsw9xCjBwawkwnu742esEG9K
 YmVValF+fFFpTmrxIUZToOcmMkuJJucDoz+vJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
 anZqakFqEUwfEwenVAOjH/ubAz5W5qXsDmypSyNzstpFvBqzo+x/C/o8uZKfsd/Z88+7R7sf
 OMlq+lVln+ri2zTxr4vpc+ZS1ootyZaPFq8LXvit3+vFk24PA4U8rlJhDsPPR97Jcye0cV3c
 dNf1Sl7PiyNLnv3ekXzSRNErz7r8yobakAWCa9k+zJW9cPKN8zpZpzVKLMUZiYZazEXFiQDM
 fxm5xgIAAA==
X-CMS-MailID: 20191219130941eucas1p13cd0170cd47303f6be82e254d536892e
X-Msg-Generator: CA
X-RootMTR: 20191219130941eucas1p13cd0170cd47303f6be82e254d536892e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130941eucas1p13cd0170cd47303f6be82e254d536892e
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130941eucas1p13cd0170cd47303f6be82e254d536892e@eucas1p1.samsung.com>
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

Add support for the Get Log Page command and basic implementations of
the mandatory Error Information, SMART / Health Information and Firmware
Slot Information log pages.

In violation of the specification, the SMART / Health Information log
page does not persist information over the lifetime of the controller
because the device has no place to store such persistent state.

Note that the LPA field in the Identify Controller data structure
intentionally has bit 0 cleared because there is no namespace specific
information in the SMART / Health information log page.

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.10 ("Get Log Page command").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 122 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  10 ++++
 hw/block/trace-events |   2 +
 include/block/nvme.h  |   2 +-
 4 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 13d412d76c8e..38a555c047d3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -567,6 +567,123 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+
+    uint32_t trans_len;
+    time_t current_ms;
+    uint64_t units_read =3D 0, units_written =3D 0, read_commands =3D 0,
+        write_commands =3D 0;
+    NvmeSmartLog smart;
+    BlockAcctStats *s;
+
+    if (nsid && nsid !=3D 0xffffffff) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    s =3D blk_get_stats(n->conf.blk);
+
+    units_read =3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
+    units_written =3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
+    read_commands =3D s->nr_ops[BLOCK_ACCT_READ];
+    write_commands =3D s->nr_ops[BLOCK_ACCT_WRITE];
+
+    if (off > sizeof(smart)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(smart) - off, buf_len);
+
+    memset(&smart, 0x0, sizeof(smart));
+
+    smart.data_units_read[0] =3D cpu_to_le64(units_read / 1000);
+    smart.data_units_written[0] =3D cpu_to_le64(units_written / 1000);
+    smart.host_read_commands[0] =3D cpu_to_le64(read_commands);
+    smart.host_write_commands[0] =3D cpu_to_le64(write_commands);
+
+    smart.temperature[0] =3D n->temperature & 0xff;
+    smart.temperature[1] =3D (n->temperature >> 8) & 0xff;
+
+    if ((n->temperature > n->features.temp_thresh_hi) ||
+        (n->temperature < n->features.temp_thresh_low)) {
+        smart.critical_warning |=3D NVME_SMART_TEMPERATURE;
+    }
+
+    current_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    smart.power_on_hours[0] =3D cpu_to_le64(
+        (((current_ms - n->starttime_ms) / 1000) / 60) / 60);
+
+    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
+        prp2);
+}
+
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    NvmeFwSlotInfoLog fw_log;
+
+    if (off > sizeof(fw_log)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    memset(&fw_log, 0, sizeof(NvmeFwSlotInfoLog));
+
+    trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
+
+    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
+        prp2);
+}
+
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
+    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint8_t  lid =3D dw10 & 0xff;
+    uint8_t  rae =3D (dw10 >> 15) & 0x1;
+    uint32_t numdl, numdu;
+    uint64_t off, lpol, lpou;
+    size_t   len;
+
+    numdl =3D (dw10 >> 16);
+    numdu =3D (dw11 & 0xffff);
+    lpol =3D dw12;
+    lpou =3D dw13;
+
+    len =3D (((numdu << 16) | numdl) + 1) << 2;
+    off =3D (lpou << 32ULL) | lpol;
+
+    if (off & 0x3) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
+
+    switch (lid) {
+    case NVME_LOG_ERROR_INFO:
+        if (off) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        return NVME_SUCCESS;
+    case NVME_LOG_SMART_INFO:
+        return nvme_smart_info(n, cmd, len, off, req);
+    case NVME_LOG_FW_SLOT_INFO:
+        return nvme_fw_log_info(n, cmd, len, off, req);
+    default:
+        trace_nvme_dev_err_invalid_log_page(nvme_cid(req), lid);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
 static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
 {
     n->cq[cq->cqid] =3D NULL;
@@ -911,6 +1028,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
         return nvme_del_sq(n, cmd);
     case NVME_ADM_CMD_CREATE_SQ:
         return nvme_create_sq(n, cmd);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return nvme_get_log(n, cmd, req);
     case NVME_ADM_CMD_DELETE_CQ:
         return nvme_del_cq(n, cmd);
     case NVME_ADM_CMD_CREATE_CQ:
@@ -1408,6 +1527,7 @@ static void nvme_init_state(NvmeCtrl *n)
=20
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D le16_to_cpu(n->id_ctrl.wctemp);
+    n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1488,7 +1608,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
      */
     id->acl =3D 3;
     id->frmw =3D 7 << 1;
-    id->lpa =3D 1 << 0;
+    id->lpa =3D 1 << 2;
=20
     /* recommended default value (~70 C) */
     id->wctemp =3D cpu_to_le16(0x157);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1518f32557a3..89b0aafa02a2 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -109,6 +109,7 @@ typedef struct NvmeCtrl {
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
     uint16_t    temperature;
+    uint64_t    starttime_ms;
=20
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
@@ -124,4 +125,13 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, Nv=
meNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
=20
+static inline uint16_t nvme_cid(NvmeRequest *req)
+{
+    if (req) {
+        return le16_to_cpu(req->cqe.cid);
+    }
+
+    return 0xffff;
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index ade506ea2bb2..7da088479f39 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,7 @@ nvme_dev_getfeat_numq(int result) "get feature number o=
f queues, result=3D%d"
 nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
 nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"P=
RIx64""
 nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"P=
RIx64""
+nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, u=
int64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" o=
ff %"PRIu64""
 nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D=
0x%"PRIx64""
@@ -85,6 +86,7 @@ nvme_dev_err_invalid_create_cq_qflags(uint16_t qflags) =
"failed creating completi
 nvme_dev_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D=
0x%"PRIx16""
 nvme_dev_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%=
"PRIx32""
 nvme_dev_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D=
0x%"PRIx32""
+nvme_dev_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16"=
 lid 0x%"PRIx16""
 nvme_dev_err_startfail_cq(void) "nvme_start_ctrl failed because there ar=
e non-admin completion queues"
 nvme_dev_err_startfail_sq(void) "nvme_start_ctrl failed because there ar=
e non-admin submission queues"
 nvme_dev_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the=
 admin submission queue address is null"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index ff31cb32117c..9a6055adeb61 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -515,7 +515,7 @@ enum NvmeSmartWarn {
     NVME_SMART_FAILED_VOLATILE_MEDIA  =3D 1 << 4,
 };
=20
-enum LogIdentifier {
+enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     =3D 0x01,
     NVME_LOG_SMART_INFO     =3D 0x02,
     NVME_LOG_FW_SLOT_INFO   =3D 0x03,
--=20
2.24.1


