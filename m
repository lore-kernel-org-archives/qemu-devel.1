Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF2FC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183AB20787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huUnGmF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183AB20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Jw-0001sT-Tu
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IW-0008Bp-9r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IP-00017I-4w
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:04 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:38623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jU6IO-00016v-Lu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:19:56 -0400
Received: by mail-lj1-x234.google.com with SMTP id e25so5884131ljg.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WFSocXCxBymnF1MvynrViesDS2ZIgpy+8V/Y8WL70Qw=;
 b=huUnGmF+7FvJsaC572x4H4NxH0s6xGpOl5Rjk3w/5yPFmi08/lCVgwmnvGGG5wM9Te
 eeKgjxwz3XCm+SK/qsJZ9/ABBKmYzJz2XghfUv3HCbyuByeQfL9WWk82TvZ8+22hkXTY
 O69r3ohmCP6tm+OAn6T5XAddJA6QF12g/qLGLydYWnUs+S4kToBN6hnwqzj0p81Zp7MH
 BhCpj44KX3MPV/ho/LTHCzG5tfFVwEmbI4Q/sr9w7yC2WaY12C5h+nmN7NimuC6qbomy
 mR7lszOMwec8fZidiz51KTxrUhzF4nQ9dqserzwnueMRuQG2ogNhOyft9Ev0Kly9n3rS
 cEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WFSocXCxBymnF1MvynrViesDS2ZIgpy+8V/Y8WL70Qw=;
 b=Z7Q/H581X4oFpIJYWjf9HiiDH8vBqonLS0+Ft09zGS0y1dxZnfqyJYR/n5ixqX1oVm
 YaG9yXSZH/jwlE7dYDbqMNF+6+E9QEBcsi41weRlTGDtlbQpLa4KC5KgtT1BZ5RrV9rb
 emVuV8tO5YD/IpbeI+3A8XWtRgjYMKRdH03PkwwMd5SodXCwW3HX3jbDD4//msfQUSU7
 B9ptksVtIoPCDOcrC3zRdpHrWdpNN9WTpTfvwpE1oWYpAzrNjXSYNxzw9tgaRa4JWyh7
 DRdT2kew1vegOz0nhESfgoYRv7mYI5yjmpQ+JU0kSg9+qYij0aSVm3i/AjR/r2AnZ20D
 TDRQ==
X-Gm-Message-State: AGi0PubQdXt6JZ4cLlM7wOTiwGwDMZnUsSnZcYCWSYIw342ngIrKO8tN
 ei5lIimy97LQmpJQaayeUBwvj+RWCNg=
X-Google-Smtp-Source: APiQypLENNIAdSp/g0oKbeqwiYOVw5DL5Rjn1lJzTuDT+B6hTnfUQxkRjiDB7UUqcgTyqE4O17GBDQ==
X-Received: by 2002:a2e:5847:: with SMTP id x7mr1718855ljd.61.1588241994777;
 Thu, 30 Apr 2020 03:19:54 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a15sm3998823ljb.37.2020.04.30.03.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 03:19:54 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 2/6] target/microblaze: Add the ill-opcode-exception property
Date: Thu, 30 Apr 2020 12:19:45 +0200
Message-Id: <20200430101949.7754-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430101949.7754-1-edgar.iglesias@gmail.com>
References: <20200430101949.7754-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::234
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the ill-opcode-exception property to control if illegal
instructions will raise exceptions.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h       | 1 +
 target/microblaze/cpu.c       | 4 ++++
 target/microblaze/translate.c | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d51587b342..71d7317a58 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -303,6 +303,7 @@ struct MicroBlazeCPU {
         bool endi;
         bool dopb_bus_exception;
         bool iopb_bus_exception;
+        bool illegal_opcode_exception;
         bool opcode_0_illegal;
         char *version;
         uint8_t pvr;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 418a0cd1fa..2cc6b1513c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  PVR2_DOPB_BUS_EXC_MASK : 0) |
                         (cpu->cfg.iopb_bus_exception ?
                                                  PVR2_IOPB_BUS_EXC_MASK : 0) |
+                        (cpu->cfg.illegal_opcode_exception ?
+                                                PVR2_ILL_OPCODE_EXC_MASK : 0) |
                         (cpu->cfg.opcode_0_illegal ?
                                                  PVR2_OPCODE_0x0_ILL_MASK : 0);
 
@@ -276,6 +278,8 @@ static Property mb_properties[] = {
     /* Enables bus exceptions on failed instruction fetches.  */
     DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
                      cfg.iopb_bus_exception, false),
+    DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
+                     cfg.illegal_opcode_exception, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 222632b670..b4a78551ef 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -185,7 +185,7 @@ static void write_carryi(DisasContext *dc, bool carry)
 static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE_FLAG)
-        && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
+        && dc->cpu->cfg.illegal_opcode_exception) {
         tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
-- 
2.20.1


