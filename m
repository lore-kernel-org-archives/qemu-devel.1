Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F02C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9DA2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4/UMPy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9DA2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fDB-0000p5-5J
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7k-0005tJ-Dj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7j-0000lQ-Do
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:32 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7j-0000k3-6v
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:31 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so11550723wmi.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CamjQrx2ACX1pcdy+Ha3T8xE7Ntp0ezj0SgMxc8gmcs=;
 b=c4/UMPy4cEWJPOu19sIDnKbKBQHCK1UaTu2xAKNM7G9dpBGC0BpTwrms73Tw7DHAOp
 W/EwyK0Y6/aVJnVYm7U3+YbYtoFFHTNPjpRo559U8tBzqELS0evaNTQZOfvKso/CawwS
 u4lLC9WmW4YDEZG4acOP6YVl17f10YjGj0tKVknruBhTk+PFS0r6/Jc8/mr8B3rB+fhE
 dhcRFK3jj1mFvxOQvLk0427NibQLjYKnwVx8AUQipFcJIw/MLIUpPCy/zBoH1G7p0Kh9
 1O/Tg1YAMytA0UgR2oCfd3On9i9FwSIkzr1IvPaNHucldAkewUdK29EicVxuMOPipeD8
 2vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CamjQrx2ACX1pcdy+Ha3T8xE7Ntp0ezj0SgMxc8gmcs=;
 b=bZvvuWebjSJ3x+1/VDWnk6Ff0cdagw6xN1TzARG3vkwa5t85Hnj2V5h7tIkYaTYJF7
 q9toa6jymezqx/z4T9HToXnuu2/d2569uPsCQ6CXPs+3Xke+nc5J8bryrFeN8t1F3NqM
 wLMJCFzUFd7BSfAIbuo5dvfBygorVHDBh6/oJWb7xqnvsnWcfZ5JcseLYNe8DlOsKJV7
 DBxou/Q+DvOcv1pSUmnTiWgKFaE7vP5dPaNxvQRqUPIU5uqDtyGecg6UxBqYNvKwUKYQ
 5GQzgBtp3Lr99By/X1c9HPNp4idnsIUEB4Go3l2Fko4wdQAhypQj+Y9oHdnuYDOvPJ8Y
 34Dw==
X-Gm-Message-State: APjAAAVnu2C3aOhE5yazO0r4Blm3eR54ED1TuyF8B7Y26S5d/duqnhXF
 kedZi0j/eN/uIWGY+wFLs/p2vA==
X-Google-Smtp-Source: APXvYqy6560S0tzqD0RgASpxqZiSB2f/jGmZUl4l+KgLn2/1GqgfG+mTVYvpNwa8+/CFFS2UEkBCWQ==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr6083108wmi.118.1581702689959; 
 Fri, 14 Feb 2020 09:51:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/21] target/arm: Use FIELD macros for clearing ID_DFR0
 PERFMON field
Date: Fri, 14 Feb 2020 17:51:02 +0000
Message-Id: <20200214175116.9164-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already define FIELD macros for ID_DFR0, so use them in the
one place where we're doing direct bit value manipulation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We have lots of this non-FIELD style in the code, of course;
I change this one purely because it otherwise looks a bit odd
sat next to the ID_AA64DFR0 line that was changed in the previous
patch...
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 12bf9688007..1024f506c51 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1719,7 +1719,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     } else {
         cpu->id_aa64dfr0 = FIELD_DP64(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
-        cpu->id_dfr0 &= ~(0xf << 24);
+        cpu->id_dfr0 = FIELD_DP32(cpu->id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
-- 
2.20.1


