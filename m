Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E57C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6022A2075E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wn3u4hXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6022A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqdU-00082B-Jo
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVo-0003rq-F3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVm-0004Ts-IE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVm-0004TF-BT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id d77so2250804wmd.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Dj9bvmQD1l5de8jG8VJF31FLCLEGTP0nVDrh17bTiY=;
 b=wn3u4hXoejvD+TBBFVuquKqc7FHlfav1FYlvJdTory5jgXqTZt6EOTc3eHrcblqs++
 oMBEvm4HFNeaKpkU19bdg2gzOiHjtbFRlQW7enV5FueUPCwvRmsu/1MsVRSddjXb5VM8
 FBJbvlhRjnQ/3TdY/6/NDB/NuM4/sBg5pWUt2DSWtrOt6dupLil9mwi363vQBu7eYDzc
 xitJGkR8TjtmYFS8eG4RpgtEH8nIeZAe3CV4k8QW8z0375jWq+4AjYe6R3AvbprCFtxw
 SHMOVrjo3cC1IclJreMpJxWvFwfK9aUXR34zWJP1eysCQs43mawDuHCBLF1W+xArl3Zg
 hskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Dj9bvmQD1l5de8jG8VJF31FLCLEGTP0nVDrh17bTiY=;
 b=k0nKjYOsoAjNRqjX1ToWhzo9QMNKyliCGb0uZxr6jPhCNlkzoQEzfrNE3VF+Z8Y0jT
 tW6qIjCAOCsrVF9zbQKxCuHu4nLjId1Noy9P5+WyGAqSNkGSxktSZ8Cqwd1ZSWXmvZof
 AC4bRPtSXp/p+oEkwNSdmwv+DSR+OacRyD+4A/Sz+mLIKbW16iXSTQW2aBLcgtPPDJye
 LDLbyrtuGkUl2CYTygB14eNq0uUaAwZrSC91MhV/SZuTucZYwU+hNqVeGpOye7XUZzAh
 M/1KkOMAE0GlpDT71mlfdpOYlv/JVBRA+9UabX9chndt5iDJnhZ9+zDxgV8tUPfnFpmh
 wVAQ==
X-Gm-Message-State: AGi0PuY91bKmVxKIn0d8z/R459tB9pWoAt9Q2ohm0M/Yt0WhANx86mhx
 aDuatBCYqccZ7hWGlNaqUWZTag==
X-Google-Smtp-Source: APiQypJh/j9qc+L/jj3QxgXIXeFngYvU6iyA3Cw4dp+qvHzXKQdOT4kT9p9lbnRUkNTYJ6KY4i5Dyw==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr1448584wma.130.1586274697219; 
 Tue, 07 Apr 2020 08:51:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e23sm21278552wra.43.2020.04.07.08.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66BC41FF9C;
 Tue,  7 Apr 2020 16:51:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/13] tcg/i386: Fix %r12 guest_base initialization
Date: Tue,  7 Apr 2020 16:51:18 +0100
Message-Id: <20200407155118.20139-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

When %gs cannot be used, we use register offset addressing.
This path is almost never used, so it was clearly not tested.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200406174803.8192-1-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 7f61eeedd09..ec083bddcfb 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3737,7 +3737,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         } else {
             /* Choose R12 because, as a base, it requires a SIB byte. */
             x86_guest_base_index = TCG_REG_R12;
-            tcg_out_mov(s, TCG_TYPE_PTR, x86_guest_base_index, guest_base);
+            tcg_out_movi(s, TCG_TYPE_PTR, x86_guest_base_index, guest_base);
             tcg_regset_set_reg(s->reserved_regs, x86_guest_base_index);
         }
     }
-- 
2.20.1


