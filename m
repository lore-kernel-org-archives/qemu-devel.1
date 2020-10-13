Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616A3C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1301208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld9DCnPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1301208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSRGM-0007If-Su
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREv-000601-Sn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREu-0002su-DR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id e17so951200wru.12
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HzYO5fAKE8c5Bjci2IhRroM8+dk3HQe48ilewjjRlvA=;
 b=ld9DCnPjE7vWNZkoZdiJVRIRto7erUFrMGGYhrszRAFirD4bm2KnxomrVLUeuZN+VI
 BbU6bsdNFwGc9Wjb38r3dwclEvRa1rxST2Lgy85RCs/kLfJZcn2+rrtQLeD9NkYIz81F
 j7N3x6Pe58izObkKcecG7Rv/5FaZ7o+OGz/clR2gV3zRDJbLFkF+y3aRNYEASQeCFRES
 ymknPJIwFr9F3/BXnEcDreqwKe12r54K+L++P5pUvyftOmNaPFQum4Kzsi9VJ3Qa2gfS
 iZHR3v93xTbp7BxiXSJr7v0fODKf7q4nKUcqeDXumck4emgp8OENE0kSBTxRsGNk2ca2
 nVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HzYO5fAKE8c5Bjci2IhRroM8+dk3HQe48ilewjjRlvA=;
 b=URRqjThSiY31hXlvMoQNZTcYHp7Cy+/pzpbALeIlN20/o7oQcjN69Ys8IcExn6H458
 q67m7BhRnHuiUeODWJ8+7NpQJii+dwS4uhuXg6X9SdjPaTLiSlIv8egad43M1LyZoJWv
 CC4Mll2wvYfc7KTbGGNZEHYiIXWCTlsiu0gnFCq6egNgYGNg4p19IxZp1ULnQjCH4xks
 dOt1yj+R9+TWnz4Z3VadShESqLcohVh1ADu7SWa0v8smUUrwxhLrwANNn3zYPuJ94UWB
 32bgixlFXB9CPwsnqeBRl2Sxg6rRt6XXsMYnEaEMTecJBq63Ch3ULuFvfP4XrMIfRJRR
 8m4Q==
X-Gm-Message-State: AOAM531LiUNOCZfCjEjO1+SZZcl2vh1Q3gG84WNbq9jMyiWEagEOxgcG
 dibk2nYKAZE8zHAgJ+x8ma7/ctrGKpQ=
X-Google-Smtp-Source: ABdhPJz5JRXAWCfY6NAPz+3FitbPy8fqAAPotFS1QWJLpU8s3JpglpNbjQX1Ls1aNot3Nen+ZjhCiw==
X-Received: by 2002:a5d:6a0a:: with SMTP id m10mr1640326wru.189.1602622182713; 
 Tue, 13 Oct 2020 13:49:42 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t83sm192680wmf.39.2020.10.13.13.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 13:49:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/misc/mac_via: Use via_irq_request() in via1_VBL(),
 via1_one_second()
Date: Tue, 13 Oct 2020 22:49:27 +0200
Message-Id: <20201013204927.3660030-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013204927.3660030-1-f4bug@amsat.org>
References: <20201013204927.3660030-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

via1_VBL() and via1_one_second() just call the generic
via_irq_request() handler raising a specific IRQ.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/mac_via.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 54088b6625a..00877a42447 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -341,11 +341,8 @@ static void via_irq_request(void *opaque, int irq, int level)
 static void via1_VBL(void *opaque)
 {
     MOS6522Q800VIA1State *v1s = opaque;
-    MOS6522State *s = MOS6522(v1s);
-    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
-    s->ifr |= VIA1_IRQ_VBLANK;
-    mdc->update_irq(s);
+    via_irq_request(v1s, VIA1_IRQ_VBLANK, 1);
 
     via1_VBL_update(v1s);
 }
@@ -353,11 +350,8 @@ static void via1_VBL(void *opaque)
 static void via1_one_second(void *opaque)
 {
     MOS6522Q800VIA1State *v1s = opaque;
-    MOS6522State *s = MOS6522(v1s);
-    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
-    s->ifr |= VIA1_IRQ_ONE_SECOND;
-    mdc->update_irq(s);
+    via_irq_request(v1s, VIA1_IRQ_ONE_SECOND, 1);
 
     via1_one_second_update(v1s);
 }
-- 
2.26.2


