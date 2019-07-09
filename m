Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345EC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4206F21707
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xweQd2n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4206F21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkvc-00078c-Hq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkku1-0005k2-Uw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkku1-00014I-16
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkku0-00013s-Rl
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id r1so8855621pfq.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ty0ceSlhLSlZJKGDv3kDThADamDPPm/37CRvid7ZnoA=;
 b=xweQd2n7cOIjNj1oVwpUquouhsktuT9M2HAcdKSu8OhqeiE6bNGVunXkJew9aYfMvV
 +3dsnpfiQxQvNGiLWQ2e1xLB3YxFeJNvaZstZE9u/A2BqtVRnokA1UNhEtekUO6y3LYC
 O1iIDmkLUMOn9Hgr38/tH+XiwJjtbZBljVMa6eCfSfQUkZJPIqLlj8hZojflET5lQe7C
 s8rzLdaSXl6dnmIr9Oz49aogjm4Bo0s8IHgCutEKPzzrIgRKs2b4vXmGOp2XJ/Xyz9UO
 /vcaJvu9j5OC+LGqVB2gem+WK1ugkg76HBkBhj0otURW/gkNbylfjpKZgsZWnfGOTv+E
 CJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ty0ceSlhLSlZJKGDv3kDThADamDPPm/37CRvid7ZnoA=;
 b=m0WFpLNq1Wyy3+5vb1Ro+O2n9GxoYNFvoqv26glcsb7DvvwdCbx4QfHBsliMckLZa9
 jNv96N3rTZPYOuVUukD9/VqYh5dOmmMLyvH+StHtPaUXbvHpO3bVX39N2wuroJn/b4vS
 OjsOJ01VNvX0Fy7VsVPiwVgXraSQUpaLO7JGQ5nq1t7kmytZPeVdWmCQ4TwIkgS1nlOb
 w7wdjH50kN3JYXxbyxC7SbSaxmC50EJgsWZq4suKtrAuZKEzcXVpZJyun+f4S69lC3bG
 plE8UbAKKwuE5GjOhmRsoc+4CNUkOWQKvDmhJzVz7PD5R7UjGsQ1bNejbT76BAXiivei
 6/dg==
X-Gm-Message-State: APjAAAU7Y2nonKeppOTN2cTdT8MfywokJFPb2kB69IrrGwk13paF+h0Y
 FNgsdy3KgQl0Pog9mR0cJhJm4YYvFBbXUg==
X-Google-Smtp-Source: APXvYqw5V/wHb1ZUfGqScU7FSTz3WNjZv+GPNT6dDRr3FUf/JT81wESpJbTzx+gOJ79JZnMqAWyfqg==
X-Received: by 2002:a17:90b:f12:: with SMTP id
 br18mr29911992pjb.127.1562658663545; 
 Tue, 09 Jul 2019 00:51:03 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id y22sm28237375pfo.39.2019.07.09.00.51.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:51:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:50:40 +0200
Message-Id: <20190709075042.13941-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709075042.13941-1-richard.henderson@linaro.org>
References: <20190709075042.13941-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PULL v2 2/2] tcg: Fix expansion of INDEX_op_not_vec
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

This operation can always be emitted, even if we need to
fall back to xor.  Adjust the assertions to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index c8fdc24f56..6714991bf4 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -90,6 +90,9 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_bitsel_vec:
             /* These opcodes are mandatory and should not be listed.  */
             g_assert_not_reached();
+        case INDEX_op_not_vec:
+            /* These opcodes have generic expansions using the above.  */
+            g_assert_not_reached();
         default:
             break;
         }
@@ -438,11 +441,14 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
 
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
+
     if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)) {
         TCGv_vec t = tcg_const_ones_vec_matching(r);
         tcg_gen_xor_vec(0, r, a, t);
         tcg_temp_free_vec(t);
     }
+    tcg_swap_vecop_list(hold_list);
 }
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
-- 
2.17.1


