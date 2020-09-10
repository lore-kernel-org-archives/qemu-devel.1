Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D688C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E7F2078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8HoDR1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E7F2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGi8-0006Re-7s
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGaq-0005ID-P2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGao-0001lV-CU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599721321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOfPlRcHNPnFEFQL04D9b7WV0+f6qJ96Y7nXN27AiJ8=;
 b=E8HoDR1xakX1Zi/Tk+P3apWt62fnF/8LzuoaQLhUiPQ1/RxXFiBa6luEkKGd23xnMyXszt
 Qv+xkCpyOiGeFUl7T4zO7XhVARYPNJfltRxIeHJbxdRQksLPZCKmigCWh+pniBgnGJuvQt
 r0hKNROiRD1A8NtlT0pPKCCq/bk0dzo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-ZYJEFeImO1K6mPG6avtPuQ-1; Thu, 10 Sep 2020 03:02:00 -0400
X-MC-Unique: ZYJEFeImO1K6mPG6avtPuQ-1
Received: by mail-wm1-f72.google.com with SMTP id u5so1302676wme.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rOfPlRcHNPnFEFQL04D9b7WV0+f6qJ96Y7nXN27AiJ8=;
 b=WcjfoOVNXp+b47Sxe0q3w5WqNSWOiBvh+8vkSfrIarW9RoaHTR6Yg254iQrTmbLjVH
 1/tIYJEEWcm5MA9x1FaQNxePYDrBTQQjRuRoSqwL9kt7/TeIweZjFmwgUiJ13luHmqSX
 Ba+9LguzrME7LtX/EXj+jdBXH1YFN1m5h2OwYjHxmYTxrHdwJUFmVn5O8qxY+kFTSDOU
 EDPse1O057bklsjRRoOGBxLNu1XVQ2+S5DCDQ6pxhLksze+3F/Olp2B8prxxbPYBWHwt
 aIUY7/XMVUTNswgkhBiYeE79/nzM+JyiL50/29Jf+p7doStaTBS7iBxK8LNEMTvDqV3J
 fgUw==
X-Gm-Message-State: AOAM5309L+a9HUpwliyCDD+2/A8QfEHzvm0fAAmHEZ/fbXG3mLBKoCdb
 LXyynS9CmNPDFM8G66ztogoXC1hlmtdvjBwA1OVELYV2aswdrhfxdbNNT49L7k1FrHK5+TwGAD1
 FTAXHxTTTD+ENwrk=
X-Received: by 2002:adf:e852:: with SMTP id d18mr8003809wrn.40.1599721316984; 
 Thu, 10 Sep 2020 00:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlwpG0tUUcWG7cYI6DeHX0M5TDMJpNZQcQfEC1vqrWrbjug/Hj3GDkPn1UBSppzX4Ol1mWhw==
X-Received: by 2002:adf:e852:: with SMTP id d18mr8003791wrn.40.1599721316799; 
 Thu, 10 Sep 2020 00:01:56 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f6sm2615123wme.32.2020.09.10.00.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:01:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/net/xilinx_axienet: Rename StreamSlave as StreamSink
Date: Thu, 10 Sep 2020 09:01:29 +0200
Message-Id: <20200910070131.435543-5-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/net/xilinx_axienet.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 0c4ac727207..4e48535f373 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -46,11 +46,11 @@
      OBJECT_CHECK(XilinxAXIEnet, (obj), TYPE_XILINX_AXI_ENET)
 
 #define XILINX_AXI_ENET_DATA_STREAM(obj) \
-     OBJECT_CHECK(XilinxAXIEnetStreamSlave, (obj),\
+     OBJECT_CHECK(XilinxAXIEnetStreamSink, (obj),\
      TYPE_XILINX_AXI_ENET_DATA_STREAM)
 
 #define XILINX_AXI_ENET_CONTROL_STREAM(obj) \
-     OBJECT_CHECK(XilinxAXIEnetStreamSlave, (obj),\
+     OBJECT_CHECK(XilinxAXIEnetStreamSink, (obj),\
      TYPE_XILINX_AXI_ENET_CONTROL_STREAM)
 
 /* Advertisement control register. */
@@ -310,10 +310,10 @@ struct TEMAC  {
     void *parent;
 };
 
-typedef struct XilinxAXIEnetStreamSlave XilinxAXIEnetStreamSlave;
+typedef struct XilinxAXIEnetStreamSink XilinxAXIEnetStreamSink;
 typedef struct XilinxAXIEnet XilinxAXIEnet;
 
-struct XilinxAXIEnetStreamSlave {
+struct XilinxAXIEnetStreamSink {
     Object parent;
 
     struct XilinxAXIEnet *enet;
@@ -325,8 +325,8 @@ struct XilinxAXIEnet {
     qemu_irq irq;
     StreamSink *tx_data_dev;
     StreamSink *tx_control_dev;
-    XilinxAXIEnetStreamSlave rx_data_dev;
-    XilinxAXIEnetStreamSlave rx_control_dev;
+    XilinxAXIEnetStreamSink rx_data_dev;
+    XilinxAXIEnetStreamSink rx_control_dev;
     NICState *nic;
     NICConf conf;
 
@@ -859,7 +859,7 @@ xilinx_axienet_control_stream_push(StreamSink *obj, uint8_t *buf, size_t len,
                                    bool eop)
 {
     int i;
-    XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
+    XilinxAXIEnetStreamSink *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
     XilinxAXIEnet *s = cs->enet;
 
     assert(eop);
@@ -880,7 +880,7 @@ static size_t
 xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
                                 bool eop)
 {
-    XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
+    XilinxAXIEnetStreamSink *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
     XilinxAXIEnet *s = ds->enet;
 
     /* TX enable ?  */
@@ -954,8 +954,8 @@ static NetClientInfo net_xilinx_enet_info = {
 static void xilinx_enet_realize(DeviceState *dev, Error **errp)
 {
     XilinxAXIEnet *s = XILINX_AXI_ENET(dev);
-    XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
-    XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(
+    XilinxAXIEnetStreamSink *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
+    XilinxAXIEnetStreamSink *cs = XILINX_AXI_ENET_CONTROL_STREAM(
                                                             &s->rx_control_dev);
 
     object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
@@ -1046,7 +1046,7 @@ static const TypeInfo xilinx_enet_info = {
 static const TypeInfo xilinx_enet_data_stream_info = {
     .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
     .parent        = TYPE_OBJECT,
-    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
+    .instance_size = sizeof(struct XilinxAXIEnetStreamSink),
     .class_init    = xilinx_enet_data_stream_class_init,
     .interfaces = (InterfaceInfo[]) {
             { TYPE_STREAM_SINK },
@@ -1057,7 +1057,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
 static const TypeInfo xilinx_enet_control_stream_info = {
     .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
     .parent        = TYPE_OBJECT,
-    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
+    .instance_size = sizeof(struct XilinxAXIEnetStreamSink),
     .class_init    = xilinx_enet_control_stream_class_init,
     .interfaces = (InterfaceInfo[]) {
             { TYPE_STREAM_SINK },
-- 
2.26.2


