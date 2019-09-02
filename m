Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6AAC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2F320820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLLtnE1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2F320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jf8-00064a-A6
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSl-0004fv-4P
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSi-0004Gt-Kt
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSi-0004GD-Ew
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id k1so13942984wmi.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=knzT63YqZl15yKh6HlQ2XhiL5UJTCYbkBsdMVBgQUuM=;
 b=JLLtnE1K6j/6hQayw3+HZYqiwtCef5eyo/e2z2LQ51gMCPhp173LH2SAT2nayhZlQ6
 FlCzI4tHaS6v3DJYNC8JSO4xkMC+BoB+7ZPL7d8FSvxrfX6GUxXDHaAy16pNvSWO3K39
 u37HM8S76JbQz100c8Uy/+JTrZDM408o5F/HYniyQplK7XdxzKO7kwjL5m1pFCW/Uvyy
 SxImWvYq+3FHEYcsH/UI+IyHwXqYjVDs5kU8gZqe14sJTv6jnrQSGgnNP1oOgKlGunS/
 z6VCTQAuh393sxqviviuPpw/gKHYZPVu35NdQ1mMTFH24wCFtQGYNIuQ0a96LzAJBvaH
 UBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=knzT63YqZl15yKh6HlQ2XhiL5UJTCYbkBsdMVBgQUuM=;
 b=S5P0jbuAewcMEunYQZrdfDfIAibhhBAUNOMeS4mWj+3VeF4wbBQRc9FLjB9W8DD0qX
 zlkdnons5IxmGN0YDTtiwUD0TErVx2ur4zP1Dk+erMDZ0dW0ru/oph4sLHiOMdhpWdye
 p63kWWpl5PWb4DNKfxrANlM+h8TpjwGp4cqCrVStk7tIK2rT3lJg1ScQTXNSLQl6mLKI
 MSSI+QBEy61M0DHqeCfLcm8UodtPnu/UcF5VdWklCPAsvzrVmVW62xupZ7No4b82/grX
 6kTdO0RpbUVaOiHC5fvgN5Jl1k3dK8EbkBIBF2IXb4j3Xz22t8SUFRAL3qDeFBL65eho
 oTkA==
X-Gm-Message-State: APjAAAUGh4IvBSQ43dgBQGT66+lQ/jrW75W08+gKKZ4ocRFirS8cUzMi
 UiDg0BLLWQmF9TuHKYi5UoRT0A==
X-Google-Smtp-Source: APXvYqzOUPMAvBUpfSLL/xoinpP4iow9T9BaVOj9pe1Vn8l2rn4C0C+kQLZqaq+R3Wwhlb4tTMGHpQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr34545032wmg.155.1567419687343; 
 Mon, 02 Sep 2019 03:21:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm16506357wra.91.2019.09.02.03.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A16EA1FF92;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:15 +0100
Message-Id: <20190902102122.1128-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 05/12] mailmap: Reorder by sections
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Our mailmap currently has 4 sections somehow documented.
Reorder few entries not related to "addresses from the original
git import" into the 3rd section, and add a comment to describe
it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190822230916.576-2-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index b8e08297c90..e1fdc88d25d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -4,20 +4,12 @@
 # into proper addresses so that they are counted properly by git shortlog.
 Andrzej Zaborowski <balrogg@gmail.com> balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
 Anthony Liguori <anthony@codemonkey.ws> aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
-Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 Aurelien Jarno <aurelien@aurel32.net> aurel32 <aurel32@c046a42c-6fe2-441c-8c8c-71466251a162>
 Blue Swirl <blauwirbel@gmail.com> blueswir1 <blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162>
 Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl <edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162>
 Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
-James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
-Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 
@@ -32,6 +24,15 @@ Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu
 Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
 Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
 
+# Next, replace old addresses by a more recent one.
+Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
+Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
-- 
2.20.1


