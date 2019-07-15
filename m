Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB09C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3A22067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otxZc/mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3A22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1GH-0003Z3-DW
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51746)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FF-0007mO-L0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FE-0006A7-Mg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FC-00067e-1S
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so15275585wmj.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cZNM3b90C0KI7GS3KaL+3KknzrTXZsMagrLfxlk+ajU=;
 b=otxZc/mtaOuA7Lkvv9rjj9HKjelnjfwkFJQu7Y9VlKFOp6WPj42XYCSIloW+OgH5eT
 YkO2OlC8a8DURpPPbCBJ27oIOPqPEm+6zj2AVs70SzgLT3vDsHZQgAAKTM1ZJ4xAt21T
 7krDirQh1GpaD864eMhEhtDCLsBxDDgaOoF1qSgp6XP9TGgu21C3thFMZpoFo+G6CIoY
 r2+OPAETIVK+2U4nan2IiKWEDDSlejEhvK1q8paV9XfcRXiPSbivJOVfAIrO020j2CRB
 3JSUfoJkhu3UzHYHCDwPcLkFse5+wfXHwgQMjLKz0NZxSXWGsKRBHK+gWt2eBqEp7szq
 rjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cZNM3b90C0KI7GS3KaL+3KknzrTXZsMagrLfxlk+ajU=;
 b=jMf7GVdDhdw+3wojs/YJnUsHZGNj0jWiDuSweqc9U53wfc8WS7TanpoSTW65v4Vu/0
 iCh4fPY9YW/vDb6xmiYvBu5Szq7SKCpqbz2+5fI2scVoNqUJffymC+HgTy/mYU1YWW3R
 ZNlJ89vajhCRiauWLWd9JrPKiEU2l3IvPwKvW1MZdsKQePHbu2+pVKetc1xV3dIvhLsy
 /23ebRbuuoi9Yzu69bwPVH/ckHMLTWciL/xZJJ1ruUnGbSxY2YkrVARWDML0JqIlOQtE
 s9pde+BbggOwOgO66CM1tNuf/3ly2MryMYw9RSdS+GPitSzxrmxHS6vkc8Atz8fXWeC2
 wpeg==
X-Gm-Message-State: APjAAAUwPuDzcjZ5gRVMXeYDzWDXSXROVb25BySCr74mNrLqCCf6ryZe
 4WybnLYuu3IAlUZXQhMuaqI00cpcNN893Q==
X-Google-Smtp-Source: APXvYqyEekqB2pH4T8kJYxFYkCaYK7OYbT75TzPxT3yJ8GpBMO9dQjWn3tSegTqCAkHnk1YfmLQzjQ==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr26250512wmf.0.1563198135022; 
 Mon, 15 Jul 2019 06:42:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:03 +0100
Message-Id: <20190715134211.23063-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 02/10] hw/ssi/xilinx_spips: Convert lqspi_read()
 to read_with_attrs
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

In the next commit we will implement the write_with_attrs()
handler. To avoid using different APIs, convert the read()
handler first.

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 8115bb6d468..b7c7275dbe4 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1202,27 +1202,26 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
     }
 }
 
-static uint64_t
-lqspi_read(void *opaque, hwaddr addr, unsigned int size)
+static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value,
+                              unsigned size, MemTxAttrs attrs)
 {
-    XilinxQSPIPS *q = opaque;
-    uint32_t ret;
+    XilinxQSPIPS *q = XILINX_QSPIPS(opaque);
 
     if (addr >= q->lqspi_cached_addr &&
             addr <= q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
         uint8_t *retp = &q->lqspi_buf[addr - q->lqspi_cached_addr];
-        ret = cpu_to_le32(*(uint32_t *)retp);
-        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
-                   (unsigned)ret);
-        return ret;
-    } else {
-        lqspi_load_cache(opaque, addr);
-        return lqspi_read(opaque, addr, size);
+        *value = cpu_to_le32(*(uint32_t *)retp);
+        DB_PRINT_L(1, "addr: %08" HWADDR_PRIx ", data: %08" PRIx64 "\n",
+                   addr, *value);
+        return MEMTX_OK;
     }
+
+    lqspi_load_cache(opaque, addr);
+    return lqspi_read(opaque, addr, value, size, attrs);
 }
 
 static const MemoryRegionOps lqspi_ops = {
-    .read = lqspi_read,
+    .read_with_attrs = lqspi_read,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-- 
2.20.1


