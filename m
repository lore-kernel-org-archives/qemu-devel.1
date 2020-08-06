Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB947C433E4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F7522CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cP5ddzGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F7522CF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dZe-00086q-8f
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRQ-0001yI-S8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRN-0007lv-Mq
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id d188so18659796pfd.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c/ghpBq2kPmrmEJfQqAVTB1c6bdR+UnyFqiBk7wXJ8Q=;
 b=cP5ddzGjzkzLNJ/q3iSfNyeywN9+I8cn202Ib0AeAAjf8TKEjPyTXAK6Xy1Q+/kE6/
 U1Te7CXlGXCVILEjEPkcd6dPbOD90rSSAEnPZjXb2i9Avm1X3zMV9H4NL9y3/SMZ0n1T
 AYNk0v1tKEy7zv+Th8BemRV6wzPAj3UOcHA8/nk1T3BjnA2ou9dFED076gZTWbObjela
 kBzs4EzC+jGJgbNjFY+oRlAmeVqAqu+X6fv/TBAzsRlDJQJJzyioFYg49loTRFbggvZm
 TTo+upMslB2wP9bRxvtN7zM3rdHCffDbm4gcwCkPdFF5AHiqMQXN4dpv74hzYZ8GOsdl
 /YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c/ghpBq2kPmrmEJfQqAVTB1c6bdR+UnyFqiBk7wXJ8Q=;
 b=MxuiATI8KcdpKF2VTgiJktMnmOxHjSrG3TnG3JN0zk5/gU0LYjCj/mV1jmoxpRDVTs
 az0hb69wNxeoaEL1Hmbr8kT8/B3sOmCZVTCwveL9twNmsS/lVMYSc6pmOv5W05ofDRnj
 XTWOiQFvHcOVGFcpnB/U7aGYFUgKOyB/RI8jOzZ3bw85XzRVNpbKNgghhNnJsgmj6r+3
 4214fl3xlx0tVIAeQxN3dcx+oEbH/JIVq0pTFbI+m16IE9wMoAknVuBDQqMwSjAvaDwI
 kBnnAcYQiHRhq73o6KVDkC1GxPye5kjD+Z+VBsLt0VPhbqG2D8ZpvbcdUuHmXdtsRf9e
 sC+w==
X-Gm-Message-State: AOAM530OAzahXzIWWaOc+8VUW37Qoo3oa9oHMHCfW9snCW0mtUTW+eU8
 XEp7YK8EmVKJULlIFUU2Jb8dSHcryuI=
X-Google-Smtp-Source: ABdhPJxrxE6DfDCrQrhti72/J6vyVqaX10koT63HUsdUchRVBRFHRfU8qEBsh+TM+zt8HM3EhCExzg==
X-Received: by 2002:a62:7644:: with SMTP id r65mr7488062pfc.271.1596710884271; 
 Thu, 06 Aug 2020 03:48:04 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:03 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 17/71] target/riscv: rvv:1.0: add translation-time nan-box
 helper function
Date: Thu,  6 Aug 2020 18:46:14 +0800
Message-Id: <20200806104709.13235-18-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Add do_nanbox() helper function to utilize gen_check_nanbox_X() to
generate the NaN-boxed floating-point values based on SEW setting.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0a4dd875e96..525aff06815 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2077,6 +2077,33 @@ GEN_OPIVI_NARROW_TRANS(vnclip_vi, IMM_ZX, vnclip_vx)
 /*
  *** Vector Float Point Arithmetic Instructions
  */
+
+/*
+ * As RVF-only cpus always have values NaN-boxed to 64-bits,
+ * RVF and RVD can be treated equally.
+ * We don't have to deal with the cases of: SEW > FLEN.
+ *
+ * If SEW < FLEN, check whether input fp register is a valid
+ * NaN-boxed value, in which case the least-significant SEW bits
+ * of the f regsiter are used, else the canonical NaN value is used.
+ */
+static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
+{
+    switch (s->sew) {
+    case 1:
+        gen_check_nanbox_h(out, in);
+        break;
+    case 2:
+        gen_check_nanbox_s(out, in);
+        break;
+    case 3:
+        tcg_gen_mov_i64(out, in);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Vector Single-Width Floating-Point Add/Subtract Instructions */
 
 /*
-- 
2.17.1


