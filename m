Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADDFC2BB84
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739432075B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrxS+4zH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739432075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGel-00039i-K4
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGam-000593-DF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGaj-0001kl-Fu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599721316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLJtjbF1Sn9R0haF3xV7HnFQaxPu+haN5ye/cmISEq4=;
 b=TrxS+4zHj3gLTE/lhdybqFzS3xouImV4qx1j3MwfOV3UPiQCjENZS0S3YXXOZb+ZGY4w2S
 dHfQPXyrnMFVCzDa9Tc2krC7C9j4Mo6siiJm5FNjXZBUEf+DW94mFxWq2ANqqlWQUs4d4s
 M6A2eYe1PouvXuPNB3Nw1sffLCLccdY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-CmK6yQItMJW03Y2hijLCfg-1; Thu, 10 Sep 2020 03:01:53 -0400
X-MC-Unique: CmK6yQItMJW03Y2hijLCfg-1
Received: by mail-wr1-f70.google.com with SMTP id y3so1879334wrl.21
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tLJtjbF1Sn9R0haF3xV7HnFQaxPu+haN5ye/cmISEq4=;
 b=RenDV9jO1bvX9+Gm2tp3iW9fIqDn4SAGQAc860R0PxcoqoPLd+bBYneoVlBP2pP4A/
 FV4sHGHfMmGWq+t9dE6BIjcjOOXBPlTkL6ltGkfMFwFXRdxm5HQs6+hW4Yc41W9ElmKc
 VrlOaUTPr7BlKdNIa+kCMRgm73Xxq7ybxUc5IzyKnvQsYA3xbNek2o3yC7k6pHiME/bE
 EnojmZyKQ8bHL+iop5+nvCerPs3czPFeK83D5sTZkOhnxuKlhHggWVdgtj9SnGB/5zlY
 6z6D3zMMKfdfKCcvRGzfHNHenHRhPdRTt1WOw1mR8IXUITAUU8PRrhoRLdw7KAIyDqvK
 9p9Q==
X-Gm-Message-State: AOAM533TvH3/jA9C8QZJMjNx4chz53qNw10P+uPoafZdRERTKsf4o5dE
 KdE1H4Sh7PXB7cAazqqY2VVNa1n9PPQsQBlwme/QCPr8vnN1Y4cWLXt/Xz2t0/ixgl7xoJVKXWp
 wv9ZNCs41tAaWsWg=
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr7278669wrt.159.1599721311426; 
 Thu, 10 Sep 2020 00:01:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8i7cmKf45V5kbz2l0XObKJh2WEGqkHysM6c4v7BhvhCTsiOpA+VO+/qwWJnvJcR5KLi5V/A==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr7278646wrt.159.1599721311241; 
 Thu, 10 Sep 2020 00:01:51 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n21sm2230672wmi.21.2020.09.10.00.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:01:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/dma/xilinx_axidma: Rename StreamSlave as StreamSink
Date: Thu, 10 Sep 2020 09:01:28 +0200
Message-Id: <20200910070131.435543-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910070131.435543-1-philmd@redhat.com>
References: <20200910070131.435543-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to use inclusive terminology, rename 'slave stream'
as 'sink stream'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/dma/xilinx_axidma.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index cf12a852ea1..19e14a2997e 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -46,11 +46,11 @@
      OBJECT_CHECK(XilinxAXIDMA, (obj), TYPE_XILINX_AXI_DMA)
 
 #define XILINX_AXI_DMA_DATA_STREAM(obj) \
-     OBJECT_CHECK(XilinxAXIDMAStreamSlave, (obj),\
+     OBJECT_CHECK(XilinxAXIDMAStreamSink, (obj),\
      TYPE_XILINX_AXI_DMA_DATA_STREAM)
 
 #define XILINX_AXI_DMA_CONTROL_STREAM(obj) \
-     OBJECT_CHECK(XilinxAXIDMAStreamSlave, (obj),\
+     OBJECT_CHECK(XilinxAXIDMAStreamSink, (obj),\
      TYPE_XILINX_AXI_DMA_CONTROL_STREAM)
 
 #define R_DMACR             (0x00 / 4)
@@ -63,7 +63,7 @@
 #define CONTROL_PAYLOAD_SIZE (CONTROL_PAYLOAD_WORDS * (sizeof(uint32_t)))
 
 typedef struct XilinxAXIDMA XilinxAXIDMA;
-typedef struct XilinxAXIDMAStreamSlave XilinxAXIDMAStreamSlave;
+typedef struct XilinxAXIDMAStreamSink XilinxAXIDMAStreamSink;
 
 enum {
     DMACR_RUNSTOP = 1,
@@ -118,7 +118,7 @@ struct Stream {
     unsigned char txbuf[16 * 1024];
 };
 
-struct XilinxAXIDMAStreamSlave {
+struct XilinxAXIDMAStreamSink {
     Object parent;
 
     struct XilinxAXIDMA *dma;
@@ -133,8 +133,8 @@ struct XilinxAXIDMA {
     uint32_t freqhz;
     StreamSink *tx_data_dev;
     StreamSink *tx_control_dev;
-    XilinxAXIDMAStreamSlave rx_data_dev;
-    XilinxAXIDMAStreamSlave rx_control_dev;
+    XilinxAXIDMAStreamSink rx_data_dev;
+    XilinxAXIDMAStreamSink rx_control_dev;
 
     struct Stream streams[2];
 
@@ -390,7 +390,7 @@ static size_t
 xilinx_axidma_control_stream_push(StreamSink *obj, unsigned char *buf,
                                   size_t len, bool eop)
 {
-    XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
+    XilinxAXIDMAStreamSink *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
     struct Stream *s = &cs->dma->streams[1];
 
     if (len != CONTROL_PAYLOAD_SIZE) {
@@ -407,7 +407,7 @@ xilinx_axidma_data_stream_can_push(StreamSink *obj,
                                    StreamCanPushNotifyFn notify,
                                    void *notify_opaque)
 {
-    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
+    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
     struct Stream *s = &ds->dma->streams[1];
 
     if (!stream_running(s) || stream_idle(s)) {
@@ -423,7 +423,7 @@ static size_t
 xilinx_axidma_data_stream_push(StreamSink *obj, unsigned char *buf, size_t len,
                                bool eop)
 {
-    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
+    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
     struct Stream *s = &ds->dma->streams[1];
     size_t ret;
 
@@ -534,8 +534,8 @@ static const MemoryRegionOps axidma_ops = {
 static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
 {
     XilinxAXIDMA *s = XILINX_AXI_DMA(dev);
-    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
-    XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
+    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
+    XilinxAXIDMAStreamSink *cs = XILINX_AXI_DMA_CONTROL_STREAM(
                                                             &s->rx_control_dev);
     int i;
 
@@ -634,7 +634,7 @@ static const TypeInfo axidma_info = {
 static const TypeInfo xilinx_axidma_data_stream_info = {
     .name          = TYPE_XILINX_AXI_DMA_DATA_STREAM,
     .parent        = TYPE_OBJECT,
-    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
+    .instance_size = sizeof(struct XilinxAXIDMAStreamSink),
     .class_init    = xilinx_axidma_stream_class_init,
     .class_data    = &xilinx_axidma_data_stream_class,
     .interfaces = (InterfaceInfo[]) {
@@ -646,7 +646,7 @@ static const TypeInfo xilinx_axidma_data_stream_info = {
 static const TypeInfo xilinx_axidma_control_stream_info = {
     .name          = TYPE_XILINX_AXI_DMA_CONTROL_STREAM,
     .parent        = TYPE_OBJECT,
-    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
+    .instance_size = sizeof(struct XilinxAXIDMAStreamSink),
     .class_init    = xilinx_axidma_stream_class_init,
     .class_data    = &xilinx_axidma_control_stream_class,
     .interfaces = (InterfaceInfo[]) {
-- 
2.26.2


