Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8059C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D54821835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sr+p4nWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D54821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQIp-0008GE-IN
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzp-0002KA-FP
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzg-0002N8-SI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:16 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:46094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzg-0002My-Lq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:08 -0500
Received: by mail-pf1-f182.google.com with SMTP id n9so595327pff.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uNidjxnV5DdRs3wA8rpbCUEyKJO/wom0WpMzXxLIKOY=;
 b=sr+p4nWLYFAPJYy8lR1fD2hStzw3ans3vKT7tk9gsfid39tVmSXAbAwTjGTowlETF9
 94n4eW9IUbs1GANymo3PpgDZ9nSkZyJBlKJMIbzCrVTdmBVTtu4kxuBy09XU1sPflvyd
 FCVc5xwavO+4PbfjrKxrmRwnekmanZwiSU8Szu9QWTvMhyW4kKmH4ugZslC19ps3j1yN
 5dLryQN143H8QWk4iH+5pFTuwwU9szQLy15J0xoDGA30Z4V9pTgnnRRwfqfSkjcyCBkL
 X+3ZyQ0sNy+eWtvUzGRtGb9K3wKfASW3wkpZ9NuIdumBWDl6ATivSIeHsu1kgmnxfZAZ
 G+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uNidjxnV5DdRs3wA8rpbCUEyKJO/wom0WpMzXxLIKOY=;
 b=ZYTKmbD6RxAnuCBkHuTbWQ1iO8tf+84fDEyDwLwlqh+vRw4nGB4Swc41ky/215u+l2
 p0oVpcOHr2WfK+6boDs8VPgsIKUbKEjSo0nCnaolHC8LSB0/JMsk2zlVjZs2FDeGZ+58
 xxf/3LepmexbXOXd6rk9UanHvvvwUiwk3aU8OHA4HH1Y9rVNF9JjBY4Taivq/GcLWiRO
 ku6tZoiiwcDnj679+8l1UmFwtiR64cWFk2/tAQMfXd0B3ulUPZ8HjfhgwYz++k2tu/CL
 br+3UHvE47hnmiPBvH2jHiFC8gAVxgfosKTA5MFsAzG22aPzDYrON+TV3rhzDHVxpI6R
 bdOg==
X-Gm-Message-State: APjAAAUi+ytGURd6wIVIkbpF/Soo6nCXZ1QF8RTU87l2s2ZusDnBHaZG
 CiB7l4UhncDCFuFzckEKPjzh3UKaXiE=
X-Google-Smtp-Source: APXvYqwet3TjpZxYq0haZ00l1u0XuoHbivHUrTOZW4Ywia4sOy5jJHVMyygT1HsNJ2/oilSbTAHY8A==
X-Received: by 2002:a63:d62:: with SMTP id 34mr949548pgn.268.1579737847414;
 Wed, 22 Jan 2020 16:04:07 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:04:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 24/24] .travis.yml: Run the AVR acceptance tests
Date: Wed, 22 Jan 2020 14:03:07 -1000
Message-Id: <20200123000307.11541-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.182
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We have one test so far, and it is very fast:

  $ avocado --show=app run -t arch:avr tests/acceptance/
  (1/1) tests/acceptance/machine_avr6.py:AVR6Machine.test_freertos: PASS (2.13 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 2.30 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200120220107.17825-19-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.20.1


