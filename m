Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAA7C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75AE206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIUBZIip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75AE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8DP-0006ZT-Tm
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89t-0001ME-C2
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89s-00007Y-33
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:53 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89r-00005I-TB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:52 -0500
Received: by mail-wr1-x436.google.com with SMTP id k11so3605075wrd.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/MBe1mn2zd5kU6RFA9wgs7vxr6r85wMgGco2Q4w0dfQ=;
 b=SIUBZIipkNKtAiIq86e3HVtOIEWViS3+DT9L709pIAqkIDnl02Cl+xdqFis7DwtH0C
 6IB/9PAV5Lb+t2AwwAW7tOU7FGx/OKZgXBfpZ1qb25rUYPdbpHd02vtOkwW8zY8TZo2U
 s67IcHBfKH0g0AaBJeZqusfAgVNG2SZNCofDh9vcY0AZaPI7zFgs39kQ2PUYSI0fWKV8
 equ88VjWt99t/E7yFOuE92hTCZ7hltzT/5hMCXxdrdzYBAs7NSG0++OiTFyMQIvVkP5e
 j0ly57tCwOs9P0L40sFtUwkg+BAJ80jnKrsDlUI8NqCNH++G6QNMF+kiBG8SDG1yYN6h
 u4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/MBe1mn2zd5kU6RFA9wgs7vxr6r85wMgGco2Q4w0dfQ=;
 b=MtGIwf4g5OypXGGUODkDqFAA7Ms6D/Tw9sMXeLQXClyhJI8gRvRFgmu4NSDHPTY3b2
 QJn59+la1pXQOPPA5zfAHWmFDiAtS5MQuzW5UJCChU3s7N2MVifmctkonhhZPn8JZeFN
 sxeDhLALbPXAWNsqxvMuiw7uUb4Nln9cMqqmcCvkvnzyk+wf7w7ZnLoilwS7UdSDk5tA
 V+RYUQezxNqW4dmXSij/3oA/H5jeg5rF/38kIB7ks5D94Mhz3WScF+Rn67vQPWD8FBqz
 jMKq3JJgFqwsHb9QFERxDLa0cqMKfxsEvOGx4M8r7o05IbNLkvtprMWgFXcp8DW3R+Lj
 hgnA==
X-Gm-Message-State: APjAAAWv86eOpgnK4IQF6vfJML8HYiwLvrSuquU06LlpNxoX4e9Lmix2
 XaYDFF0PNajXqWZFOgjxWCOt0Q==
X-Google-Smtp-Source: APXvYqw0DYJAxAP4yeYmQTlcrGk6C69oSn7pYpoP+21IkKdibPuhcmV4aqOrFesZtry+Z38mnvq9WQ==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr5046674wrn.344.1580384330867; 
 Thu, 30 Jan 2020 03:38:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q130sm6076642wme.19.2020.01.30.03.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:49 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B3A041FF93;
 Thu, 30 Jan 2020 11:32:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] hw/hppa/Kconfig: LASI chipset requires PARALLEL port
Date: Thu, 30 Jan 2020 11:32:17 +0000
Message-Id: <20200130113223.31046-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Helge Deller <deller@gmx.de>, richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The PARISC Lasi chipset emulation requires some of the common parallel
support and fails to build on a --without-default-devices:

    LINK    hppa-softmmu/qemu-system-hppa
  /usr/bin/ld: hw/hppa/lasi.o: in function `lasi_init':
  hw/hppa/lasi.c:324: undefined reference to `parallel_mm_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-hppa] Error 1

Fixes: 376b851909d
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20200129192350.27143-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/hppa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 82178c7dcb..22948db025 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -12,4 +12,5 @@ config DINO
     select LSI_SCSI_PCI
     select LASI_82596
     select LASIPS2
+    select PARALLEL
     select ARTIST
-- 
2.20.1


