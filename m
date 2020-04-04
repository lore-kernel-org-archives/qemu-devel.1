Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65079C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF5E206F5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWnkzd79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF5E206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKeGa-0004rC-QQ
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKeBG-0005wW-8F
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKeBF-00020c-19
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKeBE-00020J-QW
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id g3so8944369wrx.2
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2020 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwN78YIbadn0F1t/gIo345UXpGQM9fySiz9wjWBVkEs=;
 b=EWnkzd79cDwsaTDLV3tagWoNJhAH4YEtCIb3+w0sCIpftTsHNH06430/+CfYiphOTg
 vWN0MOuKyRB4SEq4HiWXVli3D5vP+QCKRs3xQsTJnNqQzCnG5Khxkq8RttLmgv35kZII
 Z2X1qUguqfWaobc5BLvX8C9XDCn7AJRYpLHWRwTQC1GGG1qvlswgUjbp19ZoK3lOljrd
 4U+2TZAC6xCQswsGtGKP6i9gqsT6FPXWcPBQQwWp73iZFAlBOc8zMYH0t2KWtcOfSB+L
 UzxJeQGo+Sqqgc9IFk41iTK8THZnYa1UfJZR3rIi4uGQ7qEZC08Rwab9pXXPGo7zyRIZ
 yKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vwN78YIbadn0F1t/gIo345UXpGQM9fySiz9wjWBVkEs=;
 b=MjI2wFofbdTaPA7ML1ILldBb8vgd0FIO3aXLPO8uuDtFBUDiLmCWO7KD9ZvtyCTswB
 ak4iBhuRdV1OcsJTqMKA9xIgNmKJB3fka4Tiiedk0oCF2VaxPPknIf0o+fXGVlaq6nfW
 p1sCxn5t4GzYOFeRbKdjGBFmgPWsw/oZoqmS9T1NpiakvZF4qk/UHXhyelQ+KTTDpne3
 x+nUXi1/z3e3JAun/qH99HbcAcegIIepU3reWFSOmCKEkOecUjLta/nqOn1PV+i0rLAx
 5U/8+e9RPbLU3oIyCcK9gKtYIs1TAtaAB/J03NAlYKRvrwoYiHHfNjnquIk2o5hMVGaE
 T78w==
X-Gm-Message-State: AGi0PuZIX4dBSAceE8Ys25W4CL8/Zq3BseifimGS2Eg7mkwlwFzK9z6h
 WKLpdIcl7vQfV4DskCcM4xia+nb2b4PnRQ==
X-Google-Smtp-Source: APiQypLdsvs2BnIlcrsVATp5eitQcRUZf+rtlJA5x+tO993SIftYivuejg+fdXvTydftrVDd6tzArQ==
X-Received: by 2002:a05:6000:1090:: with SMTP id
 y16mr12473129wrw.281.1585988967736; 
 Sat, 04 Apr 2020 01:29:27 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-40.inter.net.il. [84.229.155.40])
 by smtp.gmail.com with ESMTPSA id
 a10sm15884778wrm.87.2020.04.04.01.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 01:29:27 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] vmbus: add infrastructure to save/load vmbus requests
Date: Sat,  4 Apr 2020 11:29:00 +0300
Message-Id: <20200404082900.33711-8-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200404082900.33711-1-arilou@gmail.com>
References: <20200404082900.33711-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
index 46c6f5eebb..e16228a77c 100644
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


