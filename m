Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD892C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A42B2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CprRdcsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A42B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZbd-000450-1q
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZI-000269-MN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZH-0003sj-I8
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:44 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:40081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iZZZH-0003sE-C5
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:43 -0500
Received: by mail-wr1-x430.google.com with SMTP id 4so18857224wro.7
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MC6wtJLYjmgky9per11+2VE9GtNyZ6uqSDPXcUeT1Ok=;
 b=CprRdcspFWNELPtD9MHaGS0P6hPmUvuDE90Lg7SB+YRjdiVpnI2b2+y+pTblU9uDRn
 5xy3j1eTbUBe5cijxpaIU4s805+pa0EUTpuEwDg6ZvmeaCWiy8Aw3VHnIxYaSoYYp+hx
 dpOuSTCshMxWoDA3MFh2g94WG0csFIVYm8OEx2j+aELzh4Rgu0jUTMEhgTwMqQFpIgvn
 e92Ncwct5Nn4gluptky2vZ+r4YVW/cBeWwX9DCZ6wVjhi46OsWzEHR4gCDmsC+GLg9V4
 StHTXYsS5BOXvgcmCE1gnOZ3tMrOx9VM/JutB4BF4UFgmoI2loq/Lm+2mGPGZCd5ML/j
 e2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MC6wtJLYjmgky9per11+2VE9GtNyZ6uqSDPXcUeT1Ok=;
 b=igAmNdKZSIY8Ck8aLyybzg37SXtE6aNBa8GUpbHIze8MSOVS8NOGjtb8shpkt6baGL
 hWp6T7qruGL6o/z0aNcOaPMFkvgUBCrtZfQNFTJtcBLzfhppdRPeo1nrjDU4GB60NGGM
 x5Sz1d5eEHr60wQmgKqiw7xDnZazvefL1FA42mq4btoKYlwu60TmCzqhLTDKSSgX7Opq
 fwLE8mDNqENVDCteVGrxusC99TGz2Wtn3goF+6cMIjjbWUpeUfWbVIPmgIBHpzQJJXwx
 RWdPDA9iBI/7CYThav7tfyk4EbtZFmu9a3hYtkvJWdTQdB+qA7vbgE3kOv08wNnKvbb/
 UTTg==
X-Gm-Message-State: APjAAAUAOKqIfu8uxsnZnXUYiKoIPjD5HuN50fF4m/x5n083Uz7F1Bod
 +DlzFll+GzGjzFnxnM10cs34Ag==
X-Google-Smtp-Source: APXvYqxqG3wtgDIi0Mv92ROnZInRkIgWjL4HZA/mztoD8kI4bU4kBvzL5F3JBBbqwOQl91oNnitkig==
X-Received: by 2002:a5d:570a:: with SMTP id a10mr36064903wrv.107.1574769822255; 
 Tue, 26 Nov 2019 04:03:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w11sm15814168wra.83.2019.11.26.04.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 04:03:40 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A1E071FF8F;
 Tue, 26 Nov 2019 12:03:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 2/3] tests/vm/ubuntu: include language pack to silence locale
 warnings
Date: Tue, 26 Nov 2019 12:03:38 +0000
Message-Id: <20191126120339.18059-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126120339.18059-1-alex.bennee@linaro.org>
References: <20191126120339.18059-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The iotests in particular don't like the output being spammed with
warnings about locales.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 38f740eabf7..18b1ea2b72c 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -84,7 +84,7 @@ class UbuntuX86VM(basevm.BaseVM):
         self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get build-dep -y qemu")
-        self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
+        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
         self.ssh_root("poweroff")
         self.wait()
         os.rename(img_tmp, img)
-- 
2.20.1


