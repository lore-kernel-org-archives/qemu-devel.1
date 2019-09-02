Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBEFC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB8120820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCbf34P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB8120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jZ7-00015e-2W
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSn-0004kr-Hx
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSl-0004IS-Ie
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSl-0004I1-CF
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id n10so3316518wmj.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qUZSmFGjrzoPrErHsikW1HoBierWwmyBbkhOk/UFsHU=;
 b=fCbf34P+lEa7r/KOHdkc23nRJEW7qr1pUdXXAyckepyOTwE4filZn2AyFOevxZ+GlP
 9+Iv1WF6MwHuiT7FmfuwPkszHWPMuPwm/6ShHom263UPl+DhGqGBCVdgJm8br/FOWAJt
 zxOU9k5f6I2Zj4wRpel/1ZPXjbqfo3yHNtccZyLrg35BVsoRgsNTo/yTgk03QorIJ5/y
 KaQRhrbYCFKxlp1aPrfyXRAk71byScVw/0eoNkoMa5R4ZJP+kICBtcuEh9SmrrgSLgXd
 3N27foZoqt9UESh3LX66PnOd9guSqTBpsWPGSY95MAQfGI5VysO3xhzj+UEyZAghWLfc
 2LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qUZSmFGjrzoPrErHsikW1HoBierWwmyBbkhOk/UFsHU=;
 b=FKspCZt1Ed0UcDu5S9k0puafNG4aFZw4W2YZ6RL0sulWYae5DW+jYI0Quody4VgfGv
 HPpckKs7ye+GB2aFPGEdzs2O5N9Ve6C8JMsKKG+WYJCcsX85Ir5qyr+Yy1bkNKkmLFIX
 twDmwwp8MkOE+nWHN1bxbcnxYH8q06zUCuQ/2e9Xx01hJE8sLg+JkGwfAbjrN0S0Mzzh
 lzRvqkuRUbbn01igfxRI0net/hfOIKOsthTcpUSM3Dmkshv9yRhV4XdU7aJebsLmwMaA
 mllxYicQPafSnIZM9yBLGnUnMMtu36qiySdzdG2PtvaeXmjcmaW4F0Nvv3xMAkgMipf+
 nngw==
X-Gm-Message-State: APjAAAXY6D/HMKJS96Cs/8CbpIAAw+rEH1LmdRzv1jwQRX5DNmP4U/sF
 ZcEYaGRPM4sMeUDsneIEmfsI0w==
X-Google-Smtp-Source: APXvYqyRO6npHXaw2qwqUwn1XlP2wNmVMTC8ZJ0lh2BhAPgqHY4c46Z1bACHjuLKcVldpghu/J2iAQ==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr33625516wmf.54.1567419690347; 
 Mon, 02 Sep 2019 03:21:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v11sm21370826wrv.54.2019.09.02.03.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 044561FF99;
 Mon,  2 Sep 2019 11:21:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:19 +0100
Message-Id: <20190902102122.1128-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 09/12] contrib/gitdm: Add RT-RK to the domain-map
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This company has at least 7 contributors, add a domain-map entry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190822231231.1306-1-philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index fa9d454473d..9efe066ec9c 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -18,6 +18,7 @@ nokia.com       Nokia
 oracle.com      Oracle
 proxmox.com     Proxmox
 redhat.com      Red Hat
+rt-rk.com       RT-RK
 siemens.com     Siemens
 sifive.com      SiFive
 suse.de         SUSE
-- 
2.20.1


