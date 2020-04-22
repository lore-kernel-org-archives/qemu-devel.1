Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0DC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B042054F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2OnSAIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B042054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4G0-00029h-El
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41P-0001jO-G3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41O-00024n-TO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:51 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41O-00020C-9Q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:50 -0400
Received: by mail-pj1-x1042.google.com with SMTP id t40so156428pjb.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zdjt8WpN4waxB25J3ykCncF8gpDtxEJVdnhsqarrM50=;
 b=l2OnSAIN9pOZW3QTTeJHLAmMDjVXaAEqy5iGvIzdKy6Kk3WssrUciwF8eKy+p4Ux6R
 D0Y5T+tPVvPoWpsNe10lRgoaYhs7tY25QLePjuzT5/437kYPXv8iFs808khZ62moO+d/
 E79IpJKsUUCSSb8h+jkljmO2/ckjpOmW9dQtqjfx2W/rMSATTGCoOPTc7y23Q/MP7MpT
 0DgfhEXVPvTkobPtxu5jb5B8pRlP5YxU6g8oSP2lPGT2/teSFQnYL1JbYz1FMbnmLyvj
 ALx7VzwWLnXaQQZXKZWkE6apIGcbpGsZvgOivN54jxbX2QltzF1Zqe7yzDOLC1Myo5Lf
 AIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zdjt8WpN4waxB25J3ykCncF8gpDtxEJVdnhsqarrM50=;
 b=PPOmWp4ghmUt8sb8n1MxrWVbxq4M8F8xQSzsi0AfsLHEnrhAMaODoM9yROb7MzYEkW
 2aTK7Fg1vHZ7S0HUp4VuDq9XHfh9LK8QnPhLimjbareI96UqaCU9UYqnIHZsGwMTNIva
 mSblsbz9dwtnmxAUJ6LcYBfCMkPKiGdeRhqD2Q/62aXmP8cUo+NEO0LW3coRCFeK0wuS
 gCw5cWuoLthQ3Bp90areOkwah+Ki9fR83EbFjzIWf//s35+rxf84WvuH6Q+5SHOt7Cno
 r3GAhgnP8xwQ6xHiqTCSQNh+unPUdjUFzGMNTKiSe9aAc4fF3ocX4hzUy1WUyOTUmUUE
 K/Lw==
X-Gm-Message-State: AGi0PuYGIRCv1Y2psrsF79RTjr8F6RZhJk1gKID3Sk2BQlC1hNDa7tZr
 MWM7Nr6w1YtxF3KTWr2EbQG6evfPHDo=
X-Google-Smtp-Source: APiQypL3SYcns4vxeLrdjcPxXHBFPFvR8hv10Y3tvO3CZBE2HqYTOu+dMCxm51dYh1OL6XmjYAxy6w==
X-Received: by 2002:a17:902:7b96:: with SMTP id
 w22mr24706428pll.10.1587518268604; 
 Tue, 21 Apr 2020 18:17:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/36] tcg/tci: Add special tci_movi_{i32,i64} opcodes
Date: Tue, 21 Apr 2020 18:17:05 -0700
Message-Id: <20200422011722.13287-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The normal movi opcodes are going away.  We need something
for TCI to use internally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 8 ++++++++
 tcg/tci.c                | 4 ++--
 tcg/tci/tcg-target.inc.c | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9288a04946..7dee9b38f7 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -268,6 +268,14 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 #include "tcg-target.opc.h"
 #endif
 
+#ifdef TCG_TARGET_INTERPRETER
+/* These opcodes are only for use between the tci generator and interpreter. */
+DEF(tci_movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+#if TCG_TARGET_REG_BITS == 64
+DEF(tci_movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
+#endif
+#endif
+
 #undef TLADDR_ARGS
 #undef DATA64_ARGS
 #undef IMPL
diff --git a/tcg/tci.c b/tcg/tci.c
index 46fe9ce63f..a6c1aaf5af 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -576,7 +576,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             t1 = tci_read_r32(regs, &tb_ptr);
             tci_write_reg32(regs, t0, t1);
             break;
-        case INDEX_op_movi_i32:
+        case INDEX_op_tci_movi_i32:
             t0 = *tb_ptr++;
             t1 = tci_read_i32(&tb_ptr);
             tci_write_reg32(regs, t0, t1);
@@ -847,7 +847,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             t1 = tci_read_r64(regs, &tb_ptr);
             tci_write_reg64(regs, t0, t1);
             break;
-        case INDEX_op_movi_i64:
+        case INDEX_op_tci_movi_i64:
             t0 = *tb_ptr++;
             t1 = tci_read_i64(&tb_ptr);
             tci_write_reg64(regs, t0, t1);
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 992d50cb1e..1f1639df0d 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -530,13 +530,13 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     uint8_t *old_code_ptr = s->code_ptr;
     uint32_t arg32 = arg;
     if (type == TCG_TYPE_I32 || arg == arg32) {
-        tcg_out_op_t(s, INDEX_op_movi_i32);
+        tcg_out_op_t(s, INDEX_op_tci_movi_i32);
         tcg_out_r(s, t0);
         tcg_out32(s, arg32);
     } else {
         tcg_debug_assert(type == TCG_TYPE_I64);
 #if TCG_TARGET_REG_BITS == 64
-        tcg_out_op_t(s, INDEX_op_movi_i64);
+        tcg_out_op_t(s, INDEX_op_tci_movi_i64);
         tcg_out_r(s, t0);
         tcg_out64(s, arg);
 #else
-- 
2.20.1


