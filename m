Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DAC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DA2218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DA2218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIh9-0006P9-DK
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZy-0005ZM-E2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZw-00060I-Sz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:22 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZr-0005he-MG; Fri, 05 Jul 2019 03:24:16 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 99C8DC063B;
 Fri,  5 Jul 2019 07:23:53 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:28 +0200
Message-Id: <20190705072333.17171-12-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 11/16] nvme: add missing mandatory Features
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

Add support for returning a resonable response to Get/Set Features of
mandatory features.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 49 ++++++++++++++++++++++++++++++++++++++++---
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  3 ++-
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 93f5dff197e0..8259dd7c1d6c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -860,13 +860,24 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd)
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t result;
=20
+    trace_nvme_getfeat(dw10);
+
     switch (dw10) {
+    case NVME_ARBITRATION:
+        result =3D cpu_to_le32(n->features.arbitration);
+        break;
+    case NVME_POWER_MANAGEMENT:
+        result =3D cpu_to_le32(n->features.power_mgmt);
+        break;
     case NVME_TEMPERATURE_THRESHOLD:
         result =3D cpu_to_le32(n->features.temp_thresh);
         break;
     case NVME_ERROR_RECOVERY:
+        result =3D cpu_to_le32(n->features.err_rec);
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
         trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
@@ -878,6 +889,19 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
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
@@ -913,6 +937,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
+    trace_nvme_setfeat(dw10, dw11);
+
     switch (dw10) {
     case NVME_TEMPERATURE_THRESHOLD:
         n->features.temp_thresh =3D dw11;
@@ -937,6 +963,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
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
         trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1693,6 +1726,14 @@ static void nvme_init_state(NvmeCtrl *n)
     n->aer_reqs =3D g_new0(NvmeRequest *, NVME_AERL + 1);
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh =3D 0x14d;
+    n->features.int_vector_config =3D g_malloc0_n(n->params.num_queues,
+        sizeof(*n->features.int_vector_config));
+
+    /* disable coalescing (not supported) */
+    for (int i =3D 0; i < n->params.num_queues; i++) {
+        n->features.int_vector_config[i] =3D i | (1 << 16);
+    }
+
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1769,6 +1810,10 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
=20
+    if (blk_enable_write_cache(n->conf.blk)) {
+        id->vwc =3D 1;
+    }
+
     strcpy((char *) id->subnqn, "nqn.2014-08.org.nvmexpress:uuid:");
     qemu_uuid_unparse(&qemu_uuid,
         (char *) id->subnqn + strlen((char *) id->subnqn));
@@ -1776,9 +1821,6 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->psd[0].mp =3D cpu_to_le16(0x9c4);
     id->psd[0].enlat =3D cpu_to_le32(0x10);
     id->psd[0].exlat =3D cpu_to_le32(0x4);
-    if (blk_enable_write_cache(n->conf.blk)) {
-        id->vwc =3D 1;
-    }
=20
     n->bar.cap =3D 0;
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
@@ -1876,6 +1918,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->sq);
     g_free(n->elpes);
     g_free(n->aer_reqs);
+    g_free(n->features.int_vector_config);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index ed666bbc94f2..17485bb0375b 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -41,6 +41,8 @@ nvme_del_cq(uint16_t cqid) "deleted completion queue, s=
qid=3D%"PRIu16""
 nvme_identify_ctrl(void) "identify controller"
 nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
 nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRI=
u16""
+nvme_getfeat(uint32_t fid) "fid 0x%"PRIx32""
+nvme_setfeat(uint32_t fid, uint32_t val) "fid 0x%"PRIx32" val 0x%"PRIx32=
""
 nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
 nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d=
"
 nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 5a10b8b67468..d24b1f28e0fc 100644
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
2.20.1


