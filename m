Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9F3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9712620663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGev+YiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9712620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwXY-0000eE-IM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christophe.lyon@linaro.org>) id 1iNwMs-0005sE-NO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christophe.lyon@linaro.org>) id 1iNwMp-0004US-4D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:58:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christophe.lyon@linaro.org>)
 id 1iNwLS-0003XS-Qd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:58:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so1598212wrb.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=8ck//FtWXf6SZ9Hwguc/y5XScjEWNqWkVYUfldEqueU=;
 b=oGev+YiXV+wRKDVKe1aGDyB5g2JQWEvnFKLjQYsfnxPpS68+bt4vkBRaMfJq0YbtkD
 dBqT7jKUpwl+wJVoSVtJZzdnmnAYbeRD1snNQHQzkvT1OQNq/HWb/reApCk4nq1vr0GK
 q3XtNPRjB4Gu7wH0Rpt+Rfyz5MihOtDJsfd42BPY4GzpKqwkR78BD3ynJVNL95QCzGJw
 VmiYkzu5cmLAeo8WLa9JSNK7NRSdMuomROdfipb8/PBew0zUIZHG5hlsVmOx88HmglEe
 jvLEzGBQtn0NbuM+YMPuELvf90qVwzCb8yCsPoakPpHvC5DRbpCNMrmWdjj85T5Ea964
 oKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8ck//FtWXf6SZ9Hwguc/y5XScjEWNqWkVYUfldEqueU=;
 b=owOo6q6UBPvHIz5eHvRqOAqnsBT1MmPKiG2j8lWMIeEKq/rWuDro2ZgQryfEJibzRV
 Act1jhXik5w+NLTZo0v/SE6p1VQg3vD39zJqLwcGXoVyn9SyNXLUW1QLJMFxOXIQc1MO
 Vq2a4tE7wHwfrGxV5JQXm/iMxKqEPK5PO1OgpaWK30Z4x3pbTQ/Zl1AyH85fFsbjSyTQ
 HKoktAHRL1ShKL8wiNago10/kuJ9jWBANrxWXgloqYdsmhNFYcDHkIP+JY1SN+0zvqA3
 tfupLG8udyN3jCA3b3EMnZQzymUPtn4zIV1WlcU+ZvzOhXp9IKB3uhuszxD4x0LjiJk2
 Og4g==
X-Gm-Message-State: APjAAAV60ZJ/NB9UujEYWEHTu/wrb3HMyRPhGqxxR7cHFQg8NmFA248b
 c74qQtDK1driMs6wk+ObLd98mQsJAIQ=
X-Google-Smtp-Source: APXvYqyTYt4/au2/kFGuOnC/LVYcTZU9cSS1jWMEz+1mrFms4+Tbnne3F5CgzAE37DUqHuQZMYgiow==
X-Received: by 2002:a5d:640e:: with SMTP id z14mr2105552wru.311.1571997441219; 
 Fri, 25 Oct 2019 02:57:21 -0700 (PDT)
Received: from babel.clyon.hd.free.fr ([2a01:e0a:283:3130:606f:6dc3:545e:fa5c])
 by smtp.gmail.com with ESMTPSA id g17sm1651216wrq.58.2019.10.25.02.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 02:57:20 -0700 (PDT)
From: Christophe Lyon <christophe.lyon@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] target/arm: Allow reading flags from FPSCR for M-profile
Date: Fri, 25 Oct 2019 11:57:11 +0200
Message-Id: <20191025095711.10853-1-christophe.lyon@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, Christophe Lyon <christophe.lyon@linaro.org>,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

rt==15 is a special case when reading the flags: it means the
destination is APSR. This patch avoids rejecting
vmrs apsr_nzcv, fpscr
as illegal instruction.

Signed-off-by: Christophe Lyon <christophe.lyon@linaro.org>
---
 target/arm/translate-vfp.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 9ae980b..82bed5b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -705,7 +705,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
          * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
          * Writes to R15 are UNPREDICTABLE; we choose to undef.
          */
-        if (a->rt == 15 || a->reg != ARM_VFP_FPSCR) {
+        if (a->rt == 15 && (!a->l || a->reg != ARM_VFP_FPSCR)) {
             return false;
         }
     }
-- 
2.7.4


