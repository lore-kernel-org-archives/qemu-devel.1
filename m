Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BA1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72FB2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsx4jErX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72FB2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTvz-0006aG-5l
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9k-0000XO-2u
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9g-0001Ig-Up
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YA/PmyaJ3w1Dt/TGbyfek3qVmaDq/4S8uhvGmNOuqGM=;
 b=hsx4jErXMhYQlzt2BRoNcw3G/ss/Yn8mvKE70sEifUVJPOtrn1Y4W4IaH9L/Ug2yjlyRlq
 krWoddDoYNbofXNchqPBaWtJAffWN33pGdrXJSGcPgU6DG8Q8hUrUd5DlVcp9Y4lY+p4ci
 9KLht2C5bpQ5mtbDqYGRPs83MgQHSlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-vw8oNuxRPtyW18Yff_VmuA-1; Thu, 11 Jun 2020 15:45:13 -0400
X-MC-Unique: vw8oNuxRPtyW18Yff_VmuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF07F8015CE;
 Thu, 11 Jun 2020 19:45:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58BE55D9DC;
 Thu, 11 Jun 2020 19:45:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 022/115] vmbus: add infrastructure to save/load vmbus requests
Date: Thu, 11 Jun 2020 15:43:16 -0400
Message-Id: <20200611194449.31468-23-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

This can be allow to include controller-specific data while
saving/loading in-flight scsi requests of the vmbus scsi controller.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20200424123444.3481728-7-arilou@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/vmbus.c         | 99 +++++++++++++++++++++++++++++++++++++++
 include/hw/hyperv/vmbus.h |  3 ++
 2 files changed, 102 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 2acb2185e8..f371240176 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -1272,6 +1272,105 @@ void vmbus_free_req(void *req)
     g_free(req);
 }
 
+static const VMStateDescription vmstate_sgent = {
+    .name = "vmbus/sgentry",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(base, ScatterGatherEntry),
+        VMSTATE_UINT64(len, ScatterGatherEntry),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+typedef struct VMBusChanReqSave {
+    uint16_t chan_idx;
+    uint16_t pkt_type;
+    uint32_t msglen;
+    void *msg;
+    uint64_t transaction_id;
+    bool need_comp;
+    uint32_t num;
+    ScatterGatherEntry *sgl;
+} VMBusChanReqSave;
+
+static const VMStateDescription vmstate_vmbus_chan_req = {
+    .name = "vmbus/vmbus_chan_req",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(chan_idx, VMBusChanReqSave),
+        VMSTATE_UINT16(pkt_type, VMBusChanReqSave),
+        VMSTATE_UINT32(msglen, VMBusChanReqSave),
+        VMSTATE_VBUFFER_ALLOC_UINT32(msg, VMBusChanReqSave, 0, NULL, msglen),
+        VMSTATE_UINT64(transaction_id, VMBusChanReqSave),
+        VMSTATE_BOOL(need_comp, VMBusChanReqSave),
+        VMSTATE_UINT32(num, VMBusChanReqSave),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(sgl, VMBusChanReqSave, num,
+                                             vmstate_sgent, ScatterGatherEntry),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void vmbus_save_req(QEMUFile *f, VMBusChanReq *req)
+{
+    VMBusChanReqSave req_save;
+
+    req_save.chan_idx = req->chan->subchan_idx;
+    req_save.pkt_type = req->pkt_type;
+    req_save.msglen = req->msglen;
+    req_save.msg = req->msg;
+    req_save.transaction_id = req->transaction_id;
+    req_save.need_comp = req->need_comp;
+    req_save.num = req->sgl.nsg;
+    req_save.sgl = g_memdup(req->sgl.sg,
+                            req_save.num * sizeof(ScatterGatherEntry));
+
+    vmstate_save_state(f, &vmstate_vmbus_chan_req, &req_save, NULL);
+
+    g_free(req_save.sgl);
+}
+
+void *vmbus_load_req(QEMUFile *f, VMBusDevice *dev, uint32_t size)
+{
+    VMBusChanReqSave req_save;
+    VMBusChanReq *req = NULL;
+    VMBusChannel *chan = NULL;
+    uint32_t i;
+
+    vmstate_load_state(f, &vmstate_vmbus_chan_req, &req_save, 0);
+
+    if (req_save.chan_idx >= dev->num_channels) {
+        error_report("%s: %u(chan_idx) > %u(num_channels)", __func__,
+                     req_save.chan_idx, dev->num_channels);
+        goto out;
+    }
+    chan = &dev->channels[req_save.chan_idx];
+
+    if (vmbus_channel_reserve(chan, 0, req_save.msglen)) {
+        goto out;
+    }
+
+    req = vmbus_alloc_req(chan, size, req_save.pkt_type, req_save.msglen,
+                          req_save.transaction_id, req_save.need_comp);
+    if (req_save.msglen) {
+        memcpy(req->msg, req_save.msg, req_save.msglen);
+    }
+
+    for (i = 0; i < req_save.num; i++) {
+        qemu_sglist_add(&req->sgl, req_save.sgl[i].base, req_save.sgl[i].len);
+    }
+
+out:
+    if (req_save.msglen) {
+        g_free(req_save.msg);
+    }
+    if (req_save.num) {
+        g_free(req_save.sgl);
+    }
+    return req;
+}
+
 static void channel_event_cb(EventNotifier *e)
 {
     VMBusChannel *chan = container_of(e, VMBusChannel, notifier);
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 99b647e1d6..40e8417eec 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -224,4 +224,7 @@ int vmbus_map_sgl(VMBusChanReq *req, DMADirection dir, struct iovec *iov,
 void vmbus_unmap_sgl(VMBusChanReq *req, DMADirection dir, struct iovec *iov,
                      unsigned iov_cnt, size_t accessed);
 
+void vmbus_save_req(QEMUFile *f, VMBusChanReq *req);
+void *vmbus_load_req(QEMUFile *f, VMBusDevice *dev, uint32_t size);
+
 #endif
-- 
2.26.2



