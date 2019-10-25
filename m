Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D8DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9F6205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVVAIhMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9F6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0ph-0001nS-Tn
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tm-0005Be-QD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tl-0001ff-Hy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:14 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:42371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tl-0001fN-7m
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:13 -0400
Received: by mail-qt1-x82d.google.com with SMTP id w14so3451279qto.9
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XXN4/2a2+6dy7fA+RkJ2f7Fcs3d5SyLj63Al4EWJuoY=;
 b=iVVAIhMBW5/uhD8NT5xQNE5ySyRimlk7WiQwN8AeZvtJ3r3uaipzyszVb11WaS3Kjb
 LvUtOxrPZKw9K0D0BsZrrPsbdUu8uTpyE1aPjubuFnWih2TaBYrblSlgdnt1vtk9AMmY
 lg1N6xMxUKE9lnbs+lT+2FQG4D6DfVAMlQDk/VR85mNTp4OmQZWTO7k4UpAlyhT7S2vF
 87RQjiDUpdqjfWiQQli2Dqk2K3zIZdJSN0DEHBX6rgdIdHeynhXT+aJ/CBeGqM6Bbbsx
 NqHAwLhIenV6mM7uVf0EJ+LNBHX+14tmaxEYhv0rLvZ2Wx1kZAyGb/yx/+cbP4gZ1ZQO
 Qr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XXN4/2a2+6dy7fA+RkJ2f7Fcs3d5SyLj63Al4EWJuoY=;
 b=DFssHhAmO0pKn9T8WFexDX3cJOMq7R2+tJ1NFhUkucsZs6UPIKKAzl+Q+nfZ0vlc2m
 iIipzohZ1uNAFgYPVzZrDoGEyEfNO+eMdRO1HiVwkucQ8D3etfoDW2AxZDkGe/jwSJds
 Cv+41SYzWQYUHdt0442Ps/wRZ52xp7hBWCYz/XQ/v+b8g/cQsDWAjXnVIQLUkJykWFog
 N0MPQZJxKnJVEptQHP1Vb428YDkB/VysVjowNoaOjo8jLI23qXN+X1aFObtaVPbQ+QCW
 bLUWN1n4oS58IRwJ+wIXLgusrtMnWZPgCm/kQ/HNSMTmkCLyuBCErrtgPw6zJnlkOcVB
 X9gA==
X-Gm-Message-State: APjAAAXWAEDQv2r5yHxhcMfro25ZkzjcMZfTbY+xZRpKmWASRXIHZ3QM
 akxbAztVRxe9XXZIyrj6o9qrSmDLnd4=
X-Google-Smtp-Source: APXvYqyzsFQYH3N2U9N8vPW9TmIQ4C0rTWraYSwq2B62S7bVmZbS4onHELAm2Am7dmuoHeC53q+Zww==
X-Received: by 2002:aed:228b:: with SMTP id p11mr1520365qtc.196.1572013332264; 
 Fri, 25 Oct 2019 07:22:12 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
Date: Fri, 25 Oct 2019 10:21:56 -0400
Message-Id: <20191025142159.12459-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82d
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

This eliminates a set of runtime shifts.  It turns out that we
require TARGET_PAGE_MASK more often than TARGET_PAGE_SIZE, so
redefine TARGET_PAGE_SIZE based on TARGET_PAGE_MASK instead of
the other way around.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


