Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D876C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7BD2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyNgZrxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7BD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1GV-0004bt-TJ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FG-0007sT-VL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FF-0006Ap-8r
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FF-00069c-2T
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id g67so11155196wme.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lHOw/lFmFh4DCBqEH/SEFyeXO8oWbfUPsK1BSik9p+k=;
 b=EyNgZrxGyFWbJv274Z/DHUUe6esAV/mM5X262HZ6Uzw653STIvLUSsyJshnK9MAylp
 OXkwdXS0AfBgNTST1TSD/of004/rpC+QNaJ0Dt1TpAn9aqB+xu6tYpw80ApiAD3dkxRs
 MCU1K07ssWn5MTsG97DTr7DN7zRU6HbG98wXXLKHzDZH4rwomxzUjIRTiGDAcOFHTajz
 XQDfMxLk56zgjjtadbgatETYut880FehZZFSFkcLdAOMkG7oyc2AQDciHoCh+pGT3u/t
 fhTlIyTsipKFwyQ4VLC4avxKpn1HRBiH2C13ZyLkGrlETdISAYpkT54WsLErWizKPxH0
 D2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lHOw/lFmFh4DCBqEH/SEFyeXO8oWbfUPsK1BSik9p+k=;
 b=e3v92ymIeRxAkc4VzutcoyBsBxCV6a5uYnprZEIBFyNvrTUHC3b1XUPQPgDV43MW9/
 JcJDI2DEvXRRh24LYY1vQGkpUPzuaLgD6WQQ2Fb0yfNjXkACBdJD8XoRz9eG4gaw9Pde
 Cie706XBYAhUEjviIPL4ci67VVnEql0XvXe8lCbRpyh9AMiPG6GqT9qwS4PxvyYA0gvQ
 GqdTeptJon7nF1vBQDnln67sC70y7kgCJUINm18tOhKMoLgaZn2jFzXBN6kkOc8bTxpL
 yA5mmVulvm0S7BXiqIf1iCLK/HGn+M7BLrM2z4ySIiPeZ3NjTnLtPMAQfHFXx51IrZgN
 Px1A==
X-Gm-Message-State: APjAAAViPamRo2IDScnmnU00hxk+zBltsVdbeCRm9TD80YSxwyBI53Mt
 fF7RI7QLdAXREd67e+f2LHzG3UqKfFk1OA==
X-Google-Smtp-Source: APXvYqy2OuV9w/c+f5kAHvBgI2Dh1XMZBPEVkoLPUVzGeen12hcG7lbiWsG1eF1PFLbS5eFhnqXvag==
X-Received: by 2002:a1c:c542:: with SMTP id v63mr24181312wmf.97.1563198138969; 
 Mon, 15 Jul 2019 06:42:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:07 +0100
Message-Id: <20190715134211.23063-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 06/10] hw/display/xlnx_dp: Avoid crash when
 reading empty RX FIFO
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

In the previous commit we fixed a crash when the guest read a
register that pop from an empty FIFO.
By auditing the repository, we found another similar use with
an easy way to reproduce:

  $ qemu-system-aarch64 -M xlnx-zcu102 -monitor stdio -S
  QEMU 4.0.50 monitor - type 'help' for more information
  (qemu) xp/b 0xfd4a0134
  Aborted (core dumped)

  (gdb) bt
  #0  0x00007f6936dea57f in raise () at /lib64/libc.so.6
  #1  0x00007f6936dd4895 in abort () at /lib64/libc.so.6
  #2  0x0000561ad32975ec in xlnx_dp_aux_pop_rx_fifo (s=0x7f692babee70) at hw/display/xlnx_dp.c:431
  #3  0x0000561ad3297dc0 in xlnx_dp_read (opaque=0x7f692babee70, offset=77, size=4) at hw/display/xlnx_dp.c:667
  #4  0x0000561ad321b896 in memory_region_read_accessor (mr=0x7f692babf620, addr=308, value=0x7ffe05c1db88, size=4, shift=0, mask=4294967295, attrs=...) at memory.c:439
  #5  0x0000561ad321bd70 in access_with_adjusted_size (addr=308, value=0x7ffe05c1db88, size=1, access_size_min=4, access_size_max=4, access_fn=0x561ad321b858 <memory_region_read_accessor>, mr=0x7f692babf620, attrs=...) at memory.c:569
  #6  0x0000561ad321e9d5 in memory_region_dispatch_read1 (mr=0x7f692babf620, addr=308, pval=0x7ffe05c1db88, size=1, attrs=...) at memory.c:1420
  #7  0x0000561ad321ea9d in memory_region_dispatch_read (mr=0x7f692babf620, addr=308, pval=0x7ffe05c1db88, size=1, attrs=...) at memory.c:1447
  #8  0x0000561ad31bd742 in flatview_read_continue (fv=0x561ad69c04f0, addr=4249485620, attrs=..., buf=0x7ffe05c1dcf0 "\020\335\301\005\376\177", len=1, addr1=308, l=1, mr=0x7f692babf620) at exec.c:3385
  #9  0x0000561ad31bd895 in flatview_read (fv=0x561ad69c04f0, addr=4249485620, attrs=..., buf=0x7ffe05c1dcf0 "\020\335\301\005\376\177", len=1) at exec.c:3423
  #10 0x0000561ad31bd90b in address_space_read_full (as=0x561ad5bb3020, addr=4249485620, attrs=..., buf=0x7ffe05c1dcf0 "\020\335\301\005\376\177", len=1) at exec.c:3436
  #11 0x0000561ad33b1c42 in address_space_read (len=1, buf=0x7ffe05c1dcf0 "\020\335\301\005\376\177", attrs=..., addr=4249485620, as=0x561ad5bb3020) at include/exec/memory.h:2131
  #12 0x0000561ad33b1c42 in memory_dump (mon=0x561ad59c4530, count=1, format=120, wsize=1, addr=4249485620, is_physical=1) at monitor/misc.c:723
  #13 0x0000561ad33b1fc1 in hmp_physical_memory_dump (mon=0x561ad59c4530, qdict=0x561ad6c6fd00) at monitor/misc.c:795
  #14 0x0000561ad37b4a9f in handle_hmp_command (mon=0x561ad59c4530, cmdline=0x561ad59d0f22 "/b 0x00000000fd4a0134") at monitor/hmp.c:1082

Fix by checking the FIFO is not empty before popping from it.

The datasheet is not clear about the reset value of this register,
we choose to return '0'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20190709113715.7761-4-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/xlnx_dp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index cfd4c700b7f..cc5b650df0c 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -427,11 +427,18 @@ static uint8_t xlnx_dp_aux_pop_rx_fifo(XlnxDPState *s)
     uint8_t ret;
 
     if (fifo8_is_empty(&s->rx_fifo)) {
-        DPRINTF("rx_fifo underflow..\n");
-        abort();
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Reading empty RX_FIFO\n",
+                      __func__);
+        /*
+         * The datasheet is not clear about the reset value, it seems
+         * to be unspecified. We choose to return '0'.
+         */
+        ret = 0;
+    } else {
+        ret = fifo8_pop(&s->rx_fifo);
+        DPRINTF("pop 0x%" PRIX8 " from rx_fifo.\n", ret);
     }
-    ret = fifo8_pop(&s->rx_fifo);
-    DPRINTF("pop 0x%" PRIX8 " from rx_fifo.\n", ret);
     return ret;
 }
 
-- 
2.20.1


