Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3372081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlMlBDN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3372081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopQ5-0003Ej-RL
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIM-0000Cy-6j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIK-0002Gu-PR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iopIK-0002GR-JN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:16 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so54010271wre.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Butm6uDHOTmd1Tm6QI7qjPulemvQt3+T40NLuG/KpZ0=;
 b=wlMlBDN5few0TxmTokuOHHvLaYxnWNQyGwVJJKXDFm0xE0ReCK66qP5Qyx5RY/LnAa
 EffCP4fQObrxwOhaDM7gTCMrAdNU2Li+rWkClWTbhaLTqv56YXvodJz2Trz8Vqh3Tfwl
 e75JjidZoMSMIC7I2ElfPOuSN+skewCqoWkMd8822ohinvK+rQI9F40uRoTsdGLrr716
 00K/JjEzG3kzxWoWdJjAb2o4tZ7NGmTeoC1HwCnyt5b0MtAvENavaBv7q4Cbc5/hws7D
 1eqyNsH+but7AGTqGi87GzVcxFFv00/GlK20aHXVs9axd/xeX/J+s46T29a8zqqoiBgG
 9Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Butm6uDHOTmd1Tm6QI7qjPulemvQt3+T40NLuG/KpZ0=;
 b=OWRCy4D3aSn2LZiNT8ROGIL0Eram0DTRUNW3hcHh8P2kqcf+C2TDsgbcsnR7mHu5dQ
 UGaz1udhXxUxkJctl9vq327HXNcEN6zreFlGKYzCaCPSV4nF3nyeHfCn37BtYYxSKNGU
 l1tWxh/hwI1Pa4kibjuisAYTCpRKK049U0Qk0Op6fk6wdtTfGc/c9baoSSsbo/EImt32
 8R4XuJaVb55b+v0mdtxXvz5akITj7J0axg6Mj5Z/elMmY4Nl8r79CdXOvBYOeQP2Ji61
 hVwISl+NO6602YDnoKyMRPNDTLweZcmVeB+CfIc/n68vVg9RdrEmMmX25DtY+vKaR6Oh
 FMew==
X-Gm-Message-State: APjAAAUPgc3g1Y2cY80tfEYPe4r5FG60+9GrlyijoUH2sQAz+YoP2p60
 svQhGnzQVPCumbjfPU+0ULGlOQ==
X-Google-Smtp-Source: APXvYqwZTmNFsBo1/X+iGeezj/b2LD6G4IKT+SW6ac0QTG4xyqr1eUqgq30uabZzG3sS4VIqgNwUeA==
X-Received: by 2002:adf:f1d0:: with SMTP id
 z16mr105905643wro.209.1578405195609; 
 Tue, 07 Jan 2020 05:53:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x14sm26801722wmj.42.2020.01.07.05.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:53:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6EF141FF91;
 Tue,  7 Jan 2020 13:53:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/6] travis.yml: avocado: Print logs of non-pass tests only
Date: Tue,  7 Jan 2020 13:53:09 +0000
Message-Id: <20200107135311.5215-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107135311.5215-1-alex.bennee@linaro.org>
References: <20200107135311.5215-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The acceptance tests build on Travis is configured to print
the entire Avocado's job log in case any test fail. Usually one is
interested on failed tests only though. So this change the Travis
configuration in order to show the log of tests which status is
different from 'PASS' and 'SKIP' only. Note that 'CANCEL'-ed tests
will have the log printed too because it can help to debug some
condition on CI environment which is not being fulfilled.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191230184327.2800-2-wainersm@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 638fba4799a..93838bf0f8b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -262,8 +262,8 @@ matrix:
     - env:
         - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
-      after_failure:
-        - cat tests/results/latest/job.log
+      after_script:
+        - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
       addons:
         apt:
           packages:
-- 
2.20.1


