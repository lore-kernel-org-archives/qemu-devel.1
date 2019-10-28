Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F37CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D70020717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hd8eDErr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D70020717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7vQ-0006QJ-1w
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7PS-00051u-6s
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7PR-0003jJ-2h
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:22 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7PQ-0003j0-Tl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:21 -0400
Received: by mail-pl1-x641.google.com with SMTP id g9so5183624plp.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=D5lUa8xwyAhQuJBABUbBfsge6X0s1+ub7iA6TO4kaOc=;
 b=hd8eDErr/6e475gD3H5orDwGbZdvxBBHYUa3YRamsq5Tc0viHoPNow12xJJh8unBJl
 plKFgjXV9PIu4L1dn0FMQQQWYYHgHTkQHeZX7Ebg4rSQU9d+MbfD/4an0czA++PZ27gq
 +ecEmqz6/EaZqc2B+uNeb+ykS2Ky0CXw1CRaI5smQ4AmRi8pjmpFYZqAU6RPL023YUG4
 W0tQU8NkuNRBOB3FeIIpsUvb8P6MN5UawV6TYt7lYRvsCEGfxUFDGrngjwXn+nZbS65Y
 y9RKm7zAhgIO8Z9reQbV1nIR5A4CUBMJ7tiVHRDQCeI94RTV7Wae37WEWAe7NlMSIOaQ
 +6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=D5lUa8xwyAhQuJBABUbBfsge6X0s1+ub7iA6TO4kaOc=;
 b=YMvpXMe2wXBii4ycRtXpVHQ6dvs3AS62dxSzg4bvm3QM27Mz558ck8OEblleRh8xZ+
 VEor+fidI1Z/zVM7EXawje3oswiEED8uq2o+OrGfP/OV5jQCl9hsSWgKeqOgMQvCrqru
 9Bp7MCxZqo7BGceAuG+vHUvu4Y6UCeAmwdzgKl4SphNWVfhX0Y6M6miQ3/qRnC/QHoHY
 g8VKgs6hEFz9V4O7dQkvjMr1PiXyBvZJTw4OWKjcES8ZhdExufUs2jF5PRM0zqzgWnpV
 YPCk1MYAYvORM4o6v1RS87oT7Pe7zvUPxrH044ACpYkFOYb8oqIfvy4T2LmZFUOfzoKQ
 Dx1A==
X-Gm-Message-State: APjAAAUJJH1wGq3ydiPj3Mm+5PSY1z4ucjPFl8SxcKVZdEvcoU2o/trU
 9+yIj0KNQdM1UuDsgYoFij1xKZPzxFE7Vg==
X-Google-Smtp-Source: APXvYqyq3M+syw8xc6lucIqG7RBmg6RqYTXD2wiHLFaNKi4f+rK2gBJb05CmXV70xHeTohNZ5o5PKQ==
X-Received: by 2002:a17:902:7c07:: with SMTP id
 x7mr1754209pll.210.1572278299477; 
 Mon, 28 Oct 2019 08:58:19 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id d14sm13225525pfh.36.2019.10.28.08.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:18 -0700 (PDT)
Subject: [PULL 02/18] RISC-V: Handle bus errors in the page table walker
Date: Mon, 28 Oct 2019 08:48:46 -0700
Message-Id: <20191028154902.32491-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We directly access physical memory while walking the page tables on
RISC-V, but while doing so we were using cpu_ld*() which does not report
bus errors.  This patch converts the page table walker over to use
address_space_ld*(), which allows bus errors to be detected.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 87dd6a6ece..c82e7ed52b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -169,7 +169,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
      * (riscv_cpu_do_interrupt) is correct */
-
+    MemTxResult res;
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmu_idx;
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
@@ -256,11 +257,16 @@ restart:
             1 << MMU_DATA_LOAD, PRV_S)) {
             return TRANSLATE_PMP_FAIL;
         }
+
 #if defined(TARGET_RISCV32)
-        target_ulong pte = ldl_phys(cs->as, pte_addr);
+        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
 #elif defined(TARGET_RISCV64)
-        target_ulong pte = ldq_phys(cs->as, pte_addr);
+        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
 #endif
+        if (res != MEMTX_OK) {
+            return TRANSLATE_FAIL;
+        }
+
         hwaddr ppn = pte >> PTE_PPN_SHIFT;
 
         if (!(pte & PTE_V)) {
-- 
2.21.0


