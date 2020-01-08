Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEC7C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BF720705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQlBXj+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BF720705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2wU-0002kR-99
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2sm-0007fn-Uo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2sl-0003Un-QM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:48 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:46681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2sl-0003UJ-Kq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:47 -0500
Received: by mail-pl1-x62a.google.com with SMTP id y8so564762pll.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 20:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N8PydtXAISvbmvQbD5ixkVscLPB/zD5qTgZwQJqAzPI=;
 b=cQlBXj+UVwXAWWRjIc1objf8vvB5Pwq/mNAm6Ovi/JCDDNuHZk79bx6D75IAaqRsE0
 POSruroCT3cpGSIKFKXIvNGUy1pec26kyiEgTy6c2ev9juOUOgr0VRKiLf7CgPrh5I0J
 J0lEyAFromtlzIKXxS44aYA45kLJWzueMOckz+Eh7dWHlUud+jjNOp2PgUydYLua42xr
 rjOi7rShwJwVCmF28cD8Lq22DirikFN7Do54C2RNEk0Pc1xEU2RFAAmZyW0Tg+mWc9Pa
 eyof/yi4VuHqTMlecCTwMMMT8zex+TUZMwYUUC6xmslfDBtSqTaKNdTuEGMNFOAROz/j
 /isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N8PydtXAISvbmvQbD5ixkVscLPB/zD5qTgZwQJqAzPI=;
 b=Bi0kU4/W0BUIXk2E3bIr8iFd1g9Xm1Q34BAveBab9y+L85P6S/owOlSMcZ1m6dA0In
 iE9U7E7ktCadeeQFsECKnFuOvUKLeXrR1r/xiyOAsKOM5zFKBt2NCCt5OuHdVzrkD+NO
 i8/CT/tf7B48cy6ovfUBSXS6JUVjdu57d+UlIXcan6QyoxUAoW0Jd66Kn9+0/uh0BWKM
 mRFXcxK0i9SlKyZzMB5OiSDBH11zYYsxs6x2/lHU3eBXujHJ4/h4vfte+4DzcUD+J2+P
 CfUjI8pIj7VDn8AaxZzfnTb3JQ6wRwz6xKmfM8z8uvmKL4fQhh0UK4oJdKhWQ6xLPw4/
 QLsA==
X-Gm-Message-State: APjAAAUbNglj21bO+hXhapITj6s8ZW94mloNUZ2Sk3yz56Qj5bBswX6c
 XWupeaBrQDXN58cLdTetbTIZnd3tMt6q9g==
X-Google-Smtp-Source: APXvYqyzHhALxGpiqOANT+TKatwFWWaCjwq+ZbYuTVmL/MbjfIHRQ+qNJb3PtUY0SYMGDi7V+jsLPw==
X-Received: by 2002:a17:902:758f:: with SMTP id
 j15mr3296406pll.201.1578457426330; 
 Tue, 07 Jan 2020 20:23:46 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f9sm1192702pfd.141.2020.01.07.20.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 20:23:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] capstone: Update to next
Date: Wed,  8 Jan 2020 15:23:36 +1100
Message-Id: <20200108042338.9082-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108042338.9082-1-richard.henderson@linaro.org>
References: <20200108042338.9082-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to aaffb38c44fa.  Choose this over the "current" 4.0.1 tag
because next now includes the s390x z13 vector opcodes, and also
the insn tables are now read-only.

Fixes: https://bugs.launchpad.net/qemu/+bug/1826175
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile  | 1 +
 capstone  | 2 +-
 configure | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6b5ad1121b..12e129ac9d 100644
--- a/Makefile
+++ b/Makefile
@@ -499,6 +499,7 @@ dtc/%: .git-submodule-status
 # Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
 # no need to annoy QEMU developers with such things.
 CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
+CAP_CFLAGS += -I$(SRC_PATH)/capstone/include
 CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
diff --git a/capstone b/capstone
index 22ead3e0bf..aaffb38c44 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit aaffb38c44fa58f510ba9b6264f7079bfbba4c8e
diff --git a/configure b/configure
index 0ce2c0354a..b3c99728d2 100755
--- a/configure
+++ b/configure
@@ -5068,7 +5068,7 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include/capstone"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
-- 
2.20.1


