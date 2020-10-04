Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8109C4363D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4272D2065E
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNWF7OoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4272D2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8P2-0003iz-1G
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NO-000202-Vf
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NN-0008Hx-4g
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id k10so7089178wru.6
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e2Ta0Vt+iMUUkJFcNFw7uUJzE/uT96AaR36hTgf6GL0=;
 b=GNWF7OoFk3Pto0NX8iRfjDJqVEvDQIDCC9uVmuo1ivEF2fe0rzQCu5QBztgw8qT/KF
 I5JTVAYdAgBTbtZhVPFzn9hD6tqAiKnG5Sy85VHaTum0Z8jsJMEvMTgbBp/nBqmS4Dmz
 jeC4JCFOvmd3mF/erUKczYEx1FEpMO9QE3hl99wzV+NRueqF07BOLZMge5fiWzZkRbGM
 RRJxKLWGgGhN6HGCl6eFPjiiBnqguGK2PMvwEpMYQKJf5nRlj7ofGKYHpI4eWQFFvkWq
 F4w4YMA2XyyfMjIKbRQjXsxj9jxTN1HQ+dmjHlsBRENZT8rswCdCv6erPora2boC5Ik3
 GVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=e2Ta0Vt+iMUUkJFcNFw7uUJzE/uT96AaR36hTgf6GL0=;
 b=Ou+avW7nAlzMMOWw6SrPH8NYVH/2IVIdb3a9dpRtqgHTpwdMdoRIj3U5csYHqePD5r
 1kaeK1KxYZkTjHmY0iw+A7fTuIB8dHzRqo76XH7DSDI+5Yj8alpdFJf1nZFUMWXfooMC
 U4zfIPPs1cz8j34Y2W2CXfIIMOXLBa4POj02yHqhUh81scidBzAEmieWKk9tLVTM2qr/
 WPitOP0z9FtAybWBU0Y+qOWrf9Dw1T3119e/+XKw4k+Cl3m1qsUp2unmCjv3Omq0335g
 iiNRp+E+FO8lsxKPNIe0YKVwKHlWwJxUfgM4XFkpAP/96jLJXcnj8IWJAdFxCRHqpsVu
 rmNg==
X-Gm-Message-State: AOAM5307w3QEXqiFRapl+16WleCGU3CHDZ45afHijvPjF1lndlEqJzmR
 +Yfq9jd6NdobCJCY7KUZScx8LaMULhY=
X-Google-Smtp-Source: ABdhPJzwaIomLj3Cx2tUAbEh1QEyU2r2iZnSGt+bOra2KFPJ0EfK8IKdyk+8A84TkbqjD87dMKUjeQ==
X-Received: by 2002:a05:6000:108a:: with SMTP id
 y10mr7908921wrw.41.1601834687641; 
 Sun, 04 Oct 2020 11:04:47 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/21] contrib/gitdm: Add Alibaba to the domain map
Date: Sun,  4 Oct 2020 20:04:23 +0200
Message-Id: <20201004180443.2035359-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Qingming Su <qingming.su@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Eric Ren <renzhen@linux.alibaba.com>, Eryu Guan <eguan@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiufei Xue <jiufei.xue@linux.alibaba.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Eric Ren <renzhen@linux.alibaba.com>
Cc: Eryu Guan <eguan@linux.alibaba.com>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Liu Bo <bo.liu@linux.alibaba.com>
Cc: Peng Tao <tao.peng@linux.alibaba.com>
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Qingming Su <qingming.su@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index dd79147c76..edff91b28c 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -4,6 +4,7 @@
 # This maps email domains to nice easy to read company names
 #
 
+linux.alibaba.com Alibaba
 amd.com         AMD
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
-- 
2.26.2


