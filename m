Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB6EC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B512064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+AbY7Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B512064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aUP-0007Z8-EQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcQ-0005S2-UU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcP-0007EE-NN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:22 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcP-0007Dj-Hv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id u6so14616759wrt.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mRJBG/zc2GQpI0clN99w+344ScpJbk+vuaXsTd83iMo=;
 b=n+AbY7Um9xYuIrtBkAFUKLevPWbgJZdXMshg6eU1D+SJb2q5SS0ezY9ImwPmFXDDGE
 1H66VkJm8Tj6dDBmkT0AqOkDIjynUBnHOvJZaucKq/dJeik98xE0qfGEi70ojVcRwoFp
 ufRT2CJtSacs1507bXfuumLHfSFNNaExCNqqNw3Y8M2boF24OqCxpmCNvyet7RMFeh+A
 lpQBrriDjxLRZE2BJzkMRSb4nvzdUsj+tB6/IXSzSEhNFoEH0ESBakTAibcUEANw5//5
 qi5V3Optfzhu/J89MGQ/cN5imP3men8337MijfA3LUYG5LwkwexynFrI8b393kVAzKZs
 Cqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mRJBG/zc2GQpI0clN99w+344ScpJbk+vuaXsTd83iMo=;
 b=MwAHJX6ylQylHvOf8NgfseMi4dcgT+wrp35mhyqLkp1+h6+T5XR4HyIbS3x+pxCGlr
 YAOwo3lmFI0JIbNUeHHs7Wc3HYmULrbuokYWS92bjS4xljuM4NHyMYquheO2eJt3fzxN
 56tsBPAwL2xdXyJLE1RA+BZ5/rKA2JccNVifn7vx32LK8A8HQqLbqsoXCNJClR/TJqD9
 7b5ZAZ/swXNpKYt8w++TOl7Qf+skVdNHIWyLF5Ft6W8QJ0ENJD6KnMqHIRMbrPBLFUGT
 nBVkdTV3wN5DlujVaw39bfvek6Sa4snGwjAAcdyCMNLzxMkTGe9hPdB3gEbbxuBDe0Np
 BesQ==
X-Gm-Message-State: APjAAAWnU01p+uPh20eu9G+E7ZtSPJ99WaAXdwMVvoAc2QYjqtQiYMgu
 RSjwAZ4MGm/EUHathuIy3iqmCA==
X-Google-Smtp-Source: APXvYqw5AsC1xNKe6C6Nm/qTuKXOUec0rvULELtvEqno5uTuMCWgdGodrihVZuR2z8udTUv0TwmMMw==
X-Received: by 2002:adf:f091:: with SMTP id n17mr70531397wro.387.1582634840115; 
 Tue, 25 Feb 2020 04:47:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t10sm2666271wru.59.2020.02.25.04.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:14 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B726E1FF92;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 05/19] travis.yml: Test the s390-ccw build, too
Date: Tue, 25 Feb 2020 12:46:56 +0000
Message-Id: <20200225124710.14152-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 robert.foley@linaro.org, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200206202543.7085-1-thuth@redhat.com>
---
 .travis.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 58870559515..ea13e071795 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -509,6 +509,16 @@ matrix:
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


