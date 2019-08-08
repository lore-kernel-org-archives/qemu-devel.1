Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC23C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C556217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCDcC8la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C556217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvlV0-0006K4-H1
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 12:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTg-0004Sz-BZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTe-0007W2-Gf
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvlTe-0007TI-Ag
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id b3so3192693wro.4
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2RSOSRsqssKleRulrR8mChIVkJMA0GRBzSuPGfLK1Fk=;
 b=tCDcC8laVqLxCvaFMM6CIe/d7HNAEQucF6h+x1wIpjnXFQeOabnDmL6aiPDByye1wO
 jWXXJ0l5Br5iyPVSjgKPeQ568YznWqbckDoc3cKvDju//eEACZwy/FT2k711v84VUlXp
 MQGQC8qElNG0Kjmjt5ElTm3XbaSganeutq12/1OWRxpRrvYol4XRJwVpO54dnRCxB/rr
 uV5BjlHKq4Y8cpuiav0/2Jp0szW6gwdqfYCZsVCyA+V6OoUXlz2ItRbMyZc9MZwbopHy
 ZtgnxhKohEgLNKNn4PE2cWBPoTnXAp/5lcUKJ3b7+n6XpuOfTmGVPmBks73WR7ChVKHF
 ling==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2RSOSRsqssKleRulrR8mChIVkJMA0GRBzSuPGfLK1Fk=;
 b=rFkO1trohX6hbdB0K0/BywB1751mCw5TL5BiS+uNwZhXSLpEMeHuPwpdqVIHN6ejHL
 BO62ofEvIDlXpkyEfBvS4wXBMT+dVF9glhb69KU9MPJHkCxOptD9BQASpxlHz0L6EDk7
 192Ilz0sveLWCv1XFWWEO1f7Oo0QzxVviLp7PKYUC5chLbcGcZemTK04bX0CKSgJRVSF
 m/MPyfarAbP1YrOfpvmkTfRgjvUGo+EvJEIiXEQo7RF/lKWvMlimW9I0iuPdsQCGvzB8
 hKD2kMST2wsunz5NTQcEx2XzGpn+5wiKUlYKGTQYpfk2LmlwOg+K284wQGHTB2WoWUK8
 4Ipw==
X-Gm-Message-State: APjAAAVRtrgVXwGGQDQlyG5ev0hqT8hG5xtZkr/dGS/2rt1wcWzFvF/U
 u/qCZ63kdzeDjsDEI0FdvZr4kA==
X-Google-Smtp-Source: APXvYqyIYPSWVLYwFGXw04m9H9cVVMkXonpEfpWoFHUq8hMUmiNAApv+LOc+sYct8TMgZcYUNUv12w==
X-Received: by 2002:adf:f2c4:: with SMTP id d4mr17797029wrp.3.1565282480941;
 Thu, 08 Aug 2019 09:41:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l3sm4724788wrb.41.2019.08.08.09.41.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 09:41:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9224F1FF90;
 Thu,  8 Aug 2019 17:41:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 17:41:13 +0100
Message-Id: <20190808164117.23348-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808164117.23348-1-alex.bennee@linaro.org>
References: <20190808164117.23348-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 3/7] fpu: make softfloat-macros
 "self-contained"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The macros use the "flags" type and to be consistent if anyone just
needs the macros we should bring in the header we need. There is an
outstanding TODO to audit the use of "flags" and replace with bool at
which point this include could be dropped.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat-macros.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index c55aa6d1742..e698bca4e1d 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -82,6 +82,8 @@ this code that are retained.
 #ifndef FPU_SOFTFLOAT_MACROS_H
 #define FPU_SOFTFLOAT_MACROS_H
 
+#include "fpu/softfloat-types.h"
+
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
 | bits are shifted off, they are ``jammed'' into the least significant bit of
-- 
2.20.1


