Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0650C2D0E7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4DD20772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQAatAea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4DD20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJa1O-0001Dn-Ls
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyn-0004Of-Ew
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZym-0002Dj-6e
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZym-0002Ci-0m
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15so29711519wrx.9
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g9xr3EL2jz3uIXqebGO8vaQXLJoFQmUrqrOGsA7SE/w=;
 b=jQAatAearxd3EEiqn5tSEB6+FPS2h3k2Td14CANfqmoJCDJfGpFBHjeY6zadkSv24h
 yOzZ+c4oPh3X7mEkfCn1TLTvqVi8LMAO+is7A/sV2hSz/E6I7CaU7oRQFgjjil0LdgiZ
 2qwNUKn+0T+BxnJzheszEPcQLxXtYFhGbg9b/4h7EGsWqNryhmWWy0egpfn6c0HbPhJg
 f48+MdNSdYzfyYva/EklGDF/wx/edE196wks/6tT84kBC04HM55J1Zy0IjJSaxJXJ/dZ
 ocM6JskRmoB2jaw7XsvJkJgmPxtATA7+DDtpOKyykz3fMcNFL/j4Fn0WeZTaj0qjIEZm
 W8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g9xr3EL2jz3uIXqebGO8vaQXLJoFQmUrqrOGsA7SE/w=;
 b=KxUFRKFvBcdOmdj6c8ZoeUNgWYUmypsDxjsZLScBtIBEFLD3HWU8noKWaFRMRJWyPY
 OVz3mkbVZWhQgy8uHsA50hE1mzf9FICJpQqfRap+SbcqYrUU8doGu0rjcBay10oGSOOS
 MElNPXdUWTnQi3B3IVumF4oVmToy9uhMgerXLpXzsw8yx/R9ZI1PHVwAMhrKLDznsJ41
 gvb6R1Gr1aRAp/70FfAaSfWqI90IKOa0dDNV1pXTdyYTDh51qedtlb6BuiGtGyVnMIdi
 lryD6O60xv3i0IGzHyeJXJCqy8HpdfZ3jGCXIiUEOhy2mWupsvZpTLvh1aiT3ZN/cvW5
 vZBQ==
X-Gm-Message-State: ANhLgQ3XzRBVi+Hna/PMAFecqeV3SFPqA3ihC/tqoymVSEDI7HWCw/Ab
 MRyBCJy9im16P+2U2Rt7K+pVag==
X-Google-Smtp-Source: ADFU+vtwS+KAz6fvg7u2JoBRVhs6QF6eo84RM319suKKZ1QSLFOeFRtdMDaFZbtLM/uu+wHG5FBeIQ==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr26662376wrv.363.1585734491059; 
 Wed, 01 Apr 2020 02:48:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m8sm1906126wmc.28.2020.04.01.02.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 364971FF93;
 Wed,  1 Apr 2020 10:48:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/10] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
Date: Wed,  1 Apr 2020 10:47:56 +0100
Message-Id: <20200401094759.5835-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401094759.5835-1-alex.bennee@linaro.org>
References: <20200401094759.5835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

All other calls to normalize*Subnormal detect zero input before
the call -- this is the only outlier.  This case can happen with
+0.0 + +0.0 = +0.0 or -0.0 + -0.0 = -0.0, so return a zero of
the correct sign.

Reported-by: Coverity (CID 1421991)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200327232042.10008-1-richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 301ce3b537b..ae6ba718540 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         zSig1 = 0;
         zSig0 = aSig + bSig;
         if ( aExp == 0 ) {
+            if (zSig0 == 0) {
+                return packFloatx80(zSign, 0, 0);
+            }
             normalizeFloatx80Subnormal( zSig0, &zExp, &zSig0 );
             goto roundAndPack;
         }
-- 
2.20.1


