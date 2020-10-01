Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832A3C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266B420872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS0+JREy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266B420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1hZ-0001wj-7w
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1g3-00009p-Kx
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1g2-0006EB-4L
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id k18so3844077wmj.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aalZfwDNGdwdW5/IIKOVPxUHA6XH4oPdaqpcACoVNTg=;
 b=fS0+JREyYVjO9EvT+b7+KTBJI63x8Q0fqj88LoSiwFxbXe/5Vhyf2QorziKM1xwo8S
 qEXXUYpCOaj1FmSZHp9wi0lBCytWSOM9ikLZtOBDl+DhEL8Grwkn/P+EYk87aNpbn7ol
 wMFQ4jOskhB6UQaauPR0Oa9Ir5ncFoG7/bNfjw1fQ90puX0pd/5HrkUSeo67Z0NB5dsn
 n61m437iNDueDmXFv4gwCwSJ2oZlCc3BKCr91xqAS5OdlS3iqN/z7A8F8XT1y2KcGUou
 CVhlGpSAA6MHVKy1lMxSBNQ8E9w944NW0XzVOL0UORVAj4k3+GMyUhlp2UDcivL2NmKH
 VU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aalZfwDNGdwdW5/IIKOVPxUHA6XH4oPdaqpcACoVNTg=;
 b=H3UUlxhgyk6Uz2kLccIDmbWI5x9mUiUh/4jDj4MWavP+POaI4FKcJBzT21MYbCmrMo
 y7+/Pjje46zVyUBgvbm5I75FZ0wVQ13/qjm0El8CYOBQT6otn+ZBB8nYX6ZlBEVPGwU/
 frF6vQbZBYIkDdHtjzRDT1YsBZXzrdeybgIdha5MmUIASEVCbiVRXVHtmnT5VI35Nh7h
 E6YVXHi/oNkUp7twhGnYUu8t0uhOOTCBz/RzWwfEeUZ2M6FWr3RvkKGCl/O22aS3LAfo
 Zr+bOQbFsP9uKpVN5k6q730ZFgtu9WaXTdmiA4KtrnDPg7EvSKYvpBBZTxPV96Sd2DrT
 O+eA==
X-Gm-Message-State: AOAM531CMAJyZ7k/dH7Fs6cVpvcoMMQzHIixhKKaduC6Ln+lkRqEO3zS
 WNC5h1J38EgySDTqq/Mph0hJoY35dU8=
X-Google-Smtp-Source: ABdhPJwRkbwt64+1WsO53KCSGp0gY4jt27b1b4sOgvKPpIWS1rJit2eDmXAgNO3SA82056PUg0K6Sw==
X-Received: by 2002:a05:600c:2047:: with SMTP id
 p7mr979653wmg.168.1601570608415; 
 Thu, 01 Oct 2020 09:43:28 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h3sm10733059wrq.0.2020.10.01.09.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:43:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] qdev-monitor: Display frequencies scaled to SI unit
Date: Thu,  1 Oct 2020 18:43:21 +0200
Message-Id: <20201001164322.1585392-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001164322.1585392-1-f4bug@amsat.org>
References: <20201001164322.1585392-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 9f2ff99c7f2 ("qdev-monitor: print the device's clock
with info qtree") we can display the clock frequencies in the
monitor. Use the recently introduced freq_to_str() to display
the frequencies using the closest SI unit (human friendlier).

Before:

  (qemu) info qtree
  [...]
  dev: xilinx,zynq_slcr, id ""
    clock-in "ps_clk" freq_hz=3.333333e+07
    mmio 00000000f8000000/0000000000001000

After:

  dev: xilinx,zynq_slcr, id ""
    clock-in "ps_clk" freq_hz=33.3 MHz
    mmio 00000000f8000000/0000000000001000

Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qdev-monitor.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index e9b7228480..a0301cfca8 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -747,11 +747,13 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
         }
     }
     QLIST_FOREACH(ncl, &dev->clocks, node) {
-        qdev_printf("clock-%s%s \"%s\" freq_hz=%e\n",
+        g_autofree char *freq = NULL;
+
+        freq = freq_to_str(clock_get_hz(ncl->clock));
+        qdev_printf("clock-%s%s \"%s\" freq_hz=%s\n",
                     ncl->output ? "out" : "in",
                     ncl->alias ? " (alias)" : "",
-                    ncl->name,
-                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
+                    ncl->name, freq);
     }
     class = object_get_class(OBJECT(dev));
     do {
-- 
2.26.2


