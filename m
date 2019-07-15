Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872EAC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5909E2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyL6kkJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5909E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1Fm-0001E3-4X
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FG-0007sW-VH
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FF-0006Ah-6E
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FE-000693-Rt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id 207so15247139wma.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=M7cygNuQv/R1u8CJs+gp7c5R4DnZyamtxh5srkkTrmQ=;
 b=uyL6kkJrL5xDlguPEnMeJZn4TYutZ/hvvgUKVtFckiWXqDqR2hbbMAH0WeYQ1rEM28
 8ldy9gyjGB35j9v8nlOtyLxbpH9sPobvtOMTx/X/3wdYnZ9TxHBFV4KOkxAcFIHeCEKi
 0dvNQ2+ygiKEAK7hOpsLRFtaY4NyPqkOaD/k0ZUK9UYYyVYjXPZRR7+PXRy+XclOWjCm
 dNDB1OELySa+Xq01GMBwx/Wc0wRj2/G2khq6FSqi46PJ4o7GhojgoQZBBlVseacKCrxE
 Fk9cmBs2sKXJlK8CY7f2xC/y2oVDqoIOkL3MP/+svWm5vTX/7sS4J3AzSxiuUJHB66kf
 HIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M7cygNuQv/R1u8CJs+gp7c5R4DnZyamtxh5srkkTrmQ=;
 b=UdAepvspApNb4df9iKIY2L7/T8lHaGe7u+/Shy09szHFAIkl+g6ptenItk806LNx+R
 7/XUXFLEtBiHAZahVGl+slcY5qpracYGNvLSGnghw73TQCYECramKjlJNDjUCD6RbGlB
 2v/75gQqUSensNfiYOZ56svs5bKRocAfWg9koAtVZeitZhT+U13aOuS+16tfgvvFhnbx
 kCUrYSuCMhF2/UlEFfSSapoCjE2kqcPFX4R/7PU6zkVnT3zWqCSbDCNO74Iz4LcrtZ7O
 dUuPdN5pFt0NboI0uOA4S66wmjvqmhIG2YJgxvbqt2R01KR2P2q3QuCvvmTyo8pCJEh6
 g5uQ==
X-Gm-Message-State: APjAAAXnERhKAKDbWUW/lG5oiqdkOO3CBNPyXj597DR2Q+2RbokoJNDO
 xb3aQB3ovui7CT3HxshY//LJncVK9LEPlg==
X-Google-Smtp-Source: APXvYqz2QhUSu65jI50uusGpa4vkEFrU9IHf3GO0dlnTCPUZt1TiIXKzG+Yxgmjh/IL9z8id3gEGlQ==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr24343489wmf.2.1563198138072; 
 Mon, 15 Jul 2019 06:42:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:06 +0100
Message-Id: <20190715134211.23063-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 05/10] hw/ssi/mss-spi: Avoid crash when reading
 empty RX FIFO
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

Reading the RX_DATA register when the RX_FIFO is empty triggers
an abort. This can be easily reproduced:

  $ qemu-system-arm -M emcraft-sf2 -monitor stdio -S
  QEMU 4.0.50 monitor - type 'help' for more information
  (qemu) x 0x40001010
  Aborted (core dumped)

  (gdb) bt
  #1  0x00007f035874f895 in abort () at /lib64/libc.so.6
  #2  0x00005628686591ff in fifo8_pop (fifo=0x56286a9a4c68) at util/fifo8.c:66
  #3  0x00005628683e0b8e in fifo32_pop (fifo=0x56286a9a4c68) at include/qemu/fifo32.h:137
  #4  0x00005628683e0efb in spi_read (opaque=0x56286a9a4850, addr=4, size=4) at hw/ssi/mss-spi.c:168
  #5  0x0000562867f96801 in memory_region_read_accessor (mr=0x56286a9a4b60, addr=16, value=0x7ffeecb0c5c8, size=4, shift=0, mask=4294967295, attrs=...) at memory.c:439
  #6  0x0000562867f96cdb in access_with_adjusted_size (addr=16, value=0x7ffeecb0c5c8, size=4, access_size_min=1, access_size_max=4, access_fn=0x562867f967c3 <memory_region_read_accessor>, mr=0x56286a9a4b60, attrs=...) at memory.c:569
  #7  0x0000562867f99940 in memory_region_dispatch_read1 (mr=0x56286a9a4b60, addr=16, pval=0x7ffeecb0c5c8, size=4, attrs=...) at memory.c:1420
  #8  0x0000562867f99a08 in memory_region_dispatch_read (mr=0x56286a9a4b60, addr=16, pval=0x7ffeecb0c5c8, size=4, attrs=...) at memory.c:1447
  #9  0x0000562867f38721 in flatview_read_continue (fv=0x56286aec6360, addr=1073745936, attrs=..., buf=0x7ffeecb0c7c0 "\340ǰ\354\376\177", len=4, addr1=16, l=4, mr=0x56286a9a4b60) at exec.c:3385
  #10 0x0000562867f38874 in flatview_read (fv=0x56286aec6360, addr=1073745936, attrs=..., buf=0x7ffeecb0c7c0 "\340ǰ\354\376\177", len=4) at exec.c:3423
  #11 0x0000562867f388ea in address_space_read_full (as=0x56286aa3e890, addr=1073745936, attrs=..., buf=0x7ffeecb0c7c0 "\340ǰ\354\376\177", len=4) at exec.c:3436
  #12 0x0000562867f389c5 in address_space_rw (as=0x56286aa3e890, addr=1073745936, attrs=..., buf=0x7ffeecb0c7c0 "\340ǰ\354\376\177", len=4, is_write=false) at exec.c:3466
  #13 0x0000562867f3bdd7 in cpu_memory_rw_debug (cpu=0x56286aa19d00, addr=1073745936, buf=0x7ffeecb0c7c0 "\340ǰ\354\376\177", len=4, is_write=0) at exec.c:3976
  #14 0x000056286811ed51 in memory_dump (mon=0x56286a8c32d0, count=1, format=120, wsize=4, addr=1073745936, is_physical=0) at monitor/misc.c:730
  #15 0x000056286811eff1 in hmp_memory_dump (mon=0x56286a8c32d0, qdict=0x56286b15c400) at monitor/misc.c:785
  #16 0x00005628684740ee in handle_hmp_command (mon=0x56286a8c32d0, cmdline=0x56286a8caeb2 "0x40001010") at monitor/hmp.c:1082

From the datasheet "Actel SmartFusion Microcontroller Subsystem
User's Guide" Rev.1, Table 13-3 "SPI Register Summary", this
register has a reset value of 0.

Check the FIFO is not empty before accessing it, else log an
error message.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20190709113715.7761-3-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/mss-spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 918b1f3e821..4c9da5d2b28 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -165,7 +165,13 @@ spi_read(void *opaque, hwaddr addr, unsigned int size)
     case R_SPI_RX:
         s->regs[R_SPI_STATUS] &= ~S_RXFIFOFUL;
         s->regs[R_SPI_STATUS] &= ~S_RXCHOVRF;
-        ret = fifo32_pop(&s->rx_fifo);
+        if (fifo32_is_empty(&s->rx_fifo)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Reading empty RX_FIFO\n",
+                          __func__);
+        } else {
+            ret = fifo32_pop(&s->rx_fifo);
+        }
         if (fifo32_is_empty(&s->rx_fifo)) {
             s->regs[R_SPI_STATUS] |= S_RXFIFOEMP;
         }
-- 
2.20.1


