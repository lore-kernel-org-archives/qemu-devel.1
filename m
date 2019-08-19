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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E252CC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE0A2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmI6IYBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE0A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza8j-0001Uy-O4
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxz-0005ED-Sg
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxx-0007wI-Ug
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:27 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxx-0007rC-OZ; Mon, 19 Aug 2019 01:12:25 -0400
Received: by mail-pf1-x443.google.com with SMTP id v12so445802pfn.10;
 Sun, 18 Aug 2019 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=k81ZMxLa4YSaXM7FYyGMWZHDjNtien308wLbYNCZJ+o=;
 b=tmI6IYBCjr8i4SjyMjwj494FLifl7mxdRK1UQT2jaGSJ6CGq8/UeRB7LA4LsFH/rRJ
 eqpRXlazWz0sz0GPs7yL1q9ANJ2khpdB7MuRuqONJsUkM7k6d+ZOmuDRSMXBBB8ce6qz
 DVj/VHRkk3bDz16lHKID5/ayniWsYZJYBUY5Sbp0OjSZx9zjDLpMTpb1xfObAIS1fD9Y
 vLKpGVBS3c0BVihrWYEGjR9qZYWyoDQF3eS0Td18UP2STkfnbLgVxqxHOnqRkf0UZcGF
 j52Wq/D8XXzzzYDTRv1L9AcbQVd1G+grgfB0AL9m0FMr43/lXmHup5iS+SBbGla6rxQz
 J/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=k81ZMxLa4YSaXM7FYyGMWZHDjNtien308wLbYNCZJ+o=;
 b=QxiME6bGDktQfHjp0gABt92ZzL5D9YpGlwz8AXPMP3y7wubxRxm+OwsnttZl+feu1R
 HCVKOD7Y83utU/q5RXk7EeuenJs3+KD1F6a3q2znYHPalGm5f0GreeuxpTn0aCD30zJu
 GTiNW8eUKHdL5BTOsze1qxkVIQQhH3BizEvVsvrPw6vcO0jez2QEQPnnTmZjNO0/tPFR
 xZJe76h4eE5QLXMZHn0ALp2bWVikspcnX+gAcnoBWCcQK+YF1d27lsGbTYohSf02OuyS
 2ECDUNF5sr8QVLNVp7vhBYSfKVK+ai0BEr9RElccdXvtcmk9RFXc/PSqBCW39BjGSJIw
 ap7w==
X-Gm-Message-State: APjAAAWpGAtVsFSaPz2ab4j3bL7AnOcMRDa7wH13NCKn8a5UCQMDtdw9
 bSCGOvfsWeYkicsH8mnfrSE=
X-Google-Smtp-Source: APXvYqysVt1NIlaIbI3+uI4gxK/NVOAB0Tc1IATWihweUyqJ0aVgQXFxYef52FwGpSsRt80c3OkkwQ==
X-Received: by 2002:a17:90a:8081:: with SMTP id
 c1mr19322471pjn.62.1566191544408; 
 Sun, 18 Aug 2019 22:12:24 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.23
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:23 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:49 -0700
Message-Id: <1566191521-7820-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 16/28] riscv: sifive_u: Update PLIC hart
 topology configuration string
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

With heterogeneous harts config, the PLIC hart topology configuration
string are "M,MS,.." because of the monitor hart #0.

Suggested-by: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a36cd77..284f7a5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -433,10 +433,11 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = g_malloc0(plic_hart_config_len);
     for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
-            strncat(plic_hart_config, ",", plic_hart_config_len);
+            strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
+                    plic_hart_config_len);
+        } else {
+            strncat(plic_hart_config, "M", plic_hart_config_len);
         }
-        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
-                plic_hart_config_len);
         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
     }
 
-- 
2.7.4


