Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BC2C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEF0206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUewS94v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEF0206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyi7-0005E8-Sr
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybD-00051r-Mz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybC-00076r-Kf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:19 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybC-000749-Fc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:18 -0500
Received: by mail-pf1-x442.google.com with SMTP id b19so6386992pfo.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZD30K4OON5Rr10XGqonKOfQz8NelurszVZDAGc9w8Wk=;
 b=hUewS94vJaFiLoGTYHAW6I425qQZX8O5Dh0yStRd1pOpftvLaClBLaFzXIwJe/VgGi
 ENASUAZ2OVz/d/YyA7HDk/JcJd0e+5Q0PWmc4gUVHH3orp8enAEEBFB2wWmRu40Df6TZ
 dmHb+3jUkvd774DGb1Jp8FNFjONM/U4XJOJr+paLh1Omm+bqogvpqIyG1cZ7ABOiyVnE
 wZ+01m4dXuM/SZXV/E70No74XZjvLSg/6dr+DMdt+5mkzPh5ykuRw54cunsZOhmgTiAj
 pvmCoCWaI7mAr7xNMahNYSuMOIBcXMoFJQnoXnps++FAgIArnUG3jf/o0vQxufU9g5bg
 JkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZD30K4OON5Rr10XGqonKOfQz8NelurszVZDAGc9w8Wk=;
 b=PJK+f/NqL62hUl91X8NZYMlQ2P3uwlT0g4o9aozwMtoJZ7s8apm3664O8OQehvPW45
 vLnJ2Pe/mH4+tmml+8fQW2N/UvQA7JnNp+CNLVdOTzXLlVdnTlBdDgW8mCgXlqoxcvTr
 U2WweP1+fDJB8syxJROvDW2x7/qrbGX6rjdODj+saZRqbzAZuPrlAm6CcY+iWnoIOrqE
 DdeAjv/m8VXPJ3rWRWh8eA3GdqnVHMlsvTUiDnGhg/GNKrwrgYzUj64mXDVDQHZ3ko0B
 drJgBNmMVi87W2iM2pPQjOQbEc0WWnh59oiiYI/IK7j8VhsJna5XkBVEscAN80EaNBMD
 gdIA==
X-Gm-Message-State: APjAAAXdrPHhIN8xWsFFDxteyan5WyUOZ/JV+f06ZbOjHcBMG0uK+sU+
 fOHc5129VGE3qgCAVOvBCd7kBR3N9qI=
X-Google-Smtp-Source: APXvYqw5LYqS3W8VaymriZeh9znnLBHhaiP2G3zLYYa+aVfvGRkcFXxd1JEobQDyRQwrOFNVfX4TKg==
X-Received: by 2002:a62:1488:: with SMTP id 130mr18399171pfu.238.1576534337360; 
 Mon, 16 Dec 2019 14:12:17 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/28] target/arm: Include tcg.h in sve_helper.c
Date: Mon, 16 Dec 2019 12:11:40 -1000
Message-Id: <20191216221158.29572-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fc0c1755d2..83cc7f5bb5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
+#include "tcg.h"
 
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
-- 
2.20.1


