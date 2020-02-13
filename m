Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D08C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCB220873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niIgQPui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCB220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NQ4-0005J7-Eb
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKL-0004mo-Pd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKK-0003p8-Q8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:21 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKK-0003mt-G3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:20 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so8724211wrl.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qYrx6G8+J0oij9Dy1s5nRsl6vpAyTX2kML2yVNSLhuM=;
 b=niIgQPui7NAxYOQJiLcjx7TnRxkZpFyCqQatN0LoVfQCb0MXPj5C3YJByjCx0lgyJI
 6dZ4BbSXewrPQ3uAsO893PsPfc9Vtk04CH9lkeXHwEyZT2RFt9FTpVJvzVijqywQrQD+
 xrJ015peFr1YdP2X32vb4o9SfxMiJSCkN+u4rN5UXmNBiJaufPv+nwwnOv4wbzNAxJUj
 WhQNAfzaEcFK+DZqW7DP4YwvcP4TcoR+LEhJODph0UFBm2j/L8JpmqOII7YttIiflYiK
 lLiLB4Fh7h/2QQhw+anvB6HIm0HSSBo4bJlGdUxPTMEx0SmAA7BW4CnDa3tIQH6ebZzi
 FXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qYrx6G8+J0oij9Dy1s5nRsl6vpAyTX2kML2yVNSLhuM=;
 b=bl1XijWVXsixl5UfI26xGowKs5Z5tYexLvJWQ0qc1VkUgpMztJ/KI6+nYLqJqbN/WA
 qQKx5i2+kQfbANtUCYnZR9ou8DDfqnWfe0juSXUnAEzeYUXomqQPuJ6PtfV7RnsWTWwd
 8gSm3M46aTiteSQxvQGPBDcHEwtfvcwDRnJWma2GSL5WzbYY2ImwIgk3VcerTZfzYcfo
 eFWCKZamNCys2Nr4bZFOoyTgM1fitvAFnmyVEkYONQ5MvBp72ao0VK5TokHCAlKAj5VM
 mtEyP55A2bVleFPXBERiR0vq4m7P5qCA8mEtHwCLjIPk52Zdp/z+Q8li/nFFy1zzHWPH
 9seg==
X-Gm-Message-State: APjAAAWH3iILoHYUKFDEaB/3NQpz0xKJu6h2uxXcoJlNkilB/rTnCe/6
 TBKp6jq4Et22zIv/d0p9nSk74A==
X-Google-Smtp-Source: APXvYqyOowDUAhA5GGlS5+UfE6RHgUsUBzb9MatMsM+U61SwKCOwoaQAdQnxU8IUp6hdDMq7myk2Rw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr22532315wrn.50.1581634279427; 
 Thu, 13 Feb 2020 14:51:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t12sm4446150wrq.97.2020.02.13.14.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 532851FF98;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/19] tests/iotests: be a little more forgiving on the
 size test
Date: Thu, 13 Feb 2020 22:50:58 +0000
Message-Id: <20200213225109.13120-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 robert.foley@linaro.org, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 Max Reitz <mreitz@redhat.com>, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 "open list:Block layer core" <qemu-block@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least on ZFS this was failing as 512 was less than or equal to 512.
I suspect the reason is additional compression done by ZFS and however
qemu-img gets the actual size.

Loosen the criteria to make sure after is not bigger than before and
also dump the values in the report.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/214 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 3500e0c47a2..6d1324cd157 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -125,9 +125,9 @@ $QEMU_IO -c "write -P 0xcc $offset $data_size" "json:{\
 sizeB=$($QEMU_IMG info --output=json "$TEST_IMG" |
         sed -n '/"actual-size":/ s/[^0-9]//gp')
 
-if [ $sizeA -le $sizeB ]
+if [ $sizeA -lt $sizeB ]
 then
-    echo "Compression ERROR"
+    echo "Compression ERROR ($sizeA vs $sizeB)"
 fi
 
 $QEMU_IMG check --output=json "$TEST_IMG" |
-- 
2.20.1


