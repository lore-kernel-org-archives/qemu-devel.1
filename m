Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C918C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2552183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkeGprZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2552183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbprA-0005Fs-89
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkD-0000Pk-VJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkC-0002vs-Ld
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkC-0002uq-B3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id s3so3119409wms.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uuSP1+OO4V0J/TIomTItZc3CIXnPAwyQAIRCHYQETno=;
 b=ZkeGprZlGrZGdkPuX0znJNtIeQ6gD1jhae/wwKqrzu5J4M79SkJl6vCA9qxSgkeUAk
 9Q4a5yM15SdnWxg4ewbuRgS5kCkNSJ8FwDa172pwJMeu0Ree+/V45/VIn9VfNVGeUTCV
 2GQA+1ohQ9RquAeQImH+fHrQZLebX8fBQC/oRP/hBVdQVULiRMY5oEyghaRcmV8Ho4Fc
 tOgibV9TcThEDpOLCktQibl87+Hj8lcjs2IhXzR+yzBqVlmxbofd2Pkl+cegnd5Y9ngG
 7roCgzzNnasV1iTgDVe0yB12nWmC7wGl5v2L9PFAmBDX4gKMBpqbRHHwZ0vLZgo3xwwO
 iR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uuSP1+OO4V0J/TIomTItZc3CIXnPAwyQAIRCHYQETno=;
 b=BGPfIJFYZEZC7hBOKK6hYvR6JebQWzgw69vjwo8WzOzo5TUAaVqTNWdJomCRbqbMyK
 /IK2MQWPbasi2yZWA4Kn198OFwa7XES1RgnwTUpoHK3h5J4ZsJeeinUHlb2Vbl/2FJRS
 8B+ArVU85QZoXLyWZEnGarDHZCeEry+T67fq3ackmgI/hjD1blrdDY1MimwESECnUW7e
 x0wuG4924+bhYt8/XFOW7DUOJmmA4JxxVOc+x99IRaF2dO6/J9hJGcJS8BFgCHSPestr
 U/1ELxg98s1mTBYgY/vWJJob4q8GY8oS+7SYpUsboMI5f7bHwF8NlCAqI9obRGMDr9uM
 JnBg==
X-Gm-Message-State: APjAAAWkyADBlz+DbX3S92cnBtjjflf/PXCP1JSi4aSVN4ajHtSMTFDt
 ts3xnnj8NBB6y8P6O2mrtKl6Zw==
X-Google-Smtp-Source: APXvYqxd+CILFS88J+V+wzu9kgZ2fli/jH116BhLIXbrKYyil3503Ot7de3KlD+8MWH5hCPViR8+Aw==
X-Received: by 2002:a1c:be0a:: with SMTP id o10mr8688679wmf.91.1560532322971; 
 Fri, 14 Jun 2019 10:12:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r5sm6196915wrg.10.2019.06.14.10.12.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 982821FF8F;
 Fri, 14 Jun 2019 18:12:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:12 +0100
Message-Id: <20190614171200.21078-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v3 02/50] tcg/README: fix typo
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Afterwise is "wise after the fact", as in "hindsight".
Here we meant "afterwards" (as in "subsequently"). Fix it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/README b/tcg/README
index 21fcdf737f..ef9be5ba90 100644
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


