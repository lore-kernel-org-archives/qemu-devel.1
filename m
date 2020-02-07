Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE7C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E1620720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gX8EC8Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E1620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04v5-0003AT-O7
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iD-0001EH-3n
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iB-0003Rm-Un
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iB-0003RF-O7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so2992333wmi.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/iMmJfLAD2Lg7VG8f5FsK2kFIH3mqZjV6A03FkEdXps=;
 b=gX8EC8ZmUBh7hHDYyUnYumEwgh8NB5b+ml/GPff9sjwRXnzcSjFHx4QSxU3mMyJFtP
 zRnaYXXYO6DfNKSDIEAgDKki6No/4VdHvHsDUq/csUiDuXCetYHx3eAbbhynM1gtul33
 JoatmOy0kPJgK5mRUFMEt/knsdfUggMxcH5DjE2gBd4jlOCNEr351zK19vJNcLnz+37S
 dqHSHyQ4iV6A4/0FQvGZpNZ0FqKPI/iIY14J3doy4TZlLh7ZrA0Ah7iy5pkfG+C+QLER
 WWbprJQZoW7qnUQaBSB6QhYpP8VnyBU5hf50RKyUPAKIWU1WffSbytatF3aGXow95wij
 NvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/iMmJfLAD2Lg7VG8f5FsK2kFIH3mqZjV6A03FkEdXps=;
 b=TGtu+Bo5uREELQim2ZmQEHHEU6jeNkoBEh7Y2kizrUDF47Kn44mOw7MPK+dgzkRIeo
 8uuPPqZ1a4l8NQ1rt2TwCukb/ZDD+dHxc0Y7G0PTu/HFVfLrWcvyROgKlOr5+8kaWWTD
 Ux/WFBohBOf+gKEE5DLQ1Kl+52DmzkswlRqRYhj7vU7OuKIiZLUNyTB3NrbmRwsfkSJ7
 8uIb/zH8le0XiNkl33KNqillFiqCZrwMYp6SbOlg5oL4TN7f5vfGOPoTQnJpjo2jrTNb
 FgHgrDYqZU/EOffzApX+msN4rt5ZBkI1xCRRybh8KYCCCQxtLXJba7ShOvRXu1CijjIt
 tGMw==
X-Gm-Message-State: APjAAAWufYp5Vk3edkK6JTHwAwJAjoLVDibuY+GXJbwEO3zoPSYJ3lJS
 Aau92WiU+4iKWvR8WDPu6F8kRXq4pCk=
X-Google-Smtp-Source: APXvYqw8anzIfOqRi7Emedvs68pLVdbYlGo0XN8tzkssN9ambm0bI0PL+01o31Uen/w8dInfsA5I4g==
X-Received: by 2002:a1c:a754:: with SMTP id q81mr4778417wme.139.1581086065537; 
 Fri, 07 Feb 2020 06:34:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/48] target/arm: Update arm_cpu_do_interrupt_aarch64 for VHE
Date: Fri,  7 Feb 2020 14:33:32 +0000
Message-Id: <20200207143343.30322-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

When VHE is enabled, the exception level below EL2 is not EL1,
but EL0, and so to identify the entry vector offset for exceptions
targeting EL2 we need to look at the width of EL0, not of EL1.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-37-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff2d957b7c6..7d15d5c933c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9017,14 +9017,19 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * immediately lower than the target level is using AArch32 or AArch64
          */
         bool is_aa64;
+        uint64_t hcr;
 
         switch (new_el) {
         case 3:
             is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
             break;
         case 2:
-            is_aa64 = (env->cp15.hcr_el2 & HCR_RW) != 0;
-            break;
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+                is_aa64 = (hcr & HCR_RW) != 0;
+                break;
+            }
+            /* fall through */
         case 1:
             is_aa64 = is_a64(env);
             break;
-- 
2.20.1


