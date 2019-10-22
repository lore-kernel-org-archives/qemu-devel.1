Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7EBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C63C20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6ZOa74E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C63C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzvh-0005QZ-83
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznT-0004uu-VV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznS-00025t-Ph
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMznS-00025H-Jb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id g24so9415493wmh.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CR15GmJcpTxUHSy0ueYvJce2z343jSaRkeBQ2QiDxqA=;
 b=C6ZOa74EIOFdkz6DKBKo/YIFzj6BOKROAT4nnwiWM71zgqs8IiNsiCzoDtZvMlHxW9
 g8hKE3D5C/OLbKfW8naUSl9aWxo44MbNEXRkmZQRX5/vnT9dSOYA3ORMuyDUgBrpdiG4
 A+2tRZ5vKD+fu+6nHmnI0AenXp7MNqXpvDsV63f2J5tESleaYewu9c4jBm4lY2G3iQnY
 uWOPcEL1SLJAHkaIdUSvcttgtnWe/+15JZJ+ETkQPLVsgzUxXIfM7TqR8Oc+kYLeY6eQ
 F5Ucyc0ZeKA6DXX2ptUwiBbOXO+Q+XWREgA8faNB+Un8M0RNPagBW29aKHL36Y97WlrM
 Enpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CR15GmJcpTxUHSy0ueYvJce2z343jSaRkeBQ2QiDxqA=;
 b=XTKpwnI7JEQCAfjlHzQ5P3VWZZhTZpZnYaTg/cLhwvqGdWLi87qR7EIQiJ+4CvMV9p
 AJ/ShXPxKpk2zJ773ymNVbDK+qZgVtfbKu2CgtOYAcJkC18d5URBpyRixfUFkxk0EaAE
 ZX3YQrqkhmNuGbONxUWXwyZ35LYwCN4pcbiTYd67kF4nmpXcHmhbue4mrO1ZMLtQ1oOQ
 ThE0eEdJMm+6/+SC317/pPgHiB5N9ZXld8LpQ0gA1xiykLwnf5OWn2K7h0PZIfn2LKy7
 KQzZzJQqsYBSE6+1SiW9Nz6o+Hb+dZIKUXqfXEFhQt6V82MNUYK5hGuDDhyB37zoArT0
 ANOg==
X-Gm-Message-State: APjAAAU1S+gZFy0UgeQQxrTo8xWX+ecT2f0XJlCblXdID1eqUP0MMCRV
 Xd2HsP6NzSF5v9FMCaakAlkhTA==
X-Google-Smtp-Source: APXvYqzUTrHi1MiGsp2DEk4PxGSNBMDpTamEghgokyd8bFeOa4lJkxLPQPusnBF05ELsRV66qG/0Tg==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr4278222wmg.119.1571772381393; 
 Tue, 22 Oct 2019 12:26:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm20578690wme.6.2019.10.22.12.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:26:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F14421FF8C;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 19/19] iotests: Remove 130 from the "auto" group
Date: Tue, 22 Oct 2019 20:17:04 +0100
Message-Id: <20191022191704.6134-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com, John Snow <jsnow@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, Max Reitz <mreitz@redhat.com>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Peter hit a "Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared
'write' lock - Is another process using the image [TEST_DIR/t.IMGFMT]?"
error with 130 already twice. Looks like this test is a little bit
shaky, so for the time being, let's disable it from the "auto" group so
that it does not gate the pull requests.

Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191022072135.11188-7-thuth@redhat.com>
---
 tests/qemu-iotests/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 33b499ed410..4596497bced 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -151,7 +151,7 @@
 127 rw auto backing quick
 128 rw quick
 129 rw quick
-130 rw auto quick
+130 rw quick
 131 rw quick
 132 rw quick
 133 auto quick
-- 
2.20.1


