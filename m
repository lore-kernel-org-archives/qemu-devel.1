Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4819BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1494A20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8dFbzdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1494A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wzc-0004cs-68
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlS-0002GU-5G
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlR-0004D3-2X
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wlQ-0004Cf-TV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id u16so2278289wrr.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aUExrHFNvDDWB8ZI7TeI5fqa+GiUSS9y/dm2gcc+xvU=;
 b=e8dFbzdEmq2cCEbobonZYtdQ+QnUt+wzcZuxuAZ5H4Oqg/+e4qC8wOLd+Ud+VZ30E3
 NQ8mptg+8pk59ylhumhfV55Ag2wEZjyyl0TQtJEWsTnLReoBqs3Ejl2N4FIntaJ/L7cB
 Kpc8Y8TY1InC4nhn1vDA02Jhluw2FhjgIjXsZpJ3gxtfiKo0eK+j8An26Ua3OygnKlpL
 8IUkKHyI3yjwJGC3kar4jsLIt4/XDEHZ2+cKnhC3QmbFWc3JlXCkScmdvUE55NwZxRyI
 qgLheJkha5qNOpgri+rPHfwatwIOwnyUp6t8wrv92VMYnZP85zu6OtR+jsrkGiZytw88
 cicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aUExrHFNvDDWB8ZI7TeI5fqa+GiUSS9y/dm2gcc+xvU=;
 b=Rii0iFya6DUrjs+5VUOaGpg4tRBe9qG0whXMh5yeyunAgtaqZYUIJk2Z+fhrk3JmXQ
 F0R6btmZPzuN3BGlaQiqcO3wcSeuwFKH7BJUJRXhU19CVH3I6Vl5QTVzbQj5JijXIodQ
 IfoD/bepoEqFGMBSv5FVUKcApLmmV0bziGwp9G2sJTbH9VUpakfDRjMUxfzgev+0NRIy
 9K6lbS7xiqp5YVOefZRhx71ykQ8yTxhAqqJoajImETZ5Nzx1Rz3+d9AUk7rUrGHnhxNv
 k2p0PXS6EokpRVUZmKMyEfKrZPvouLF3Ks7tx0VxzPATy9Lu8AzCIh6FEqreIuqXqGdU
 i4FQ==
X-Gm-Message-State: APjAAAW45uekBs/+9shAKi+ow6vvR0Mbxt+qXDpc4hHdZ57agzaDzh71
 04+3dvhIGWC2Ld7Y4/8E12emVuGkNgs=
X-Google-Smtp-Source: APXvYqzJ4kF8gidT/VP/c1e+iNj3/Xps2UQ/iIqA17w3RwCwa9n6D7BbVSs2SdV7P58seOhYIk3Hzw==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr4265026wrr.318.1566994163898; 
 Wed, 28 Aug 2019 05:09:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m7sm4502844wmi.18.2019.08.28.05.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:09:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F03B01FF8C;
 Wed, 28 Aug 2019 13:09:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:09:14 +0100
Message-Id: <20190828120921.9586-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828120921.9586-1-alex.bennee@linaro.org>
References: <20190828120921.9586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PATCH v1 1/8] contrib/gitdm: filetype interface is
 not in order, fix
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

gitm prints the rather cryptic message "interface not found, appended
to the last order".  This is because filetypes.txt has filetype
interface, but neglects to mention it in order.  Fix that.

Fixes: 2f28271d807edfcdc47a280c06999dd866dcae10
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190822122350.29852-2-armbru@redhat.com>
---
 contrib/gitdm/filetypes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index 165b71b3f9a..2d5002fea0c 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -34,7 +34,7 @@
 #   If there is an filetype which is not in order but has values, it will
 #   be added at the end.
 #
-order build,tests,code,documentation,devel-doc,blobs
+order build,interface,tests,code,documentation,devel-doc,blobs
 
 #
 #
-- 
2.20.1


