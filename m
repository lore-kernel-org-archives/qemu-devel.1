Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A060C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1663422CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BibhaDgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1663422CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B99-000425-Od
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Ara-00034r-8J
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArZ-00063G-2U
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArY-00062a-Sb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id b16so17977645wrq.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nR0JGIs4B0XqG/9nvKTr4WHZcNIZDzXugHm2rJffA5M=;
 b=BibhaDghWk5wZz/Qw7wSjtQzUPC8PRJ426VZ9tIC2phcGd4q8m68y4ErUO0t2zZeoM
 6JFqrOUeKNICgdi7tiFWduE68C6Ok6PtfbfEm8LPmcRpQeUDjPHGZNh13/tR/4tYZTWy
 UFlU/u4sEpj4dhhs2CeHLsNHcHRqQZFRNTBInX0Tg3/BKMbpCfoX6Kx18rNDK3QbtJN8
 mHgFfp95LMdi6GveSXWGt8Li+APoQnkswka/YtmVFM7SW7knv7TpIIT5beP0zBuzVPlK
 ikir7iL5Fhrwg0wvQxdeNytVJ9yeFeLdpXm5Ch6ApwjEI2n/3MlOZLc/BL9Np8ig7iQB
 kmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nR0JGIs4B0XqG/9nvKTr4WHZcNIZDzXugHm2rJffA5M=;
 b=VT5hzWt1FrmX17LbYEcyrO5JfJGTsvkpYfcs0A1y/wlik0oyDolThO5RLpf9iXZJN9
 19dlgGC9IgWXDCTLRMDccnySmWz1u+OkMmw/VrRGBjQgSzFBd1UfMKh4HtlSCdn5Retn
 q9+5AIGaFIWZo/7/Lhav7MNhagd7qsnysMO7i6fYeCBaQpIJbJXaHnKiyrMgLLvCFOKS
 OWkRF0Trmu35ahXyWT4XIvo4+f8swSlZnvnyMeTx2d5SSVHARjJPfqBx+eSwBRmgK1vV
 3FY69/vBN3KwluCZFsgixBGMqRwtYMBqsM52uibiU/bqkRODRfQ7aRfx49EV094IJRhE
 xNCA==
X-Gm-Message-State: APjAAAUT4akFLAGB90rc+TjuRHGggg6mofF69G8a8pndRy1A9ndu3CNC
 5B81pJ9gyfpNuy/dR9BxKLBDUqSUkmO+1w==
X-Google-Smtp-Source: APXvYqw0gbgGwLL1WAOWJf6H9B1SjX9aWo2AXYeHRaB3anBbF8e442c9Z0mpM2vro0TDlRGg700x5w==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr6493827wrp.281.1567525015708; 
 Tue, 03 Sep 2019 08:36:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:29 +0100
Message-Id: <20190903153633.6651-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 17/21] tcg/README: fix typo
 s/afterwise/afterwards/
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

From: "Emilio G. Cota" <cota@braap.org>

Afterwise is "wise after the fact", as in "hindsight".
Here we meant "afterwards" (as in "subsequently"). Fix it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190828165307.18321-7-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/README b/tcg/README
index 21fcdf737ff..ef9be5ba90e 100644
--- a/tcg/README
+++ b/tcg/README
@@ -101,7 +101,7 @@ This can be overridden using the following function modifiers:
   canonical locations before calling the helper.
 - TCG_CALL_NO_WRITE_GLOBALS means that the helper does not modify any globals.
   They will only be saved to their canonical location before calling helpers,
-  but they won't be reloaded afterwise.
+  but they won't be reloaded afterwards.
 - TCG_CALL_NO_SIDE_EFFECTS means that the call to the function is removed if
   the return value is not used.
 
-- 
2.20.1


