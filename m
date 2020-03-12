Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D89C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76ED20674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTUiXXDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76ED20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMH5-0004yX-RA
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG6-0003RK-Qx
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG5-0001zh-RR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMG5-0001z9-LY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id l18so6981063wru.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UObsBGwVnKBodrfFF5Zg1LJ0/tMYPiJ56dulhQSD3Lg=;
 b=kTUiXXDZ9C3JA5EI6l72dJtvyZvaDtdxTssHCSl7LBD1CCYPZNwvmah5q2bdQkEQM3
 mfl1SNEUXWEwgAh9Wj7qiOKeRJCpV01FBKNsB2ZTckj9uIMOSlCuBm2niz4snbJjYand
 23VeBP8+qUtFansEM23f/q4frPWHFUW+66k0PuIgm8MVIhmsyUQ7dA8cbdAd62gfg3Fd
 o7q+MHGqidP1HHznefdiFy+mUen4+LWPWS7VWrBqF4W0IQC55xRKgWQZynls2SexSECB
 r+31zACbkJvNx5VpQ9YrBNST7xDA1QdBf7gFQk4/aGfD616KBDVjZ5xb6rn0NAYu9IYE
 5xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UObsBGwVnKBodrfFF5Zg1LJ0/tMYPiJ56dulhQSD3Lg=;
 b=esT1YW+1Iaoy1MrhIdrOYJxJQC2QWimtkxjmHqeDvPv+dRkint4gjmPvkMcIoO6hdJ
 5RvKAB4a9E4XhSgqB9c2wE6CIlM0ROAOvxP9kkAQqZ075bUd355/a75Bo1q5gXLZKpqz
 MEpj4aVo1p3ZDKIt7kIdFZ4t7nmHtuL4WQ2z//dMBojgnheSYFbpkm0DxAyPpt29iqn3
 c/YvBMA/rDbBxQh/KiZx1bjJiHYL08KFtiSH/yc+revvw61j6HDuyV91cIxcupTmKm9i
 623mn38HAq1rFpHWBX/AAcj5jLc1tljqMhiwSRxqGvHxLZAdDEC5ihHv17dAGvU0/0uH
 Z7jQ==
X-Gm-Message-State: ANhLgQ29uoSUU71ODC8S0336ix8jmm7a4g+zRuhWIvss0d8J8sxQgyu5
 fw1bgxr16FxObnuvxx8p6ZT/+bm4RvaYtw==
X-Google-Smtp-Source: ADFU+vvdKNsSgTesq0bIPNGD3H0XybdrmR3IkLCnns+OaycSNxVLr5ZZOapKIItp+P/4F/7rIbwd2g==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr10489333wrk.407.1584013452421; 
 Thu, 12 Mar 2020 04:44:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] Makefile: Remove redundant Texinfo related code
Date: Thu, 12 Mar 2020 11:43:57 +0000
Message-Id: <20200312114408.16891-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recent conversion of qemu-doc.texi to rST forgot a few stray bits
of makefile code that are now redundant. Remove them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200306171749.10756-2-peter.maydell@linaro.org
---
 Makefile | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 37aed4a2442..fae4ce181ea 100644
--- a/Makefile
+++ b/Makefile
@@ -795,7 +795,7 @@ rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(M
 endef
 
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f config-host.mak config-host.h* config-host.ld $(DOCS)
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
@@ -1122,15 +1122,6 @@ $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
              "GEN","$@")
 
-qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
-- 
2.20.1


