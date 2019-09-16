Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00710C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA06A20650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWuRAHJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA06A20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sUs-0007eU-3T
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnS-0004bT-Me
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnQ-000711-Df
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnP-0006zL-St
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id a11so29317038wrx.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+TLqHbpNEdFdoOs/T99sxVwsEvUGOL0cA+fPHcIpClc=;
 b=sWuRAHJ+Lp0Yyv0LksXsbzNARffbqNQ0AtbIl7CvRMLd2hIXjLH8lWE3NXEhuRSd3n
 6fGAG4M1GfZCk4olMbIJd+8Mdx5UlNXa7NlpGadYbcpBak/Ee+l4bQPE4/ZdmtOjZBrb
 6ca+S9XAKta6/koGyMJrh94bpkEceDjcLIQ3wA11r4GJkh/flAkckunXEe1OyNY1b5HI
 iskjSbmUg6XHw5wI1y2cEvCnUwbmRt56MtvsDZ31Mq753n802xbbxMdKRqYGYWDyH+dl
 G3iKQBfkN6cVy2Ds7PFX659nn0mWc6FmYAdhjjqkih+qAjLfR803adNaPxqwDZN/5rrs
 BnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+TLqHbpNEdFdoOs/T99sxVwsEvUGOL0cA+fPHcIpClc=;
 b=RzQ8Zxtk62BUlPtCxf6P4QbwrOnd3rQMBqbCxEVN13jF4N2UuIFW6SImaTDkAGunKA
 mk2emOcl6xxl7G14QlBx0jTPpkWleePHy7rKXB/EzHXDeXN7zPfJpUO+NYYBJIoMcSuZ
 IvOwHzhKf/GifyML4RzsF0PwCbcvyJGDpSR9tAKF2QpNtdSOaJ/eoZhnfQWOKFzumxGm
 Bk4VcgbuE3smduFYSDjSnnjVeWAfzdIpAm/nU47FFl5E1anODGJcCIhWys+NU7W3UeAs
 1JiwqYHjGYJUhYtKlJ5ZNKwQ4LO4M6zSKsb8fSmDgSErAZPG0socGyn6msAcLpan43cn
 ftEg==
X-Gm-Message-State: APjAAAV2lg/etX+PdFMe74OVYyryKrnR9Y2u/poAXtBHOmFUTjAXEjkj
 OoV05yg1gsLFD+KobVHlZyUepQ==
X-Google-Smtp-Source: APXvYqxXjV9ACn0RO8JvYa5+5KwRR80QHwJXhZVSaT7RJR/S9Sse7DCQDn/W6/9nOCOwY4SIkfySAg==
X-Received: by 2002:a5d:55d0:: with SMTP id i16mr32654wrw.108.1568643362808;
 Mon, 16 Sep 2019 07:16:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:16:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:42 +0100
Message-Id: <20190916141544.17540-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 13/15] target/arm/arm-semi: Implement
 support for semihosting feature detection
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 2.0 of the semihosting specification added support for
allowing a guest to detect whether the implementation supported
particular features. This works by the guest opening a magic
file ":semihosting-features", which contains a fixed set of
data with some magic numbers followed by a sequence of bytes
with feature flags. The file is expected to behave sensibly
for the various semihosting calls which operate on files
(SYS_FLEN, SYS_SEEK, etc).

Implement this as another kind of guest FD using our function
table dispatch mechanism. Initially we report no extended
features, so we have just one feature flag byte which is zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/arm-semi.c | 109 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 87c911f0187..57491740d73 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -110,6 +110,7 @@ typedef enum GuestFDType {
     GuestFDUnused = 0,
     GuestFDHost = 1,
     GuestFDGDB = 2,
+    GuestFDFeatureFile = 3,
 } GuestFDType;
 
 /*
@@ -118,7 +119,10 @@ typedef enum GuestFDType {
  */
 typedef struct GuestFD {
     GuestFDType type;
-    int hostfd;
+    union {
+        int hostfd;
+        target_ulong featurefile_offset;
+    };
 } GuestFD;
 
 static GArray *guestfd_array;
@@ -504,6 +508,89 @@ static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
                            gf->hostfd, arm_flen_buf(cpu));
 }
 
+#define SHFB_MAGIC_0 0x53
+#define SHFB_MAGIC_1 0x48
+#define SHFB_MAGIC_2 0x46
+#define SHFB_MAGIC_3 0x42
+
+static const uint8_t featurefile_data[] = {
+    SHFB_MAGIC_0,
+    SHFB_MAGIC_1,
+    SHFB_MAGIC_2,
+    SHFB_MAGIC_3,
+    0, /* Feature byte 0 */
+};
+
+static void init_featurefile_guestfd(int guestfd)
+{
+    GuestFD *gf = do_get_guestfd(guestfd);
+
+    assert(gf);
+    gf->type = GuestFDFeatureFile;
+    gf->featurefile_offset = 0;
+}
+
+static uint32_t featurefile_closefn(ARMCPU *cpu, GuestFD *gf)
+{
+    /* Nothing to do */
+    return 0;
+}
+
+static uint32_t featurefile_writefn(ARMCPU *cpu, GuestFD *gf,
+                                    target_ulong buf, uint32_t len)
+{
+    /* This fd can never be open for writing */
+    CPUARMState *env = &cpu->env;
+
+    errno = EBADF;
+    return set_swi_errno(env, -1);
+}
+
+static uint32_t featurefile_readfn(ARMCPU *cpu, GuestFD *gf,
+                                   target_ulong buf, uint32_t len)
+{
+    uint32_t i;
+#ifndef CONFIG_USER_ONLY
+    CPUARMState *env = &cpu->env;
+#endif
+    char *s;
+
+    s = lock_user(VERIFY_WRITE, buf, len, 0);
+    if (!s) {
+        return len;
+    }
+
+    for (i = 0; i < len; i++) {
+        if (gf->featurefile_offset >= sizeof(featurefile_data)) {
+            break;
+        }
+        s[i] = featurefile_data[gf->featurefile_offset];
+        gf->featurefile_offset++;
+    }
+
+    unlock_user(s, buf, len);
+
+    /* Return number of bytes not read */
+    return len - i;
+}
+
+static uint32_t featurefile_isattyfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return 0;
+}
+
+static uint32_t featurefile_seekfn(ARMCPU *cpu, GuestFD *gf,
+                                   target_ulong offset)
+{
+    gf->featurefile_offset = offset;
+    return 0;
+}
+
+static uint32_t featurefile_flenfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return sizeof(featurefile_data);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
@@ -530,6 +617,14 @@ static const GuestFDFunctions guestfd_fns[] = {
         .seekfn = gdb_seekfn,
         .flenfn = gdb_flenfn,
     },
+    [GuestFDFeatureFile] = {
+        .closefn = featurefile_closefn,
+        .writefn = featurefile_writefn,
+        .readfn = featurefile_readfn,
+        .isattyfn = featurefile_isattyfn,
+        .seekfn = featurefile_seekfn,
+        .flenfn = featurefile_flenfn,
+    },
 };
 
 /* Read the input value from the argument block; fail the semihosting
@@ -616,6 +711,18 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             unlock_user(s, arg0, 0);
             return guestfd;
         }
+        if (strcmp(s, ":semihosting-features") == 0) {
+            unlock_user(s, arg0, 0);
+            /* We must fail opens for modes other than 0 ('r') or 1 ('rb') */
+            if (arg1 != 0 && arg1 != 1) {
+                dealloc_guestfd(guestfd);
+                errno = EACCES;
+                return set_swi_errno(env, -1);
+            }
+            init_featurefile_guestfd(guestfd);
+            return guestfd;
+        }
+
         if (use_gdb_syscalls()) {
             arm_semi_open_guestfd = guestfd;
             ret = arm_gdb_syscall(cpu, arm_semi_open_cb, "open,%s,%x,1a4", arg0,
-- 
2.20.1


