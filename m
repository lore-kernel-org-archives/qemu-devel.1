Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E2C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A315A2075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emeFHzIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A315A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1hh-0002C3-MB
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xj-0005IY-VD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:55 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:36606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xi-0004XS-72
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:55 -0400
Received: by mail-pg1-x52b.google.com with SMTP id x16so4450653pgj.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=emeFHzIS4iUEPcOCm6oli21aRFjvflj6+e9WjiCh8H/iY187imDjCWK9EJQb1rhZit
 DBynOuKfl6SmxaGApwtcEBehUQHWD4KBU8k94ZGWh5KuezFmI+aKA87UXftdEa5+/gPo
 T7fddsmZrmOCbRrFHGvq6etjtZpZOJ7V5cTghV7k7fVZqOu2/HwqjP1raI8bfOxoeAvp
 BjwMxSwAfh/ZpLz0gXKMlnIjux2vFERHlbRYWyM3s1QYOxTDVzYtDnJLuEIK2BjdTpxy
 qMqwKMQEjxZb5m6IRQY0ZhLLUdzVvOzi0FzwB18JQNMTa9XekkOnb8QoyQTT2+lH5LUc
 vw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=FZZdNAwftNQD3urNo7G0EaU9E2FCtpg7DJn10yz670qfKioRFgNWt8c3JTYSy29W1U
 1SGTEH6bexwM5pp8NuUxid20o17wsl6UTVGql4xg93KWkuB8BqbKIF1sMpeBiixpNyeC
 O60kfZOi7L8cenethr0NlJOTVFhsSWntEJGtnlX42biYMljLqq2jrvYesHlvmoxsXFBw
 ry0xQWiU8tR2jT9aoEU/yBHb+4pqAuQl8SZsdeFn3b9IyrHKwxZbdQHyy5ejnx/cEimS
 pmuph+rBRER2wpawJjbp8mrEyvl4vxmKBwF+tYgi/49uGvhpN1IMFqQ7FzK3ZmXucW14
 o1XA==
X-Gm-Message-State: AOAM533qNKj0eON99m26vm9h3Q0GkNwoHvxVccF9FfKdEsdijUvBFX2F
 NNfTgYaTVt2+JIlOZJ0qsoUA1U+BpvDVSA==
X-Google-Smtp-Source: ABdhPJwkbMMTrDFEfLzzTDS08GRqgGfcGmqew3lVoJt5gCDzBePL6nEjFQl/iPekNZuUbGxp2ZDZCA==
X-Received: by 2002:a17:902:6b8b:b029:d2:173:33d0 with SMTP id
 p11-20020a1709026b8bb02900d2017333d0mr7693596plk.62.1601570092328; 
 Thu, 01 Oct 2020 09:34:52 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t12sm6946028pfh.73.2020.10.01.09.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:34:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] cirrus: Enable plugin in cirrus for windows
Date: Fri,  2 Oct 2020 00:34:26 +0800
Message-Id: <20201001163429.1348-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001163429.1348-1-luoyonggang@gmail.com>
References: <20201001163429.1348-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 86ea33926a..5363142373 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -104,7 +104,8 @@ windows_msys2_task:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
       --python=python3 --ninja=ninja
-      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
+      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu
+      --enable-plugins"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


