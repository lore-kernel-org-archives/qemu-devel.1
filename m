Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F33C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F9E207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZwx6qET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F9E207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYoq-0002G9-Kh
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkC-00046V-Di
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkB-0007Wd-Ib
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c3so20036973wru.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=idot/QDNLgKUfkv/Kifwf1j/trErlW/RBMlHKACXiRc=;
 b=QZwx6qETfdfmbSCN+2wAvaFhzrcVKRUBv815jN/puBVbS/f4vxAbRdUdK0tOqkkAlq
 daqJAiQgvgL7U1j7bC3yEmM56jtHVc8hhl0h4CSHuew/0mJAlmEnkakMQkyp/tDICSo7
 P1kZR0dDrFOkNs3CfsehMM4mYKcu+qRjjL0v6i9SWGMqFyhKzBTCW3aXSWS8a/JDbvVJ
 FranaQywWzzACMtOWr9dRMVv6V8mHEtAb0NnIZWMj3YHMzkZip5nLMKnyUv24VhMiZCT
 UG7dDljh1oEYp1z5h8NGFvSM1qsHroMAoRU7enAPS9isFBi+22lfrfyd8WqP5/BQR03I
 N5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=idot/QDNLgKUfkv/Kifwf1j/trErlW/RBMlHKACXiRc=;
 b=ht1cSa2fWL+hPEM7sfD3VTbjCc0l8pIJXSqPGIund7qQJxy+H55jLFqGcAC7ol8ctI
 JoK56BhwzuoF2tIaET8k1Ln1ByGc/715Hd0QAN4fvpmIp6veDVPtQJvQjzlY2S0imumw
 /uDlFqGVRWFgm/E5sTxJBdfgBfsHzST9ogU9Kis01AyZO0WM2EqbG+5Pt0iEY6RyiNiD
 Df62Xdip3kkXNCQMaP1dgOKGbIzefgIo0/MsyYRdMUjUcnpZClFXvVjvG+0/Sj6Ui3Fq
 jUbS8iLUxnY+gynSSN7uAQpUGlqDXjub3hTky4bIOajgHFpNdu6YAtYHh4kVxs0QedQa
 CNiA==
X-Gm-Message-State: AOAM533WPq2iiQFHQD/xL2lgV7G7c+H+yvR/+WEuVthYR5Irm2VdGFHz
 lR/vIq0psxH4ZaxFfXC7RwYsQ+sz
X-Google-Smtp-Source: ABdhPJwJQwE4R2E7g8IVAZOdrJEj08ziEHbiTwKnbzLe3Lx35icAesQrd8wFOI/cNlyEfUepOdSpTg==
X-Received: by 2002:adf:b348:: with SMTP id k8mr3167562wrd.157.1591687941923; 
 Tue, 09 Jun 2020 00:32:21 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] hw/misc/empty_slot: Convert debug printf() to trace event
Date: Tue,  9 Jun 2020 09:32:03 +0200
Message-Id: <20200609073214.14079-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200510152840.13558-6-f4bug@amsat.org>
---
 hw/core/empty_slot.c | 19 ++++++++-----------
 hw/core/trace-events |  4 ++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 576b276c4b..d28f7f99c9 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -14,15 +14,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "hw/empty_slot.h"
-
-//#define DEBUG_EMPTY_SLOT
-
-#ifdef DEBUG_EMPTY_SLOT
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("empty_slot: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#include "trace.h"
 
 #define TYPE_EMPTY_SLOT "empty_slot"
 #define EMPTY_SLOT(obj) OBJECT_CHECK(EmptySlot, (obj), TYPE_EMPTY_SLOT)
@@ -38,14 +30,19 @@ typedef struct EmptySlot {
 static uint64_t empty_slot_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    DPRINTF("read from " TARGET_FMT_plx "\n", addr);
+    EmptySlot *s = EMPTY_SLOT(opaque);
+
+    trace_empty_slot_write(addr, size << 1, 0, size, s->name);
+
     return 0;
 }
 
 static void empty_slot_write(void *opaque, hwaddr addr,
                              uint64_t val, unsigned size)
 {
-    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
+    EmptySlot *s = EMPTY_SLOT(opaque);
+
+    trace_empty_slot_write(addr, size << 1, val, size, s->name);
 }
 
 static const MemoryRegionOps empty_slot_ops = {
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 1ac60ede6b..bbb68fb6f0 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -34,3 +34,7 @@ clock_disconnect(const char *clk) "'%s'"
 clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
 clock_propagate(const char *clk) "'%s'"
 clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
+
+# empty_slot.c
+empty_slot_read(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "rd addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
+empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
-- 
2.21.3


