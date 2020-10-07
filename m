Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B519C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097522064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+5QzZFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097522064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCGs-0005l8-Ve
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBs6-0005ED-Jl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBs4-0000zc-Cz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id v12so2979128wmh.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t8kaYfXkJQp5EB64uF/+mNdSC14dIjEV+8Lq273LV3A=;
 b=x+5QzZFVkOxMmk+NyovkBxy7U90AewKmPnDYQ6gH069pWiYcriAuhw7+NzAN4EhIAJ
 XOy+zuHo7wd69UwAOXE3RTWe0m5VCDCQw2Duc480+TeVB7tp5Pd9TiWSTVJNbF9la2d+
 n7xsGsjU/g6m6WJtLEv8AupvK8lmmKvCTWsL0J1bK3d/zD6SaU/06/ySUq5fcQ2KWxdl
 IS1+vZPzpsXG9+lW5OJWN/czojUbDcufkyAzcIVbyDYRkWIGTPTmTnCUSNDIJ/ADzI0+
 7ZOHuHJBCFskfFhbuIf8qrsPSFV8ZcJxbo72KmXlSjEz+l5JBEmEXHe16OmaQ/b6tMkj
 op5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t8kaYfXkJQp5EB64uF/+mNdSC14dIjEV+8Lq273LV3A=;
 b=DsTYYPFmSnmyfEX5A+2h9/Qb6HE0i0ef+dxUyM84d3kLuIeg2mr1qxLtQH+sF22u4o
 82qJ9CakIs9vl2oNowv+ZcdNuAK8xaEhB2sWuGJNvYiQjhIwOxp7t9noLoCUmadvIZwT
 SvWzqYTDR9FBUBgokdyKzdks7LSNQo02TsWqmuotUC70s5vtQR2JxD9m6+qTK9R3KdHm
 1RSwVKKiMQl7LnV1tGlis+cynOE7H4YGRCL2sUlZUD2lndyBEQOKL+LwJCvtds3Hp01g
 5JjNZubBC7a9ZuzDgi0Etv5F/pKHq5mqVOjSd586JZWiDFFM4Q4KDaON2+iu24HVFYja
 CPtA==
X-Gm-Message-State: AOAM533A76Gc++9cMIZiNI0k/CEQMZasj9C8lhAWuNsdpC380qbudWhf
 l3H+vxemaET/7YYFz0msUnq/QA==
X-Google-Smtp-Source: ABdhPJwuvZJM3YmKQOrTAJR3qNYMNXCanpTfC2RP0YHnLsI097+OQZaoitwFIXl7SMpV/IMwWcs7SA==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr3951690wmh.53.1602086450056;
 Wed, 07 Oct 2020 09:00:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm3452429wrv.25.2020.10.07.09.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93F481FF91;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/22] cirrus: msys2/mingw speed is up,
 add excluded target back
Date: Wed,  7 Oct 2020 17:00:21 +0100
Message-Id: <20201007160038.26953-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Cc: Ed Maste <emaste@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

The following target are add back:
i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201007145300.1197-3-luoyonggang@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index eb768fa260..301a64f104 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -124,8 +124,7 @@ windows_msys2_task:
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
-      --python=python3 --ninja=ninja
-      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
+      --python=python3 --ninja=ninja"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.20.1


