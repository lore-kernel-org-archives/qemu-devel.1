Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD95C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6FD20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LM12FLca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6FD20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j022q-0008VB-6g
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01zF-0002yI-MC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01zE-0005vO-MX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:53 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01zA-0005pb-Eq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:52 -0500
Received: by mail-wm1-x343.google.com with SMTP id t23so2260877wmi.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rsiIdEhaM/iOPfLlY60O9vdPZWnumy7Z7gwdeT+Wfgk=;
 b=LM12FLcakXBj21+F86V88TYgdgdLMhmMT0g3hJjTXZmkDlVpp+CWMNG/ZLqjdjh8+s
 Je0YHdGI5ERim8K63/bpq8EVbq73+l+hS4Q0XiKyMubmaou/CPYsH9sHp+ff497o1Gjt
 7NnkXTUF2ROO4jG5j6MiU3AKyEeOQdM1pqxpfiZ3KeVeGp1optXWBQg+U6TOjUdcrTGV
 ywiFbmjuTtpAD6ZkDO0XbVZB+6cr2qBYGJk6rst5dLieVQ4aencSbOhltO3mTbCD7vZv
 ajksgQC4fbKuINO5ZiMGGKajC6+vMMkQPTpkcdJMakldWMQUl4WhX/MQYN8cSPPGqNxf
 4/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rsiIdEhaM/iOPfLlY60O9vdPZWnumy7Z7gwdeT+Wfgk=;
 b=IEl+fVyaYgQr3MyM3S/9Mf5HZaz3Ose/Mt7xogzhQeiW/7qasK/5t4Bg87KNiFvxN/
 0HDgYrH1E395uyK02yOfQPOMDpP2ULgXP2w/gzVw9zeR50FAIr1b5rVW9GGev2LcnCMd
 fWTPe0JEabH9KC9aPnNrQzpdLFGmaB7QRqSS21diijInXnAk8kAbUQ4MIg7sonCnCmwd
 hZX2enRiDU+DekA7Gu4ss1haOlv7AigTRKNABZcvX3uetonN4XZyz8B1mNMDRO5yqN+1
 wv/9lxLfgZ4eGdRu13NZyvJpXzHcl52wyRbTSc4fftp9PVPqojLKn0FXm+dqjZfgBAD3
 GM4A==
X-Gm-Message-State: APjAAAUGNkSR1u4TU4b23Kmf+auNwgTsdR6WPzrVpBEiB3zAmRVh8YHN
 sSn6wAwOEPxRA3B6gfd0qXwNgQ==
X-Google-Smtp-Source: APXvYqzKkAJORZ8KfxVtIdVEWGJJ0KcxcI+zXysFD+nK7Z7Tr4rte7O8WYrNQ40qdWeWUoKR6NMG3A==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr3936555wmk.67.1581075587350; 
 Fri, 07 Feb 2020 03:39:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i3sm3324844wrc.6.2020.02.07.03.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:39:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E23A41FF92;
 Fri,  7 Feb 2020 11:39:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/5] travis.yml: Test the s390-ccw build, too
Date: Fri,  7 Feb 2020 11:39:39 +0000
Message-Id: <20200207113939.9247-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207113939.9247-1-alex.bennee@linaro.org>
References: <20200207113939.9247-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Since we can now use a s390x host on Travis, we can also build and
test the s390-ccw bios images there. For this we have to make sure
that roms/SLOF is checked out, too, and then move the generated *.img
files to the right location before running the tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200206202543.7085-1-thuth@redhat.com>
---
 .travis.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 6c0ec6cf69f..c0eeff9caa9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -508,6 +508,16 @@ matrix:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
+      script:
+        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
+        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
+        - |
+          if [ "$BUILD_RC" -eq 0 ] ; then
+              mv pc-bios/s390-ccw/*.img pc-bios/ ;
+              ${TEST_CMD} ;
+          else
+              $(exit $BUILD_RC);
+          fi
 
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
-- 
2.20.1


