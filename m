Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77701C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4571622464
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlM2O6WB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4571622464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyp5-00068t-95
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybP-0005MN-QI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybO-0007Pn-Op
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:31 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybO-0007OK-JQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:30 -0500
Received: by mail-pf1-x441.google.com with SMTP id 2so6376904pfx.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HC2V75/4cEYrSuehSqGFKt4qZAQdtudJE9CcEzS2ZMc=;
 b=mlM2O6WBUH+LbGvC6aZ0uVh/Xx8YWLRuP5gAe9BB9BUTkMOoj/HWaVFP7S0ew09q1v
 Fz+UAJqQex/Cmt821SwQcJYd7sEfI18aGRO7oH9gcZ1XPaSyYS3dIdnmKWqc/+F5L2v2
 CogC5wTLSGTvkAE+68INAkttFxM+pPVjca598vR9wQV3p0+LmrQ4VfxiLwrbtF5PTrJn
 kHR+7K4KTGzNstDxQURe/AlLKATZ5W6aQHWcT6Y+CiPg0ue2kiKQhOPTSJwF+9IiUvaY
 xhuO/DREwv4cBW4RUfki4A7aqKYVbeCq8yVxK1PVLXnVg3Ftg7aaxXBI75emE7Uzj6NP
 bRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HC2V75/4cEYrSuehSqGFKt4qZAQdtudJE9CcEzS2ZMc=;
 b=uXfwZNVR1szCM+gCY+3/fUhvmao4WSDhzaZQobTeAZDSu7gadGKN1L96NNkyROfxKM
 EyPWkDIOwl1KsZoN5rVePJF8jXXEFmwGBju4geHSUyqKlJ1wn0CNU2JG65pb7shzY/Hb
 vJB0inXR8sP6Om85hARDoNY3gLMMZx80aPcQmFwFddIhSt6TvXCo2radKm27Sl9ypF4F
 cKCxATgHX//VNLLeEK0Na6/Df36HC1qnc2XUBurLqRD4bw40Wz6qHfppV09DCTLYo3Is
 kyfd3jRsX2r/AJoHHKtDkACxJv82ph1bJfsAuJ86oQhkRF736mAiVcPrvfW7OqPgc+ZT
 MjRg==
X-Gm-Message-State: APjAAAUtMUFQlrL6jAFCbZ4vpU+/jTb/QrLunXcy+Q7XCC7rjH8maczO
 cCU+JOmoFu/odTO/DCxdM3Ss3/7G0nw=
X-Google-Smtp-Source: APXvYqy0kN1k32Q3ZJomEtOLxz1wG8ymwbnaqMBI2GZCSqs7o5ogYW0BZIg54+EM+10mNju2kraxkA==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr20870819pgl.230.1576534349416; 
 Mon, 16 Dec 2019 14:12:29 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/28] target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:48 -1000
Message-Id: <20191216221158.29572-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cde2a16b94..6a8228df4f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1949,9 +1949,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _ksmap
-#define MMU_MODE1_SUFFIX _user
-#define MMU_MODE2_SUFFIX _knosmap /* SMAP disabled or CPL<3 && AC=1 */
 #define MMU_KSMAP_IDX   0
 #define MMU_USER_IDX    1
 #define MMU_KNOSMAP_IDX 2
-- 
2.20.1


