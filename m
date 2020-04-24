Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA218C55191
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DFF20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxuRr7jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DFF20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxdU-0005eD-Ov
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxY3-0003tF-1X
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxY2-0004Ca-1s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jRxY1-00046L-Hn
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id z6so10536209wml.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WU+H5+odnL+lFKgHafO2P278mQjtE3V6d/6koMgqUwg=;
 b=KxuRr7jd5tHBiypzb+xVrfEXuDyyKw3SnEmHWwcrYi7pg0cKtyUqYKXb45IdC84F9b
 EmehJmY/FICnpzqmDwrax3eHquJsV4F12JYNji65g5cns7OEF85OrEktAo+rUeZVrwsF
 EpV93MVy5I4m1ziZhwquLvFcwjYljARsEMh90X8iU6mx4YX3JtgOKBIPk8peilSBQIv2
 TUQgm4saaLrPpPoQPGVfyfwBxEBoMobs6w0EVyx1UUYrsFyzvNStv3xtwndBDf47AWPo
 BSGhUloKd4RHg0UhIU25qIkoYaLSS4SVxdmvIX3EaRLUPdZyAutdKuE88LGXQnjeDogF
 iABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WU+H5+odnL+lFKgHafO2P278mQjtE3V6d/6koMgqUwg=;
 b=F2mk7gMQmpJErdeAkdGvtkepvkc098pis8vhJFWsyj4hHME49RqiovEAdBdDFi/mfS
 wHL65nCzkBvD+f7h10odzhyLCzPMvxR0LTJ+vZFsSLuhYVMjoamXTYiRF4pWcdVUgz6J
 wzeD+YTybxUuAS9I5OI1RTgMNQwdFVtZ2zNx2wg78ZxmhkQnVsFHD/q7u2qE7O0xXHUp
 RVfFEiohB1O1GEXpNrs4PLcGaPTIiXqzr4jDu7tRAepd3uekYeg7kEWUUptC2gseEXRZ
 WJfMH6NtWS839l29wLEvi7diNWKZV+EneAbaw3ho0GgLHIiFu+mELLGyeRJHIbslGQiP
 wJuA==
X-Gm-Message-State: AGi0PuZg3X/Cs6ExwRE/YshNHcgwItXyhqC83KhKEcJpX0S7mQxi1KSB
 g9Va7dunkNCd3JP3dh7Wv7bFyMYda6UYcw==
X-Google-Smtp-Source: APiQypKGpz6JkG2RNKnSne5MgEkRpY/JXTNssrthxrX8QXIstuz18URmyCipMSZgEfw2UTv1Ru+WXQ==
X-Received: by 2002:a1c:384:: with SMTP id 126mr10016216wmd.58.1587731708827; 
 Fri, 24 Apr 2020 05:35:08 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 91sm8462859wra.37.2020.04.24.05.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 05:35:08 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/6] vmbus: add infrastructure to save/load vmbus requests
Date: Fri, 24 Apr 2020 15:34:44 +0300
Message-Id: <20200424123444.3481728-7-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424123444.3481728-1-arilou@gmail.com>
References: <20200424123444.3481728-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 pbonzini@redhat.com, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can be allow to include controller-specific data while
saving/loading in-flight scsi requests of the vmbus scsi controller.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/vmbus.c         | 99 +++++++++++++++++++++++++++++++++++++++
 include/hw/hyperv/vmbus.h |  3 ++
 2 files changed, 102 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 0df7afe0ca..ab72a59a4a 100644
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
index 63a5b807b6..9219f34d6b 100644
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
2.24.1


