Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA748C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA9F2133D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmDTJKEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9F2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBte-0002md-Rj
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45096)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB55-0008Ns-J7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB54-0005ye-LE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB54-0005xM-Ec
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r18so1383933wrm.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+ZfldLb9B7VeRUSVpRgzD28NkUAhkqFAzhazcc+u144=;
 b=cmDTJKEtkMzcr6psA3LNpNyRnkhVyJKJ0w9cn2DW2WpQ8eGs94sCcn54vZ+YUuzKbN
 kPvRiV1ZVUB1ajzcWuYMr0ui24lzQPm6aa42LOEYZr+RBtLeE3mHRM07Ivi6cgJDCoda
 3Ev4rKWnwolD2drdnnTvQUIkcxMWp3wrFWFyJfxnmmp9laDFGr8Qc9ynIQWaTNR+f4UO
 AD+QuGWUmyirmwG52cSmLFfI9yrdJzmB50dIEHXM89C3uK0l6Gv7ZUkZzipzvS3lFdZR
 ikwo99G/qvY4Q6HTdP+C1o6buLZqqBidXMky+kqpZQZpT9J5r5RqSHWDh+akIvKNQsZY
 uplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+ZfldLb9B7VeRUSVpRgzD28NkUAhkqFAzhazcc+u144=;
 b=mLZvspwwkZ3Evn5kpToRbRkHJS+ruBzsWH0DVTYIvlcLXzxoCmJYx4qYJG31XvL/Df
 cfmSSn0b3wRy045BJnSZkvdbVzvUZJtgzKXsGNgFKn0408zV43YgVVIs+ykTIIuQEvgX
 UQMkq7YY216MCwqO1qgdAUOV32xltbX+RuagHeHwNpm3pjKsZqYIANKGERyXhdUdLw+P
 hOfjcopZpqJGRXobxVGXfgW2iMlzJ+jufkQVS1agijKgu/ozn+j9NojgERgNO4GHzIpe
 9QZO94wIfAwV3rXSiPOUxpFFuP+6jyIb9U81eP7rtvScs44VucHZx/tgmubxWGNev/cq
 b8KQ==
X-Gm-Message-State: APjAAAXU2EC4egS53IiyYjdSjB+bmsBJCUbvAJKOe3pU/H7L8CRysv0X
 PhEme/k1tixUewHdznzwwNyP2w==
X-Google-Smtp-Source: APXvYqziNaH+upgth6XvX62bEsM1xfaHdBppgpaQ8sLDBBsXnbybR6lvgm/q1zrc7+VSGiKI6sZcow==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr16183565wru.264.1559899357141; 
 Fri, 07 Jun 2019 02:22:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b136sm1669984wme.30.2019.06.07.02.22.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 834181FF8C;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:18 +0100
Message-Id: <20190607090552.12434-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 19/52] tests/vm: add DEBUG=1 to help text
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190520124716.30472-9-kraxel@redhat.com>
[AJB: fix minor conflict]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index e329129bd6..628eecade7 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -25,6 +25,8 @@ vm-test:
 	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
 	@echo
 	@echo "Special variables:"
+	@echo "    DEBUG=1                       - be verbose, also start interactive"
+	@echo "	                                   shell on build failures"
 	@echo "    BUILD_TARGET=foo		 - Override the build target"
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
-- 
2.20.1


