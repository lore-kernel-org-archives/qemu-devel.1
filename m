Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18149C32767
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 06:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D193521734
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 06:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GN0KA3Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D193521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioLyp-0001Je-0C
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 01:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ioLyD-0000tn-VN
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ioLyC-0000Iq-D7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:34:33 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:34067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ioLyC-0000H1-6R
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:34:32 -0500
Received: by mail-pl1-x62e.google.com with SMTP id x17so21478231pln.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 22:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8Sv72+ovyw24PpYpbfobOmh2BxgLi4Pv+FP0elJP/o=;
 b=GN0KA3Gr472xSHwFEAgW3ppMGQTjahgm0PfbZ/SIkAERLcSyTPbb1yxLPLwx56m+bB
 fr/YV0Pt0I2Qi+2J1sdjzN92Z7THfx5h9TpmRHz3HP7XVq81wNlNJ45+DRyLOgGQ+m6D
 VzETl3AYNIAd9UT6k4MAy6WC9dygJsb6S+fFsm+f7kUE5yFvuq12WTNdqYE+ou6M80La
 p8X+LiXc7Pio+EmRYKf5BfEPwbyfaUcyBz95bpXuJZ9bRxWxqvumKe204XtBuGuo7JF4
 Zt1qdoBmg3GKpFSoOlxggKH+2QaG39Qc2DNFsnbOV3ZcISAyfjZJM7z2vWq0S/Qlz9RG
 vKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8Sv72+ovyw24PpYpbfobOmh2BxgLi4Pv+FP0elJP/o=;
 b=XYoWNdo5/Yys2fBMWEUdA3/e3YHi38ZJeHWiH2vp2nnb5lLGOm29S8jXk9O32nDT2A
 Gd/+z7C2YmpXpAIm4jEVy6Sy0MBYv7UgOheFr3jqyzJFbeMIsRVB0G7RfCA47vYvpgZK
 k0IamgJJWMKnL127/ojcZfs43Clxux5mA4qgIQNxh6jH1IbxbnZf+4PDxuzKNLLKC3u6
 1oFz4rGSDHYlBDHeZpTIKu84fwxrd+/uuWy/WWrLGh1uYeX0iJ/0tHTV8qNeCFTGyLbt
 ClP2omBlqIaa149RCr36uWEq2qUdn0cNxhvoD18AG2CHYKSu4p9HuG6o0KRUyp1ncTQL
 yR9Q==
X-Gm-Message-State: APjAAAXmlhZGjKbC1OHb7Rt1KqMwjagYZ9miwIHh+voYlanQWKMl52Vr
 Zc2DFSvSPHRacUKfrwA00Oee6DK3EC8=
X-Google-Smtp-Source: APXvYqwVaKBiG//bK13hh95TsuQUCC3ZBjTbQje+x4t/N87CvGpmLSK2AxUpR+9/Kh0Cc18bIsEItg==
X-Received: by 2002:a17:90a:200d:: with SMTP id
 n13mr42191643pjc.16.1578292470586; 
 Sun, 05 Jan 2020 22:34:30 -0800 (PST)
Received: from cloudburst.lan
 (2001-44b8-2176-c800-f1c3-9f9c-2e9f-1ebd.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:f1c3:9f9c:2e9f:1ebd])
 by smtp.gmail.com with ESMTPSA id j6sm23181380pjv.10.2020.01.05.22.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 22:34:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] MAINTAINERS: Replace Claudio Fontana for tcg/aarch64
Date: Mon,  6 Jan 2020 16:34:23 +1000
Message-Id: <20200106063423.10936-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62e
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
 Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Claudio's Huawei address has been defunct for quite a while.  In

  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06872.html

he asked for his personal address to be removed as well.

I will take over officially.

Cc: Claudio Fontana <claudio.fontana@gmail.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f453fc94c..1f5f3ca21b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2384,8 +2384,7 @@ F: plugins/
 F: tests/plugin
 
 AArch64 TCG target
-M: Claudio Fontana <claudio.fontana@huawei.com>
-M: Claudio Fontana <claudio.fontana@gmail.com>
+M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
 L: qemu-arm@nongnu.org
 F: tcg/aarch64/
-- 
2.20.1


