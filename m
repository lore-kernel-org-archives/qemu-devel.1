Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A806C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098C5206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXs6vLnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098C5206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfXE-0007Db-5C
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUp-00029R-K9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUo-00037T-Fl
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOfUo-00037D-9m
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id x4so16843604wmj.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R1iGbNrPxs7Q1flfCK5WZAyghUVesN3d6e9WvcQ4hxE=;
 b=bXs6vLnL1mmwCoZunbo4QOPJgBB3Nr1b5K1QpKfcOt80TgynDurUml9i13rYBUdXjj
 RASNv6rnVvK8gfMGDvxwRjvqRcsbrJbiiCYKWxnW6AaE++dtX/thhAN/lKblFkhQirUd
 4VAr331f1TmVHcOhFeu87JdpbTeJxGLVcjWgjQUI+Olr4LLbeylbwm+lZefPk8hNfs8o
 58uZFDax1ppAvQXI7htmHuGH1BOg+4RIyv2BB9uDvk9L8hSQJSYW6CnPia+ZhEU4fzBi
 vK4Aby+fer7RBNuTaSLQYKXLppuMBVH+eN0v0dWDP7XK/pMCnCKtER1ZBWfryudDleh6
 NPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R1iGbNrPxs7Q1flfCK5WZAyghUVesN3d6e9WvcQ4hxE=;
 b=IBZSOS3dDCNhIzvu0VfEVpjoEEkjiho7HOVWoHjMqbtIecVR0WkPfyrlkcQ9i4Xhnw
 6KG+AJ+Pf1kVnQlhTjSdTt81e8ejXM45YbON9SGO+7utnsKdz6x92WBIrS10ZmYZwjAY
 llBWR+cFcgFm+NlbiThzLEjNiz1FvTyv4lgOgabqYKoJucJbwNO3QIEnvE6OpsAbkrrH
 EOpRGfgd7IdccHGh5HuenFPkmVS2e3lfSGte5iXPKe9pIiMvJlc8G6CmnNhAeIn307+U
 dABlWGpgDXD7FWcY8oe8ALdd7RVtS4092yYtYyLC7rslJVbQCRLco5D3CihqAdJCe9kZ
 Bhfg==
X-Gm-Message-State: AGi0PuaGExaLSE3344w90ePm/xOIqQZKrpWObWou03YNJVmPuwDYkdAV
 YD8RGhXwE+urY5iXLEJHfFUdJw==
X-Google-Smtp-Source: APiQypKb/M6xge/q/yD5nbz1LzCSXm33CHkFr7YucYOpdg6FuCG/mOppP/+hsqsrFCoK6Xwrc+vmhA==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr4759100wmb.92.1586947337330;
 Wed, 15 Apr 2020 03:42:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm22831332wrt.16.2020.04.15.03.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 03:42:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 416D21FF8F;
 Wed, 15 Apr 2020 11:42:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/8] configure: disable PIE for Windows builds
Date: Wed, 15 Apr 2020 11:42:06 +0100
Message-Id: <20200415104211.9388-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415104211.9388-1-alex.bennee@linaro.org>
References: <20200415104211.9388-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Bug 1871798 <1871798@bugs.launchpad.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 James Le Cuirot <chewi@aura-online.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems on some compilers the test can pass but still give you
broken binaries.

Fixes: d2cd29e30736
Fixes: https://bugs.launchpad.net/qemu/+bug/1871798
Cc: Bug 1871798 <1871798@bugs.launchpad.net>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Tested-by: James Le Cuirot <chewi@aura-online.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200414200631.12799-9-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 25f7d915720..23b5e93752b 100755
--- a/configure
+++ b/configure
@@ -807,6 +807,7 @@ MINGW32*)
     audio_drv_list=""
   fi
   supported_os="yes"
+  pie="no"
 ;;
 GNU/kFreeBSD)
   bsd="yes"
-- 
2.20.1


