Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9600C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C64420B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cet4zqGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C64420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBeD-0006gA-PD
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42201)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002FX-AY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004yE-He
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004kQ-8j
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id f10so1243927wmb.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=99Dn3AIAE6bUMupx6Zxv5Z+hFUdE7BsSiaYvbx/TT8U=;
 b=Cet4zqGwxmOsg9wlvbgbB0jSgfw143kcG3Mv7oMA9DzOl4GxtUwDEb6PX6Sg3z5M+z
 JZf0Uwnz9fxzhft81kDZx9UdVtyRB83w1uBvVm8KnaDrwGEKBSndUQxp/f7w1SPnFAYL
 iBe3UjrzbHBwmqh9CKW5/gXpDVPh+EIoGyvi4z7H/uMd2pZWvi5RmGOeDZApH59+4iGG
 7CnkqWmuehmD4BBuiEHEBnKkpy3bt6tcruNrZLMQtzOE4ISLtIG39GLFX4/GNF18JOel
 pOtFQRlNDAJTH/gvTMceJX1vXnM9EyXIzGWh0YnPLUH1X50mKbMWgdE9h8EOaeIVqRXB
 VlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=99Dn3AIAE6bUMupx6Zxv5Z+hFUdE7BsSiaYvbx/TT8U=;
 b=H2Er5Ci16YzhMU02tGQX0S9BJDM4hI/7yuxM75aoBW5q3KPg7XqX6LqXknBpUadlcV
 X3tVgh2Ahj8Puj4zP9Bo80PXhr6/K8OpMIRNstRwApbyTbVx+oL6sxMZjcj09F339ruD
 1h1hKargy23Ub8uOmiYN1muoW2Lc8MGECDp13I+QstUzBxk+osox/wa24ERCJFWNIPTn
 Tu3c1cYT62iHa7fwWLWyIQNiO/+vnRpkwahzLOUQ1QppSGK75Baea2Jg1SOmRpPLrvF+
 2SL/Gbrc2YrtDd2za04Y7EHrRb+yWb/sJME/PouCURHUCzFSnU4yv4kLSOvUstGJmwgl
 vv2Q==
X-Gm-Message-State: APjAAAVWn9uoJnQJSzLTzIGNHONBo19fLqcp7YkQmbs8hwucHvjqyhVW
 VgrH5q/eLElYinsZsiCBQs2/rw==
X-Google-Smtp-Source: APXvYqwTjIomDmqChv3zwEFdhG5z/ke18HDvwWXCELjQ8XLSLdBAO/ekGKrW3DM9bOTVDcIaen+K9w==
X-Received: by 2002:a05:600c:20c3:: with SMTP id
 y3mr3008049wmm.3.1559898753112; 
 Fri, 07 Jun 2019 02:12:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j82sm1303398wmj.40.2019.06.07.02.12.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31EC21FFB1;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:26 +0100
Message-Id: <20190607090552.12434-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 27/52] cputlb: use uint64_t for interim values
 for unaligned load
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running on 32 bit TCG backends a wide unaligned load ends up
truncating data before returning to the guest. We specifically have
the return type as uint64_t to avoid any premature truncation so we
should use the same for the interim types.

Fixes: https://bugs.launchpad.net/qemu/+bug/1830872
Fixes: eed5664238e

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdcc377102..b796ab1cbe 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                     >= TARGET_PAGE_SIZE)) {
         target_ulong addr1, addr2;
-        tcg_target_ulong r1, r2;
+        uint64_t r1, r2;
         unsigned shift;
     do_unaligned_access:
         addr1 = addr & ~(size - 1);
-- 
2.20.1


