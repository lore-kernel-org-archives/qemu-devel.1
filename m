Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E7C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EEE20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EEE20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt1I-0002L0-8t
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkw-0000DC-VT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkq-0002Y1-R8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:14 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkl-0007i3-TT; Mon, 16 Mar 2020 10:30:04 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 95F6FBF538;
 Mon, 16 Mar 2020 14:29:42 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 14/42] nvme: add missing mandatory features
Date: Mon, 16 Mar 2020 07:29:00 -0700
Message-Id: <20200316142928.153431-15-its@irrelevant.dk>
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

Add support for returning a resonable response to Get/Set Features of
mandatory features.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 60 ++++++++++++++++++++++++++++++++++++++++++-
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  6 ++++-
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ff8975cd6667..eb9c722df968 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1025,7 +1025,15 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvme=
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
@@ -1046,9 +1054,12 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
             break;
         }
=20
+        break;
+    case NVME_ERROR_RECOVERY:
+        result =3D cpu_to_le32(n->features.err_rec);
         break;
     case NVME_VOLATILE_WRITE_CACHE:
-        result =3D blk_enable_write_cache(n->conf.blk);
+        result =3D cpu_to_le32(blk_enable_write_cache(n->conf.blk));
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
@@ -1058,6 +1069,19 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
+    case NVME_INTERRUPT_COALESCING:
+        result =3D cpu_to_le32(n->features.int_coalescing);
+        break;
+    case NVME_INTERRUPT_VECTOR_CONF:
+        if ((dw11 & 0xffff) > n->params.max_ioqpairs + 1) {
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
@@ -1093,6 +1117,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
+    trace_nvme_dev_setfeat(nvme_cid(req), dw10, dw11);
+
     switch (dw10) {
     case NVME_TEMPERATURE_THRESHOLD:
         if (NVME_TEMP_TMPSEL(dw11)) {
@@ -1120,6 +1146,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
=20
         break;
     case NVME_VOLATILE_WRITE_CACHE:
+        if (blk_enable_write_cache(n->conf.blk)) {
+            blk_flush(n->conf.blk);
+        }
+
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
@@ -1135,6 +1165,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
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
@@ -1716,6 +1753,25 @@ static void nvme_init_state(NvmeCtrl *n)
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
     n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+
+    /*
+     * There is no limit on the number of commands that the controller m=
ay
+     * launch at one time from a particular Submission Queue.
+     */
+    n->features.arbitration =3D NVME_ARB_AB_NOLIMIT;
+
+    n->features.int_vector_config =3D g_malloc0_n(n->params.max_ioqpairs=
 + 1,
+        sizeof(*n->features.int_vector_config));
+
+    for (int i =3D 0; i < n->params.max_ioqpairs + 1; i++) {
+        n->features.int_vector_config[i] =3D i;
+
+        /* interrupt coalescing is not supported for the admin queue */
+        if (i =3D=3D 0) {
+            n->features.int_vector_config[i] |=3D NVME_INTVC_NOCOALESCIN=
G;
+        }
+    }
+
     n->aer_reqs =3D g_new0(NvmeRequest *, n->params.aerl + 1);
 }
=20
@@ -1804,6 +1860,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
+
     id->psd[0].mp =3D cpu_to_le16(0x9c4);
     id->psd[0].enlat =3D cpu_to_le32(0x10);
     id->psd[0].exlat =3D cpu_to_le32(0x4);
@@ -1879,6 +1936,7 @@ static void nvme_exit(PCIDevice *pci_dev)
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
index f2a8b07c0f2f..ecc02fbe8bb8 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -490,7 +490,8 @@ enum NvmeStatusCodes {
     NVME_FW_REQ_RESET           =3D 0x010b,
     NVME_INVALID_QUEUE_DEL      =3D 0x010c,
     NVME_FID_NOT_SAVEABLE       =3D 0x010d,
-    NVME_FID_NOT_NSID_SPEC      =3D 0x010f,
+    NVME_FEAT_NOT_CHANGABLE     =3D 0x010e,
+    NVME_FEAT_NOT_NS_SPEC       =3D 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  =3D 0x0110,
     NVME_CONFLICTING_ATTRS      =3D 0x0180,
     NVME_INVALID_PROT_INFO      =3D 0x0181,
@@ -706,6 +707,7 @@ typedef struct NvmeFeatureVal {
 } NvmeFeatureVal;
=20
 #define NVME_ARB_AB(arb)    (arb & 0x7)
+#define NVME_ARB_AB_NOLIMIT 0x7
 #define NVME_ARB_LPW(arb)   ((arb >> 8) & 0xff)
 #define NVME_ARB_MPW(arb)   ((arb >> 16) & 0xff)
 #define NVME_ARB_HPW(arb)   ((arb >> 24) & 0xff)
@@ -713,6 +715,8 @@ typedef struct NvmeFeatureVal {
 #define NVME_INTC_THR(intc)     (intc & 0xff)
 #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
=20
+#define NVME_INTVC_NOCOALESCING (0x1 << 16)
+
 #define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
 #define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
 #define NVME_TEMP_TMPTH(temp)  ((temp >>  0) & 0xffff)
--=20
2.25.1


