Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55334C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F212073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZfSGkjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F212073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZbi-0004DL-V0
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZN-0002Dj-T2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZI-0003ta-Tl
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iZZZI-0003t3-NO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:44 -0500
Received: by mail-wr1-x434.google.com with SMTP id s5so22126438wrw.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NOfhHYHAVHQqA398V8VrFjyYiHEgmhZRL2cRcI0yNls=;
 b=UZfSGkjzlQjh4O9TE1ktd3Q0W29WjUdYaqunXWq3Rgfvb3Yu1ehLSrE+H0QF37dRao
 KZsrGVgbYozQTCzB17RG51xT+2VwlatAvBYBABKd8c5XcQLyZGnHbkVbbde7E0+/9YBB
 p8gM27vzCCFgVOGU1Vnr/NmguI0ci20b2tdlCleBgikWZezoOy5jEQOvfYpQ8WHP95pJ
 kxgcxLb0EK/i7Zepm7GNDf9dR7IUo4JKpWoV7PBfPNFcC2fJu9tzZis5GFpMwnCF3Gpv
 ocmUfweu2DlrOldVq9wEWrOB6HsLFsS0s8Zj5CaIzEprPpr3WKHMIAcLh5mtp/yUd/uD
 RS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NOfhHYHAVHQqA398V8VrFjyYiHEgmhZRL2cRcI0yNls=;
 b=A8Mn2N7hHaEvr0NW4+QEmJDCCCmX6aP1+BfqD/xEqiCXft+dMWqs5XuqsRt5yBa7De
 25akfiSQYAtX/471Jx8hGyhBAVMDDAwhmD5RKUeriztzbIcZfQDVwFGYjV8ZdOxO3J8X
 8Tm08sElf/cCN2wvjB6DXYep1gUv8l59kIC0MFINjmQiRtDWxCx5yGV5AtxUv7VwcCKv
 yQojR0GkSCcIaHUVcuhbfMAMp2ILcP2fD7Hs40LuwZ0cW+TB4D8wtQXeSAd5vrM6DcGX
 EUxefKaJy15qhTQBQVsbSROfVW/l296+mI9pAdtGf0LY5zivCQ+7ZZMCQ6ELsxh+IlMA
 kdIg==
X-Gm-Message-State: APjAAAXQgaKA6z8qJLsvNRbwA/uDm2jLLlVBvraL9Zroqwv92VnmDo4G
 vT9y9APMvX3+6wzUfW50WXjnsQ==
X-Google-Smtp-Source: APXvYqz0isJA8uFdbqQunqzyqY2CQjN96Z1Qil1NtTkQPhfRaaBj9HvfQ8Q4xweYA1CbKEgF3KMP/g==
X-Received: by 2002:a05:6000:103:: with SMTP id
 o3mr4445219wrx.80.1574769823503; 
 Tue, 26 Nov 2019 04:03:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 60sm14019041wrn.86.2019.11.26.04.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 04:03:40 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 778B11FF87;
 Tue, 26 Nov 2019 12:03:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL for 4.2 0/3] a few vm-test fixes
Date: Tue, 26 Nov 2019 12:03:36 +0000
Message-Id: <20191126120339.18059-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a5701:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-11-25 15:47:44 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-rc3-testing-261119-1

for you to fetch changes up to b3b9a433b0691b73c96d9ea4de67fe9c8ea293e8:

  tests/vm/ubuntu: update i386 image to 18.04 (2019-11-26 11:28:23 +0000)

----------------------------------------------------------------
A few vm-test updates

  - use Ubuntu 18.04 for i386 image
  - python3 for centos and docker
  - install locales for ubuntu

----------------------------------------------------------------
Alex Bennée (3):
      tests/vm/centos: fix centos build target
      tests/vm/ubuntu: include language pack to silence locale warnings
      tests/vm/ubuntu: update i386 image to 18.04

 tests/vm/centos      | 2 +-
 tests/vm/ubuntu.i386 | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1


