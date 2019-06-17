Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3C2C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A1C2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xy1A1GBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A1C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsoq-0001Lb-8c
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiF-0003RV-Mn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiE-000806-BR
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiE-0007x4-2u
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so10257918wru.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Yes+XPIwYzH/0L/luwos/53c0Vr5A+E/3/iRnhnUMhI=;
 b=Xy1A1GBBFS77IHMIiisB9rD/TfwAy0xj3fKBBYTLUvlff10zeWY6ki903zNPY8uTYJ
 nnIvuGE7oUH6wJUvznW7IGXzc/ttZ947WmIGqC61ect/HgorETGoky1oLBjMZUuV0S9R
 ztuX3wZLqexxyCYvC1k5hmxBgQ6zgopPD7YwLgJ1wY3mBPLbvujX4GQM9mFlfM4WOGEQ
 RbG5d9DyitWo92KMqTfYcK3Q1Rp4r1B74cIj1nR18M65EKezkHJ+HniZOrtOr7iIBkPo
 L12mYbuZ4dsJmEgja4uIvfR88LgM/j6dx+8D2kn6f569/6R/1cT/EqNUdzmhis61dTIM
 bpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yes+XPIwYzH/0L/luwos/53c0Vr5A+E/3/iRnhnUMhI=;
 b=VmTy8bfCGj46PJSkgxTK8SQ9M/EzAeh1pcXeMooCVwboO9hp0ZgYqnOlX29aCy//Of
 3pzWG+I3IxrhjZJy18pdKuVRHWf1QWK2WhpNbFm2c7xarx1qzybADP3qtQ5d+duACyx7
 X8wLpqrIef9/iZLjZIxFsHNL0NRuAOWuLn8QJYiTtKPvsnjhMVLOdP82ffEl8b+tTNoG
 l3eS4JCEbRJtTspNIOyQwZYLs/v+nDamZDv7+ouLnuHLtTeh1ha+1hr6RpcvVyJWI8QO
 5MzTAvHS+ZA1/xkEseMdJYbD8BkKUqjwcYj6UnX6mTLEia3ZpUNeW3taq6nGjs5C2aoH
 rOBQ==
X-Gm-Message-State: APjAAAUcuLnJKhfFQTTRgJEg1MkHyJB+bXjtz35oRqH6jX6WdNcISaXX
 UMf62f9mshgtvDq0Oit4JRB1AB7bQMXhpQ==
X-Google-Smtp-Source: APXvYqwCYqz+bflcX3kzilmdKLCARyjqgMhqt47s6YEm7KMWiMeCLK1wEKPo83w1Vt/S304OY54wqQ==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr1995895wrs.183.1560782057296; 
 Mon, 17 Jun 2019 07:34:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:50 +0100
Message-Id: <20190617143412.5734-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 02/24] hw/arm/boot: Diagnose layouts that put
 initrd or DTB off the end of RAM
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

We calculate the locations in memory where we want to put the
initrd and the DTB based on the size of the kernel, since they
come after it. Add some explicit checks that these aren't off the
end of RAM entirely.

(At the moment the way we calculate the initrd_start means that
it can't ever be off the end of RAM, but that will change with
the next commit.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Message-id: 20190516144733.32399-3-peter.maydell@linaro.org
---
 hw/arm/boot.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index bb37a9383f3..5ddba727d45 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1056,11 +1056,25 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         error_report("could not load kernel '%s'", info->kernel_filename);
         exit(1);
     }
+
+    if (kernel_size > info->ram_size) {
+        error_report("kernel '%s' is too large to fit in RAM "
+                     "(kernel size %d, RAM size %" PRId64 ")",
+                     info->kernel_filename, kernel_size, info->ram_size);
+        exit(1);
+    }
+
     info->entry = entry;
     if (is_linux) {
         uint32_t fixupcontext[FIXUP_MAX];
 
         if (info->initrd_filename) {
+
+            if (info->initrd_start >= ram_end) {
+                error_report("not enough space after kernel to load initrd");
+                exit(1);
+            }
+
             initrd_size = load_ramdisk_as(info->initrd_filename,
                                           info->initrd_start,
                                           ram_end - info->initrd_start, as);
@@ -1076,6 +1090,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
                              info->initrd_filename);
                 exit(1);
             }
+            if (info->initrd_start + initrd_size > info->ram_size) {
+                error_report("could not load initrd '%s': "
+                             "too big to fit into RAM after the kernel",
+                             info->initrd_filename);
+            }
         } else {
             initrd_size = 0;
         }
@@ -1111,6 +1130,10 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
             /* Place the DTB after the initrd in memory with alignment. */
             info->dtb_start = QEMU_ALIGN_UP(info->initrd_start + initrd_size,
                                            align);
+            if (info->dtb_start >= ram_end) {
+                error_report("Not enough space for DTB after kernel/initrd");
+                exit(1);
+            }
             fixupcontext[FIXUP_ARGPTR_LO] = info->dtb_start;
             fixupcontext[FIXUP_ARGPTR_HI] = info->dtb_start >> 32;
         } else {
-- 
2.20.1


