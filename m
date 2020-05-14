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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4FE2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge4N30UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4FE2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEj5-0000BV-7d
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcq-0007XM-9f
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:16 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:40394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcp-0003ma-BO
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:15 -0400
Received: by mail-lf1-x141.google.com with SMTP id h188so2022410lfd.7
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r7a5kGEyzosESTdmEwVGGd/q63HdJiXWSrEI6m5XxK4=;
 b=Ge4N30UKYfgXdi3mmq031ONleaEHuug4sPQzs7eiPuPiYmR5U5hlzmuAS1yDYDXaor
 77phzA8mSbhZkAhL3B2fzlVfx6zgT+D05SdCIGLAtr+/1y5soRF1VyFf9rxqZ4syOdCM
 Wl8RaT/GZ8uPpIwqS0/qjU8u7ob+tmAeWJt6lHYaHFUreuig0zjS6yxGrRhP4nT736i0
 C6wrK6F51atOAoeE5Tto+VpCne81YsgolvenVq+7XyNL8pE8w4946sHmZBNk2WZCSWSB
 IGwbMkrDafxDYOHc1lJeXUoeCr/XOkBf3JkxzDPH3sIRdclYIjSD3n6+zTcCAQJYphxy
 Jkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r7a5kGEyzosESTdmEwVGGd/q63HdJiXWSrEI6m5XxK4=;
 b=jB3riGZb0VCyyo9gpQF5DIvVXOrzj1dTAx66vLYC2z7AV9r3SEGY9U1hhItw+sWoRM
 4i1q+1gYy2j5Wtr+oHo2U+86zh2Cetuyzh3+z6wW/FjDup9OY9PKM/QUrb6WAKIrD8Tb
 SrkgAo+gy2M2Y7SausxuGvCPAE9f10BFgByJG2rIzz9Q8gtQ8KUq3ruzwQ5OhCy/fICo
 sjVXLX53T8M+krOP5es6n6zAzuIHRRDXigrBFj0lfKDwcc2BdiiL+OsLR72hKZEi9TMH
 EJBrtEFyxPHzDVgNATu0F10q/5DsZM+ftSkjksLzKKxKXhmXaH32bauRRO0kQS1lIxMZ
 Hb6w==
X-Gm-Message-State: AOAM532FMlE2yhVPgcWBppKeAqAadxa6wFrL+ZuhA0iN8FTvkeHzcxX8
 +rED4kiqziyOWdeL5yjmREBYLIxw7PQ=
X-Google-Smtp-Source: ABdhPJxhcdOP9vo1zJNV7XfYgDKgChzM4BUUzRNmEVggJ9A0pPyPuFuTFW0N63qhAaiPShKcNqBp1g==
X-Received: by 2002:a05:6512:691:: with SMTP id
 t17mr3650080lfe.85.1589465653567; 
 Thu, 14 May 2020 07:14:13 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id r9sm1582242ljg.69.2020.05.14.07.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:12 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 07/14] hw/dma/xilinx_axidma: mm2s: Stream descriptor by
 descriptor
Date: Thu, 14 May 2020 16:13:55 +0200
Message-Id: <20200514141402.12498-8-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
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

Stream descriptor by descriptor from memory instead of
buffering entire packets before pushing. This enables
non-packet streaming clients to work and also lifts the
limitation that our internal DMA buffer needs to be able
to hold entire packets.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20200506082513.18751-8-edgar.iglesias@gmail.com>
---
 hw/dma/xilinx_axidma.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index a770e12c96..101d32a965 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -111,7 +111,6 @@ struct Stream {
     int nr;
 
     struct SDesc desc;
-    int pos;
     unsigned int complete_cnt;
     uint32_t regs[R_MAX];
     uint8_t app[20];
@@ -267,7 +266,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
                                  StreamSlave *tx_control_dev)
 {
     uint32_t prev_d;
-    unsigned int txlen;
+    uint32_t txlen;
+    uint64_t addr;
+    bool eop;
 
     if (!stream_running(s) || stream_idle(s)) {
         return;
@@ -282,24 +283,26 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
         }
 
         if (stream_desc_sof(&s->desc)) {
-            s->pos = 0;
             stream_push(tx_control_dev, s->desc.app, sizeof(s->desc.app), true);
         }
 
         txlen = s->desc.control & SDESC_CTRL_LEN_MASK;
-        if ((txlen + s->pos) > sizeof s->txbuf) {
-            hw_error("%s: too small internal txbuf! %d\n", __func__,
-                     txlen + s->pos);
-        }
 
-        address_space_read(&s->dma->as, s->desc.buffer_address,
-                           MEMTXATTRS_UNSPECIFIED,
-                           s->txbuf + s->pos, txlen);
-        s->pos += txlen;
+        eop = stream_desc_eof(&s->desc);
+        addr = s->desc.buffer_address;
+        while (txlen) {
+            unsigned int len;
+
+            len = txlen > sizeof s->txbuf ? sizeof s->txbuf : txlen;
+            address_space_read(&s->dma->as, addr,
+                               MEMTXATTRS_UNSPECIFIED,
+                               s->txbuf, len);
+            stream_push(tx_data_dev, s->txbuf, len, eop && len == txlen);
+            txlen -= len;
+            addr += len;
+        }
 
-        if (stream_desc_eof(&s->desc)) {
-            stream_push(tx_data_dev, s->txbuf, s->pos, true);
-            s->pos = 0;
+        if (eop) {
             stream_complete(s);
         }
 
-- 
2.20.1


