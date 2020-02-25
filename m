Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93808C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6A221744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wlc/hzHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6A221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aca-0003vr-K0
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZkW-0003pC-HL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZkV-0004A9-F8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZkV-00048g-77
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:43 -0500
Received: by mail-wr1-x443.google.com with SMTP id p18so10963749wre.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EBaGCMW6W6S2Wg/FY9JiNSNkk1jY3/TyEWd55UX+4ek=;
 b=Wlc/hzHXbGUzouldUtC2d3w93tY3tBXwVYf7DnxH2x1Ww7rQwpHCNMwF46GPpJ/kxf
 QcJZpGIWgur4DasbTEOcFuWzjjwUDfVUX13yv+OOdsoXT9w9eDh2jtq+cQ78wyLkZqwF
 kszseq0rmPJnqbCWWJpBIY4UsrEB8togkUpuUdCVjDV+dlCYD7zc37kZIDXBrikVd8gd
 I6kEy1i+g6Jg243zPs3roeM6ysSfofsvIkn4tIDvt4tYrwJlQ3N8Ac7fTR3kNnngMAin
 oIbqmzQylyOlfGHQM0DrDTNfffS2u11OJ8/Um/PGtd8ATfkGH82TavfAMTA8JEruFzX/
 svUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBaGCMW6W6S2Wg/FY9JiNSNkk1jY3/TyEWd55UX+4ek=;
 b=tlJeHupX/Fo+alj3eg3SMML0m5O36XJRxiQECuGSNmz8R7ZvNp2mYjB94pXu/Q1HBa
 nUXKoGroRiSC7YxrsS7G4NU/rBn4e3ZYlxFPgwzD+wjD3OQ3coBaU4IWWwAsqzHAGzYS
 ysmGKwW64hFWEf3PAhi6M5pcZb1wAxam1jHkoanKrqKuDofd3DE9d5fj+0ZPxpMqc6b5
 w26hxGwmyunGdLP1q+86QiS5gFesN4towrlg4YaEo/bUAkNiryVlhrMdEzmSZggahUR+
 2JLs1tIT2bKpGS0bc+lIz3ADuNQj1CzB8y74lTXKRlyf1u1GJxPB5F4l1b76Vxg6CkN5
 nSvg==
X-Gm-Message-State: APjAAAUmTh4ezTEfQBMJBusKBvrfPuqpcO13r4n+S/0jNZKMLpT/NqnG
 e0FaH6pihmCabpsJSl5DeVuJUA==
X-Google-Smtp-Source: APXvYqxKmpx+NcYJEQZfvMqGSjgBhUfvDVxPbOXA3ZI+qNbeuqQAqGcuMU77aHy01/2sOonnetE/fw==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr14710204wro.51.1582635342188; 
 Tue, 25 Feb 2020 04:55:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v16sm3964669wml.11.2020.02.25.04.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:55:37 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE1961FFA6;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 17/19] tcg: save vaddr temp for plugin usage
Date: Tue, 25 Feb 2020 12:47:08 +0000
Message-Id: <20200225124710.14152-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 qemu-stable@nongnu.org, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

While do_gen_mem_cb does copy (via extu_tl_i64) vaddr into a new temp
this won't help if the vaddr temp gets clobbered by the actual
load/store op. To avoid this clobbering we explicitly copy vaddr
before the op to ensure it is live my the time we do the
instrumentation.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Cc: qemu-stable@nongnu.org
---
 tcg/tcg-op.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7d782002e3f..e2e25ebf7db 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2794,13 +2794,26 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static inline TCGv plugin_prep_mem_callbacks(TCGv vaddr)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        /* Save a copy of the vaddr for use after a load.  */
+        TCGv temp = tcg_temp_new();
+        tcg_gen_mov_tl(temp, vaddr);
+        return temp;
+    }
+#endif
+    return vaddr;
+}
+
 static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint16_t info)
 {
 #ifdef CONFIG_PLUGIN
-    if (tcg_ctx->plugin_insn == NULL) {
-        return;
+    if (tcg_ctx->plugin_insn != NULL) {
+        plugin_gen_empty_mem_callback(vaddr, info);
+        tcg_temp_free(vaddr);
     }
-    plugin_gen_empty_mem_callback(vaddr, info);
 #endif
 }
 
@@ -2822,6 +2835,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2868,6 +2882,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2905,6 +2920,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2967,6 +2983,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
-- 
2.20.1


