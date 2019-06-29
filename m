Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E4C5B57A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2912054F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYfuVXP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2912054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDAk-0000hH-Pd
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41299)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyC-0007zW-60
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0003e5-Hf
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy8-0003RU-S1
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id x15so11607632wmj.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zjeC4ofMb5GuXRx7cMDcJK3V1wAxhsRuOauMaRsy7iw=;
 b=sYfuVXP3f97a3GbkhE5bnOPp6wQWEslCExC7+mtmuWGyuVfL4GeP0fn56Vd/Cvw/fo
 KjVAv4psiNZDRSOpk6ws9yWGr7nJ8pndh4XERijZK2v/J/nyKv5UpqW+ey97YaLoxhav
 nZfl+RxqVCqlMMbYNKvhyL8NH0DNiHA0CNyHWplvcLtAy/uuUiZyGuMNXcEV3TdvWDL0
 Edzz1/KVaUsu7tZqszuLHUO7ALRSoEQ7up7+C+iRRlDFqzzDUlRdOYKMyC503xBt17dZ
 i2tAHznYC9doDvMpVbrIHZdtP/uEO6+jZ3OpHuYpn5zAGnZYyz+haT3nss8/ERZeim2w
 sr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zjeC4ofMb5GuXRx7cMDcJK3V1wAxhsRuOauMaRsy7iw=;
 b=be8w9eize45GQiGc3pG3/e4bE46UUbyDl4waNzPZmsjV+c/D0He8HGXtiPbVSITt7P
 9dI/ywPWo5qf+G5XRwMfVBKjxMcER22C/Lu7WWfSVMPn2ua0fY0gRJALekjATBO48mR8
 iiX4u4ukkIw28LYjZ7NJqjhUms0p57QPzkSvS4tsJBWvHdomTRyXmBWXMiUozFMYNiqb
 g8ZyQ//SBMJ9gl3ps+zpLs0C4zIzLLH6OyRDG42fGx2iNeye9juxnpvtAVZA/6u9xWX9
 OpcRcqMBJrrbgLChAqjoioTEw/Oze7yNkr+IbkpTfAv4m6XWkI0IakF36C4/yEYo7AcR
 +6iQ==
X-Gm-Message-State: APjAAAWv2ht9tJXIPqLNWotZ0QiTkdVLIMDPZ1ANChkIMfQY4dD6Jl8/
 XkVogupKUHi52avZaDjbJ3KgeWjYVCvXkQ==
X-Google-Smtp-Source: APXvYqwjLMG11wdYHPHK2boP7aywQ+E7ZYlJKv/e0ONFEmyRD0+Su3MseZSuKBBU7Y8AFN3cwjhG6Q==
X-Received: by 2002:a05:600c:228b:: with SMTP id
 11mr11027797wmf.26.1561813228310; 
 Sat, 29 Jun 2019 06:00:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:10 +0200
Message-Id: <20190629130017.2973-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PATCH v6 09/16] tcg/ppc: Prepare case for vector
 multiply
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This line is just preparation for full vector multiply support
in some of subsequent patches.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 307e809fad..e19400609c 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3306,6 +3306,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
-- 
2.17.1


