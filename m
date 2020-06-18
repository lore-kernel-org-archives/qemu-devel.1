Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB2CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B71217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqoAoBTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B71217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jln14-0000mz-Fp
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmF2-0007HK-HK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:32 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:39304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmF0-0003gM-R7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id d66so2199246pfd.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E14O64whYVWkcjjdESbOpmxAElX5odxSSFhOR+o6tVA=;
 b=fqoAoBTUzhTy/6XCbZEVq1IKvFVp6D+fTRwtO/G22UZPvnEtJbwB8Y0D7zpgB3SfWS
 5aTESsoy+cpyw+MXo75/p8oSBS6b9WFpilptEwEA6+8RyScPfSN4P1URhqoUKAIiy+cE
 /8oFMPK2f6g+8feRAyKCb3bSLFcaHFdVIw2H2IRne2B+DNDigCjIjdTueiYoe5XVKaua
 A3LYRKbrKvJwkJnKN/d92Ksa6+vTGOHiBpEcfyjBVW8JyLM3kU70bt5vAn6FD5ySTfYf
 KMbLKxarvLfXZt7AwM6VCdgHT4ilWxCphJKZLUrWoiXw3ZdRRLdDwv2yMoC0Y43uzfcV
 ExSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E14O64whYVWkcjjdESbOpmxAElX5odxSSFhOR+o6tVA=;
 b=hke1no5CGV4fFn33zNSsM4EgcD59Lv/F7Yop8nhIhHtKYVm7+JYr6YgPcB2UeNF/aq
 Xl5PiKbV6UJJDn0FZzwHEBbO7Kb1br5LzsrPWeWdn+taBHkKcq/1bsJilDAQosQ7Yx/f
 S8OYbw8BFrz6tQ/yZP2KdssLDBIgl9sokJaIqNCiLEgaVWES56Zh6M2GlsYJui9K5e/s
 SB+baePHW0a+RhXZKLZ8QBPFkpRYCbEXiAYxJG0JUpzwQofMxpIHbDU5pDJd0zWf8Ux6
 R2Fc3qEGG3rRyiBMCt56Rkv7QK/5fbtWm/3RjwcHKhcIfUe9apm/IkxxHpIymHrCWTpM
 y8sg==
X-Gm-Message-State: AOAM531reyE7SQ1WLtkxZzAkJr4JjUlGJm/0NFbZmG0TDIqbuGsfPidB
 fhu/NfimwZ4P8qlXJ1uT5MqOp4IcT4I=
X-Google-Smtp-Source: ABdhPJzeiWwiijZrJYmT/xd/qkUx+X2DWLFZ71cPkIr8hDlGtiSzv7od4nf9IH8YtHu1Vq4o6p7zJA==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr2011010pfb.0.1592454809187; 
 Wed, 17 Jun 2020 21:33:29 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q22sm1288212pfg.192.2020.06.17.21.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:33:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 095/100] tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
Date: Wed, 17 Jun 2020 21:26:39 -0700
Message-Id: <20200618042644.1685561-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already support duplication of 128-bit blocks.  This extends
that support to 256-bit blocks.  This will be needed by SVE2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 52 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3707c0effb..1b7876bb22 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1570,12 +1570,10 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
             tcg_temp_free_i64(in);
         }
-    } else {
+    } else if (vece == 4) {
         /* 128-bit duplicate.  */
-        /* ??? Dup to 256-bit vector.  */
         int i;
 
-        tcg_debug_assert(vece == 4);
         tcg_debug_assert(oprsz >= 16);
         if (TCG_TARGET_HAS_v128) {
             TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V128);
@@ -1601,6 +1599,54 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
         if (oprsz < maxsz) {
             expand_clr(dofs + oprsz, maxsz - oprsz);
         }
+    } else if (vece == 5) {
+        /* 256-bit duplicate.  */
+        int i;
+
+        tcg_debug_assert(oprsz >= 32);
+        tcg_debug_assert(oprsz % 32 == 0);
+        if (TCG_TARGET_HAS_v256) {
+            TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V256);
+
+            tcg_gen_ld_vec(in, cpu_env, aofs);
+            for (i = 0; i < oprsz; i += 32) {
+                tcg_gen_st_vec(in, cpu_env, dofs + i);
+            }
+            tcg_temp_free_vec(in);
+        } else if (TCG_TARGET_HAS_v128) {
+            TCGv_vec in0 = tcg_temp_new_vec(TCG_TYPE_V128);
+            TCGv_vec in1 = tcg_temp_new_vec(TCG_TYPE_V128);
+
+            tcg_gen_ld_vec(in0, cpu_env, aofs);
+            tcg_gen_ld_vec(in1, cpu_env, aofs + 16);
+            for (i = 0; i < oprsz; i += 32) {
+                tcg_gen_st_vec(in0, cpu_env, dofs + i);
+                tcg_gen_st_vec(in1, cpu_env, dofs + i + 16);
+            }
+            tcg_temp_free_vec(in0);
+            tcg_temp_free_vec(in1);
+        } else {
+            TCGv_i64 in[4];
+            int j;
+
+            for (j = 0; j < 4; ++j) {
+                in[j] = tcg_temp_new_i64();
+                tcg_gen_ld_i64(in[j], cpu_env, aofs + j * 8);
+            }
+            for (i = 0; i < oprsz; i += 32) {
+                for (j = 0; j < 4; ++j) {
+                    tcg_gen_st_i64(in[j], cpu_env, dofs + i + j * 8);
+                }
+            }
+            for (j = 0; j < 4; ++j) {
+                tcg_temp_free_i64(in[j]);
+            }
+        }
+        if (oprsz < maxsz) {
+            expand_clr(dofs + oprsz, maxsz - oprsz);
+        }
+    } else {
+        g_assert_not_reached();
     }
 }
 
-- 
2.25.1


