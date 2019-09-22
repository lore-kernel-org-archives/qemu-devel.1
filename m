Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48ABC3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DD8208C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHq64Hpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DD8208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBt3R-0006p8-3B
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxn-0001LU-7P
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxl-00085h-QH
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxl-00085K-KX
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id z12so5989848pgp.9
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=byxOPmOWUxDtiAxAlrSZ0T4d6Z5pot/AQfly4fPI+LE=;
 b=IHq64Hpw987w/v4gQ/depF8PupqP1t18Ieyvie54MBJpTzZRG0VgxoZmaSqkYIuFR6
 so8NZvhwtWEYnMJO3I2VW1rc4Ng9XO2nRBbXCvxkd/bE4RGoC5lE7c23mpJyV2mnkdpU
 f4qXjZsGnTNZzC1Lf3j41m6cYSgsmPx/3MaYZGPeyy12gBNFEzYTJjOhrrb8EvcDRCAA
 RGSHZiYFRUiG5HouPeti5AH/YFsDmf9vG1sautkZOeXaSp73Gev14YIdCLD9AOHsaZvY
 I7V+KfR+UJLvdPDdxKNyZaiHUm7RYcUIaFz6/hxOg7EKEgunRET32IDZyjvdue3aNtDs
 E1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=byxOPmOWUxDtiAxAlrSZ0T4d6Z5pot/AQfly4fPI+LE=;
 b=CPRV0sssA0ZCt/kJVcz90FVA1KUrb9IS0V/00c1E9wtaQPy2qWDeMoDj5Y1O5ewpH4
 +U4GdXOsuMVbfM9aZrEHHayQpwGX80dGH3DcIesrLfxb7H1vWs4iMH/bYj0LJdXqAzx/
 JcZQ0+2kxLmn4IT+wBVEW38c5ffNyUIYi90GsH0F9TCL7PebuKcMP+K7APpeUfjXpZMp
 G6HPNwRIQsYS6Yr3qipg51GA9DO4RAVp7WT8/brUFmEbe/zVlWDJez3y8tjwzy3s50Ki
 /K6I9+jtHAL5BnLeQuay6LmjvoTMiLTcmE2zk5hCyrDDRinbSbe/buy2JxnERY/aN3uf
 +MAA==
X-Gm-Message-State: APjAAAV0veU+7lFM5oGgfNGYYcLjl6PkkMRFP4HbNezfaQZf04GZAqJD
 l7X3RKmuHglD17fplW6HxDQkRGxAb9E=
X-Google-Smtp-Source: APXvYqwdYkasUAjt7wLwGAkQpq7RLmBw+FzSUFoYGU/2I0ApDfTK05npQuWnd85mlvM0wroL+rBKpQ==
X-Received: by 2002:a63:5754:: with SMTP id h20mr22412937pgm.195.1569124504267; 
 Sat, 21 Sep 2019 20:55:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/20] exec: Use const alias for TARGET_PAGE_BITS_VARY
Date: Sat, 21 Sep 2019 20:54:41 -0700
Message-Id: <20190922035458.14879-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using a variable that is declared "const" for this tells the
compiler that it may read the value once and assume that it
does not change across function calls.

For target_page_size, this means we have only one assert per
function, and one read of the variable.

This reduces the size of qemu-system-aarch64 by 8k.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 10 +++++----
 exec-vary.c            | 46 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e0c8dc540c..a53b761b48 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -210,10 +210,12 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 /* page related stuff */
 
 #ifdef TARGET_PAGE_BITS_VARY
-extern bool target_page_bits_decided;
-extern int target_page_bits;
-#define TARGET_PAGE_BITS ({ assert(target_page_bits_decided); \
-                            target_page_bits; })
+typedef struct {
+    bool decided;
+    int bits;
+} TargetPageBits;
+extern const TargetPageBits target_page;
+#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
diff --git a/exec-vary.c b/exec-vary.c
index 48c0ab306c..67cdf57a9c 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -22,8 +22,38 @@
 #include "exec/exec-all.h"
 
 #ifdef TARGET_PAGE_BITS_VARY
-int target_page_bits;
-bool target_page_bits_decided;
+/*
+ * We want to declare the "target_page" variable as const, which tells
+ * the compiler that it can cache any value that it reads across calls.
+ * This avoids multiple assertions and multiple reads within any one user.
+ *
+ * This works because we initialize the target_page data very early, in a
+ * location far removed from the functions that require the final results.
+ *
+ * This also requires that we have a non-constant symbol by which we can
+ * perform the actual initialization, and which forces the data to be
+ * allocated within writable memory.  Thus "init_target_page", and we use
+ * that symbol exclusively in the two functions that initialize this value.
+ *
+ * The "target_page" symbol is created as an alias of "init_target_page".
+ */
+static TargetPageBits init_target_page;
+
+/*
+ * Note that this is *not* a redundant decl, this is the definition of
+ * the "target_page" symbol.  The syntax for this definition requires
+ * the use of the extern keyword.  This seems to be a GCC bug in
+ * either the syntax for the alias attribute or in -Wredundant-decls.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91765
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wredundant-decls"
+
+extern const TargetPageBits target_page
+    __attribute__((alias("init_target_page")));
+
+#pragma GCC diagnostic pop
 #endif
 
 bool set_preferred_target_page_bits(int bits)
@@ -36,11 +66,11 @@ bool set_preferred_target_page_bits(int bits)
      */
 #ifdef TARGET_PAGE_BITS_VARY
     assert(bits >= TARGET_PAGE_BITS_MIN);
-    if (target_page_bits == 0 || target_page_bits > bits) {
-        if (target_page_bits_decided) {
+    if (init_target_page.bits == 0 || init_target_page.bits > bits) {
+        if (init_target_page.decided) {
             return false;
         }
-        target_page_bits = bits;
+        init_target_page.bits = bits;
     }
 #endif
     return true;
@@ -49,9 +79,9 @@ bool set_preferred_target_page_bits(int bits)
 void finalize_target_page_bits(void)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-    if (target_page_bits == 0) {
-        target_page_bits = TARGET_PAGE_BITS_MIN;
+    if (init_target_page.bits == 0) {
+        init_target_page.bits = TARGET_PAGE_BITS_MIN;
     }
-    target_page_bits_decided = true;
+    init_target_page.decided = true;
 #endif
 }
-- 
2.17.1


