Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B56620842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B56620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSy9-0002k3-G1
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsY-0001xQ-Pr
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0002Yp-DX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsO-0001y3-DT; Tue, 01 Oct 2019 19:48:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlWwg135052; Tue, 1 Oct 2019 19:47:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccwberj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:53 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlrPW138284;
 Tue, 1 Oct 2019 19:47:53 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccwberj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:53 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlmW032693;
 Tue, 1 Oct 2019 23:47:52 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 2v9y57qb8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:52 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlp6d53674250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:51 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 878E328065;
 Tue,  1 Oct 2019 23:47:51 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C1E22805C;
 Tue,  1 Oct 2019 23:47:51 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:51 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 72/97] dma-helpers: ensure AIO callback is invoked after
 cancellation
Date: Tue,  1 Oct 2019 18:45:51 -0500
Message-Id: <20191001234616.7825-73-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

dma_aio_cancel unschedules the BH if there is one, which corresponds
to the reschedule_dma case of dma_blk_cb.  This can stall the DMA
permanently, because dma_complete will never get invoked and therefore
nobody will ever invoke the original AIO callback in dbs->common.cb.

Fix this by invoking the callback (which is ensured to happen after
a bdrv_aio_cancel_async, or done manually in the dbs->bh case), and
add assertions to check that the DMA state machine is indeed waiting
for dma_complete or reschedule_dma, but never both.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20190729213416.1972-1-pbonzini@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 539343c0a47e19d5dd64d846d64d084d9793681f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 dma-helpers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d35e..d3871dc61e 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -90,6 +90,7 @@ static void reschedule_dma(void *opaque)
 {
     DMAAIOCB *dbs = (DMAAIOCB *)opaque;
 
+    assert(!dbs->acb && dbs->bh);
     qemu_bh_delete(dbs->bh);
     dbs->bh = NULL;
     dma_blk_cb(dbs, 0);
@@ -111,15 +112,12 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
 {
     trace_dma_complete(dbs, ret, dbs->common.cb);
 
+    assert(!dbs->acb && !dbs->bh);
     dma_blk_unmap(dbs);
     if (dbs->common.cb) {
         dbs->common.cb(dbs->common.opaque, ret);
     }
     qemu_iovec_destroy(&dbs->iov);
-    if (dbs->bh) {
-        qemu_bh_delete(dbs->bh);
-        dbs->bh = NULL;
-    }
     qemu_aio_unref(dbs);
 }
 
@@ -179,14 +177,21 @@ static void dma_aio_cancel(BlockAIOCB *acb)
 
     trace_dma_aio_cancel(dbs);
 
+    assert(!(dbs->acb && dbs->bh));
     if (dbs->acb) {
+        /* This will invoke dma_blk_cb.  */
         blk_aio_cancel_async(dbs->acb);
+        return;
     }
+
     if (dbs->bh) {
         cpu_unregister_map_client(dbs->bh);
         qemu_bh_delete(dbs->bh);
         dbs->bh = NULL;
     }
+    if (dbs->common.cb) {
+        dbs->common.cb(dbs->common.opaque, -ECANCELED);
+    }
 }
 
 static AioContext *dma_get_aio_context(BlockAIOCB *acb)
-- 
2.17.1


