Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B5C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2AA2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0OXDxHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2AA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hk7-0004RC-V5
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNu-0005bU-7l
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNs-00055f-ME
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNs-000558-FA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id q17so16120736wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HFFhnwi1XTh3mteeZB/9qILvDTOSvSbdeT/3s5BHyng=;
 b=z0OXDxHK0OAM37pLD3qWAdkOd2MXOAjoEsXOa6/rmAaP3RxEgFPj+MkEEe2R5xmLyT
 N6Dmh4rlbm6D6Vet9Hp894dXJC+t8qEmC71ryNd0RW+HVcQDe5iCzPxr5Rqn49TAm3BQ
 AnCXv1eZ/FxwkMeZZ3G9yrEB+uCz53JO9cRicduZQO+8o3IkG/xVTlzDVLZ73oYpZ/2C
 yyIn7kMqwf0R0pQ+jLcrTC9Xvh8cokBxF0bN/XtySXYZs1gcf+J/ah3cg1+P6ypD+r9H
 KYb6pKaqYnMWJMv7iiwLor32Ucz7L46Y+P7Myse0E7ivB/R5AWUPYDJMzRPmgZNFIxWE
 kdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HFFhnwi1XTh3mteeZB/9qILvDTOSvSbdeT/3s5BHyng=;
 b=MQf6IAKMOqSPT4xVnmOKEdYQJaviyo/HFtt8MhhGOXWbvzk5Oii4mJJnUfEoIuNjgI
 Evg4Jz0t5TbWJFv2EF9YDdRRDeTcQeWHMrc4EyPqCyXxnOZEyW85m0uh7B1YVVc373Rp
 D+X0EUgZ87Invt8PEKg5y/PHe0TGQCMV/VROWm//ktLO1TvGp3aPana7L3jYV8998kub
 kctEHdG1d+cyqS0eiciVabE8r0s0ItSNuc0yzKGW0HgJaaosbIOzCteVBQNV/JO3Dlr6
 UiiE2JGkwAa76cc6jlVInHuaRpcpYHZaYRU/0UJGeu0tW+chvQ0xAtojbYA9jLla4cq5
 UjSg==
X-Gm-Message-State: APjAAAXnza2FlBCFPistzKbP/pR8YHfLCIxKUZ4xU584+O7dtEYFl/jh
 XMe+AYo9fHnSwuAmdXVTPok5jQ==
X-Google-Smtp-Source: APXvYqxOpSw0ENil0jtjZ3fVle80ExjXe/59M0PvW6ehdObFPjGLayobeFcun36dpUL6hl0rRdWCXA==
X-Received: by 2002:adf:f543:: with SMTP id j3mr8291026wrp.243.1568126683569; 
 Tue, 10 Sep 2019 07:44:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:26 +0100
Message-Id: <20190910144428.32597-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 11/13] target/arm/arm-semi: Implement support
 for semihosting feature detection
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
---
 target/arm/arm-semi.c | 107 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index f9019b00b8d..531084b7799 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -117,6 +117,7 @@ typedef enum GuestFDType {
     GuestFDUnused = 0,
     GuestFDHost = 1,
     GuestFDGDB = 2,
+    GuestFDFeatureFile = 3,
 } GuestFDType;
 
 /*
@@ -125,7 +126,10 @@ typedef enum GuestFDType {
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
@@ -467,6 +471,87 @@ static uint32_t gdb_flenfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
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
+static uint32_t featurefile_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
+{
+    /* Nothing to do */
+    return 0;
+}
+
+static uint32_t featurefile_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
+                                    target_ulong buf, uint32_t len)
+{
+    /* This fd can never be open for writing */
+    errno = EBADF;
+    return set_swi_errno(ts, -1);
+}
+
+static uint32_t featurefile_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
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
+static uint32_t featurefile_isattyfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
+{
+    return 0;
+}
+
+static uint32_t featurefile_seekfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
+                                   target_ulong offset)
+{
+    gf->featurefile_offset = offset;
+    return 0;
+}
+
+static uint32_t featurefile_flenfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
+{
+    return sizeof(featurefile_data);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
@@ -493,6 +578,14 @@ static const GuestFDFunctions guestfd_fns[] = {
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
@@ -586,6 +679,18 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             unlock_user(s, arg0, 0);
             return guestfd;
         }
+        if (strcmp(s, ":semihosting-features") == 0) {
+            unlock_user(s, arg0, 0);
+            /* We must fail opens for modes other than 0 ('r') or 1 ('rb') */
+            if (arg1 != 0 && arg1 != 1) {
+                dealloc_guestfd(guestfd);
+                errno = EINVAL;
+                return set_swi_errno(ts, -1);
+            }
+            init_featurefile_guestfd(guestfd);
+            return guestfd;
+        }
+
         if (use_gdb_syscalls()) {
             ret = arm_gdb_syscall(cpu, arm_semi_cb, "open,%s,%x,1a4", arg0,
                                   (int)arg2+1, gdb_open_modeflags[arg1]);
-- 
2.20.1


