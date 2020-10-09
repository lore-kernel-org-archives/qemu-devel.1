Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67778C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103D42227F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maAT/LL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103D42227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvNy-0006ee-7d
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJQ-0000Qz-LQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJN-0005Bg-Nc
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id f21so10407839wml.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HxIyoYU/k3kOEGuCcAHD+FnA8yS+62GGIqaWUy0Cfjg=;
 b=maAT/LL9ZGDpzigG9B2jN538myI+Hw+enELSp8Jf3LH2su8BVZC7QCyJc3AVbYYNbT
 cN1LJvQ6y5ODS+/CTRWyZJ+qmioNUhqe59mNRgYKpqWOTveXBeW0n2r/aXd9p1aNqM6E
 +GFHAyt5wZToIsJlmeDNqQyXT1XSBszYQxSTl5pyDRGMaCS5uTUo+U6hJaNsFsCSh41z
 0jtzYd3kojJLfoqMLmUNlFmVt3Yzq9Jlxiu+tM9ySCppcRVe+WhVSyp+gRgQSX6iiSjU
 wpuetf+MwTOLcov1mF8v9amtxHuO9iF7T0k57vyWi8tb6AiIY8C6AbsuEPKDcW7rC3ko
 FMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HxIyoYU/k3kOEGuCcAHD+FnA8yS+62GGIqaWUy0Cfjg=;
 b=BkM/lnhxuRl/IT05B4LF/LO43lS3sKoEIYeVvOeXNNoDqmD3h+xsQKspI/1Nz9dFIJ
 kh9uOsS7qRzW6dADYeTCPJo6S+xlmJ3lTbSxxWnA1eTXCZdP/7WgANYHxp+JodEuvTQN
 QfdK7PUkzNWMy7e4tB/93CGuBoPDqBjOECcHT4x+/et0kU2WGx/FSqdTcS/Ii+phhbL8
 /h9gM0IWlFz92aXDoAlB1NnjVDcMK1GaaNHnGTQ89eGLdxBEoguKiaQqMiSyqz8kHK9d
 f6ALXialXQ+BB+FRZZa/3l4u4TJkSQJb4Z8N8E5x2iEspE4ug5OD35GphxMMmPXr7d2/
 Ogaw==
X-Gm-Message-State: AOAM531GSkAj/MLxCusDEm6fXC9KPnofBl/Xgun4XO7buPrnPKBl7DzC
 CqH7UolKzASxb7l6ZWyOpm1IXA==
X-Google-Smtp-Source: ABdhPJw2aIjTi5HwR5CwybXinCl/781XbzD4Emcjpb8vRB2Sz5IxRVfsA1oLklJMzWdgkoXSRgvHjQ==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr15289783wmj.150.1602261123983; 
 Fri, 09 Oct 2020 09:32:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q13sm13127891wra.93.2020.10.09.09.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 002E01FF99;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/22] contrib/gitdm: Add ByteDance to the domain map
Date: Fri,  9 Oct 2020 17:31:35 +0100
Message-Id: <20201009163147.28512-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Message-Id: <20201006160653.2391972-5-f4bug@amsat.org>
Message-Id: <20201007160038.26953-11-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index a4102154b6..ae5d149434 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -6,6 +6,7 @@
 
 amd.com         AMD
 baidu.com       Baidu
+bytedance.com   ByteDance
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
-- 
2.20.1


