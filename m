Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDFC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3588D206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLAQf80l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3588D206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrJd-0004Y8-FL
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8m-0002AZ-9v
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8h-0000mO-Fi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8f-0000dv-6T
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id x1so20404052wrr.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uLNFFdsSuak+Uy2t3FRbExjx92r6RyqLYQAFwuvDHzw=;
 b=HLAQf80lv0Lb/1bSS69wcmuEszlSD+YIxlbf6jVuGFw++d1bTM9wPioHO2Res0xz64
 CzB7qmOtWf8iZWDzTb0j25GNDreDP3VXg5v+QUyQNpXz91odPYht908236wXvTIJ2q0w
 Hyma+8H7IQO2IJJW5uFlpe3JuistRDQAnGh15BuMsJi8Ijz54lo3erWearoEJn+xaF9I
 JPqk4f4ul+sSsL1kmGUXK+IoODkZW1zfX9cNy1GC3GSNhKYfrkMiHEjHPe/xLvIP5ZYy
 8+IpEtqmIGJ7AVO4tE3I18SAd3/N/rmasggBzg+MuDzkIhdaahUfUAkXLuTEH2MjhnVh
 wAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uLNFFdsSuak+Uy2t3FRbExjx92r6RyqLYQAFwuvDHzw=;
 b=cTHVkTPqBU2AzxWNIzH5N/hXHJASos4SJ6huZ0srBCD/gAubYr493gmHii0OA3EVeV
 mqeh/WLBHR0CzCLhTW3bWkE9HiQE4R9mOa2SkGLdig6EKIg3Q922lxWNqzW1ByGcNu0y
 B3jPu5HRekg4u8cOf6XTjtW+jTH7scYt5cugklNFUZHBPnFrSickLPIJ1SDgjDfIjvgx
 kHbw6ccpn9hm8rJN0GGyaHtMpSkhDjKNJ5N3lxwBe+srCZDD+BUqpi6tu7+6P2Bq6szu
 4dwKB+Rx3Ac7ZUiTuiBNLrvRHQxZ9M/Fe669gi8t8zzdf/fN9khMFy5nRBcDOKzyYfMt
 YurA==
X-Gm-Message-State: APjAAAWZXHGePHIaNK9LhmdosI+Xr7W6f4zAr6mqhjYVmKEa3y1ZIHJA
 nWnfv0KtNQct/nAKqgPzppLQYA==
X-Google-Smtp-Source: APXvYqxtiPUqHMCXlkNYlvFTBvypJCnxo2XtuLeNGBhqTIXlO+qcEj+YcqvTNwqZqAHKI+WtAH3qrA==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr12171241wrn.269.1564589244646; 
 Wed, 31 Jul 2019 09:07:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t185sm59154541wma.11.2019.07.31.09.07.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD0A51FF92;
 Wed, 31 Jul 2019 17:07:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:30 +0100
Message-Id: <20190731160719.11396-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v4 05/54] includes: remove stale [smp|max]_cpus
 externs
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com, Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a5e0b3311 removed these in favour of querying machine
properties. Remove the extern declarations as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190711130546.18578-1-alex.bennee@linaro.org>
---
 include/sysemu/sysemu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 984c439ac96..e70edf7c1cf 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -103,8 +103,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int smp_cpus;
-extern unsigned int max_cpus;
 extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_quit;
-- 
2.20.1


