Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C6820671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0yqi/X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C6820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEeU-0001QR-0n
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEci-0007Gt-UX
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:08 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEci-0003lV-7Y
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:08 -0400
Received: by mail-lj1-x241.google.com with SMTP id u6so3682402ljl.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5d6jbtddgGFL5WCJTRJhnSo2ooSc1NJpLI9in/SUXbM=;
 b=q0yqi/X/LYs4yCqVyIullYi7RDgXfysKHhW4D2zYd49eDkmlR7ImGdFUNcQ3qs1PFx
 r2CoJDWCgDExyDSM7GD4hCFuoQwm408PXOstqK8a802rjfz1/Qk1KwV3StxZIbjBrZCP
 FhuHXxyAsTPrlcxauJNp4DxVPkHv2k1HaJAX4iPI4HbBijCUItByc3KrF27mH3kJdzw9
 esFGzOVpriCe/MbcxRKySN7ed63spNuPdDdWrchNLAwqavG5/0ujRQxPavelPgjIeeh/
 rgHVfTGxZXIy7/Aj5VI1KXvcbpNwBEudwMxmMctiG2LeQmugt90zZJB6LUJiqdTi5IG5
 QgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5d6jbtddgGFL5WCJTRJhnSo2ooSc1NJpLI9in/SUXbM=;
 b=CoaTVb8m8qVZs2FlinrJ0EZWFrvb3/y2aRccDaUTimGGg8y1tXTRiCtIxIdxnnTrpw
 rPuYm3PSLP+r0mpfHg/lZnC1sRme/ysc2XjHirUTq9AzfqDuYHHPvxAUK3Kx8QGxhz4O
 i2KVCCwGE4n747u4j51OyoKXIXQCjVmVjFjEpVROMjMJ6OpGujnAaOLlo1a480g6z20s
 B7kZESf2ngOyzcGE+qxtciKC+SQio8zctjF2Q9ETQxTBbhWzpwlx4Uf+v+nkNZ3qN0s3
 5iRqUc7mYLLiIVr0+ZzQXp2IzJzkMBpf9EbZQlrYxCNwi0rGKk2gt6pNOGp6ACWUdxEj
 +SKg==
X-Gm-Message-State: AOAM532cxwDcFj5fK5LYfbLx8wdgP/qFzeV2ingpT+V+QxVrXnmTbYXE
 ME7+bBa5uGGCvszuXEGgrI0hynGke8I=
X-Google-Smtp-Source: ABdhPJxwB9urorrEJw4EbtD0neypToKHGXNAwUpQnfeuNXdpUmd77TOR1Hzc3cRADvzzBJHg8kqNqA==
X-Received: by 2002:a2e:8813:: with SMTP id x19mr2951450ljh.83.1589465646254; 
 Thu, 14 May 2020 07:14:06 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id g11sm1575083ljg.24.2020.05.14.07.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 02/14] hw/net/xilinx_axienet: Cleanup stream->push assignment
Date: Thu, 14 May 2020 16:13:50 +0200
Message-Id: <20200514141402.12498-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Split the shared stream_class_init function to assign
stream->push with better type-safety.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200506082513.18751-3-edgar.iglesias@gmail.com>
---
 hw/net/xilinx_axienet.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 0f97510d8a..84073753d7 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1029,11 +1029,19 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
     dc->reset = xilinx_axienet_reset;
 }
 
-static void xilinx_enet_stream_class_init(ObjectClass *klass, void *data)
+static void xilinx_enet_control_stream_class_init(ObjectClass *klass,
+                                                  void *data)
 {
     StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
 
-    ssc->push = data;
+    ssc->push = xilinx_axienet_control_stream_push;
+}
+
+static void xilinx_enet_data_stream_class_init(ObjectClass *klass, void *data)
+{
+    StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
+
+    ssc->push = xilinx_axienet_data_stream_push;
 }
 
 static const TypeInfo xilinx_enet_info = {
@@ -1048,8 +1056,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
     .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
-    .class_init    = xilinx_enet_stream_class_init,
-    .class_data    = xilinx_axienet_data_stream_push,
+    .class_init    = xilinx_enet_data_stream_class_init,
     .interfaces = (InterfaceInfo[]) {
             { TYPE_STREAM_SLAVE },
             { }
@@ -1060,8 +1067,7 @@ static const TypeInfo xilinx_enet_control_stream_info = {
     .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
-    .class_init    = xilinx_enet_stream_class_init,
-    .class_data    = xilinx_axienet_control_stream_push,
+    .class_init    = xilinx_enet_control_stream_class_init,
     .interfaces = (InterfaceInfo[]) {
             { TYPE_STREAM_SLAVE },
             { }
-- 
2.20.1


