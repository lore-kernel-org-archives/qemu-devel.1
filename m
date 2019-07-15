Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA4C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DE12080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3lc+zto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DE12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38719 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1Fn-0001I5-HC
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FE-0007lA-Ua
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FD-00069O-5J
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FB-000682-LO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id v15so15252331wml.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SRhHW3p+BKr58tLhFiUoR21pNGFw1vt263k2cYakmhQ=;
 b=h3lc+ztoxeXOSl05jAM7rqFEc9nxQw6ot8kKvvMx87rJLydY17kr43R3zA+6F4Hjex
 UBBqJKdPtMAV3bYyK7O9LRWmpMmMrf3mcB8FTMqIR/a53pk2JPlUkeNjrhir8dTU3XHP
 X6sl96dV4A+wpd9yLnLI0KLnmwNrERverd8W7Qodw5j6tw1xAqFL7rNBcdt3DLzY9po0
 FAVhDl5/VoKQ0oChRhfgEhQqAOoEpyU4uU+CRKloBkDrh5d1EvpqypJpO3T9ZS/uLPI3
 0yucOIa5rUm3SEWsI/3WbVKVn+sVrOIlA6VO6dic5jKVou+2jLt4FV6Ss+JDU9ltts+4
 +grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SRhHW3p+BKr58tLhFiUoR21pNGFw1vt263k2cYakmhQ=;
 b=jdXiAmnCXsGarx6jqoDopOz7cgVVY5wprnUrhpfGPKFtMNPT7s2/1YuCIZ0Sz01EYD
 FVuQZvF8WgORp8jnQFXe1Upk6wzbh3OHnjUpkHU4smAymsjM3WwQNvvb7WOiEpL64fQy
 wXrPVNyuvsUlOozWtMmvLOQvpQOUBl8gZKjWpGESzf+Th9ZiY50XlYTsS5Fsfask9vFH
 EZP0MRNbZ335mqqWjKJ4f8zZG3QsLytpAUPoRq4xW7MVdSJwHQdzfnJSb+8rrgrfF8Iw
 olHYX/FyNXhBrdLKJ2PgW0SV4IgoawtQtUZ6LKPhprHMkDUy0P3a4wqOyfrHC3U/jHne
 VAWw==
X-Gm-Message-State: APjAAAW4hY78bI2qx/YXyRjBIwTdY4YP0CpY7I+IYj9Wsbhq8jc3ROce
 LRjdSEzuOU0p32oYiEnYaJeG1TeerINjTQ==
X-Google-Smtp-Source: APXvYqyvZPJ+z62DNTyRh9V0oA+rh6qctpzUQvaqrNxehe06XBBo8XfVC7RT79k3JS3YTkg4Zcbgwg==
X-Received: by 2002:a1c:b155:: with SMTP id a82mr23805926wmf.35.1563198135847; 
 Mon, 15 Jul 2019 06:42:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:04 +0100
Message-Id: <20190715134211.23063-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 03/10] hw/ssi/xilinx_spips: Avoid AXI writes to
 the LQSPI linear memory
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

Lei Sun found while auditing the code that a CPU write would
trigger a NULL pointer dereference.

>From UG1085 datasheet [*] AXI writes in this region are ignored
and generates an AXI Slave Error (SLVERR).

Fix by implementing the write_with_attrs() handler.
Return MEMTX_ERROR when the region is accessed (this error maps
to an AXI slave error).

[*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf

Reported-by: Lei Sun <slei.casper@gmail.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index b7c7275dbe4..3c4e8365ee1 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1220,8 +1220,24 @@ static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value,
     return lqspi_read(opaque, addr, value, size, attrs);
 }
 
+static MemTxResult lqspi_write(void *opaque, hwaddr offset, uint64_t value,
+                               unsigned size, MemTxAttrs attrs)
+{
+    /*
+     * From UG1085, Chapter 24 (Quad-SPI controllers):
+     * - Writes are ignored
+     * - AXI writes generate an external AXI slave error (SLVERR)
+     */
+    qemu_log_mask(LOG_GUEST_ERROR, "%s Unexpected %u-bit access to 0x%" PRIx64
+                                   " (value: 0x%" PRIx64 "\n",
+                  __func__, size << 3, offset, value);
+
+    return MEMTX_ERROR;
+}
+
 static const MemoryRegionOps lqspi_ops = {
     .read_with_attrs = lqspi_read,
+    .write_with_attrs = lqspi_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-- 
2.20.1


