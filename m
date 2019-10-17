Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464E0ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115AF2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDCy5Z/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115AF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6LZ-0003i2-H9
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5ma-0002PN-D7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mY-0001Jq-AS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mY-0001JP-3b
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id 5so2580995wmg.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XmG2LtoiX+Cg+MugL8I+LN/rDbeWOzTWr6UI0zmW2pc=;
 b=nDCy5Z/TRTPUe0KHndfJE4gP+kZU21oDfjwgPIJZfyqSS4YZCb7pmjAtwjDUSfKrPZ
 tqmOtE4xzlFgBKLzFvnH9/8QhMP4PyTlGOOaG41uPoVSLvXjoWXVo3eFEGx8kQYVBmWZ
 cNid4V9Fy9vCL82p+4SsXyQCa1VdCuvDl0QeQz2A4ZF1skNdINGRIu/eT19zFLwDYONx
 D6zpUP0d3VW3t7Qw1J1OUArs7kLPCcRoHloAJKDoytmCgiqF3oCWRJe2mSB6/b4ftcoO
 00Pellt60T4duKBLFuA+sjhnWcMZri4aEHNtSnK+xfxFs3JA1lDegSMR0pmUgM9fR6yn
 gGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XmG2LtoiX+Cg+MugL8I+LN/rDbeWOzTWr6UI0zmW2pc=;
 b=QHmN9aHQvUVmpX2W9abgRth+norFBUxvpXOEl3jfRXiTmMzyTMXxyei8bOt4jwtu03
 5nruabvrmoXFAAVRU/YmaFjb4mb6wqyj/ISY4wSdr+fdoandsq2AibxidoKi786MdYxQ
 ri7cniVLAFUhPx2HMfhRC/A9Dz0n7lRvEaqH5xWzExuYC4gXUoi37nxauRtYOb4Xe+3S
 PVmBTPM8P2G1QgXm9GFXe1it5PrOHnn7QSOYFa/PF4QQwOS3ucQ+gGo4umBq7HFhcCwD
 wKqVJvKFmFt5CPdZLg2104+VMmJcLWj1uw5M0Pt6FAjI7+o0YclIG8dPp9BMs6c+Vb6E
 Ci1A==
X-Gm-Message-State: APjAAAWse3SE27O+mQLP2dDhPYvGUA3er0P/TVSC0QaRu3hgQip+Sikz
 RifcJnJs0RDQ4ymNLz0jpI9/3A==
X-Google-Smtp-Source: APXvYqyJrjVSraqxLkfZl7TPYd2rX1Xjv0GSGLW4Y22Z7IC029hgK2Gw1i1TH7MEAPRcKYdeQtyFYQ==
X-Received: by 2002:a05:600c:29a:: with SMTP id
 26mr3100450wmk.127.1571318732938; 
 Thu, 17 Oct 2019 06:25:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm2866432wmb.19.2019.10.17.06.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 011E21FFCE;
 Thu, 17 Oct 2019 14:16:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 54/54] scripts/checkpatch.pl: don't complain about (foo,
 /* empty */)
Date: Thu, 17 Oct 2019 14:16:15 +0100
Message-Id: <20191017131615.19660-55-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's quite common to have a mini comment inside braces to acknowledge
we know it's empty. Expand the inline detection to allow closing
braces before the end of line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index aa9a354a0e..db67b4da87 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1639,7 +1639,7 @@ sub process {
 # Block comment styles
 
 		# Block comments use /* on a line of its own
-		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
+		if ($rawline !~ m@^\+.*/\*.*\*/[ \t)}]*$@ &&	#inline /*...*/
 		    $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
 			WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
 		}
-- 
2.20.1


