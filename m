Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEEDC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F82A20678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKyQkm5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F82A20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFuh-0004GS-OU
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 13:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFql-0007us-Hu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqk-0000kw-9z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqk-0000kD-42
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so4407806wrw.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kXtcRU+evWm4ZwyBxV8pmjYNaAs60PlKYV5qf3mHeDM=;
 b=fKyQkm5A5TyB9ooCiKZxDdbvZvj9jS4PZaBW78UD8jhasA98Gsa5ITpQWI9ZyJHJbf
 aXuNYG5l9kctqArIcOb5MY01pAoISbyNuEmGLRNeq8NAKvzfW92q/Ru/KCTBQhcs41pz
 6gODm2CT2B19JcNhcCq4ZR7nSUgAA2mLauyZPLFMwKT5yor96iO0FfXX3sokAWKdihNy
 YPp7a9kuE+Iwmz2hFNCL67m8yWY770JxMsAlBgZmtPpOezwRJ+cCzGNX/S5Rtk8mwvK9
 NWtEySznJIEAaLasNh/C3bweSBC2os8098vZTRmkkfcTR5ks4OGiia1SgrBmNoZSHUR7
 QT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kXtcRU+evWm4ZwyBxV8pmjYNaAs60PlKYV5qf3mHeDM=;
 b=I3I7fgg/ilRYBZ/ZhX2Ljkv7NQqiplnsD/KQINIE0Xqk5fecFvX0Lq2TE3aUPI2L8W
 CMaye+4pbaaPoE4ZMUuJe99XZfE2mVwJ0luaQcvu3KUFucLSDFymiWc4SEBkz2bglff6
 otwVpZss4ckAjin7QJeyjmGSDnMNA4dh9FJ3S2AClm+0P8YduPltZtcdOVBZmYCkRis0
 DlkX9Rxx+COhyrOFetT3nP49XXkOjLEvPh2j91mmuKX0nxtWw6kF+DHge6U4rLacgrjc
 C3pjCY1QGk8ydXe3uNqvASyj9jZqM4rYDs4R2KNRTewm80OdsOlyqh4//puSCrKAt3cY
 q3bg==
X-Gm-Message-State: APjAAAVcP4PgFypWlFEa2d8T93fCABFuvDVXV/R8lA1R3LJbiV9IisKS
 gR7ABjF27XY5H660e8ElWywgfFxe
X-Google-Smtp-Source: APXvYqz5t5Ltixp0Z6P5pMTAyu8pmhlZi4LMoD9ExYhvdEKeO6KNxXDRL/3FfSOd3vnZzT/Z1L9tHA==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr6102580wrv.302.1578507273222; 
 Wed, 08 Jan 2020 10:14:33 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id l19sm2908653wmj.12.2020.01.08.10.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 10:14:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>
Subject: [RFC PATCH 3/3] hw/hppa/machine: Warn when using more than 4095MB of
 RAM
Date: Wed,  8 Jan 2020 19:14:25 +0100
Message-Id: <20200108181425.21485-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200108181425.21485-1-f4bug@amsat.org>
References: <20200108181425.21485-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use SeaBIOS as firmware, and pass the RAM size in a 32-bit
wide register. When using 4GB of RAM, the register is truncated
to 0, SeaBIOS is confused and halts the machine:

  $ qemu-system-hppa -m 4g -serial stdio

  SeaBIOS: Machine configured with too little memory (0 MB), minimum is 16 MB.

  SeaBIOS wants SYSTEM HALT.

Display a warning in case the user is not looking at the serial
console.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/machine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d10c967d06..e74aafea2f 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -159,6 +159,10 @@ static void machine_hppa_init(MachineState *machine)
         exit(1);
     }
     g_free(firmware_filename);
+    if (machine->ram_size > 4095 * MiB) {
+        /* FIXME As we use 32-bit registers, 4GiB is truncated to 0 */
+        warn_report("Firmware might misbehave with 4GB of RAM");
+    }
 
     rom_region = g_new(MemoryRegion, 1);
     memory_region_init_ram(rom_region, NULL, "firmware",
-- 
2.21.1


