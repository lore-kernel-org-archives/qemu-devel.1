Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0885DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC50F2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlTVE+NT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC50F2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hvj-0004I8-OZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqs-0002BG-Bs
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqp-00054W-LU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so15593441wrw.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+1f1xYxQv9iAMf0ZcH5rNUu+lZAXATbXmvjHTkMEv7U=;
 b=dlTVE+NTmghw64Lm+wnYk7TGn1R4Vp8z1aApw6/X43aXHgpmkZ1oVzYc5QaXBBpjDr
 ihLmeb87Qr7vOU92Fp7c5YGzgEe5VqZ5ZatXJo62BadiymvmOFJ5q1Xvx9yPuqWa5cFd
 MEi2EMV7lg6nrWX/VrW+4gEqFTBRQuMHmsyh3BmqVWdtKxOORfXL3/WlWNfB6MGqItQr
 YCagRSzKNoH0WAm86s2VLDEfpOitB7DVs0H1108shX4nl5mVcCKTGi3sEKbAAT3+j+3f
 dk1J7nKCPMhO+ot7+Ti1nvNXKeWy+BmPKNs3fkoHcJF+YAVgVxhj1ZWP+tKgoTZSBHxE
 u5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+1f1xYxQv9iAMf0ZcH5rNUu+lZAXATbXmvjHTkMEv7U=;
 b=rk4/W7V8NOBaHVVpF5C7HWiSLVVX5KlqU7LiO+q3xKlQ3vtnjJcvNQhf5kHenDuFHN
 W1LtxpUsdKI4Gy745CMKdUIqgkBNRTiEb5mQfP+zqGWKhNrI3/iR/FT7TeHGKi7bb4f6
 z+0dj+CfC2dXQ3GjiTw+XFRYgVIwgYkdxPJaPz+8dNt8SqvUUhIcEsVWvq+quGSIQtI3
 L99GTPkw8dVeKOPfmOAjVUgGtIlFf+VWo4Ns9lAOCCW/E+p9s2+mY1UZTcIoH8V7ebOY
 RhigbEPAI9p7TXFE7tvEsTzJ+lH/eEgYKwnMHB/kUqw5wLOy53Ruc4gEJdqm3NhRT6RF
 qnJg==
X-Gm-Message-State: AOAM530gupWXJYFdctpVpn3Fs3LuRZiGKuz1TdbKIXcJrOcT6WBjSkSl
 rYav1a8sRXiRo1pmBZ6tQg1CW0hElTk=
X-Google-Smtp-Source: ABdhPJzxt76j2R+ep+UDuNQLpMDcMPvtFOCnNPo19YCT/sZBR2a2iWQGumzWTC2vE49T7iAghUcYmw==
X-Received: by 2002:adf:e90f:: with SMTP id f15mr16467437wrm.18.1597681150116; 
 Mon, 17 Aug 2020 09:19:10 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:19:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 9/9] hw/misc/interleaver: Display subregions in 'info
 mtree'
Date: Mon, 17 Aug 2020 18:18:53 +0200
Message-Id: <20200817161853.593247-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement the MemoryRegion::subregions_description() handler to
be able to display the inverleaved memory regions:

  $ qemu-system-sh4 -M none -monitor stdio \
    -device mmio-testdev,address=0x00000000 -monitor stdio
  address-space: memory
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-000000001fffffff (prio 0, i/o): testdev
        0000000000000000-00000000000007ff (prio 0, ram): testdev-sram
        0000000010000000-0000000017ffffff (prio 0, i/o): interleaver-container
          0000000011608000-00000000116081ff (prio 0, i/o): interleaver-16x8
          0000000011608000-00000000116081ff (prio 0, i/o):   8-bit access on 'sram-p0'
          0000000011608000-00000000116081ff (prio 0, i/o):   8-bit access on 'sram-p1' (8-bit shifted)
          0000000013208000-00000000132083ff (prio 0, i/o): interleaver-32x8
          0000000013208000-00000000132083ff (prio 0, i/o):   8-bit access on 'sram-p0'
          0000000013208000-00000000132083ff (prio 0, i/o):   8-bit access on 'sram-p1' (8-bit shifted)
          0000000013208000-00000000132083ff (prio 0, i/o):   8-bit access on 'sram-p2' (16-bit shifted)
          0000000013208000-00000000132083ff (prio 0, i/o):   8-bit access on 'sram-p3' (24-bit shifted)
          0000000013216000-00000000132161ff (prio 0, i/o): interleaver-32x16
          0000000013216000-00000000132161ff (prio 0, i/o):   16-bit access on 'sram-p0'
          0000000013216000-00000000132161ff (prio 0, i/o):   16-bit access on 'sram-p1' (16-bit shifted)
          0000000016408000-00000000164087ff (prio 0, i/o): interleaver-64x8
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p0'
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p1' (8-bit shifted)
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p2' (16-bit shifted)
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p3' (24-bit shifted)
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p4' (32-bit shifted)
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p5' (40-bit shifted)
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p6' (48-bit shifted)
          0000000016408000-00000000164087ff (prio 0, i/o):   8-bit access on 'sram-p7' (56-bit shifted)
          0000000016416000-00000000164163ff (prio 0, i/o): interleaver-64x16
          0000000016416000-00000000164163ff (prio 0, i/o):   16-bit access on 'sram-p0'
          0000000016416000-00000000164163ff (prio 0, i/o):   16-bit access on 'sram-p1' (16-bit shifted)
          0000000016416000-00000000164163ff (prio 0, i/o):   16-bit access on 'sram-p2' (32-bit shifted)
          0000000016416000-00000000164163ff (prio 0, i/o):   16-bit access on 'sram-p3' (48-bit shifted)
          0000000016432000-00000000164321ff (prio 0, i/o): interleaver-64x32
          0000000016432000-00000000164321ff (prio 0, i/o):   32-bit access on 'sram-p0'
          0000000016432000-00000000164321ff (prio 0, i/o):   32-bit access on 'sram-p1' (32-bit shifted)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/interleaver.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/misc/interleaver.c b/hw/misc/interleaver.c
index 46099e9e11..5cedcb3541 100644
--- a/hw/misc/interleaver.c
+++ b/hw/misc/interleaver.c
@@ -112,6 +112,34 @@ static MemTxResult interleaver_write(void *opaque,
     return r;
 }
 
+static GStrv interleaver_subregions_description(const MemoryRegion *mr)
+{
+    InterleaverDeviceState *s = container_of(mr, InterleaverDeviceState, iomem);
+    InterleaverDeviceClass *idc = INTERLEAVER_DEVICE_GET_CLASS(s);
+    gchar **descs = g_new(gchar *, idc->mr_count + 1);
+    unsigned output_access_bits = idc->output_access_size << 3;
+    size_t i;
+
+    for (i = 0; i < idc->mr_count; i++) {
+        if (i) {
+            descs[i] = g_strdup_printf("  %u-bit access on '%s'"
+                                       " (%zu-bit shifted)",
+                                       output_access_bits,
+                                       s->mr[i] ? memory_region_name(s->mr[i])
+                                                : emtpy_mr_name,
+                                       i * output_access_bits);
+       } else {
+            descs[i] = g_strdup_printf("  %u-bit access on '%s'",
+                                       output_access_bits,
+                                       s->mr[i] ? memory_region_name(s->mr[i])
+                                                : emtpy_mr_name);
+        }
+    }
+    descs[i] = NULL;
+
+    return descs;
+}
+
 static void interleaver_realize(DeviceState *dev, Error **errp)
 {
     InterleaverDeviceState *s = INTERLEAVER_DEVICE(dev);
@@ -139,6 +167,7 @@ static void interleaver_realize(DeviceState *dev, Error **errp)
     }
     memory_region_init_io(&s->iomem, OBJECT(s), &idc->ops, s,
                           idc->name, s->size);
+    s->iomem.subregions_description = interleaver_subregions_description;
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
 }
 
-- 
2.26.2


