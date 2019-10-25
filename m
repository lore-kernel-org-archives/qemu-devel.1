Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52281CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223202070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVmfgZgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223202070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuRb-0003Ao-BJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtq1-0004kW-NH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtq0-0007Fj-Ki
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtq0-0007FJ-Ee
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 11so876866wmk.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RBkpe4GEuH6saQwGoDoa7cSKDDeby0g+/F7eldRIZd0=;
 b=sVmfgZgEIjmhtj0555OUTriBxgyzaIR5YyC93fJUScvFjHIexkbIJOjXXX7ddc4sLq
 gNk3RN59zunoy1bkyUIox39OuW6goSwKH6X2ZTcHwwwiBHRAFZuImSFw5qD1W1KprYJK
 Jj8m+Mi5VIq8TJYTMXdMyJRobm7J7YzooHGVnIC7npQHZ3oyZ3SMKhqkzzdAHgg73g91
 o48CEz0l97NnPooeVKIo36fcRko3dtiTu/w2ev0hXgabzGcy8HdXvB8LAEZ+Vg98f9x5
 9B1dz2EFotZFIryAeECZh0tJ7wRzy0LiCFdG7s7ki1XZPSnguVxqfZYDrV5W/R1IKYW5
 61HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RBkpe4GEuH6saQwGoDoa7cSKDDeby0g+/F7eldRIZd0=;
 b=AOTjafOWWznBTxtQEv0wDkyG3wHAE4JS3Mzgc6ER8tL4RAMUb4S6vxjnL2807mP+Q2
 tqFEj+pLH6RFYri2tOuFpcwax0blley3tG/Wk/CQV+Ljn3RnzwGSMYNsuahkUd5wE4R4
 dNKSAWfcAwg7wvPNP9alZV9C2zKEsu/MPP7fTOTFMSGbqM7hfQUhLgIcs7XIQrOKH+Tx
 TwvJZczeSmU7GxeoPABUuRTfB0bjzah2z7U/khS6L3RousPEZF53oTNDe4qbG15perwP
 E4EChVlB2aZV32nah/4TZRzyoMypBRKUKnwybXP5K50++cPd2z86h+sdPzNeq3SeN0VB
 9I7w==
X-Gm-Message-State: APjAAAX8GDFjOsMx6r/9tNQ1A7ILXUzmurBA0++m7iW5J5A3uNRQQQqw
 u81aJRiNTP3qEpFALgsIbtzkbDj0DLA=
X-Google-Smtp-Source: APXvYqzaBASJHOtvOZ7MW+8Z1gDMTdxkmnPa3pgcqUM3rBKuOKxHTfETwYtYEY74XJQTdAWoA+sRmg==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr1847674wme.99.1571987803408; 
 Fri, 25 Oct 2019 00:16:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d11sm1386866wrf.80.2019.10.25.00.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 21BDA1FFDA;
 Fri, 25 Oct 2019 07:37:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 68/73] accel/stubs: reduce headers from tcg-stub
Date: Fri, 25 Oct 2019 07:37:08 +0100
Message-Id: <20191025063713.23374-69-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need much for these. However I do wonder why these aren't
just null inlines in exec-all.h

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index e2d23edafe0..677191a69cf 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
-- 
2.20.1


