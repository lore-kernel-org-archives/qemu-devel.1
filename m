Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B14C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE012077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPK2hf4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE012077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Axw-0001Db-Rz
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArW-0002yB-Hy
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArV-00060q-CY
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArV-00060F-6C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id t17so18753650wmi.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Jh428xFMZspE9pzmT4T/vs6lA+3UmLCdDqsT/xMT5PA=;
 b=rPK2hf4Tm3a3xnzX1tqtxXub5x15pPJcI11sH/pYEdjJd7Vy+LC5W4UsULfAUXDnMD
 G60b3LkNc7BxVSKh2wjvodE/SxtrWKQhWuyGChggHeundz6Zhkv555z0VDhAgviIjzSY
 DYgjsNFXUYpomxw1k1zXyySCTj01a9XGQ5j9WqqEYTfQRYqh0FkwT0rsKmaF6gIVXqW5
 /5Zp4/1G1BO/q6vz2BWnxbzL64E3xCvOyyhoKDUJwPzbt0A/61+lsNQxfWadS5P7qMZd
 6g/3sB31q74KZft20MC/cxOCiBoZIuZUtO3XErk/v2xjspGEqs+k1KEY3dlpIGG4lmgV
 mZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jh428xFMZspE9pzmT4T/vs6lA+3UmLCdDqsT/xMT5PA=;
 b=p5VEyZiz7aoHEgMYLuNYtcv702FQIuiVZAEmDqdnw5mecESQbkYfsxNUOtHaPV9Zwi
 7mc1ff1y+0suyy3ItHV/tNcCmYlpVLBSUFzjzqagwYrkNW1hu7bBR2C2WuaGQ2dJMjKf
 iTMniYzfgti4yQ78j+P2AeDRsEAkPPCLyZzVQTKYjXxA7EjxwIfaXQDnYO8iBkhflmEE
 yT04S5/HtGyASC9Q6OiF05FDSmmtKBwvzAmQHzOT1n1IQBi6K/h7/RWVjJOxAXBFYEsA
 0eBwgF2EJdmgC1/OE79CmbaTgfiL/32s12Fp7XjumOK/dA76sQBS/KzaF/OzbnxxsYWl
 2NNw==
X-Gm-Message-State: APjAAAXsO08f4iuQaAyBOakIkveWDvNTU6vJA6bubhSRbpDjnfAUHUc/
 Edh4Qq5e6w+5k2JAGDW1aSMDYqq895Vlbw==
X-Google-Smtp-Source: APXvYqy8me/hDC390Sh1q3+M3E44cZXcICos3F3vPTxp5U4Lf6XsePitp2aUfG99oU/gDPD6vyvLTA==
X-Received: by 2002:a7b:cb0f:: with SMTP id u15mr717576wmj.173.1567525011888; 
 Tue, 03 Sep 2019 08:36:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:26 +0100
Message-Id: <20190903153633.6651-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 14/21] hw/dma/xilinx_axi: Use
 object_initialize_child for correct ref. counting
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As explained in commit aff39be0ed97:

  Both functions, object_initialize() and object_property_add_child()
  increase the reference counter of the new object, so one of the
  references has to be dropped afterwards to get the reference
  counting right. Otherwise the child object will not be properly
  cleaned up when the parent gets destroyed.
  Thus let's use now object_initialize_child() instead to get the
  reference counting here right.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190823143249.8096-6-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xilinx_axidma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index d176df6d449..a254275b64e 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -566,14 +566,14 @@ static void xilinx_axidma_init(Object *obj)
     XilinxAXIDMA *s = XILINX_AXI_DMA(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
-                      TYPE_XILINX_AXI_DMA_DATA_STREAM);
-    object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
-                      TYPE_XILINX_AXI_DMA_CONTROL_STREAM);
-    object_property_add_child(OBJECT(s), "axistream-connected-target",
-                              (Object *)&s->rx_data_dev, &error_abort);
-    object_property_add_child(OBJECT(s), "axistream-control-connected-target",
-                              (Object *)&s->rx_control_dev, &error_abort);
+    object_initialize_child(OBJECT(s), "axistream-connected-target",
+                            &s->rx_data_dev, sizeof(s->rx_data_dev),
+                            TYPE_XILINX_AXI_DMA_DATA_STREAM, &error_abort,
+                            NULL);
+    object_initialize_child(OBJECT(s), "axistream-control-connected-target",
+                            &s->rx_control_dev, sizeof(s->rx_control_dev),
+                            TYPE_XILINX_AXI_DMA_CONTROL_STREAM, &error_abort,
+                            NULL);
 
     sysbus_init_irq(sbd, &s->streams[0].irq);
     sysbus_init_irq(sbd, &s->streams[1].irq);
-- 
2.20.1


