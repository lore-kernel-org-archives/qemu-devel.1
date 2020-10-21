Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F7C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A2E2242F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMcvC8yP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A2E2242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIEL-0007Do-FZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1h-0004CH-Gh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1d-0006IA-PV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id a72so2992637wme.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p6WWIsaS0I3UntqPKdZpY4UhujIkCcQKP7e4gj992fw=;
 b=XMcvC8yPcH2DqQ0sZMxPYfcTa/pHDgm6brwx7QDW247J4Q4vNCJOSJ0RlfHoRqmECS
 UBgK71S/JGHsz1wGj4e2hO0wVXjqC8c4cADVY1S1liSc8fxDiNSFAaAgfIMGZYl5oEad
 ew2ljuNIQp/xhDjs4LXuKvzWZfaoMaJGwjv93v8aBycHV+El5i7DfNLunIILae/oBmJD
 wCfGbqWy6Vg/U8ccDwF+HZrCttruQIfq3aRUjcdvHHULjtUtLotQe8CH074eax1UUPNt
 VaHrNcuLoT+Eo+PXp/4XfMheVI20OgAlU4vAE+mdYrh6VrzopoAkGx5nZxmKL69eKACk
 3Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p6WWIsaS0I3UntqPKdZpY4UhujIkCcQKP7e4gj992fw=;
 b=Wj25NE1hUtk5jXZ6JlE8bUvVxs0/FSs+JvT8mqBk/am9uERoA7MHKdTjZH8LhKR9nx
 MqsOHMSzX/wwJXMuEyTxlKduseYzc0utGRQLej6jtwtJ7ZZzxqsSl1n/ixZ9NLK+OZQ5
 UJ/3oISk/1srxD5LrkmQ6rPEVJsZuQIwOh5h07Tdhc0RwyfUzg6hsnoc9iTnQNRbaZDK
 7aYhqb7YNI6ycmkj/Er/o0gz6ZIBEy63M0ANnjJPZtZW15K/ZephotIedazfjvvdpKZn
 wJKcNlgcz+dAkprsoYQJF87/ZmaLS0eGyy43NFtEh7eGRupcg+F6R17Zg3sVP8EF7bV3
 w/pg==
X-Gm-Message-State: AOAM532+OLeen8DliJaImgtaqaZj8UdJTy7omMYP8TYej82JOb6AhfME
 9INLUMgndz+H6egUR5ZCbAU4Or4BynY=
X-Google-Smtp-Source: ABdhPJxo1UigovYRWF8fiNhKTbGbLDxlaK/ujDfESF2lS7IbEhMIoRZP0vI1NAl/iZU+Chx33VrxvA==
X-Received: by 2002:a1c:2d53:: with SMTP id t80mr4451258wmt.125.1603301747614; 
 Wed, 21 Oct 2020 10:35:47 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j7sm5150707wrn.81.2020.10.21.10.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] hw/sd/sdcard: Do not attempt to erase out of range
 addresses
Date: Wed, 21 Oct 2020 19:34:49 +0200
Message-Id: <20201021173450.2616910-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the Spec v3 is not very clear, v6 states:

  If the host provides an out of range address as an argument
  to CMD32 or CMD33, the card shall indicate OUT_OF_RANGE error
  in R1 (ERX) for CMD38.

If an address is out of range, do not attempt to erase it:
return R1 with the error bit set.

Buglink: https://bugs.launchpad.net/qemu/+bug/1895310
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201015063824.212980-6-f4bug@amsat.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ee7b64023aa..4454d168e2f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -766,6 +766,13 @@ static void sd_erase(SDState *sd)
         erase_end *= 512;
     }
 
+    if (sd->erase_start > sd->size || sd->erase_end > sd->size) {
+        sd->card_status |= OUT_OF_RANGE;
+        sd->erase_start = INVALID_ADDRESS;
+        sd->erase_end = INVALID_ADDRESS;
+        return;
+    }
+
     erase_start = sd_addr_to_wpnum(erase_start);
     erase_end = sd_addr_to_wpnum(erase_end);
     sd->erase_start = INVALID_ADDRESS;
-- 
2.26.2


