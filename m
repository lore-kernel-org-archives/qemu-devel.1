Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B83C33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C653217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3aEGOZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C653217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfKX-0002u7-Eo
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf73-0001rY-8O
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf72-0005zn-35
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:33760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf71-0005zZ-Sv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id d139so794641wmd.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KDkVC2+bOrjkb5KBMB6fZY6qUfAQU9/xqCnC4Kii7iM=;
 b=B3aEGOZwYe8EFpsAuUgcK+D9yUCqaZKkn2l2qfIqfsAn6R0jF22vB5SbdyO8m8/HbD
 Xt4vyWK0vmKZUup2jMg4wB4dxO6qQpcIG36PNaauhVS7+f6BUnQ4AjBv61QDACcMdB6o
 A9VcUU0eYEewpBworRWmMwVC0A3SI+IIVwLRptMvyzJFZ2QlhRbiaAqA9Ghn+jlMT/BR
 bTf5tafz8fZMhdNXXoI3DbtzxFNxjEZNmoyD2HJT6/9Gau9NjM13Mq3Rk718pmzR5Ji2
 vo791ki6TsgLkpOrvelayTBc4mMZ8ayd+eI97vEAhetjXMq9umjBSfrnLsp8B5dagBaM
 90gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KDkVC2+bOrjkb5KBMB6fZY6qUfAQU9/xqCnC4Kii7iM=;
 b=isq9Tm1PfwJGtmzTlhjcfW1e931aR8eexcxG7+4TYGNPraO1kgB5UEvMdDhpeWwT2/
 CCPFXePhWBvqfBLOswYUMXHguIx/4Cq4SqKngw1rmZ2ZtaxeLEh+w1yd7RqtZqt0bggm
 8jiizptAzRIwz25YpjNvmijzYo/1Mvbi4c/Sdi+5t9viaQbm5VaOjxqiJcxF43g5LfDS
 RtVJQznRMvee2skfTEOtpRNwZhI1ergXGyQch6C4fURavtUehiqOZfDwJFBBTck+QOnf
 yRCBRuRLVpaqi5HUhFDc0xgU+4+VPcysOAKAze5VliuINQvwQcej4+hq3tgtQb2WNlT4
 Zraw==
X-Gm-Message-State: APjAAAWvgTOfayY8N+Koa1/Owf/meU/QAjoRx8o11liyZSZ5FKqd/OcG
 MSumARZcHA3i2dC3dCtmuAttOX+Z
X-Google-Smtp-Source: APXvYqz8txA8LyQSzmwqahQMF1TTkKkQDD0a13NQQNgWNJ8SO/NAQPiEnHku/kVYF7LH6/D2C4p+Qg==
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr876418wmg.144.1579557694730; 
 Mon, 20 Jan 2020 14:01:34 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/18] .travis.yml: Run the AVR acceptance tests
Date: Mon, 20 Jan 2020 23:01:07 +0100
Message-Id: <20200120220107.17825-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: Fam Zheng <fam@euphon.net>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have one test so far, and it is very fast:

  $ avocado --show=app run -t arch:avr tests/acceptance/
  (1/1) tests/acceptance/machine_avr6.py:AVR6Machine.test_freertos: PASS (2.13 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 2.30 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a0f1..2301c9221e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -268,7 +268,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu,avr-softmmu"
         - TEST_CMD="make check-acceptance"
       after_script:
         - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-- 
2.21.1


