Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C485C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3E120870
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHYvHz5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3E120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDsf-0006rK-DG
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeB-0001bf-T7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdf-0000wz-G0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdf-0000sX-2O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so3075027wma.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lRqNh66uUwxsrOUZqGJJ72hNoPBVPihCXfF/QnEp9gk=;
 b=vHYvHz5Rwl6GJRqtb5n8BgStHDaL3cHZxvkWU5sQ7hEC26xIP0Fn3341nQu5hBcyMu
 +85bYTvUR5rUrooVcQbGPK/SVRXKCm9O2Qeo43b0je7qBlSupUX/OR3Oq5GdrGpLsVIM
 Ftgc7A9VXmaheGmeQiuETvQMqQN/rLsxXOoLQnQErFd5IXRj22/DRfSy2CtIjSp+OWaL
 TOGPrTY0XfxBtBxphhvCHeX+W7+k6kCoRwMX28Vr0MMiiSKMEEx+uTg5TAwpCaApntSM
 Vlc94Y2mvxst31EvvtQpjiZRWJlRiGkXJIAhETeAwulJMYpWKz+Eg+JFwVmIsGA/edlX
 a/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lRqNh66uUwxsrOUZqGJJ72hNoPBVPihCXfF/QnEp9gk=;
 b=iPLKSLr/ZuL6CKkqXu2BhncXUS3PyGFHJX/wa7LWuYIdABRV9tlEaaeFC744Nml2J9
 ul5kdJYThH0Q5zJao6GCoDQiwlIoZJG18s8W2xpzYdPjU6ULYhpe7NT6zbHXvMcToBL8
 CNgVNgEdt2OmMFzbAHrNYCkpKBrfF436SFBBJRp4KuxHvXvM+PCyQcwXG/aSAcyve+AX
 Fy4XDqWTfMTkqIAK+R8tjvLKlsBF6upqpa16fd7/spliRhVjixSJPfW5aYpHYxwrvVl/
 SiHlBcDqDgHBBjs9p3LTwNeoXHh1mI1H5WdjSuGCThTXTin0NtBh1UvPFHjUS1NWrt5k
 hi5w==
X-Gm-Message-State: AGi0PuY8DHIO3cA+ASELrHyTocQOwTFWZX4MvuBEOqRx1+ZfVhX19KlG
 qhq7CGrNLE9JADdztd1FwlZxaQ==
X-Google-Smtp-Source: APiQypLEdqdOIbmQRxGbPAMHd9VGwa8EHgJ8eIM4pmh/k8ybPrc+zMTRYSyBqHr9Xkio0yIyItdviw==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr4428286wmj.111.1588270221629; 
 Thu, 30 Apr 2020 11:10:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/36] target/arm: Convert Neon 'load single structure to all
 lanes' to decodetree
Date: Thu, 30 Apr 2020 19:09:39 +0100
Message-Id: <20200430181003.21682-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon "load single structure to all lanes" insns to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 73 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 55 +------------------------
 target/arm/neon-ls.decode       |  5 +++
 3 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 966c0d92012..e60e9559bad 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -398,3 +398,76 @@ static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
     gen_neon_ldst_base_update(s, a->rm, a->rn, nregs * interleave * 8);
     return true;
 }
+
+static bool trans_VLD_all_lanes(DisasContext *s, arg_VLD_all_lanes *a)
+{
+    /* Neon load single structure to all lanes */
+    int reg, stride, vec_size;
+    int vd = a->vd;
+    int size = a->size;
+    int nregs = a->n + 1;
+    TCGv_i32 addr, tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (size == 3) {
+        if (nregs != 4 || a->a == 0) {
+            return false;
+        }
+        /* For VLD4 size == 3 a == 1 means 32 bits at 16 byte alignment */
+        size = 2;
+    }
+    if (nregs == 1 && a->a == 1 && size == 0) {
+        return false;
+    }
+    if (nregs == 3 && a->a == 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * VLD1 to all lanes: T bit indicates how many Dregs to write.
+     * VLD2/3/4 to all lanes: T bit indicates register stride.
+     */
+    stride = a->t ? 2 : 1;
+    vec_size = nregs == 1 ? stride * 8 : 8;
+
+    tmp = tcg_temp_new_i32();
+    addr = tcg_temp_new_i32();
+    load_reg_var(s, addr, a->rn);
+    for (reg = 0; reg < nregs; reg++) {
+        gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                        s->be_data | size);
+        if ((vd & 1) && vec_size == 16) {
+            /*
+             * We cannot write 16 bytes at once because the
+             * destination is unaligned.
+             */
+            tcg_gen_gvec_dup_i32(size, neon_reg_offset(vd, 0),
+                                 8, 8, tmp);
+            tcg_gen_gvec_mov(0, neon_reg_offset(vd + 1, 0),
+                             neon_reg_offset(vd, 0), 8, 8);
+        } else {
+            tcg_gen_gvec_dup_i32(size, neon_reg_offset(vd, 0),
+                                 vec_size, vec_size, tmp);
+        }
+        tcg_gen_addi_i32(addr, addr, 1 << size);
+        vd += stride;
+    }
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(addr);
+
+    gen_neon_ldst_base_update(s, a->rm, a->rn, (1 << size) * nregs);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3f97635a524..a9cad04ba91 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3224,7 +3224,6 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     int size;
     int reg;
     int load;
-    int vec_size;
     TCGv_i32 addr;
     TCGv_i32 tmp;
 
@@ -3254,58 +3253,8 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     } else {
         size = (insn >> 10) & 3;
         if (size == 3) {
-            /* Load single element to all lanes.  */
-            int a = (insn >> 4) & 1;
-            if (!load) {
-                return 1;
-            }
-            size = (insn >> 6) & 3;
-            nregs = ((insn >> 8) & 3) + 1;
-
-            if (size == 3) {
-                if (nregs != 4 || a == 0) {
-                    return 1;
-                }
-                /* For VLD4 size==3 a == 1 means 32 bits at 16 byte alignment */
-                size = 2;
-            }
-            if (nregs == 1 && a == 1 && size == 0) {
-                return 1;
-            }
-            if (nregs == 3 && a == 1) {
-                return 1;
-            }
-            addr = tcg_temp_new_i32();
-            load_reg_var(s, addr, rn);
-
-            /* VLD1 to all lanes: bit 5 indicates how many Dregs to write.
-             * VLD2/3/4 to all lanes: bit 5 indicates register stride.
-             */
-            stride = (insn & (1 << 5)) ? 2 : 1;
-            vec_size = nregs == 1 ? stride * 8 : 8;
-
-            tmp = tcg_temp_new_i32();
-            for (reg = 0; reg < nregs; reg++) {
-                gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
-                                s->be_data | size);
-                if ((rd & 1) && vec_size == 16) {
-                    /* We cannot write 16 bytes at once because the
-                     * destination is unaligned.
-                     */
-                    tcg_gen_gvec_dup_i32(size, neon_reg_offset(rd, 0),
-                                         8, 8, tmp);
-                    tcg_gen_gvec_mov(0, neon_reg_offset(rd + 1, 0),
-                                     neon_reg_offset(rd, 0), 8, 8);
-                } else {
-                    tcg_gen_gvec_dup_i32(size, neon_reg_offset(rd, 0),
-                                         vec_size, vec_size, tmp);
-                }
-                tcg_gen_addi_i32(addr, addr, 1 << size);
-                rd += stride;
-            }
-            tcg_temp_free_i32(tmp);
-            tcg_temp_free_i32(addr);
-            stride = (1 << size) * nregs;
+            /* Load single element to all lanes -- handled by decodetree  */
+            return 1;
         } else {
             /* Single element.  */
             int idx = (insn >> 4) & 0xf;
diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index dd03d5a37bd..f0ab6d2c987 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -34,3 +34,8 @@
 
 VLDST_multiple 1111 0100 0 . l:1 0 rn:4 .... itype:4 size:2 align:2 rm:4 \
                vd=%vd_dp
+
+# Neon load single element to all lanes
+
+VLD_all_lanes  1111 0100 1 . 1 0 rn:4 .... 11 n:2 size:2 t:1 a:1 rm:4 \
+               vd=%vd_dp
-- 
2.20.1


