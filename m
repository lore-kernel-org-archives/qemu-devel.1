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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B50C8300D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032292137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mosi9aoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032292137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Lz-0005WZ-SC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IX-0008DL-Tz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IR-00017t-If
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:05 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b]:41706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jU6IR-00017d-5I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:19:59 -0400
Received: by mail-lf1-x12b.google.com with SMTP id u10so744954lfo.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OIrWCjv3YCoAXpqwetGuNZL8wxZClcfAMwDABAcwnXE=;
 b=Mosi9aoXyMkPX51GSWdICQ1lgWyATJgquOiR9QCOFFdVCLZttAnkaxHhGLNxuk10fY
 eqvccS6DX1gOCJ3dNSZceIqIvA2D7bGL+Fa0A7fsNFA5/WcLsRZAhEozFVxf7BZl+pEU
 R8neYkfFHwHHZJ6N24zhsFKjskqLKbpU40sHtRZwp9xbqSria9JJ7te/eDk8PI1e6/SE
 fWnl5BGshDA5W2bCqeGvgZT96MQAuW7YQ/cx6hdVmIunjdPwRd3eV7OvJpq00KjKQBjw
 RHvJ1H+bMLtLlm5IksebAst5SZ9bqa50aMisieZ4cCPAEwWmWr5CMTyL/yXbGoAfF8aL
 RO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OIrWCjv3YCoAXpqwetGuNZL8wxZClcfAMwDABAcwnXE=;
 b=Y3WWUekcwaHYL/SSGl8h96hgbge/ayCbHxlrmL7iUi/zbt3Iqf2B06KT7a8yMURTnH
 vF806puVxt2D3abAHETRytNJjKW7FduUtue7NeeRpfYuOn6SyyIVBxAh/9XQoTW1uIld
 py7ej2/21lZ91UV8Yxn6pqmQRSX29F1fKSPT5v0XF/YCqsh2OfQ4iv6Ko/lHFgjyLxI/
 Fx+Hex1j4qOzQSX3R73rMevUR/QiAE2LztoULcxqmZYEMdx8DYyVyugre4Cks3JVqWId
 dlJ/tPGNB6o3lcDiV8x67q+j97uhp0MPKBR59/eRCw5i0DLqHTlrlzjexqG3ncQ9trt4
 SQ7Q==
X-Gm-Message-State: AGi0PuZOATaE7l1t7RXPSl69e2zgHRA/njHkofpLlZg5SwOWhZ0MWT4Q
 8LBpY3YEHiE4PZCIwnr/Z7hVsEZPgSI=
X-Google-Smtp-Source: APiQypKsgRxyPfcYyGS8fWoR0MkCLIIdYYFrNL6DnvoUehWu6+Ks6XfWdktOAVA7kEaQsMSY/cwZxQ==
X-Received: by 2002:a19:d84:: with SMTP id 126mr1696739lfn.35.1588241997205;
 Thu, 30 Apr 2020 03:19:57 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 24sm4205632ljv.3.2020.04.30.03.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 03:19:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 4/6] target/microblaze: Add the unaligned-exceptions property
Date: Thu, 30 Apr 2020 12:19:47 +0200
Message-Id: <20200430101949.7754-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430101949.7754-1-edgar.iglesias@gmail.com>
References: <20200430101949.7754-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::12b
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

Add the unaligned-exceptions property to control if the core
traps unaligned memory accesses.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h       | 1 +
 target/microblaze/cpu.c       | 4 ++++
 target/microblaze/translate.c | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3c07f9b3f7..ef9081db40 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -306,6 +306,7 @@ struct MicroBlazeCPU {
         bool illegal_opcode_exception;
         bool opcode_0_illegal;
         bool div_zero_exception;
+        bool unaligned_exceptions;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 4211f50c11..585e60e817 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -211,6 +211,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  PVR2_DIV_ZERO_EXC_MASK : 0) |
                         (cpu->cfg.illegal_opcode_exception ?
                                                 PVR2_ILL_OPCODE_EXC_MASK : 0) |
+                        (cpu->cfg.unaligned_exceptions ?
+                                                PVR2_UNALIGNED_EXC_MASK : 0) |
                         (cpu->cfg.opcode_0_illegal ?
                                                  PVR2_OPCODE_0x0_ILL_MASK : 0);
 
@@ -284,6 +286,8 @@ static Property mb_properties[] = {
                      cfg.illegal_opcode_exception, false),
     DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
                      cfg.div_zero_exception, false),
+    DEFINE_PROP_BOOL("unaligned-exceptions", MicroBlazeCPU,
+                     cfg.unaligned_exceptions, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b4a78551ef..20b7427811 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -995,7 +995,7 @@ static void dec_load(DisasContext *dc)
     v = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
 
-    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
         TCGv_i32 t0 = tcg_const_i32(0);
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
@@ -1110,7 +1110,7 @@ static void dec_store(DisasContext *dc)
     tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
 
     /* Verify alignment if needed.  */
-    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
         TCGv_i32 t1 = tcg_const_i32(1);
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
-- 
2.20.1


