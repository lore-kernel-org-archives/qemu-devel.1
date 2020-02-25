Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657FDC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E64C20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0Pdjjl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E64C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZeU-0000XL-9q
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcS-0005UI-MU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcR-0007FJ-Na
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcR-0007Ed-HK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:23 -0500
Received: by mail-wm1-x342.google.com with SMTP id i10so1040869wmd.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qYrx6G8+J0oij9Dy1s5nRsl6vpAyTX2kML2yVNSLhuM=;
 b=T0Pdjjl//K5FJFwxjoPqZ0gYkbUq3bjHZIRDUrby2xFwXlja1j5MdD1+N0gZuB021Z
 Gu3ybFlXe73vdCU5BzHZQnepoSKLMxLFzS9bFCDaUj8K+WLprHHm+Go90J91wYfTRQB7
 fdU1zB+I502ZEk236nPnT13jlTXUkGr0EjLCt8gqYxlLERs+cjIFMuw5FIGfk2NqvLvz
 bJv1DIMakx63ae+wrjfpTTBi8q0GouCd5ApGFvAIR5n/kApM2+gPtymlx55eZIaNGBmJ
 sRp1incyofgESNCLIyG97Bcv2sZSEWBpI7llEtXC9uG7uQ5Xc5R9ef9wCTyEo0IHUd+m
 vBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qYrx6G8+J0oij9Dy1s5nRsl6vpAyTX2kML2yVNSLhuM=;
 b=tGm19DbX1CqpGCFJS14LmSG7kllrP+AAO9n3NdI9j5BQ9uwTRBaHqW4tNoF8lyQHbE
 qvRr3aDCGUEMorZlQgGfZM8Xji0HOWf1TdHHIu/7tYKFiifNBnL55p/lI1elsPiQMvRK
 STKH0CIqnHpLrZd1Pg7TkxAF7JNLqVKug1dr7vhf+k8arqgNBHwbdcQiPG/qV/ycgXdS
 5pTws4a/XT8XiQ5Se0dqReT3Fp5tUQQFyVKkwcO8Dq8y8rVv24/zQRdBc3vZNe1H95ph
 jCkIx86YglMhd3cJFuZ2IKhhy+4vtoxbtsAxAJfw8AcJTXQnXC18rHgrKHdH5iK5CugC
 2SzA==
X-Gm-Message-State: APjAAAWWQAmwd0CCWexmRAPOo+LjuNdMgSHK+XBnhGDFbSyWYiy/H4eH
 7/Q6hf23cwtA3QWOmnAFrRjC+A==
X-Google-Smtp-Source: APXvYqxbE/qEKwzBBk0V7zARHsmHINnaCaefWtBHIstT29snQVH9+mAVFveD78tQLEGwUx/NOF9jng==
X-Received: by 2002:a1c:c5:: with SMTP id 188mr5037107wma.187.1582634842374;
 Tue, 25 Feb 2020 04:47:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r28sm667031wra.16.2020.02.25.04.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:15 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02B4C1FF98;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/19] tests/iotests: be a little more forgiving on the
 size test
Date: Tue, 25 Feb 2020 12:46:59 +0000
Message-Id: <20200225124710.14152-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


