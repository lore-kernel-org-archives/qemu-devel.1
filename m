Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD9C352A9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9339F21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RU3a81IQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9339F21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYnW-0002up-Ku
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcc-00080k-BQ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYca-0006a7-Pl
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYca-0006WW-6x
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id r19so3898051wmh.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IkSkbE2A8XNFwDDaVkK81Wt34q5E4KR6a0fcYuaVex0=;
 b=RU3a81IQYYoyIHolhR+CyykgRz/LW3oFX2LqINlnq2NSapCcmhjkc65Xva1t29sh/j
 708bXv5jRkb438J1OnD5aBGHkjVhKPTIDfoQTISPlQF6g/XlhoClUtarU1ulLzhXlQTZ
 DxgGiakFLHgqYChXFX1gP5GoA01A/W95SnZeJsdb2kKt1yxB6rt369eiSxtm/IHYXgUM
 uZbf6QHA5efyBwulr7Do6EjibgaSz7tRwzsy2KCy0L2l7KMDG9SPm8lISOpB024XNsro
 uzpkm3BKJ2MJlsql3EvGyEU3PVv5aKjNNeD2RO49It9TAJUtsCiFmUFkB9RsQRF0iDsT
 7OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkSkbE2A8XNFwDDaVkK81Wt34q5E4KR6a0fcYuaVex0=;
 b=qUS6JX41vHgmoQ+XLjA1pPOYnm2TW8nPMfbobkPWFmpK1JgzaMdYVPZMieQ5gwwF4A
 EPNS57wS8Db5e9ma+vBd60IbpmDhTBCdfXqevUo9XPU5OvHW2TZKGZmKy7BAj1NwPyKY
 hZnSseyT61uDcEFPueumlJes2nPP0Kxaa7mx447lKkyOkEqqFc5BuwnrA2qxE0rAbBbe
 kMTNzffvnhEpcrvyBciwCMQxmm8wEoXj5GsGdo8j3Aa7NmuvR3mI2MJXn0Pd7P9jga9G
 beLEPkdO1XHb77Yw1NmUd6Z7yL+TKGq1AWLNvxFDiarScjQqbLvZ+ZXZT22nls7c3Acp
 qmAQ==
X-Gm-Message-State: APjAAAWjN34dm9ApHiSh5GslAzFPRJAYxkqwY6hO0AL8tcfx6wPJ7Kaj
 EMcWAWE+fgTT+D1KbBaDeV7voA==
X-Google-Smtp-Source: APXvYqxcoyh1zq1bBYZv8/hsOk6eFAiKkr6ub8fSgnEFuy9cgKdWR9qKrdvtBAyMCLtadTTjBA8nBw==
X-Received: by 2002:a1c:c104:: with SMTP id r4mr4452937wmf.64.1569522965436;
 Thu, 26 Sep 2019 11:36:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 207sm5781787wme.17.2019.09.26.11.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:36:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 535381FF9D;
 Thu, 26 Sep 2019 19:35:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/28] podman: fix command invocation
Date: Thu, 26 Sep 2019 19:35:38 +0100
Message-Id: <20190926183553.13895-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Oops; there's no argv here.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190913193821.17756-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 3112892fdf..31d8adf836 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -332,7 +332,7 @@ class Docker(object):
             cmd = [ "-u", str(uid) ] + cmd
             # podman requires a bit more fiddling
             if self._command[0] == "podman":
-                argv.insert(0, '--userns=keep-id')
+                cmd.insert(0, '--userns=keep-id')
 
         ret = self._do_check(["run", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
-- 
2.20.1


