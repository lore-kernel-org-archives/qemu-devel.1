Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60BC38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7B620B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai+tR+BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7B620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQaex-000400-Vy
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36556 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabL-0006fs-La
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:08 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabI-0003ug-01
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:59 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36340)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQabH-0003s1-JN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:55 -0400
Received: by mail-lf1-x142.google.com with SMTP id w145so8740166lff.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wIXQdHy319V2N/FhegMebf+jwU+zMT4Ec4BdCWpHxiM=;
 b=ai+tR+BPFYl9k+EtpSp+7Gi3HDDEip7g6OPUn1A2iB9YmiZYpjH0+XjEgW08YfBJN4
 YGUjMZJtxO5t+Zse7EA47Fqej4nJSkrcVgJn4+FtIL1d+CrX5CIdODTXg3G8tEAuyrvx
 vSzBamDJb8xjHtt0pPUXN8seQ5wcZ/GhHyOC9PVHkcTpyMzysbiyxBZrnQNXsWcSS45Z
 gZIEv3yQqK5vQG73cGscZ765D45bw5HcX69hzWSA58YcCj3NtASg6TGgk0kkzIGyFlUM
 qRUp8A685U5rY/ERA6YTEtuUtIVBXLb4UHieiMw3gk/Y+ekgNdwrtuLdGSMEBOBIwzJ0
 /Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wIXQdHy319V2N/FhegMebf+jwU+zMT4Ec4BdCWpHxiM=;
 b=BYZHPJmUc/D+ZMkwiUg1zcdW67c9cgphEsTMXxhH0r+7N0mxiBFrOJgpPHMr7h37BA
 VEFhXarWz779qCgpv+zRg4b84RJxtNpoIUp//cexZ9rNr9R7GWcCxfdoSp7d1TvBah9j
 gFaxC7Xk4M4nJmdCIsrNW5Uv375fwVhIIZtvcYRbyGQpnipzaSKylE6aQTJj/vgz80L/
 l7C/yjYyaZLR9ozqNi+6z4Rdmv+bKHcpiM5wYY7mAUPhEo+4z2oFlbLoEcmb8T1+VKVB
 UA5pNIzY7Q5rP8DdDfEDLfuIwYusnZyuL0wRaIFP9tO58kwOq11IfGD8saV/qsG9vBiF
 1bAg==
X-Gm-Message-State: AGi0PuYGMhbhL6QP61xw9yAC9a5l64gygMqYVKZWNueWWi41jX2S0k1E
 PTJIRcYQhHXZD1I7nz1AhSqxV+5ZAR4=
X-Google-Smtp-Source: APiQypKMIC8/93ysyH9iO5UHbooVa7gY3+sk8v0v8Ejj0J20KITGTff3JkyBu6jUGvectqibk83Idw==
X-Received: by 2002:a19:ad45:: with SMTP id s5mr11233854lfd.106.1587405173433; 
 Mon, 20 Apr 2020 10:52:53 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id l12sm83412lfp.35.2020.04.20.10.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 10:52:52 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] target/microblaze: Add the opcode-0x0-illegal CPU
 property
Date: Mon, 20 Apr 2020 19:52:45 +0200
Message-Id: <20200420175250.25777-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420175250.25777-1-edgar.iglesias@gmail.com>
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::142
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the opcode-0x0-illegal CPU property to control if the core
should trap opcode zero as illegal.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 6 +++++-
 target/microblaze/cpu.h       | 1 +
 target/microblaze/translate.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index a2c2f271df..1044120702 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -206,7 +206,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.dopb_bus_exception ?
                                                  PVR2_DOPB_BUS_EXC_MASK : 0) |
                         (cpu->cfg.iopb_bus_exception ?
-                                                 PVR2_IOPB_BUS_EXC_MASK : 0);
+                                                 PVR2_IOPB_BUS_EXC_MASK : 0) |
+                        (cpu->cfg.opcode_0_illegal ?
+                                                 PVR2_OPCODE_0x0_ILL_MASK : 0);
 
     env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
                                         PVR5_DCACHE_WRITEBACK_MASK : 0;
@@ -274,6 +276,8 @@ static Property mb_properties[] = {
     /* Enables bus exceptions on failed instruction fetches.  */
     DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
                      cfg.iopb_bus_exception, false),
+    DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
+                     cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 1a700a880c..d51587b342 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -303,6 +303,7 @@ struct MicroBlazeCPU {
         bool endi;
         bool dopb_bus_exception;
         bool iopb_bus_exception;
+        bool opcode_0_illegal;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 37a844db99..222632b670 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1573,7 +1573,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
     LOG_DIS("%8.8x\t", dc->ir);
 
     if (ir == 0) {
-        trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
+        trap_illegal(dc, dc->cpu->cfg.opcode_0_illegal);
         /* Don't decode nop/zero instructions any further.  */
         return;
     }
-- 
2.20.1


