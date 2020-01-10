Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BAC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D1320673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v68t3ki4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D1320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwzG-0003Wk-Hi
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipwxb-0002Ma-Fy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipwxa-0007Yu-Ah
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:31 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipwxa-0007Vf-48
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:30 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so2357028wrt.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sH1vHww7VcOtks3y+ZrcP6gPfRazqmJe6Ac+pRXoMAs=;
 b=v68t3ki4ejQvRt4C0La+V1Fgz4LWFtZzi6/nBc6Pa14wdFP5ctr6kPq9HOCs+aFCa5
 IqthzQMFPMJtzW31N8g6rk9rhcKXSzpgwdB3FFyBRWqkOOsCi8vgjZCcUM8Vmyzc6cVt
 youK3jY9YVymMFynlCPqSnLw6uRBsk+9IerDQ5XuXCCpM/1dYa1uESDQODlM3YSS1y5W
 G+EjVbcRjkc2bcrVPKN8WPfCv/51Y0//6g2Mki1ZKX711EA0oyx0HhWd+C7ihnZNhlMi
 Ca34FiP+sEa7xHXpQnldl0/93avm29/i6NPSAwIlg2oBY3PkhI5C5J33dkDmcnyOvG3u
 Q4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sH1vHww7VcOtks3y+ZrcP6gPfRazqmJe6Ac+pRXoMAs=;
 b=CC4d6w9nlz9D4RtTX8Im2PevPoVssWUjYRnVjFdL4rQQ7Y6Z7EgeUUKSrZdWQQdGZv
 C7u7JTWy83IRplGJ/TlcnWYSXY/UrRpRx97LVyMvVA7hHT3r6ns2n93uL98HIiKjmASK
 VEQEIV31LKJa79wIvIbVSaDfho7nGTVIv+6bS+ojHlSn8R9a7q0iNTDTAmbAWjgrpxfy
 Wu9hQYXIcVCmLgaGUSI0Q/iVlGBlG4DxQoXUwzd8GctLiDFNAvhN+EVwnVH1gdCfvciq
 HNIXsSjItHqEBZRdVEQD4Ivk47vzZDyi4Yf7JqjiiENJOiIfJe0//CttvZnPs2xuSsMG
 VVgw==
X-Gm-Message-State: APjAAAX46J5kZQw7fL8/o+ZAhBBiu+8GSZ2JL//O43Lj+bsFOJFDgIGl
 v+nS6J/SMR3ABB5URT1MYI2kqA==
X-Google-Smtp-Source: APXvYqx1RFo+DRbavUS8IOkjJ8AzAYnRiAqaqiHiSibBMorJpn5zJgZApcAruVZhByDQ0Lyvha8x7Q==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr4283925wru.353.1578672989119; 
 Fri, 10 Jan 2020 08:16:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d14sm2826056wru.9.2020.01.10.08.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 08:16:27 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5DC421FF8C;
 Fri, 10 Jan 2020 16:16:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] target/arm: detect 64 bit overflow caused by high cval
 + voff
Date: Fri, 10 Jan 2020 16:16:25 +0000
Message-Id: <20200110161626.31943-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110161626.31943-1-alex.bennee@linaro.org>
References: <20200110161626.31943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, 1859021@bugs.launchpad.net,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we don't detect this we will be stuck in a busy loop as we schedule
a timer for before now which will continually trigger gt_recalc_timer
even though we haven't reached the state required to trigger the IRQ.

Bug: https://bugs.launchpad.net/bugs/1859021
Cc: 1859021@bugs.launchpad.net
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19a57a17da5..eb17106f7bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2481,6 +2481,9 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         } else {
             /* Next transition is when we hit cval */
             nexttick = gt->cval + offset;
+            if (nexttick < gt->cval) {
+                nexttick = UINT64_MAX;
+            }
         }
         /* Note that the desired next expiry time might be beyond the
          * signed-64-bit range of a QEMUTimer -- in this case we just
-- 
2.20.1


