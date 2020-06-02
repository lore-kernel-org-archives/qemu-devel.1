Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19E4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFB9206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWXRad9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFB9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAK9-0000HV-QH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIk-0005wT-6P
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:10 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIi-0007R2-Qv
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:09 -0400
Received: by mail-pl1-x641.google.com with SMTP id v24so1579696plo.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tHqpToSLuNmT3+mxdztxkjY6kBf+OhopPIY/mAzI0FM=;
 b=zWXRad9lLOfYB1kXttHNm+JcpktLPnPGpwp7jC0FwNZQCg6PRYkS/OIVgOKccBA2TM
 /B3USpHFUcUsyinpJiow+8rOYAwHUbDr0Kud7Ec3k6gZS6qdKFZoUcZn4ptlBgxUdB7W
 G4olbpY4UX7ECn4Cn4SAhG56tycAYLDCdztHq+w4kDvn5QknpsGq/VPBwo+utQNttTwv
 HvL1uKdBB6QEUi0MZkegsskymKLBSe4rcdMvLZ0OBL3FH4/bwyQ+0sSrXdBPlUT2jCo+
 avA56rJnHa07OjSF05fUoGSlAJKy/WbsLlkm3SW3oV3ehkBE3RIu3Rn5cbiCKuHG1K86
 O8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tHqpToSLuNmT3+mxdztxkjY6kBf+OhopPIY/mAzI0FM=;
 b=NQFBf2cJmqAPtL6+9fwPI33WfWDniJiincnKqoa9pEPcxEpMp8jzpR7ftUd4EUG1hb
 o/iIQzqmTXcPKV4OkLuW6nF3QR9kn2kqW2sDM29VKpZI2g/YmCpv/Lis7Tg3Kto1kIlJ
 AUferlV8GEIYUoZ37uooOUgfCJ2pZGHcH4uqz1iIZljI9RSSiGQFEmflgWx9rpU/K14u
 5tyGtcYe0Ky4Stw0gdREz0Euv8QuABIoieFm5yXtopQzWYyOCPfIYnb8njQJNmTb0BdI
 pudmBGjKHMY6vmAKR9INEqaAEtx42LTvM73h7oHP7CooGfYAGI0i7mPF+htdFVjLstRC
 v9aA==
X-Gm-Message-State: AOAM530079jYTOFzhNDxuGs9fI6fG7H/shnAfdiYVAbcHztXZH5SJiin
 jzqboaJJaeTf5rE+Si6R+Q4jSf6pVcA=
X-Google-Smtp-Source: ABdhPJxGjH5MdEur0AM3tXciVZgUXl0C6kbK91WqbKJVgQU1pkO91xxYk7KNGEg0Y6LfueCl8a05DQ==
X-Received: by 2002:a17:902:c3d3:: with SMTP id
 j19mr26285210plj.47.1591117326991; 
 Tue, 02 Jun 2020 10:02:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:02:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] tcg: Improve move ops in liveness_pass_2
Date: Tue,  2 Jun 2020 10:01:49 -0700
Message-Id: <20200602170151.321389-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the output of the move is dead, then the last use is in
the store.  If we propagate the input to the store, then we
can remove the move opcode entirely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 78 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 97558ec068..1aa6cb47f2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2982,34 +2982,68 @@ static bool liveness_pass_2(TCGContext *s)
         }
 
         /* Outputs become available.  */
-        for (i = 0; i < nb_oargs; i++) {
-            arg_ts = arg_temp(op->args[i]);
+        if (opc == INDEX_op_mov_i32 || opc == INDEX_op_mov_i64) {
+            arg_ts = arg_temp(op->args[0]);
             dir_ts = arg_ts->state_ptr;
-            if (!dir_ts) {
-                continue;
+            if (dir_ts) {
+                op->args[0] = temp_arg(dir_ts);
+                changes = true;
+
+                /* The output is now live and modified.  */
+                arg_ts->state = 0;
+
+                if (NEED_SYNC_ARG(0)) {
+                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
+                                      ? INDEX_op_st_i32
+                                      : INDEX_op_st_i64);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc);
+                    TCGTemp *out_ts = dir_ts;
+
+                    if (IS_DEAD_ARG(0)) {
+                        out_ts = arg_temp(op->args[1]);
+                        arg_ts->state = TS_DEAD;
+                        tcg_op_remove(s, op);
+                    } else {
+                        arg_ts->state = TS_MEM;
+                    }
+
+                    sop->args[0] = temp_arg(out_ts);
+                    sop->args[1] = temp_arg(arg_ts->mem_base);
+                    sop->args[2] = arg_ts->mem_offset;
+                } else {
+                    tcg_debug_assert(!IS_DEAD_ARG(0));
+                }
             }
-            op->args[i] = temp_arg(dir_ts);
-            changes = true;
+        } else {
+            for (i = 0; i < nb_oargs; i++) {
+                arg_ts = arg_temp(op->args[i]);
+                dir_ts = arg_ts->state_ptr;
+                if (!dir_ts) {
+                    continue;
+                }
+                op->args[i] = temp_arg(dir_ts);
+                changes = true;
 
-            /* The output is now live and modified.  */
-            arg_ts->state = 0;
+                /* The output is now live and modified.  */
+                arg_ts->state = 0;
 
-            /* Sync outputs upon their last write.  */
-            if (NEED_SYNC_ARG(i)) {
-                TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
-                                  ? INDEX_op_st_i32
-                                  : INDEX_op_st_i64);
-                TCGOp *sop = tcg_op_insert_after(s, op, sopc);
+                /* Sync outputs upon their last write.  */
+                if (NEED_SYNC_ARG(i)) {
+                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
+                                      ? INDEX_op_st_i32
+                                      : INDEX_op_st_i64);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc);
 
-                sop->args[0] = temp_arg(dir_ts);
-                sop->args[1] = temp_arg(arg_ts->mem_base);
-                sop->args[2] = arg_ts->mem_offset;
+                    sop->args[0] = temp_arg(dir_ts);
+                    sop->args[1] = temp_arg(arg_ts->mem_base);
+                    sop->args[2] = arg_ts->mem_offset;
 
-                arg_ts->state = TS_MEM;
-            }
-            /* Drop outputs that are dead.  */
-            if (IS_DEAD_ARG(i)) {
-                arg_ts->state = TS_DEAD;
+                    arg_ts->state = TS_MEM;
+                }
+                /* Drop outputs that are dead.  */
+                if (IS_DEAD_ARG(i)) {
+                    arg_ts->state = TS_DEAD;
+                }
             }
         }
     }
-- 
2.25.1


