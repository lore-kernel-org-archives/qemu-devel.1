Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64323C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7AD20727
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiHWkFYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7AD20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSH6-0000TZ-Re
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSBx-0003KK-A3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:40028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSBu-0004Rf-9p
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:24 -0400
Received: by mail-pf1-x42e.google.com with SMTP id w21so1247529pfc.7
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l4c7t48Ie241pwgULUUoEJnXqKB0sfr3ZrdrLJQD0q8=;
 b=CiHWkFYGtjvojIFuuJhgfB8hhCPzI8v3+crXsbMSfQN4lnr1NFHv4PHPC63sv3rN0k
 BchGrxwK7DljmRBtrun4Ykd7TAl1QzC5Cv3If2Tqyu3kixmNK9o0dAefln8w50TccJT4
 ays/ZNdcr2FFrLTMmjobcYHksFxBnJ+AyPP65//UELNSE3DXM8lZ1l8dygOYrB2cC/Cg
 DHYOUiuZJ5zssTy7sSDMS3YotKHZIL+FsFq62hev9X+C5nJOOoSVe25GIrOneLxdojXX
 QHEZWirEcw3ese+WRUZXrg8rLtFli5LDl24mZO8Nrb0klbyCTS3lEVaDRvXTtPgYs+I7
 gByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l4c7t48Ie241pwgULUUoEJnXqKB0sfr3ZrdrLJQD0q8=;
 b=einuG9DixxaXmaTDmKpgXUUpLs4L8h+AgzZfl4P3nsM8bOMZcUrIL9mqGwgCyZfhUk
 sBCZ5vQLpuWTMGn4z2Fwk8aM+vA21e7apiRP/mKO/iJPL50J1sQ6QLTay74Av2W2mHJ9
 rn6xf8iFduyzAzXQu7E4iU/RCmXyNp9ABAftQokCv68DhSUlyTHxCVX3QB9/SFhvhZYI
 XJnTv0TYL1bnj6dk229riM5uxg78wdplArS9AIe/0THbK8gsu23S7RL9JGzCEp0ewSzj
 uvRLr3nnzVIMqjoU/5U6RoVV2p9ZZuP76sI2O6IGjalyiVWpFFkVEfJ2RdNw9eDQvz7y
 g5Zg==
X-Gm-Message-State: AOAM530U9DH9Au7S7D+BUXAD71klLVHwrOlHr3TVIax+9Y1S3xAp5nfR
 OUsAEjCqvirbpPdYuT2VNY2ypjRsdEprEw==
X-Google-Smtp-Source: ABdhPJzkZQGNXws9uH0UfuAa0mn7L/q7AbXG/1gskpG3XLdNJovUOFnLxGaOH66IPTs2Cb4tdCrOyg==
X-Received: by 2002:a65:50c9:: with SMTP id s9mr2713518pgp.20.1603817480617;
 Tue, 27 Oct 2020 09:51:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q16sm2955283pfj.117.2020.10.27.09.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 09:51:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] tcg/optimize: Flush data at labels not TCG_OPF_BB_END
Date: Tue, 27 Oct 2020 09:51:13 -0700
Message-Id: <20201027165114.71508-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027165114.71508-1-richard.henderson@linaro.org>
References: <20201027165114.71508-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can easily propagate temp values through the entire extended
basic block (in this case, the set of blocks connected by fallthru),
simply by not discarding the register state at the branch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 220f4601d5..9952c28bdc 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1484,29 +1484,30 @@ void tcg_optimize(TCGContext *s)
                     }
                 }
             }
-            goto do_reset_output;
+            /* fall through */
 
         default:
         do_default:
-            /* Default case: we know nothing about operation (or were unable
-               to compute the operation result) so no propagation is done.
-               We trash everything if the operation is the end of a basic
-               block, otherwise we only trash the output args.  "mask" is
-               the non-zero bits mask for the first output arg.  */
-            if (def->flags & TCG_OPF_BB_END) {
-                bitmap_zero(temps_used.l, nb_temps);
-            } else {
-        do_reset_output:
-                for (i = 0; i < nb_oargs; i++) {
-                    reset_temp(op->args[i]);
-                    /* Save the corresponding known-zero bits mask for the
-                       first output argument (only one supported so far). */
-                    if (i == 0) {
-                        arg_info(op->args[i])->mask = mask;
-                    }
+            /*
+             * Default case: we know nothing about operation (or were unable
+             * to compute the operation result) so no propagation is done.
+             */
+            for (i = 0; i < nb_oargs; i++) {
+                reset_temp(op->args[i]);
+                /*
+                 * Save the corresponding known-zero bits mask for the
+                 * first output argument (only one supported so far).
+                 */
+                if (i == 0) {
+                    arg_info(op->args[i])->mask = mask;
                 }
             }
             break;
+
+        case INDEX_op_set_label:
+            /* Trash everything at the start of a new extended bb. */
+            bitmap_zero(temps_used.l, nb_temps);
+            break;
         }
 
         /* Eliminate duplicate and redundant fence instructions.  */
-- 
2.25.1


