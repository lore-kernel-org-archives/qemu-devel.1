Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC65C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC90620880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkWJYFEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC90620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6Hd-0003Xd-0K
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho6HR-00038j-1J
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho6HP-0000aK-TT
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:17:04 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho6HP-0000Zx-MD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:17:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id z1so28632727wru.13
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6H+4HaROlQ1ydOvZvdvguPC8aRdkbSwRP+bc3alnVIc=;
 b=qkWJYFEhLiXaZwnibMVkOtdZZyN2mQlWoPKM7DZioAF5bUwPTFRSEhFEJVLpW4p9FU
 ho8bpj17lIaLxQmD8OTi9a0OR8RCQ7hB/pwNAqCd0ZipvKGs7vyns3Xzbo35BULn7e6a
 3mM76h3xMYeeDYIUITJwAvWAvYObSag2Bz2ek7kVxkOpg+fiF3uxrNe+KipliVVdbKnA
 AARtlDKQX0EPBMAnI4jNm19lHCgKtlfQPNITNKLeim0Q1HLvMbDTwjOq6AnbXp3K52qu
 MQ7R8fJKsaYf0kFPWyuLd9AkCJF5Wy+ZC02iHoLu6mb29H5wFXBY4z5agMCS77tSCPdK
 KiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6H+4HaROlQ1ydOvZvdvguPC8aRdkbSwRP+bc3alnVIc=;
 b=jsTBHw6TKorhdM0C11Pp5SQjYOUmi+uvlCXG/KBBsPHd7JbxJXJhPNnBv8w4KEe13u
 phG+tS2rTfE4bXgyIZxQCSR96B62tzhZd8sIB0WgcB5Vz697kryC/7x/4TvHSYfZHXrH
 MZ7eKAWnSni6vA5KFh+4KyaYzqFKdSi33twbyn5n7ZgXrA0kv1HjFItSX7DhcIN13TIr
 cXkQRV9isyH9aIalCbb61f4Mjn8HHLgHk8UVNb4EMODjxH5uCozFC2AkQbW6QZkoVsk+
 mNHsdH2j5NlQbZP5CvVjQoNl5UNDdmwGDiA9P8CScNNg5a8SxYO+bCAeD4cneZ7qxbwV
 R3wA==
X-Gm-Message-State: APjAAAUHNlD5VRI98nqE0e4EbUrsHMUZekX6kgt5GzuuqFT0NAB1mT/f
 BvFMa97npgqnAAX2kz8rOcSHYud3/8fAMA==
X-Google-Smtp-Source: APXvYqzktGusyrRjcJMXe3GErBp+qawMF7aWmgSLcmSd3cODHMooh0HufOWTT+SOWrUSCMluayZHLw==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr51855809wrv.128.1563455821891; 
 Thu, 18 Jul 2019 06:17:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 15sm19480213wmk.34.2019.07.18.06.17.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 06:17:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 14:16:59 +0100
Message-Id: <20190718131659.20783-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PATCH for-4.1] configure: Clarify URL to source
 downloads
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
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If configure detects that it's being run on a source tree which
is missing git modules, it prints an error messages suggesting
that the user downloads a correct source archive from the project
website. However https://www.qemu.org/download/ is a link to a
page with multiple tabs, with the default being the one telling
users how to get binaries from their distro. Clarify the URL
we print to include the #source anchor, so that the browser will
go directly to the source-tarball instructions.

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index eb635c3b9a5..bf79bbd0e8d 100755
--- a/configure
+++ b/configure
@@ -322,7 +322,7 @@ else
         echo "to acquire QEMU source archives. Non-GIT builds are only"
         echo "supported with source archives linked from:"
         echo
-        echo "  https://www.qemu.org/download/"
+        echo "  https://www.qemu.org/download/#source"
         echo
         echo "Developers working with GIT can use scripts/archive-source.sh"
         echo "if they need to create valid source archives."
-- 
2.20.1


