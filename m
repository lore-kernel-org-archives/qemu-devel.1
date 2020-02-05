Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C979C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96972072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUyrQKX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96972072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSJr-0006gF-J1
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSIu-00054x-NT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSIt-0005zw-N7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:48 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:38988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSIt-0005xL-H8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:47 -0500
Received: by mail-pj1-x102a.google.com with SMTP id e9so1552459pjr.4
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ylAb0fonLdpVNdNrr/Msmq6GA3Xtf0QpCchhiYOBib0=;
 b=zUyrQKX0TNovhHu15n5osFOM21VK9Jf+BHEL7dv1idJolSTqjsqpcFb4tGAnBBus5/
 EVqCcKLef9KUqhfuBbG3qFKh+hM8T5GXtK5uHwpSChnBIIuVfhAsSdTIVCfmA8nz6ODe
 RsQtcPVQ7npmb7a0MDg+6iFykOkYAuQYOa5zVHj2LBahMrFE5eTo3UWUY8XEeuzWjSwc
 4Qd4ciCY/NNEfuyxUYaXzNYGwSyS0yEHR/0DKmZToA6CgvsqTIwm9EV4ixJtyVNcN8Oz
 U64DjJYD92m5E9EuN6zjtlJMCbxJqC7zdeperh+NV2ch5/cV8Adt6OQsrI9f1pseEPBU
 Kn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ylAb0fonLdpVNdNrr/Msmq6GA3Xtf0QpCchhiYOBib0=;
 b=Y9NI47OcQNxiNRJpUcu1Zq4Ex3nUSIofHggA9zVkQhH6tj65GVuph7QHFB20tGIU/S
 e3+ovK9AygbKj1IfRj2h2+3t90HTe8awdgT6BojmtAZ1OaMocPpgWBeyyy0WiYvw+yeF
 Cgf+s5O7ataAAKeeLmw5elwI9Fnbb5U6OUJ8EHcex6mu4cA8QSCgQLP8vMH/GEPCX4cp
 GUQNCoXsFz/P7B/GZ0YktWi1U8izSt4ZXZg6jS6n1lyUXhTzrZ4h+gKnj9jQRwQh73kA
 qzMbXvG++O+XNgwZaX8eF6U8tvJtymAH7un5vPnb8wmprvqf2d8OUpKQUL+OIZ8+htql
 eiiQ==
X-Gm-Message-State: APjAAAUA/HYYe9+hHxhASNjEMujG5iuvWvcRsULTbiN62GUQLP+HKpVC
 c78o3FfRgmLvQG5MhFdA0n/uu1OoOQU=
X-Google-Smtp-Source: APXvYqyPxGlz9bDHhTzkcqStWLMp7XeObhNrLwwm0v//lgEaI0/xhLsYXuYWitSlmeb7Ll8fQs7YvQ==
X-Received: by 2002:a17:902:9f88:: with SMTP id g8mr27573plq.100.1580938426260; 
 Wed, 05 Feb 2020 13:33:46 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:33:45 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/14] tests/vm: use $(PYTHON) consistently
Date: Wed,  5 Feb 2020 16:29:07 -0500
Message-Id: <20200205212920.467-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102a
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
consistent with other cases like vm-build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 9e7c46a473..778e506755 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 
 vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		--image "$<" \
 		--interactive \
-- 
2.17.1


