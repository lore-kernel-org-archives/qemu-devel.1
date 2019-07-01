Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DCC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF1620B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDA1jQSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF1620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyO9-0001av-UL
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKS-0000Qy-LI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKL-0003YX-Me
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKJ-0003Wk-Rh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id h19so314047wme.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cxCjEB5zKdWfSZxX3+j2v2ItnSTW3coA+RW/5hRm9LQ=;
 b=qDA1jQSuCgcMlqiAvOoPnUFwvoKCAD4oPTXzpCqT63Rhkix/iEuHCP/Fpy4DgHPDPs
 DNzXKO8LXbUoBoMFz/psKzLQUANRqW8k8w+zFMThPxavUmwiqNqPOGdp7IpCza2WDnN7
 bgYjxCSUtQd50ev2brEo+QQ1FGclh63MNYTlVhChhAP4qmMUMWNGu+WLMvvRVJrfFIYL
 H7VBRx6N+c+8q9UqE4NBH2vz0shJxeZLNXK6nBHaCSO/lq9bIbUGw3LMlEFhqwvKQF0W
 l/JRvHoknpTX7ssXltPFTCw1VMnNotTO5bdddU/WRTV8BcQkXTsRWki0g4+TLyOggVDC
 djCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cxCjEB5zKdWfSZxX3+j2v2ItnSTW3coA+RW/5hRm9LQ=;
 b=KCQUOiNWB0YuJswPEOAlUQ48igika9Y1KU5L/s1NOU4HaXF11q3f69MYV3HWBPD/Xm
 f8tCs2RpDT3m+Ia5jJ2lnsTDnlPrIXUya6P25rm4on/74BgbmjIv2FnkQ+3gnO1TwoJs
 oHaIMV02/XQRA/sjb/dvhWjG4dqm4zmLPXKGuIQRtub2jwsISx0xvECoxOgg0fbhf9Ck
 dQWlhJWD2HDMPOK8tlyxG6s1/R3K1bTmtLo1aGQFwUOgF+6zPl3LH+vBAPOL+eEg88pc
 WD/YgWknYbedt4OzdfSFQWu/UEw4XqOocGsikB22Gguo+eKARkPA8wBQaDoiO69RMfyX
 fMGg==
X-Gm-Message-State: APjAAAUlGixKsM1VpkizkXnJMNu0zgCJeETkvK/ZM+JJcgN25Vdm+yht
 RZJ9H5uSrIGRby5KAUnlMccgV/dr
X-Google-Smtp-Source: APXvYqyAQY3CiwKUCIfgWGScUWWHOJzMjSok2hbZPbgBb8+kayPRtsdNrekXQUm7vq/cLT+r3aZ7jg==
X-Received: by 2002:a1c:448b:: with SMTP id
 r133mr18259488wma.114.1561995282370; 
 Mon, 01 Jul 2019 08:34:42 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id w24sm8922341wmc.30.2019.07.01.08.34.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 08:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:34:36 +0200
Message-Id: <20190701153436.16579-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190701153436.16579-1-f4bug@amsat.org>
References: <20190701153436.16579-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PATCH v2 2/2] .travis.yml: Let the avocado job run
 the NeXTcube tests
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2:
- install tesseract English package (Thomas)
- install PIL
---
 .travis.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index aeb9b211cd..0980f65ec5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -231,15 +231,20 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,m68k-softmmu"
         - TEST_CMD="make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
       addons:
         apt:
           packages:
+            - python3-pil
             - python3-pip
             - python3.5-venv
+            - tesseract-ocr
+            - tesseract-ocr-eng
+
+
     # Using newer GCC with sanitizers
     - addons:
         apt:
-- 
2.19.1


