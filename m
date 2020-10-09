Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F1C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA662225F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcUsIMod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA662225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvoj-0000Fm-Bx
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJj-0000YC-NH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJZ-0005DF-Jc
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id d4so10391835wmd.5
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QSRJirT04KzPlTG554HUlrK3ZZFI9u30wr3rgSYwDnE=;
 b=YcUsIModY0W1po6WbK48GXm4vg57VZv3K04+OjhnusnKvw2GJCYNQESxAMYcS3X5wx
 xZ4eQb0pDDA4tTp27+x36rb0W6NSsC136QPDDNhoM/nxsFEEgPMbCJUPBPw8HSu6hK5r
 ptH4CsyUW0Hb7fexPx9KIGF27cb4+mu42Tyk4w4ETH2JFxDi4WO6C1myZBxG8hYJFejT
 FjLOaybpgzr4EqgEiHY7Ul7Ox46h2REh5sX6DJ7IzOYeZGtuNS4hiQTosCzX6xysD4Nl
 Xee357ZzZCQ/ueifrKr1ccECwyZ/jEFE+P7MCPYHx/hSxebA8jz953CR4uzRqbP8GiFQ
 SCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QSRJirT04KzPlTG554HUlrK3ZZFI9u30wr3rgSYwDnE=;
 b=Xi50VHvzqWJcd7QPneLAYl5wb0wM/Q9h7MNqI3C7X7Ixmy1YzPFV+BUV9BnJ+PMLfZ
 QPiZd5F2bUhvE1n1YbwxOCQLfdqSAZO1jdJbZpAF2sA40r453On8zzMdqGGUIvBz7072
 OjdYVA+XBfbNHRwVJoAUlSGf+1IeXL08HxFfAf5E+iCeLXz+Idv1EqGFRTQ/NkqYhG34
 hYfH3tZxga+15j4ecuBbkiKN5XKKrlnwrUS+7KvaQRl+fXUJ1zgMpX4FhcSgMoFG7yGS
 44f9ZDvuasNohAE4XjZqDcONuC5fi9LwcYPaMybSijIPA1EjDBd1oCCi54h1tZf4xQJc
 o7Mw==
X-Gm-Message-State: AOAM531yYqT4PNFETZ5pFidmNCgXep4PH54n0cn2oBL2qAgaVYSaoJjQ
 XLhCv8Pk7+Bl1EAswq9GZkH+ug==
X-Google-Smtp-Source: ABdhPJzwRHAk10l5mpe/BPFqsT+oeE4FNLzt3dbq7ro9UEeP6P4EE8oTW732nU3xsbtTGiPjIAp5Iw==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr14743509wmi.120.1602261136085; 
 Fri, 09 Oct 2020 09:32:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g2sm12119518wmg.38.2020.10.09.09.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:32:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1386E1FFAC;
 Fri,  9 Oct 2020 17:31:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 22/22] tests/acceptance: disable machine_rx_gdbsim on GitLab
Date: Fri,  9 Oct 2020 17:31:47 +0100
Message-Id: <20201009163147.28512-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While I can get the ssh test to fail on my test setup this seems a lot
more stable except when on GitLab. Hopefully we can re-enable both
once the serial timing patches have been added.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201007160038.26953-23-alex.bennee@linaro.org>

diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
index 0c72506028..32b737b6d8 100644
--- a/tests/acceptance/machine_rx_gdbsim.py
+++ b/tests/acceptance/machine_rx_gdbsim.py
@@ -22,6 +22,7 @@ class RxGdbSimMachine(Test):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
-- 
2.20.1


