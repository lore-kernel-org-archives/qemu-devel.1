Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E0AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C2A2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeNn1QLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C2A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYni-0000wd-R0
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkB-00044s-Bi
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkA-0007WK-Kw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id x13so20071241wrv.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ys/xyxuX8fMwGT919bDlpMl+pENH1CXUCrM9T9iwbXw=;
 b=oeNn1QLxCWPC1oApF8dukZQFJLxTZ043I7lEHsc1mqAgmYh1ujfqS1cCrFDAkYPxNu
 4CXMRjt+F8opiMTeQJl65SOnshYTOAdh9ad70bZUY1VlAWgkKviQuVbVZEFNh1auIkzd
 eEuBZJnGapljPh1EgUXjZoDnboND9kpGN+QiXjG0+t2zSU3SDunqr00cJcKy13F/5X/2
 /dfz1SrUwnpF6y5ZkBGEtLUD60N8iiCD1A4MxyA4mqDzFglJuOCFDIVXrxuVNVhQvTCq
 PiRkXCIcIfmhdpDznyJvnDnr/7aX2GnDiNr9LtT7Nk+0zPzGFN2wwk6QrRTRpGibdKF3
 sEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ys/xyxuX8fMwGT919bDlpMl+pENH1CXUCrM9T9iwbXw=;
 b=liIqZi2x/u3t3+6weIxP4G5WSBx+vfcw4sHwkt+yNJwaXWUU7jK67YwtQicJmhiG+x
 ZRVKVxq4kucTIIK5EjmKVvxBSN4Ks96XSlBWRTSViChF4c/r9ti2nbv3VQB9JFm2LTGq
 zSbQhmy2hI5XlQ4vFGJoos4i/XdnEhP2EXiIjr7156abgCTPclQs7+V2TmUBI1iS8SZB
 sjs53g0Ny6wnzrvP/9KhzIHWprFXiZFBil1yHQ2bNRoO7Ho9GVSYLkex/LzFnOGhijYV
 tca8I0zjG8tCtO84UR8WZ2VVR63TJVvsexRLqhcKpQk7yb11B329bWscyA6InpGrTyJT
 eoCA==
X-Gm-Message-State: AOAM5320M51wY8TLxviPGKUrOWySCXJBn/JtUgFxjwusB2wrVXmOxMTj
 AuT0lPO3Ed70ATGjTnrm95X0wLGU
X-Google-Smtp-Source: ABdhPJyocJu4bPvJg8ncPXYqIVmAMfqDx7bMGoMYAxuMVpNzD7NeqSiQ7nPwKCpvD1XkOSUV1hLlSA==
X-Received: by 2002:a5d:4490:: with SMTP id j16mr3132758wrq.276.1591687940791; 
 Tue, 09 Jun 2020 00:32:20 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] hw/misc/empty_slot: Add a 'name' qdev property
Date: Tue,  9 Jun 2020 09:32:02 +0200
Message-Id: <20200609073214.14079-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
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

Add a 'name' qdev property so when multiple slots are
accessed, we can notice which one is accessed.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200510152840.13558-5-f4bug@amsat.org>
---
 hw/core/empty_slot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 0df086fe98..576b276c4b 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -31,6 +31,7 @@ typedef struct EmptySlot {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    char *name;
     uint64_t size;
 } EmptySlot;
 
@@ -72,13 +73,17 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
 {
     EmptySlot *s = EMPTY_SLOT(dev);
 
+    if (s->name == NULL) {
+        s->name = g_strdup("empty-slot");
+    }
     memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
-                          "empty-slot", s->size);
+                          s->name, s->size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static Property empty_slot_properties[] = {
     DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
+    DEFINE_PROP_STRING("name", EmptySlot, name),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.3


