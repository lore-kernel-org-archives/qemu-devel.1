Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D022C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC312072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbQNc8jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC312072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxgO-0001Gu-2V
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWg-00033N-KL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:10 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:53751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWf-00058i-CG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:10 -0400
Received: by mail-pj1-x102c.google.com with SMTP id ci21so4301989pjb.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yWhTT6Tler29jJNVR4Zy3JBAxKgKpOlXGq4NgNVQoXk=;
 b=jbQNc8jmS6QsogwRXB6jiRqzwhYNSaoVNMotTMIk4pxg0AowvCR/GNpofFlPtGCkGh
 LEoC/59q5a2k8KPNdmnH4sQGCAz1ZqxutLuhGO2BWecKWos7Nhiw2yOIdu9UxkXEbK8F
 RqC1QtFoRzaQJf1KHI/WM7ixkP0zKXp12OYBEjdFyPYTjRjEQcYd3Dlo8X4jeMLyAi9s
 3NNBA/vP3QO/FitdSI/VkIAp8Njgn0DHkd2F64Adl1FViF93J7T+pcfnK63ZNWTNhC7y
 lSgQxJYYvDLjxLTVYuQa2XHOlwKvKTFCWb6NULs6tORLJj9faa5dkrJ9kbv58kXAQV5K
 F1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yWhTT6Tler29jJNVR4Zy3JBAxKgKpOlXGq4NgNVQoXk=;
 b=pEf+HjaqmGjfnMzjCZkXGhh/QnJT9c9WXKru+C0cHP+vWn2uMT3Q5oQD0IhZeye1tG
 fLRq23QtM6Acf4do9YSUx6PsNHTEM3rv1acwf0ypHoue2stfN4E4+yEBuldsMpvp2N7R
 beDvq+IZzQrNYB9XRLUYU5XZZ4CyePS60U9FaKogh7plu6lAB4gUcxW5kbsLZAk2dTwp
 CPrhsaiS7czuMtuJ9gMALJ/n0ZTCybsLoOg1kO1ikSLcpBZZkrAgpJfYtrj8Nisi41GR
 ydOmHSCdDB3R5of+gOxbabNvdjEf7Rjf2fnP1A5Z7VN2KsDdxs+67emdLCP7gu5lZLwy
 I/mg==
X-Gm-Message-State: AOAM531ffd0fvJjElrJECf6w73nxV1hrusZ3uHz0g0VX5b8r7AqHTKOi
 TX3Fp/ae50jYJEkVnrtCtN1fm9Kij90=
X-Google-Smtp-Source: ABdhPJwfnORRMmewVmf4ibPtq53wyRK/Fpyz52RhkpPsgmwdwchuk0CyYyJ4jXZlgWd7B17cmU9D2Q==
X-Received: by 2002:a17:90a:17ed:: with SMTP id
 q100mr1677697pja.80.1590114907295; 
 Thu, 21 May 2020 19:35:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/25] aarch64: Use arch_init to configure sve
Date: Thu, 21 May 2020 19:34:35 -0700
Message-Id: <20200522023440.26261-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adjust some of the aarch64 code to look at the reginfo struct
instead of looking at test_sve, so that we do not need to pass
the --test-sve option in order to dump sve trace files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                 |  1 +
 risu.c                 |  3 +++
 risu_reginfo_aarch64.c | 55 +++++++++++++++++++++++++++---------------
 risu_reginfo_arm.c     |  4 +++
 risu_reginfo_i386.c    |  4 +++
 risu_reginfo_m68k.c    |  4 +++
 risu_reginfo_ppc64.c   |  4 +++
 7 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/risu.h b/risu.h
index 3cad3d5..bdb70c1 100644
--- a/risu.h
+++ b/risu.h
@@ -23,6 +23,7 @@
 extern const struct option * const arch_long_opts;
 extern const char * const arch_extra_help;
 void process_arch_opt(int opt, const char *arg);
+void arch_init(void);
 #define FIRST_ARCH_OPT   0x100
 
 /* GCC computed include to pull in the correct risu_reginfo_*.h for
diff --git a/risu.c b/risu.c
index a70b778..1c096a8 100644
--- a/risu.c
+++ b/risu.c
@@ -617,6 +617,9 @@ int main(int argc, char **argv)
 
     load_image(imgfile);
 
+    /* E.g. select requested SVE vector length. */
+    arch_init();
+
     if (ismaster) {
         return master();
     } else {
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index a1020ac..fb8e11a 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -44,8 +44,6 @@ const char * const arch_extra_help
 void process_arch_opt(int opt, const char *arg)
 {
 #ifdef SVE_MAGIC
-    long want, got;
-
     assert(opt == FIRST_ARCH_OPT);
     test_sve = strtol(arg, 0, 10);
 
@@ -53,22 +51,37 @@ void process_arch_opt(int opt, const char *arg)
         fprintf(stderr, "Invalid value for VQ (1-%d)\n", SVE_VQ_MAX);
         exit(EXIT_FAILURE);
     }
-    want = sve_vl_from_vq(test_sve);
-    got = prctl(PR_SVE_SET_VL, want);
-    if (want != got) {
-        if (got < 0) {
-            perror("prctl PR_SVE_SET_VL");
-        } else {
-            fprintf(stderr, "Unsupported value for VQ (%d != %d)\n",
-                    test_sve, (int)sve_vq_from_vl(got));
-        }
-        exit(EXIT_FAILURE);
-    }
 #else
     abort();
 #endif
 }
 
+void arch_init(void)
+{
+#ifdef SVE_MAGIC
+    long want, got1, got2;
+
+    if (test_sve == 0) {
+        return;
+    }
+
+    want = sve_vl_from_vq(test_sve);
+    asm(".arch_extension sve\n\trdvl %0, #1" : "=r"(got1));
+    if (want != got1) {
+        got2 = prctl(PR_SVE_SET_VL, want);
+        if (want != got2) {
+            if (got2 < 0) {
+                perror("prctl PR_SVE_SET_VL");
+                got2 = got1;
+            }
+            fprintf(stderr, "Unsupported value for VQ (%d != %d)\n",
+                    test_sve, (int)sve_vq_from_vl(got1));
+            exit(EXIT_FAILURE);
+        }
+    }
+#endif
+}
+
 int reginfo_size(struct reginfo *ri)
 {
 #ifdef SVE_MAGIC
@@ -170,6 +183,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
         if (sve->head.size < SVE_SIG_CONTEXT_SIZE(vq)) {
             if (sve->head.size == sizeof(*sve)) {
                 /* SVE state is empty -- not an error.  */
+                goto do_simd;
             } else {
                 fprintf(stderr, "risu_reginfo_aarch64: "
                         "failed to get complete SVE state\n");
@@ -182,6 +196,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
                SVE_SIG_CONTEXT_SIZE(vq) - SVE_SIG_REGS_OFFSET);
         return;
     }
+ do_simd:
 #endif /* SVE_MAGIC */
 
     for (i = 0; i < 32; i++) {
@@ -260,8 +275,9 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "  fpcr   : %08x\n", ri->fpcr);
 
 #ifdef SVE_MAGIC
-    if (test_sve) {
-        int q, vq = test_sve;
+    if (ri->sve_vl) {
+        int vq = sve_vq_from_vl(ri->sve_vl);
+        int q;
 
         fprintf(f, "  vl     : %d\n", ri->sve_vl);
 
@@ -339,13 +355,12 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
     }
 
 #ifdef SVE_MAGIC
-    if (test_sve) {
+    if (m->sve_vl != a->sve_vl) {
+        fprintf(f, "  vl    : %d vs %d\n", m->sve_vl, a->sve_vl);
+    }
+    if (m->sve_vl) {
         int vq = sve_vq_from_vl(m->sve_vl);
 
-        if (m->sve_vl != a->sve_vl) {
-            fprintf(f, "  vl    : %d vs %d\n", m->sve_vl, a->sve_vl);
-        }
-
         for (i = 0; i < SVE_NUM_ZREGS; i++) {
             uint64_t *zm = reginfo_zreg(m, vq, i);
             uint64_t *za = reginfo_zreg(a, vq, i);
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 47c52e8..202120b 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -36,6 +36,10 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(*ri);
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 50505ab..e9730be 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -74,6 +74,10 @@ void process_arch_opt(int opt, const char *arg)
     }
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(*ri);
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 4eb30cd..4c25e77 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -23,6 +23,10 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(*ri);
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 39e8f1c..c80e387 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -32,6 +32,10 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(*ri);
-- 
2.20.1


