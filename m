Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9525C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23552086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkCKGW00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23552086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza6T-0006Gk-Ab
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxz-0005EA-Rx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxx-0007vX-NA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxw-0007nu-4P; Mon, 19 Aug 2019 01:12:24 -0400
Received: by mail-pf1-x444.google.com with SMTP id w16so452419pfn.7;
 Sun, 18 Aug 2019 22:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=VEJB+HxL2ZrMa+PdqWbMrKQ++EGFdXzRJFd60wjp4Xw=;
 b=bkCKGW0002EcdSdhNrnmBn8rPWBa95djQ/Et3RSJgI1u8JTbaUPnLmX98i3WR3W7sZ
 wlq5DYXIiARwF4ucZ2K2Ad5iYKzJIuZTPVcCNLgfDmyslvxj3wE63aWoGKrbxlx0gvuq
 b97GKg9qd15+1DaYBRxOaz0MG9fIuxbRLW3ek3PCcvALjaOjAzlHnbeSLZD0qvGSyO9G
 3dVd6JWazGuqu9mgvkgY7GvREzS/vhQr9y7eGbluX2BZ7P/DzesI2FfNnndF6dBjrzbX
 vUHnagEavWBDnqBruLsXfDX1RSBy/CY+rf3jfAyCF9meOVBzoe7UZLUbOlABcnnhPwXs
 tn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=VEJB+HxL2ZrMa+PdqWbMrKQ++EGFdXzRJFd60wjp4Xw=;
 b=momVPzlCW+SfHYMPb1jYZbgj7D3mbwvBPTNN1chmlyJNzwqcqjD0YjLK+xEIQjZC1x
 +cbPwuvRshr/Jpf2XXs5Anky7M40OmSWEFgraStsDb0VKiKmDCkUYD33TMyKA+MWVP/P
 pYMtKu4Byslk/IzZrXgxoLt6FZD8ooKr4iCsoRcBZLdBJtAZOvPQviQSTHHPL+JTvS/K
 AnQ+jITGAjgZ5HEpyBhl8cnSjln7fZxFnWTFOZUD9XvtICkb+TGCwEtLorRNOjoM9ncO
 q2kv01j2X4qSMbCEaadgt+LR8BbX/lmQ1y9ywle5CSkDCaTUHMXZAacGMCjprIORXV/5
 Ah9g==
X-Gm-Message-State: APjAAAWFjh8BQNC23KXCEMvmxE5SyeeWBs9t7QVnW/iVK97v+G60mhWI
 msstzCEK0Y34s0jvuM1vMCE=
X-Google-Smtp-Source: APXvYqwm3ysD41xzE1AgxVRbYwVna6NwrJFjGev3WtKVA95zx+KN+O2IMiXkkC9hxZ2hwH6vRe4dgg==
X-Received: by 2002:a62:1715:: with SMTP id 21mr22525457pfx.134.1566191543338; 
 Sun, 18 Aug 2019 22:12:23 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.22
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:22 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:48 -0700
Message-Id: <1566191521-7820-16-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 15/28] riscv: sifive_u: Set the minimum
 number of cpus to 2
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not useful if we only have one management CPU.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v4: None
Changes in v3:
- use management cpu count + 1 for the min_cpus

Changes in v2:
- update the file header to indicate at least 2 harts are created

 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0e5bbe7..a36cd77 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,8 +10,8 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  *
- * This board currently generates devicetree dynamically that indicates at most
- * five harts.
+ * This board currently generates devicetree dynamically that indicates at least
+ * two harts and up to five harts.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -485,6 +485,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
     mc->desc = "RISC-V Board compatible with SiFive U SDK";
     mc->init = riscv_sifive_u_init;
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
+    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
-- 
2.7.4


