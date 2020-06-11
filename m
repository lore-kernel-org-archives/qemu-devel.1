Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92DCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F637207C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej/JXeMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F637207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJiu-0003nS-Uc
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJhn-0002WL-Or
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:41:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38379)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJhm-00073L-Ru
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:41:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1so5432620wrt.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxKuIgdrvT2CMCeuqas9v5Tid0cbFEYlE1QEy3ewPr0=;
 b=Ej/JXeMhu4/n71AOh/5Zfjmmg9BaRZzWeixt5dpgSComg1+hvo2U2Drq1iDMdvjY6E
 AHUZS0O9ljZyxay/8UpPZCJ6YKEu5xvvDG4s+xvzhfWQvs1fzb3AE4oSBikolcsZi6xm
 x+kseIHE3wbg2fTRWYABXnbKgeVR7a4jpDfl0o9GK3tCElwMpm0JNVpiu8ngicTPL6PJ
 tnurCNxJJoucBxXUvoJAN+nW30P8oDMh4GRHe6zaT7rbhLV8lqDL0KqByaMnKmh7XwUi
 AnZqqHnxgmNUh+uuK6rtwEa7QZ54R0LfDveXDropoJQvjHTA8Xdec5mbKC/7RXhoKXWN
 NvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxKuIgdrvT2CMCeuqas9v5Tid0cbFEYlE1QEy3ewPr0=;
 b=BIJYVXZ/XMjh3K6wFaSbWfVDl0WH6lRB1Wr/T/xKEosnqLYtVNTX6vmn+StAwJcJkL
 hrq+PNF1B5xvrgJI1XY/oDOeSrOUHNOV0XL2oNeEjtCRmRg+jgV872+p+sZerd8YAtxP
 8vu8Qb4mLDDhgWPBq13pNzs9MEgihdIX39vL2HLzEkdwxCXw9pJ/lDh3H1u3OXJiSIBF
 spNBWC3R1Qeb/VY8Iui1/9tQmkvpUzPA6nmsrTGIrFyk54ff+8rdKtjVq5Y4xf/0osVZ
 F5mdXH1UDpmrNUBNlzcX4H1FRkxY7QGH/vgIRJPwCVfuanimFathPJs/6pyvcN/TSpyM
 gdGg==
X-Gm-Message-State: AOAM531e+MsezVnTD9Szy9BLFXjRXnTE4L9MoxVHZFpVfSMOaLuiEsSz
 jGWr9sRHo4psILRO0sdeiqlQDPK8Dts=
X-Google-Smtp-Source: ABdhPJxBMw0VwufK69pU2htZOaXCAB9gpCCBP9tZeECC/O/zoq+ErEY72T/jQqDoc0DI7p3xBl5umA==
X-Received: by 2002:adf:a357:: with SMTP id d23mr9114872wrb.351.1591868456185; 
 Thu, 11 Jun 2020 02:40:56 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id e5sm4124975wrw.19.2020.06.11.02.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 02:40:55 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] MAINTAINERS: Adjust sh4 maintainership
Date: Thu, 11 Jun 2020 11:40:29 +0200
Message-Id: <20200611094029.9528-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611094029.9528-1-aleksandar.qemu.devel@gmail.com>
References: <20200611094029.9528-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch transfers sh4 sections to Yoshinori Sato, who is
best positioned in the community to assume sh4 maintainership.
He is the maintainer of the related target rx as well, which
means that some synergy between the two targets can be expected
in future.

Further adjustments, reorganizations, and improvements of sh4
sections are left to the future maintainer to be devised and
executed, as he deems suitable.

Aurelien and Magnus are deleted as maintainers in some sections
of the MAINTAINERS file with this patch. However, they will not
be deleted from QEMU Hall of Fame, where their names will always
remained carved in stone as QEMU pioneers and granddaddies.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: Magnus Damm <magnus.damm@gmail.com>
Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..7ddb6db38c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -296,7 +296,7 @@ F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SH4 TCG CPUs
-M: Aurelien Jarno <aurelien@aurel32.net>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Odd Fixes
 F: target/sh4/
 F: hw/sh4/
@@ -1251,14 +1251,14 @@ F: include/hw/riscv/opentitan.h
 SH4 Machines
 ------------
 R2D
-M: Magnus Damm <magnus.damm@gmail.com>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
 
 Shix
-M: Magnus Damm <magnus.damm@gmail.com>
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Odd Fixes
 F: hw/sh4/shix.c
 
-- 
2.20.1


