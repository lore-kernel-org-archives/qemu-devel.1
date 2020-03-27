Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48037C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154772083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBnVPvBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154772083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtbD-0005Rd-5y
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU8-0001zS-Lr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU7-0000tl-1N
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtU6-0000s5-QE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id m17so12500499wrw.11
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hddMp6YbU7VIRh+p3dmSk6KMYfcJvHBxPkgSszrgB38=;
 b=FBnVPvBws3bMpxRDx9HPW1/Gf91d7kKq+oTMdezJYqJ8B/C1A5QxDjUq2hlOgQDT2X
 HI0QtCVA70y8UWH8Hk1A096qfYsDtJdHJ5o8HuFX0uEn4zF9mKGVcYZ2cGUx3nLZ1Qi3
 eVvRt9dwxKFAEQ0jPrqDQTWvpEvg2UV+PFpdt4eSeUiEsQ0IXh7uYSoLjJqCYtCK78F9
 +JHATAakpaAwj3e1fH1jVW/eWUYJqY9FcKOKHqjVYgaRSFG2tULyFOReKCW5oxJzHF5o
 8xmapk9WUmImKN1DF4A5LEl8tyxI8P5hlX4vRrkY62sEmeflnluKB8iLC1NP/iwT22kE
 l0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hddMp6YbU7VIRh+p3dmSk6KMYfcJvHBxPkgSszrgB38=;
 b=n9tqIGmTlUrj/HZDITYcV7tv7aM3ZoVtK6NIgQH9RC6/eOfgc5ZrPSYFzb9lqHCgAb
 wVH4mG6MpqZHuLDlWV/oiBBf5FR4GgzNfCDeI2Rfip1ZCzbFfrhAXUG1KbcCTZ+kXCBS
 zydw0kCJwnnMVf/hgRBgsNWlUHS3f9WASSJEbuspaWejDLnqklIX1T0Ny8gHP74zRo7V
 Siybo1TBGJKVqo+UqSIN0jzanxUAtSmJjFsNAIuoNYy+LvMvLwKq3EubLwvgMqoAPnhd
 1mymHmu3A0vHXsqwGVdoK7QJ9aZp+FVmniSiXesVIs9bmFPvC1Ewk/YB7e51zv6r/a1H
 kBdQ==
X-Gm-Message-State: ANhLgQ3aORCA/BNyugTemJTAoxCN1aZ1kyMd7i+n9JHJtK/sA5E0dmAT
 Nn90g2TtpwmNt8knSeX9kVO+kQ==
X-Google-Smtp-Source: ADFU+vvPjPBs6/MnhZAbSULPe5UfNRCrR4pHpwNUGBVYGEGQC1z6qNAFu8ofUtGNeKYd2f5AYoy2ww==
X-Received: by 2002:adf:d088:: with SMTP id y8mr711729wrh.36.1585332813597;
 Fri, 27 Mar 2020 11:13:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r15sm9843603wra.19.2020.03.27.11.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B6561FF98;
 Fri, 27 Mar 2020 18:13:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 09/12] tests/docker: Install gcrypt devel package in Debian
 image
Date: Fri, 27 Mar 2020 18:13:17 +0000
Message-Id: <20200327181320.23329-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit 6f8bbb374be we enabled building with the gcrypt library
on the the Debian 'x86 host', which was based on Debian Stretch.
Later in commit 698a71edbed we upgraded the Debian base image to
Buster.

Apparently Debian Stretch was listing gcrypt as a QEMU dependency,
but this is not the case anymore in Buster, so we need to install
it manually (it it not listed by 'apt-get -s build-dep qemu' in
the common debian10.docker anymore). This fixes:

 $ ../configure $QEMU_CONFIGURE_OPTS

  ERROR: User requested feature gcrypt
         configure was not able to find it.
         Install gcrypt devel >= 1.5.0

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322120104.21267-3-philmd@redhat.com>
Message-Id: <20200323161514.23952-9-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index d4849f509f4..957f0bc2e79 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -16,6 +16,7 @@ RUN apt update && \
     apt install -y --no-install-recommends \
         libbz2-dev \
         liblzo2-dev \
+        libgcrypt20-dev \
         librdmacm-dev \
         libsasl2-dev \
         libsnappy-dev \
-- 
2.20.1


