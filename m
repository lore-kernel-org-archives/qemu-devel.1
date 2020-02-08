Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93460C35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619CF21741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijJgiTKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619CF21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43407 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TVS-0006RZ-GM
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPo-0005Yq-1v
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPm-0001fX-Vk
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:07 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPm-0001f3-PX; Sat, 08 Feb 2020 11:57:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id k11so2466522wrd.9;
 Sat, 08 Feb 2020 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ARVdXcT1NUZV1xpoAwVDWgKAlJcTG5+YbJyusfS3GjE=;
 b=ijJgiTKHPkl0o8pwZXJeJc1kNWcCUxWxXvDUnNyveK4yvd+icdEum0EEEThDv7VJDM
 iNnCFW2kpLyu2Ku0M6i62CqVde6Cgtm9TtTq682nphG4PtUTfNm9wYEkTHXL2NyxCW9z
 1uE2HhCCWrlE3dIgFO2q9nBfzeLq1vC46uBZM2WCXUMRnd205caOVDD1Yhng57pkijNU
 rYC3KhZ9QpQNTYwlWUcZXwYqznQ1KyA3nSigI7QA6iUykXgcrhsYg8IGXzST812I3N2+
 JAkchoet2ynUjZSm4AeZSdQvZ2kqPKp5ipyPRoCJkSkHEWy19SL12HLrk5tn5yppVZps
 MP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ARVdXcT1NUZV1xpoAwVDWgKAlJcTG5+YbJyusfS3GjE=;
 b=rNiEsGccgE3RUv/07B58a3PLY5R/UERstmuHVdeWGO2m3zBUZKyMLp6Fx/i9Fi4yNg
 /mJLOGSNMHYaSIMtC1D5u7V7Omi5HVyrrrpSpUYwwTdrDsuZ3BdZ9dqFDclO6QR3InOu
 VCAr6FZaAk4UI3EPbA6E9yOq69j4nzeED36Jfj9Zx1XyX7IQB96jUe0gXE+YSL8Sp76g
 mvKIv003MLy6WlfKuCwAve5XQ1/IUBT2WOwTZkiG5NILxGpUqr1gsSqF+C7gEUZP8vyg
 KFCCg+n/HgOmHRFk6YJkO8IichWMxzI0E8wUGI1+nwvGoZW7dSyN4O5WvpmWOFcV3iiH
 HFeQ==
X-Gm-Message-State: APjAAAX4uJwg6h+0117iiksPnyxyAtcafDCy9mS/mN+ksmXbQb4nWp75
 stHkNYdeRI7YtULbOn4BeYskUP/R
X-Google-Smtp-Source: APXvYqwnP/wvp6aHo+8Q37idXC6lsQN8OJb9+ce5fAUBbek4gLD7JLpGyHgR25nZ5TOGiBwF6XSTdQ==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr6312639wrw.313.1581181025603; 
 Sat, 08 Feb 2020 08:57:05 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/13] hw/arm/raspi: Extract the version from the board
 revision
Date: Sat,  8 Feb 2020 17:56:35 +0100
Message-Id: <20200208165645.15657-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the board version. Add a helper
to extract the version, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 818146fdbb..f285e2988f 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
+#include "hw/registerfields.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
@@ -37,6 +38,28 @@ typedef struct RasPiState {
     MemoryRegion ram;
 } RasPiState;
 
+/*
+ * Board revision codes:
+ * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/
+ */
+FIELD(REV_CODE, REVISION,           0, 4);
+FIELD(REV_CODE, TYPE,               4, 8);
+FIELD(REV_CODE, PROCESSOR,         12, 4);
+FIELD(REV_CODE, MANUFACTURER,      16, 4);
+FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
+FIELD(REV_CODE, STYLE,             23, 1);
+
+static int board_processor_id(uint32_t board_rev)
+{
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    return FIELD_EX32(board_rev, REV_CODE, PROCESSOR);
+}
+
+static int board_version(uint32_t board_rev)
+{
+    return board_processor_id(board_rev) + 1;
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -164,9 +187,10 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
 
-static void raspi_init(MachineState *machine, int version)
+static void raspi_init(MachineState *machine, uint32_t board_rev)
 {
     RasPiState *s = g_new0(RasPiState, 1);
+    int version = board_version(board_rev);
     uint32_t vcram_size;
     DriveInfo *di;
     BlockBackend *blk;
@@ -192,7 +216,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
@@ -216,7 +239,7 @@ static void raspi_init(MachineState *machine, int version)
 
 static void raspi2_init(MachineState *machine)
 {
-    raspi_init(machine, 2);
+    raspi_init(machine, 0xa21041);
 }
 
 static void raspi2_machine_init(MachineClass *mc)
@@ -238,7 +261,7 @@ DEFINE_MACHINE("raspi2", raspi2_machine_init)
 #ifdef TARGET_AARCH64
 static void raspi3_init(MachineState *machine)
 {
-    raspi_init(machine, 3);
+    raspi_init(machine, 0xa02082);
 }
 
 static void raspi3_machine_init(MachineClass *mc)
-- 
2.21.1


