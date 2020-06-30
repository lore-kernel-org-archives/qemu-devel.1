Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7841C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838DF20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKI1u9S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838DF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHeR-00047s-M6
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHct-0000TV-Ea
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:47 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcr-0002U5-V3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:47 -0400
Received: by mail-ej1-x641.google.com with SMTP id o18so16511520eje.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TakACgpmN29DQ1JWs/1VSOQ1s/5rYVVO7B6tdCzInUU=;
 b=EKI1u9S4EBWzEy5MueWfeTKGdD5ZYLr8eCgyE32/7IE5e/AZDXYDg8rU70eaEKlLvx
 NPsTV7joVA/zHQl0XuRO56fhzHeA5XOSKH6rFwuOKnz33GK/XOCozd+BDc6/C5htQXEq
 qTXNtZ5DVahxWZJ+p80+C/JXwEE5xqt+yWLMc7asS0yLvZGMDrUgHeGwV4zkh+tXSNtv
 zht/nAc6RMRlfjlEngYsVqXrnBDluIvowfUcHgpZo81JRRTCxJgu2ZKhJ3gOOGZOOCyz
 FRxQRIG9YWeRV46lPSyq1XLv86yh9E7uT/6PvtA/rc6DvMrKtPSDDTEZd/8mVkiCwOD9
 i27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TakACgpmN29DQ1JWs/1VSOQ1s/5rYVVO7B6tdCzInUU=;
 b=sWtklX1hRVubl5sF4PnoGBGixVxuKs7cr2H7b8yOgYeZKlaS+8w9AT4UMPxRlmUWtt
 +qTpmAbm3hT5dsPHKqLejYy29d0esqHzB7SlXB0BKcp7gUXJt62hwfQ8c8s5cHJd8ugT
 5KyGgxNr6ZFeVv4hGSBfW9zPJv372NQHC5ydKxmPaAvqk66U31EspVM0NYoNzGAUtha2
 lz8YYItVypTnULtpa6AFcORJAL+bsHZzTPXvUJSPS3DqiZmrcAb/uiBDKNZiLVZRxrR2
 8L3vTP6WG0dR1iGl5mPcrlAUuIi6OvXXHnpQOsKe48RscFppIohzHdrQpsJcTI+tC/Yr
 Sz0g==
X-Gm-Message-State: AOAM533jjhKZXFs8nitlnI6zfWjT/BddkZ3ZN9+TjhiZI0CR7Mqs+aAK
 CZNk3nOt1bl+41OqKROEXdE=
X-Google-Smtp-Source: ABdhPJwdbi7yRKtak+Y65S2GSQ6LgCMdhdPPOl6ilArvFqUGANMiPeKgZbibhfUPEvEniZo3toXIAQ==
X-Received: by 2002:a17:906:8401:: with SMTP id
 n1mr18395959ejx.479.1593528764491; 
 Tue, 30 Jun 2020 07:52:44 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p9sm2144569ejd.50.2020.06.30.07.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:52:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Aurelien Jarno <aurelien@aurel32.net>, Yunqiang Su <ysu@wavecomp.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] hw/mips/malta: Verify malta-strict machine uses
 correct DIMM sizes
Date: Tue, 30 Jun 2020 16:52:35 +0200
Message-Id: <20200630145236.27529-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630145236.27529-1-f4bug@amsat.org>
References: <20200630145236.27529-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The machine has 4 DIMM slots. Each DIMM must be a power of 2.
Add a check the total RAM is a good combination of DIMMs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 209237d066..63c1d5ea5f 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -71,6 +71,8 @@
 
 #define MAX_IDE_BUS         2
 
+#define DIMM_SLOTS_COUNT    4
+
 #define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta-base")
 #define MALTA_MACHINE_CLASS(klass) \
      OBJECT_CLASS_CHECK(MaltaMachineClass, (klass), TYPE_MALTA_MACHINE)
@@ -82,6 +84,7 @@ typedef struct MaltaMachineClass {
     MachineClass parent_obj;
     /* Public */
     ram_addr_t max_ramsize;
+    bool verify_dimm_sizes;
 } MaltaMachineClass;
 
 typedef struct {
@@ -1260,6 +1263,12 @@ void mips_malta_init(MachineState *machine)
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
 
+    if (mmc->verify_dimm_sizes && ctpop64(ram_size) > DIMM_SLOTS_COUNT) {
+        error_report("RAM size must be the combination of %d powers of 2",
+                     DIMM_SLOTS_COUNT);
+        exit(1);
+    }
+
     /*
      * The GT-64120A north bridge accepts at most 256 MiB per SCS for
      * address decoding, so we have a maximum of 1 GiB. We deliberately
@@ -1493,6 +1502,7 @@ static void malta_machine_strict_class_init(ObjectClass *oc, void *data)
 #endif
     mc->default_ram_size = 32 * MiB;
     mmc->max_ramsize = 256 * MiB; /* 32 MByte PC100 SDRAM DIMMs x 4 slots */
+    mmc->verify_dimm_sizes = true;
 };
 
 static const TypeInfo malta_machine_types[] = {
-- 
2.21.3


