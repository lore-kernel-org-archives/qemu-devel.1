Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07191CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADAD205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvAGOaSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADAD205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJ9y-0007Da-8w
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp4-0004mY-RS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp3-0005aY-FS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:18 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIp3-0005Zd-Au
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:17 -0400
Received: by mail-qk1-x741.google.com with SMTP id m4so3244209qke.9
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JjWcaTsnfa9rn5Sr9u0qn7xbDpDf/Xngde06dSTH5/8=;
 b=xvAGOaSrw0eVg5PLraV/c3pa1IsjmiLrQ/GZQUHU+4DVYyTs58Qbmsa1U1sihy0SAM
 HhhkF41bkgIkLMwVGC59UrY/Vrvnx2BzoI41MRbR/68WItfrITAdhNc3UG+1cnENG6Y0
 XMjcb9Wo2zYhdrHKYzC/8bvDSqpwKS96tEKnGo2DUzN0fI0/kfyvMxu91p97az6Gkbgk
 LWmAMQsOBR+8pEu3XqtXlNmAaw6h35WxTFW8CPe/K4Txmb0aaDNbiklT9ZqV1DkFWZoo
 zJQZzOvkfFsocg8SWY9T3zmy9+m8TVDYF5G6SwG3IK1pxd4fwp0lrtm+5Z7fOSRFbhkH
 yW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JjWcaTsnfa9rn5Sr9u0qn7xbDpDf/Xngde06dSTH5/8=;
 b=Tx+hS39Zh7YzTLeeihcxoinddu8sZeU5EM+ivinIlYBVxKpQYlifuDxxrheAIEoY8Z
 o65svB2J2zN69Hx/6cmkeYstIjDyTvxvmIlsBji8yqua7j0SmqfpWzUDlZeH7SIvs2D3
 iROwWBL047lAZ5JfzBN5RqE2pSmDD9jYnAxhAzN1asSSiGObB/RLlw52FMwTELkfIZnW
 zqC0LZBP7TBHLY8wt6NX+MG48VoqWbsqVz9l2l0FDlpg2FLw1lgC7te+PI+hQAHGIrX3
 BL1kwSVqrkLlQRnZA4Vd3biKLw7IYvL8+w01XSmlP6Qv6FE9SRBufIysPonGQ7dh8bSH
 XBMQ==
X-Gm-Message-State: APjAAAUIQMRUhleTexGBbDgy83vfV+q7oQ+9LGK4vHipALVUKeGS/Wyn
 pYGkewmwC5SncKweh/Cm/UboRnWxclM=
X-Google-Smtp-Source: APXvYqzsG5OEUNH6cqyMrYkUZCFKFOlkOfKxnrAKf2eA7rgvL2bs56EOGsDwFiRK8Gd/2WyzO4MdpA==
X-Received: by 2002:a37:90c2:: with SMTP id s185mr1977393qkd.377.1571845516352; 
 Wed, 23 Oct 2019 08:45:16 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
Date: Wed, 23 Oct 2019 11:45:05 -0400
Message-Id: <20191023154505.30521-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This eliminates a set of runtime shifts.  It turns out that we
require TARGET_PAGE_MASK more often than TARGET_PAGE_SIZE, so
redefine TARGET_PAGE_SIZE based on TARGET_PAGE_MASK instead of
the other way around.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 8 ++++++--
 exec-vary.c            | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ba6d3306bf..08b3a5ab06 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -213,6 +213,7 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 typedef struct {
     bool decided;
     int bits;
+    target_long mask;
 } TargetPageBits;
 # if defined(CONFIG_ATTRIBUTE_ALIAS) || !defined(IN_EXEC_VARY)
 extern const TargetPageBits target_page;
@@ -221,15 +222,18 @@ extern TargetPageBits target_page;
 # endif
 # ifdef CONFIG_DEBUG_TCG
 #  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+#  define TARGET_PAGE_MASK (assert(target_page.decided), target_page.mask)
 # else
 #  define TARGET_PAGE_BITS target_page.bits
+#  define TARGET_PAGE_MASK target_page.mask
 # endif
+# define TARGET_PAGE_SIZE  (-(int)TARGET_PAGE_MASK)
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
+#define TARGET_PAGE_SIZE   (1 << TARGET_PAGE_BITS)
+#define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
 #endif
 
-#define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
diff --git a/exec-vary.c b/exec-vary.c
index e0befd502a..0594f61fef 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -97,5 +97,6 @@ void finalize_target_page_bits(void)
         init_target_page.bits = TARGET_PAGE_BITS_MIN;
     }
     init_target_page.decided = true;
+    init_target_page.mask = (target_long)-1 << init_target_page.bits;
 #endif
 }
-- 
2.17.1


