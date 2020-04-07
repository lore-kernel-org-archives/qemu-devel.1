Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BDDC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B5620730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvuvtpMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B5620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLhBz-000098-US
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 01:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jLh9t-0004jr-Jh
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jLh9s-0002cD-Fr
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jLh9s-0002bo-9l
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id h2so470749wmb.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 22:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WU+H5+odnL+lFKgHafO2P278mQjtE3V6d/6koMgqUwg=;
 b=kvuvtpMZxquKhKaB3Yi0fhE1guv6O64cTGRGRC1M5XjwJ8SNWO63AQXDodUzimkxEH
 XRKq1/W2hGgYohXRTgOFBS/AN9S2CTOXR/tsuJJ56Y0zclNeyEMfT/vmG3+va0gxwpHV
 j/RbTdCojP4oa8jDPobbK9x5hUf/kwmxFWhiwF8kfJa74gQTModm6o0/XebiJ7a4CRJ0
 5vLf9o0xS6HXgB1xdaAtZtk1BKFrCvWH2rw1swFdMSkTzavOqaKWMuDFt66H/YAOJP2y
 Kx8t8bKPfpY1fwHNTPHG45mccS2D8vDrnomGQp2eby2PUGEfAaszwWw+dPKa4+bnhYNg
 G+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WU+H5+odnL+lFKgHafO2P278mQjtE3V6d/6koMgqUwg=;
 b=UWQF4kFznYB/mrVC9I5ik9t4lAu1Lb6zjyDMhJEfAfLyi0HCyaU2AxSLV6MrmHPcCq
 IUl//cCEyuwef0x8bIU4SuULB4vy+iPeHQK2LkfhcJZfedkh/pcwTHaqfeAmBImlbnO/
 ivYHkwrQs0ZMS9bUjnuAWO58uCXfbjzfhUML9kSMx38pCr0HmZWsPPor2/NJnPzC9juS
 Dsx6kTyUD95Pu46E9vRJ6pCJLzD8iBHbp4YNzubhoLhWCBls0suaFkeh1tg07nqzA1lD
 vNWMq3wjxa3Rp47CcMRParVj7fVqPyvw7/PvtULdD5eXMsRylqs1Wwaah9dc5mA/gbhF
 d9Iw==
X-Gm-Message-State: AGi0PubSNhnYEREmJmaQE4GQWWlWgfXNM3E3jYb92ZBAzB0uKIxZgVcu
 IssA3tKi+25lzoQsVVpjQ6O14Ikj2aY=
X-Google-Smtp-Source: APiQypJ1XaSLTGzuq2Mqjcf2TvJzt+aOBXFggMYaEIqVJPaK7acvxFOCMXlZIxDYxOOLjiZ2Smd5rA==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr583148wmb.26.1586238743104;
 Mon, 06 Apr 2020 22:52:23 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
 by smtp.gmail.com with ESMTPSA id
 n11sm32271007wrg.72.2020.04.06.22.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 22:52:22 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] vmbus: add infrastructure to save/load vmbus requests
Date: Tue,  7 Apr 2020 08:51:56 +0300
Message-Id: <20200407055156.137249-8-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407055156.137249-1-arilou@gmail.com>
References: <20200407055156.137249-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


