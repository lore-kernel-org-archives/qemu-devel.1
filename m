Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDEDC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E8F20873
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQ/I2joQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E8F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vtQ-0006Qh-7G
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 12:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqQ-0001zP-OM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqP-0000Ip-Nl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:38 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:40731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j1vqP-0000I9-Hz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:37 -0500
Received: by mail-pf1-x42f.google.com with SMTP id q8so1565209pfh.7
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=jvUnrCfwBmFS79rScsI1Rt17EyEa11qYGHquQ8V2ZQY=;
 b=fQ/I2joQFMaynu4jWp9UQZX/4R92DGprjnwF4HK5xMNmgKJkNnWv5bZEZ3udG0zcRy
 DcI8arHDLvgUoa2I5h6hEgnokPMqJl4lxAMHLOqmLmVrt5RnSgJoBEPPqf+ZkJju678s
 5uRGh7MdlVLhq/MurySrb1MBJnSQuaueGIXJrkwHiCEVa3kddJ53GlUuk4l9mB8yAz1P
 elUzcZ7l6CNT5JQiBjVFVnb70XGDwnrL1lTBtH4Cx77JqtN5hwSTTuSnq8OLsPec8BEY
 eN82YyqxUklYzUJeL/8qd0zaTTRZB1tg+fG6MplPQPYUdcMfkgtJRMvzLJfeND+pIkj8
 J8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=jvUnrCfwBmFS79rScsI1Rt17EyEa11qYGHquQ8V2ZQY=;
 b=fZ1/7E2phNEqJ3ZJbrG0DIKEA8+G/XTjTKNV4vcj/xjcx18mwWGFKjnNSGDeQW50t7
 6X812uDT/pxBYjdNa72ozuJ2Sy5RDanfpT6ZynnaE0V1GcUzfXCURg1cuqOnETOOICAg
 gDOkbcQemeq3p8m1OKa6rcV5A0R8EJpim2IcynqVvu2XLZmfkBYYA69xuFAeexNoYSlV
 HZjTNGTJsCnhWBfV4VUEx8WC4yPA/zkL4TDqIDH0WSLOtcrrS9N1eGqNE4jFE2JSnI30
 gYkZ0AidI++pQlgo3R3ZGKllZQ7WB2bvislFRsr8wkdn8WLMRwfyOdUTumMR7udqlw6+
 RPcg==
X-Gm-Message-State: APjAAAUGjNiemLOhnJ/quKrB3+0gCzkJCAaLXSAutmRrnxX00pAEuY7x
 8FratmoHEB1L+8PI+9a1OnGhmL3zrZM=
X-Google-Smtp-Source: APXvYqwy57jU5T4RF43F6BY/GDPQpznZUrJoEHYug2LlYD1fKV9nybBmCQVrbAsqdezaqC5V6CtuzQ==
X-Received: by 2002:a63:d042:: with SMTP id s2mr13380564pgi.66.1581528636271; 
 Wed, 12 Feb 2020 09:30:36 -0800 (PST)
Received: from localhost ([2620:0:1000:fd28:dc94:91b3:e554:4ae7])
 by smtp.gmail.com with ESMTPSA id g9sm1530599pfm.150.2020.02.12.09.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 09:30:35 -0800 (PST)
Subject: [PULL 5/5] MAINTAINERS: Add maintainer entry for Goldfish RTC
Date: Wed, 12 Feb 2020 09:29:21 -0800
Message-Id: <20200212172921.36796-6-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212172921.36796-1-palmerdabbelt@google.com>
References: <20200212172921.36796-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 Anup Patel <Anup.Patel@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <Anup.Patel@wdc.com>

Add myself as Goldfish RTC maintainer until someone else is
willing to maintain it.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce46c0a552..43d29ea662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -562,6 +562,14 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
 
+Goldfish RTC
+M: Anup Patel <anup.patel@wdc.com>
+M: Alistair Francis <Alistair.Francis@wdc.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: hw/rtc/goldfish_rtc.c
+F: include/hw/rtc/goldfish_rtc.h
+
 Gumstix
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daudé <f4bug@amsat.org>
-- 
2.25.0.225.g125e21ebc7-goog


