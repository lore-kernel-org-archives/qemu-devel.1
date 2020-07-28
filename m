Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E12C433F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBCD2075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gSGX97x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBCD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KxI-0005Ej-Sw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwS-0003pq-5X
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:32 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwQ-0000ph-IK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:31 -0400
Received: by mail-pl1-x642.google.com with SMTP id t1so348306plq.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PMPZNC54WFXLzT2HiWdjfPndP8TkMz19Jn6EwJG2AFc=;
 b=gSGX97x+US9ilo8NDO3o9WZrYxXIJBLGGLMkAAULkK0jMmzqf7CAgTxLxm9DJbge1P
 QBSnKlY3R5N6NzbacQskOT3hRLuI0zE53t4hKWXWo7ZX6V1f2Wc5789ol+msOw+WYX+I
 V+cZSfvy1pccsBLhNZYFyXUfIDnOoI0y3wNIXg9QqJdxFojnUMsZD1mOIsfJt4USUpT5
 CMwp0NmjlX0yKWl83bzUXbRTn6HtxFUAl42333s63X7yEGMuSQBMui/fKkNNhADovPjI
 q7ZA38wZxI3R4LnxlwU6x/+vALD3PapPYq/KC83Kd28e6Jjbr4Vk2EZZMGzgFrgNCDE8
 6BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PMPZNC54WFXLzT2HiWdjfPndP8TkMz19Jn6EwJG2AFc=;
 b=e8pjgVtiksYS1Y7zqdEaZukmdsP3NmWqBEJolWPT8zIc6OBvfAyR0LoW0qz32IhKLu
 rEzKOOZ84rINvlKRP+OCavCnJgdU5YoyCP3tZ6thsjgyrfCAMCSb1HNsDR0aFjIXO+E7
 +RmBlL/P5P11VKbYTDt0qto8xAGRZ9prDYZVQzMK36nF/40wpBa87tBEyAlFbOswv9df
 5D2jTJjOeK9EmZnV+zj8PEIJUUbr2RDyXabL08iAmJL7D37IB3/ueUxwa+uqfjpGNkPx
 wn3LVEzXWdFna1du9klrsAlHPug74q6XFWoSGepM0T7QTe8QhEeA7BzSwl+EDcIFzG1c
 GGGQ==
X-Gm-Message-State: AOAM532HYe3oXFWAB0CzVocXTkPRz+h7rkvhmRW8PfW1rcXBwuhp+NR+
 kGggeAxDIt5AbQxg21oXnxCssg==
X-Google-Smtp-Source: ABdhPJze6gyBY7ObJJbFhPylgZ8Z6i79vFvUiKZVgggDq+RZInxVraUNYrreGND5o0A17nc7SB4AGw==
X-Received: by 2002:a17:90a:d42:: with SMTP id 2mr3328011pju.15.1595924789289; 
 Tue, 28 Jul 2020 01:26:29 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id h2sm17599747pfk.93.2020.07.28.01.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 01:26:28 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 3/4] target/riscv: Fix the translation of physical address
Date: Tue, 28 Jul 2020 16:26:16 +0800
Message-Id: <370a983d0f9e8a9a927b9bb8af5e7bc84b1bf9b1.1595924470.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595924470.git.zong.li@sifive.com>
References: <cover.1595924470.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=zong.li@sifive.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The real physical address should add the 12 bits page offset. It also
causes the PMP wrong checking due to the minimum granularity of PMP is
4 byte, but we always get the physical address which is 4KB alignment,
that means, we always use the start address of the page to check PMP for
all addresses which in the same page.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 target/riscv/cpu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae3434..2f337e418c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -543,7 +543,8 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            *physical = ((ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT) |
+                        (addr & ~TARGET_PAGE_MASK);
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
@@ -630,7 +631,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         }
     }
 
-    return phys_addr;
+    return phys_addr & TARGET_PAGE_MASK;
 }
 
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.27.0


