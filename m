Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8FFC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C5920873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdQ2tRiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C5920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NLM-0006FU-0I
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKE-0004b2-OW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKD-0003ZT-PU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKD-0003Xp-Ix
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id p17so8612945wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aRRamzMzvjTZar30SD38wYqoFHYtaZyfi67Aj7iN5oE=;
 b=LdQ2tRiBHrDfXBpumJ1UphwGxoAJogYZB7mi6IWCgo+aSs3PjTJ2WA9xU2W3SJdmXu
 CkA6Cky4tGs0EWwsS3UJAZVIiUbL8+deqR/fOgDKqBs7cZMGacTGo4RWMGgB/s4vrGcJ
 OMPBzl7ugengzbSU8FeIh6rKobOf3Va00CQq4KgDJAZtT9z6PKYxGT0vGXFKCKOvjFw8
 u1i44yQf3u4QtOcVZCeAqAyji/bpIwK4zV99aG1bbXnCk9Fz5+y/6cPHmdRtMVy3DPjG
 KdqSNxaa4kcqbedaPQrVn3+Q8FN2yfAsL/4eqYxyfKTtjptTMOypliEmdtY58EQor0dz
 8ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aRRamzMzvjTZar30SD38wYqoFHYtaZyfi67Aj7iN5oE=;
 b=d2lnvXSmv3tEhxosVrrdKBv/7GVbgIguu0JgwROdrHqx/0CH2NkxczIWrSTXvMDVsl
 13RKa5GlgC2NPNJ2DYb58AeUhc5s90WP+x6gX+l/klwtxvved5AliBE7e03DBDhRSqhu
 8OxyyQ6TCVddr+bNErw2bReQFY7ghdWseGClrDY6UWDnJuwWU2MFURXCRmYvOjKz0MnK
 rps3IeCAuAojccDS4m5OwpfBcGGvjpfhxSqGT3LIvmED22g6pXu3Mt0oDu77qEW9zLV9
 E4iCPQLYlZ7fHzmiAUz+zwr7nX2vrsK+9zOucgRIjPHAxHMNwKHRMS2ksRO9+zvdPElL
 a8pQ==
X-Gm-Message-State: APjAAAWVi8K2iaW13aFyXagc0RgXe+pHVhLvAhUavAD43C/PbFiqQxP4
 GzSTP3fmBCBDlODWVRDp/JgIwQ==
X-Google-Smtp-Source: APXvYqwwjTtUKcO/iA1vaMG2OJ6wJpu6R+2tmUENN5pWQ3a+K2SPrScwJZit2CyOo4C+tvYgaC9gSA==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr312058wmd.91.1581634272467;
 Thu, 13 Feb 2020 14:51:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g17sm4841694wru.13.2020.02.13.14.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:10 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5E7B1FF8C;
 Thu, 13 Feb 2020 22:51:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/19] tests/tcg: include a skip runner for pauth3 with
 plugins
Date: Thu, 13 Feb 2020 22:50:51 +0000
Message-Id: <20200213225109.13120-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, robert.foley@linaro.org, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have plugins enabled we still need to have built the test to be
able to run it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index d2299b98b76..71f72cfbe34 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -70,4 +70,6 @@ pauth-3:
 	$(call skip-test, "BUILD of $@", "missing compiler support")
 run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
+run-plugin-pauth-3-with-%:
+	$(call skip-test, "RUN of pauth-3 ($*)", "not built")
 endif
-- 
2.20.1


