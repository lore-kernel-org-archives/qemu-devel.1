Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F21C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4812C207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJygbJX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4812C207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibnY-0003yv-I7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibjY-0007J1-P0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibjX-0005Dg-Pn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id r7so20762286wro.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9+zsJ7z9WwK/dGWrZodx5Civohk1cvnYUrMU7t5GYU=;
 b=SJygbJX6YYn+prddjMVYTxKJlIf8rtP7z2lxvk7p9BNuVujjGJ58ECBosu8w8qrkNd
 B7HKmnEunE1dpPjeIs/tRxzEmyRDxKFkZOoFBHkCa5AKm+4egXYhxWSMxOQkA904lJl0
 S/pEGJH/iLmhfYgnxlM8g5K8htI7oenhxWa/7JArmxl38AZ26ezhOi3YPNxT9uEDf3P6
 3qHKP74V/aAIMr/QdYmeTj3MStZJp/Se2spWTxSoYBqCwwFHFYEbBZi1dSETi8Z+006p
 NSAoNa2hWMyRVvVRVp1X9wvOFq4UHfUZ5s0pI3LKgukTTeA/vlVl5hX1O/DssnW9RaC+
 nSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9+zsJ7z9WwK/dGWrZodx5Civohk1cvnYUrMU7t5GYU=;
 b=tJM6xCxs89TpZVJEMm5CTh6yV6koyAau6xTIB8PqnclcY0Lebo5zFDWNAh4+pwKaPM
 w5hxj4XJTZW1AxB807Wogeu5iFpqSijG+2VXFW+eVm82T7TpWaR3fiB7HNvp7ke4rGV2
 FG4iYC2J2mmk0OnCn4LKcSoyrBIPbPuW1waOmmjbEXWqbSjbVfD8oAYUQzOlI1qb8qH2
 kxmMK4HWloIs3SNu7b068tse/k/RSeNelce8S0fLVnZpXUCUQKhMdb6fTvoOIXsQS8mM
 9iipO+X/JYm/kpYSdxtoTVE5eS1McQe3VLqYYmueqmA5gXujq1tY/Ms/XqfFovJjibXG
 gG3w==
X-Gm-Message-State: AOAM5303XAGLXFda4AHgaz4ReauiGz2yhXJsA9m9Wnktxw+R0/ssv6rH
 t04MIu1t+y9lKUNyJBba2dBY0w==
X-Google-Smtp-Source: ABdhPJyOUGLUccKYFL312/tibawMXg0iqHSu64dzxSiiy4f3ynU7IREYr2iWF0sH5C15xD2ZR8yd8w==
X-Received: by 2002:a5d:5483:: with SMTP id h3mr3865295wrv.10.1591699434395;
 Tue, 09 Jun 2020 03:43:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm2405807wmj.29.2020.06.09.03.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:43:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E57201FF9F;
 Tue,  9 Jun 2020 11:38:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 17/17] scripts/coverity-scan: Remove flex/bison packages
Date: Tue,  9 Jun 2020 11:38:09 +0100
Message-Id: <20200609103809.23443-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200515163029.12917-6-philmd@redhat.com>

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index a4f64d12834..ad4d64c0f81 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -19,7 +19,6 @@ FROM fedora:30
 ENV PACKAGES \
     alsa-lib-devel \
     bc \
-    bison \
     brlapi-devel \
     bzip2 \
     bzip2-devel \
@@ -30,7 +29,6 @@ ENV PACKAGES \
     dbus-daemon \
     device-mapper-multipath-devel \
     findutils \
-    flex \
     gcc \
     gcc-c++ \
     gettext \
-- 
2.20.1


