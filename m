Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8ADC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866262070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbrmNMJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866262070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2c6-000738-8P
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IQ-00041J-K4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IP-00035q-Jr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:14 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:37213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2IP-00034m-57
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:13 -0500
Received: by mail-pg1-x530.google.com with SMTP id q127so873099pga.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jQF5VrEZeBR4M+X3J6whzntO7zMYieHMFU8i9iH/tgE=;
 b=SbrmNMJng32wFRhvzM8SJa1KETz0h8384DvU3AHe3dMWiU+jyBoI6UqvLV/yyvEWG3
 FYcFEpJ9iob7FpLOY6GnGfOadVAdcVgBO0C+X4y9R+5hzwGySJHal6FUMK3S0ozAJgDP
 5zCVlOSVF8uz1vu6ZY3YbzyjjPFEP5mLB1cbZnZNFaMWwriMi3iMSiNhfFonoDs5djUB
 NL5kHDjdJfD/FWQ7VjGmd7aBfhR2hPnRLEU1NN5IsbwdDLf4eEaHjfgsObz5/CE0sOTx
 1BS9rULH0gh7bSwOrHAmLXed/XhL6ymzIsrE9XOvpP1WykaNyteHPSC+0G9Es9KdpYxp
 fQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jQF5VrEZeBR4M+X3J6whzntO7zMYieHMFU8i9iH/tgE=;
 b=G02vjxvshj3926J526871gkzZwtiyBGYM1r/6kKCUFAL9VnrYDNfFk5ObFcohhgFO7
 1nv3jTXO5a07RLuYSybuA/ImPn01zBP1edYiHwhdSNJfTe8chCytglDOtWJZdVemOXCx
 5SMNjIiZeb8wnVoDiT/VTjEOThK1OpD3AkXznMBOaiTknVeYU/4ljv1JYNYoKMIgzj6l
 X+DdjH3aF1xoPuRXbe4QEqF9NxE2yattFRkyv1hqVkl4a362HvuVZY64j7mciITSWBif
 OAiFmX4RpMeQefF5NbCQsB+1X2qwxIivZwucBeCN9TvfB8s8qWzbDrjkkCPrOfsky7PA
 uEOg==
X-Gm-Message-State: APjAAAWCojkb/vAq1o1oPQXs4xF2bvpAMP7W7qzuoNCo7dv+BDUjACQY
 uG0dqMsBDLFJ0QDncqIYR9CweDgm66PEoA==
X-Google-Smtp-Source: APXvYqwnyfghpQfqJ3vr/7lCZ+Qvix1s9BB7Kru1cMRULzepn5f+RMOZL3k2bwUvf5wDV/zsrIF4fQ==
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr2936068pfo.31.1578455171880; 
 Tue, 07 Jan 2020 19:46:11 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/41] linux-user: Include tcg.h in syscall.c
Date: Wed,  8 Jan 2020 14:44:56 +1100
Message-Id: <20200108034523.17349-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 171c0caef3..34825f15bf 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -115,6 +115,7 @@
 #include "user/syscall-trace.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
+#include "tcg.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
-- 
2.20.1


