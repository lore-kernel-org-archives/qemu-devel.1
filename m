Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAFCC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835B121655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835B121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifpAJ-0001IQ-7Q
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 12:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifp82-0007Yh-8l
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 12:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifp80-0005kW-Tj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 12:53:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41204
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ifp80-0005jX-Ou; Fri, 13 Dec 2019 12:53:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDHqgGi062534; Fri, 13 Dec 2019 12:53:01 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wurcs41v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 12:53:01 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBDHr0aa063901;
 Fri, 13 Dec 2019 12:53:00 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wurcs41u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 12:53:00 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBDHj5lY007945;
 Fri, 13 Dec 2019 17:52:59 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 2wr3q7q0gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 17:52:59 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDHqwWM12386690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 17:52:58 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 475CCC605D;
 Fri, 13 Dec 2019 17:52:58 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEA65C6055;
 Fri, 13 Dec 2019 17:52:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 17:52:57 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v6 2/4] tpm_spapr: Support suspend and resume
Date: Fri, 13 Dec 2019 12:52:13 -0500
Message-Id: <20191213175215.1234660-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191213175215.1234660-1-stefanb@linux.vnet.ibm.com>
References: <20191213175215.1234660-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=1 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the tpm_spapr frontend with VM suspend and resume support.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_spapr.c  | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/tpm/trace-events |  2 ++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index a5f19b9ca3..3add2b3fc4 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -76,6 +76,9 @@ typedef struct {
 
     unsigned char buffer[TPM_SPAPR_BUFFER_MAX];
 
+    uint32_t numbytes; /* number of bytes in suspend_buffer */
+    unsigned char *suspend_buffer;
+
     TPMBackendCmd cmd;
 
     TPMBackend *be_driver;
@@ -263,6 +266,13 @@ static void tpm_spapr_request_completed(TPMIf *ti, int ret)
 
     /* a max. of be_buffer_size bytes can be transported */
     len = MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
+
+    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        /* defer delivery of response until .post_load */
+        s->numbytes = len;
+        return;
+    }
+
     rc = spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
                              s->buffer, len);
 
@@ -315,12 +325,14 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
     SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
 
     s->state = SPAPR_VTPM_STATE_NONE;
+    s->numbytes = 0;
 
     s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
     tpm_spapr_update_deviceclass(dev);
 
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_SPAPR_BUFFER_MAX);
+    s->suspend_buffer = g_realloc(s->suspend_buffer, s->be_buffer_size);
 
     tpm_backend_reset(s->be_driver);
     tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
@@ -337,9 +349,62 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
     return tpm_backend_get_tpm_version(s->be_driver);
 }
 
+/* persistent state handling */
+
+static int tpm_spapr_pre_save(void *opaque)
+{
+    SpaprTpmState *s = opaque;
+
+    tpm_backend_finish_sync(s->be_driver);
+
+    if (s->numbytes) {
+        memcpy(s->suspend_buffer, s->buffer, s->numbytes);
+    }
+
+    trace_tpm_spapr_pre_save(s->numbytes);
+    /*
+     * we cannot deliver the results to the VM since DMA would touch VM memory
+     */
+
+    return 0;
+}
+
+static int tpm_spapr_post_load(void *opaque, int version_id)
+{
+    SpaprTpmState *s = opaque;
+
+    if (s->numbytes) {
+        trace_tpm_spapr_post_load();
+
+        memcpy(s->buffer, s->suspend_buffer,
+               MIN(s->numbytes, s->be_buffer_size));
+        /* deliver the results to the VM via DMA */
+        tpm_spapr_request_completed(TPM_IF(s), 0);
+        s->numbytes = 0;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_spapr_vtpm = {
     .name = "tpm-spapr",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .pre_save = tpm_spapr_pre_save,
+    .post_load = tpm_spapr_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_SPAPR_VIO(vdev, SpaprTpmState),
+
+        VMSTATE_UINT8(state, SpaprTpmState),
+        VMSTATE_UINT32(numbytes, SpaprTpmState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(suspend_buffer,
+                                     SpaprTpmState, 0, NULL,
+                                     numbytes),
+        /* remember DMA address */
+        VMSTATE_UINT32(crq.data, SpaprTpmState),
+        VMSTATE_END_OF_LIST(),
+    }
 };
 
 static Property tpm_spapr_properties[] = {
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 6278a39618..401d9a424d 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "response: version %u"
 tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspend"
 tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x%02x"
 tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x%02x 0x%02x ..."
+tpm_spapr_pre_save(uint32_t v) "Number of TPM response bytes to deliver after resume: %u"
+tpm_spapr_post_load(void) "Delivering TPM response after resume"
-- 
2.21.0


