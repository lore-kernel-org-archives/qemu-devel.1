Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DDC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3908206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXtXqzVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3908206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCU2-0004F8-It
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0v-0004UR-Pa
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:10:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0s-0003Fe-1J
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:10:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id j2so2852215wrx.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6LduDxf0ldWzs59y+Iy2JXH5Wmk6O1eII1y8fHp7Zgg=;
 b=eXtXqzVtg0WTb+AIs34gkeROB55CKVnwd18mZZHLUpl1ZHzhy8COfiudvX3L9Iqwmz
 PA8MigK1dmwmL2vkqi7cXytMZafg+KRKUrCMWCAqUeQlOy/7wAMQ22YMDLEt/MBmNFOE
 OwM/ITnMYinGITsYVxey0g1TfPRcJnf1G3kBqmrHr16ODghIVx2DiD6FvbuOS7jfhx0V
 OVa7h1olCU7j1Ehfa4ixV2Ed7GKcFUl/bQjXLl17LNvh3Qp/5nH4H9okRcxy0g/m8yfO
 ZHUnqOBLKI/O1c7xqqpfUydnF0ZBOHg273zK1sqJrX6vAUE9foRSFDwfrBPZfvl0pgCM
 2F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6LduDxf0ldWzs59y+Iy2JXH5Wmk6O1eII1y8fHp7Zgg=;
 b=b5sR2zSvWPS5qu7zyzuDZsqjD7HX+beRnzQ0vl0SFEdsTsmeacIaKREoW/rS6ntNgE
 pgZR79ugQ2jqXqm/uwMoRvNKXOKi1eHw7rq9VnMOf1sqAaYDyQQ8PUBEZgvIWvn/a7Ex
 IdyC0ubAe58pu2RBUGJ9DX7xG8UDsmV+YypQhBxs1BkJYNwtJg9z4xY+rEyOZWf3R9up
 fhq4sAAydQUsz/sxPbI5wGndZeH0I9jdmXW6x0yz88g31k6swlJz5nxu9JbYU5M1jukj
 TxxEBDn71MieYfOZFetQkS1Ew2ygc+kKDAsehtOF82SzB84yu9rcQl6hEA9hJ2A7SHId
 HuWg==
X-Gm-Message-State: AOAM5314LxU+7ry3n7ynphTMYoGdYZ6LQbCwqq6+VTe5FJh6MWxXQ4M+
 qlgjXxqoP25zucwSRqTxcb40TA==
X-Google-Smtp-Source: ABdhPJx+Ky4mCKW/dwFzLuJBw3Zl6KcqBwetTdoQiNnCp/cfQ/L5dsfAhWnUFvHunnR+FpswVmTiuQ==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr1230821wrp.99.1602086996373; 
 Wed, 07 Oct 2020 09:09:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i14sm3894678wro.96.2020.10.07.09.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 79BB91FF9E;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 15/22] contrib/gitdm: Add SUSE to the domain map
Date: Wed,  7 Oct 2020 17:00:31 +0100
Message-Id: <20201007160038.26953-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Bruce Rogers <brogers@suse.com>
Message-Id: <20201006160653.2391972-10-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 6c5c92260d..d767620837 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -27,6 +27,7 @@ redhat.com      Red Hat
 rt-rk.com       RT-RK
 siemens.com     Siemens
 sifive.com      SiFive
+suse.com        SUSE
 suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
-- 
2.20.1


