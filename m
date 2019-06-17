Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA6EC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CF7208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZ8sZVrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CF7208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuDw-0003Vm-Iu
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4w-0000R3-25
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4u-0007N9-D6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hct4t-0007KK-Vf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id s3so9637420wms.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=R3EMjxTAgk7x/2CJ0lHu+WPGswGOg17/TQG/Vi7Uo/I=;
 b=mZ8sZVrIQ6jLrxw8vx1eb85f+JVXRVn1TMADsp5FxMID9wBtMwTpJUIqR1c2y1Vh/J
 opUr8+AaKYy6XspMA9LvWIVz5fonAaKmkMmyirYnuyCWauKDE3W/Nd0byw9DrTBN1l4/
 grdIGYtdH3o4CDTXGlP54J67w/8FJlpYjRWALfNhhpU3F4uauRSsBql9T9SzZrgG0iMs
 XWY74F09mSZngPjdwBbDEwFz8QpTIchmF/l5a8EeiPyYnzdlo/kTsOpdHTbAS71iAnnr
 0ZD1yMx7wMmDRTvSfNmUxPiLYjPYCArtQvo5xcCFcFznGHM179yayJeq31V1U3T+CS+b
 Ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R3EMjxTAgk7x/2CJ0lHu+WPGswGOg17/TQG/Vi7Uo/I=;
 b=Qsl21S7IFByLllTgfLOfMxk8ycpVw8c+VCOyuV5Qw6yVUrXuCLdIbJx3MByS6ZRPQO
 9gdPVImZsLncPd7xNwxoT/IE4uF1J32NChQTQnM4Fg4Y2rzAT7sppBSA98YnnMdcKWhQ
 /Pqq7CNtcNsARNrPW+mqSpz5hRFLE3FB8ab2ALN/w0K+c4mIFD67F+69XhXaxVpaqjBP
 /Q0m5dTzwms5hoeZ5IyzP0uSl7vGMBLrr4uYVAxYgl9Q4ERdjzZj4KshnKV50NRAc6A4
 s13kpjHaGvggzXrvfJTt6+YzkCqhpzXqPHBlyRL/0btwZilDKgfnMzEe2gWggSMSTBYa
 Ptww==
X-Gm-Message-State: APjAAAUeLK3xdz/vBQjaBNDrXG5HD31KcpYs+zm/d79PS5JW226++HPP
 5whbnOruoNtlu46jYJP6AnwdFfGCuOwhlw==
X-Google-Smtp-Source: APXvYqwd4hMVxE8H1UvtMWkg1I7wTEWF19EeYE5dZ+eFoPpMt3j6Tj4t+wr9x3U6MqWCEC9uSI+XOQ==
X-Received: by 2002:a1c:740f:: with SMTP id p15mr14191354wmc.103.1560783465542; 
 Mon, 17 Jun 2019 07:57:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14690750wmf.8.2019.06.17.07.57.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:57:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:57:39 +0100
Message-Id: <20190617145740.9881-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617145740.9881-1-peter.maydell@linaro.org>
References: <20190617145740.9881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PULL 3/4] docs/specs/index.rst: Fix minor syntax
 issues
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

The docs/specs/index.rst has a couple of minor issues which
we didn't notice because we weren't building the manual:
 * the ToC entry for the new PPC XIVE docs points to
   a nonexistent file
 * the initial comment needs to be marked by '..', not '.',
   or it will appear in the output
 * the title doesn't match the capitialization used by
   the existing interop or devel manuals, and uses
   'full-system emulation' rather than the 'system emulation'
   that the interop manual title uses

Fix these minor issues before we start trying to build the manual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-id: 20190610152444.20859-2-peter.maydell@linaro.org
---
 docs/specs/index.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 2e927519c2e..40adb97c5eb 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -1,8 +1,8 @@
-. This is the top level page for the 'specs' manual
+.. This is the top level page for the 'specs' manual
 
 
-QEMU full-system emulation guest hardware specifications
-========================================================
+QEMU System Emulation Guest Hardware Specifications
+===================================================
 
 
 Contents:
@@ -10,4 +10,5 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
-   xive
+   ppc-xive
+   ppc-spapr-xive
-- 
2.20.1


