Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA53C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665CC207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFE67NzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665CC207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haAHO-0006PW-NO
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eT-0006yw-Eh
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eR-000286-H3
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:13 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eP-00024S-Dn
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id 20so4159989pgr.4
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2m2+rpL1xWjB5db+GO//3xJA4pzKyCYCkFox2ZrQZRk=;
 b=xFE67NzHxiUppK2yJCIC6/JnaqnLlAIWX7Q+pn4RmNDqRvQL8vYPcJv7XHfNe8ae9R
 bXsbnoeygiuECEGt1dwUpo5RjFE5mVHfxh0XuOYatmSGh9vWbRs1GBKR4ApYJRDXgc1l
 SBA7fIW9WQ6JqIbojSLhgg4fG4HWWQkoHpJ7CYZD6a73IlFTByj8JoZ4dj6IvQ+LLVf5
 Y1+hP1V9mJjClbgbtpCf9JYK+0i/k/4T8Qx8m7NnEz+KaO/Wf9lN6sG1bsVMh1pIUkfV
 eGjq8CRykofmwJ/wfvddCve9CgwVmHcQe4ceywSOjesZIg6mwYlTCE/qo+wDDnV03iOB
 jnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2m2+rpL1xWjB5db+GO//3xJA4pzKyCYCkFox2ZrQZRk=;
 b=n/eXltuTogjF8EgSdKByJi7IuJ5t6BvoKApxk6PoVuIAUqzXKJbO0iHBwbnagDCLQu
 aME4CDqHj8ACl/yNsQztIbdhWhr83+7/v9U/dvsoebki3nwSQgPMiI/3DcZtZFQDp05T
 QF/s/NZpIkcY16eUIQUmPkgJLtTkAAIokqOm5aqqHkq8ja/6b1PlNSNUV/sMa0ADOfgB
 mlwDCqY2yWgKZ1dpBuo3FlJ+WgWT3wBqjoq7i4Qe3T9Gx383Pkdir4nDmqXAdrqLyfmB
 d8Il26Phi4dESWUTYGq4ry+BtKSHjlxr/N9Sg8fqpRz0mUtqXZLOA8y+oWEmGQfKop6v
 eF5w==
X-Gm-Message-State: APjAAAUGQFQEyUyWbEmMK2C1DnvnR+LCDsNh6mizMVDHstwL1oyAxcTE
 ZbC3HLpzIH312WiRrRV/5dNZh9Y0UKg=
X-Google-Smtp-Source: APXvYqysj9SEeFE6o/zBtGanLkw4fjyEaQdnPm2s3ZiPZ8xhzFqoDsWi13oYk2rvKhE6APrYHLrVVA==
X-Received: by 2002:a63:f10e:: with SMTP id f14mr13497066pgi.226.1560132184817; 
 Sun, 09 Jun 2019 19:03:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.03.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:03:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:16 -0700
Message-Id: <20190610020218.9228-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PULL 37/39] tcg/aarch64: Use LDP to load tlb
 mask+table
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes the code generation for the tlb from e.g.

	ldur     x0, [x19, #0xffffffffffffffe0]
	ldur     x1, [x19, #0xffffffffffffffe8]
	and      x0, x0, x20, lsr #8
	add      x1, x1, x0
	ldr      x0, [x1]
	ldr      x1, [x1, #0x18]

to

	ldp      x0, x1, [x19, #-0x20]
	and      x0, x0, x20, lsr #8
	add      x1, x1, x0
	ldr      x0, [x1]
	ldr      x1, [x1, #0x18]

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 57c297f9d7..b0f8106642 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1641,6 +1641,10 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -512);
 
+/* These offsets are built into the LDP below.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
+
 /* Load and compare a TLB entry, emitting the conditional jump to the
    slow path for the failure case, which will be patched later when finalizing
    the slow path. Generated code returns the host addend in X1,
@@ -1649,23 +1653,20 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
                              tcg_insn_unit **label_ptr, int mem_index,
                              bool is_read)
 {
-    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
-    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
-    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_mask = (1u << a_bits) - 1;
     unsigned s_mask = (1u << s_bits) - 1;
-    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0, x3;
+    TCGReg x3;
     TCGType mask_type;
     uint64_t compare_mask;
 
     mask_type = (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, mask_type, TCG_REG_X0, mask_base, mask_ofs);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, table_base, table_ofs);
+    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {x0,x1}.  */
+    tcg_out_insn(s, 3314, LDP, TCG_REG_X0, TCG_REG_X1, TCG_AREG0,
+                 TLB_MASK_TABLE_OFS(mem_index), 1, 0);
 
     /* Extract the TLB index from the address into X0.  */
     tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
-- 
2.17.1


