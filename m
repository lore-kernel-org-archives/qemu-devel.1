Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A4C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2202C20838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQD077Tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2202C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLZb-0006Hn-A9
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLG4-0005Wm-Qk
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLG3-0008Kh-O6
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:32 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLG3-0008HA-HT
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:31 -0500
Received: by mail-pj1-x1043.google.com with SMTP id n96so6309377pjc.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nAc6bZFMh5Y6eraePuEkGsT4LHqoTY3CFOaKZXGiiQo=;
 b=WQD077TlgHyUkOD57O2exBM5dLkPrPvBLDLPA9xY71hN/Binp/QUwL5rTbqnn98Z1y
 TMUKpKJ+kJX+GeYWhx+L7TCVo1uaK8cEdX2W1R7QWaZvir+X3JytF6ZRWl8Xlnx12Mrd
 8ZKN/ZGBYJwODw/5O1rSv6txw8iHsUWT3JsIl1JcGPk8qqS3nwE8gfYMx2An7hbdLe+5
 x1ObAgld1ru/TmCpzuu/Cv7lvK0DgWsla3cuUfmKjnLr0cW0hBEYKkvzBo6gpXelCFfF
 hRfFNNOoOiBzOyFhy8f5ZL5U3Kdtf9XbDMymBvxwc/ZklhbQJTc3xdz6ifevc0JUoZwg
 MLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nAc6bZFMh5Y6eraePuEkGsT4LHqoTY3CFOaKZXGiiQo=;
 b=Wd/5+YZH/BWtkv1FTyflmzdVLCI7Zb11AS91awvrBNpuKUVdKwA2wH7rd8UhSr5dZV
 1xe9FpHa7WAokPJ0E2WKDZhVgJFQU3PqJdLUkt2pQGAPnNkNYepYccDt008XkcKeDAbT
 7qclDgZXN7INpKAPVCbWZSm9862OSlPVhrHqiEMZEP5CYTpQX364J4DKLN7MxbhrbiJy
 qrc5ITcnSvC+mfmcRfRzqU4oX38bOLjPtXT5RisVDXaCJU6Y/udbKktek19T9PMkZZto
 yKDS73856CiQNaZoaKdGRZVlzAdc+UWQe96mdKLEVqmrYxE3nybe7eQoxfhMOfRQSQ+H
 2SeQ==
X-Gm-Message-State: APjAAAWwxjJrnhAVzVRWDFmRCZqOlaPZuJh/1h8Rn2vgQBnRH1Yy6OxB
 97d5yBeOVHxdQb+PcVPl79fVekLfmsc=
X-Google-Smtp-Source: APXvYqw1Y8giqf5I9mzEmT9X0LIJmcRvAkc7LUZbbG7ZLiVyJhvOQ7v50c6W64DGTp2YDKaZ4B7NcQ==
X-Received: by 2002:a17:90a:fc82:: with SMTP id
 ci2mr35160292pjb.13.1577574750356; 
 Sat, 28 Dec 2019 15:12:30 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/29] target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:15 +1100
Message-Id: <20191228231124.18307-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 95773089aa..32522f606b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -328,9 +328,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define cpu_signal_handler cpu_mb_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _nommu
-#define MMU_MODE1_SUFFIX _kernel
-#define MMU_MODE2_SUFFIX _user
 #define MMU_NOMMU_IDX   0
 #define MMU_KERNEL_IDX  1
 #define MMU_USER_IDX    2
-- 
2.20.1


