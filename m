Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A68C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD6820880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lO9SRqxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD6820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnO1r-0006va-Oi
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnO1b-0006Wj-OU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnO1a-00064X-Jj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:01:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnO1a-00063q-A9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:01:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so18790542wmj.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mz7/qAWIZBgCxy/KQHnwd3kx6dvkYS2R0nAOMZwpcnc=;
 b=lO9SRqxtMYzubpB8KHB3tzm+dQIkcf3/WC7Aia5YfoZjHyWCBWQKdSIEHpFZ9u6/b7
 lleANc7jnXUSXe3e17lSHFEH7xkLSO8a0rdgAHQkdBCqCzebIeA3gMIuk5ZuGrAorkZt
 9PJ3iWIULeg3iJZ/VZbzhhOXFYR9HMGB9QWIxzOSY4QEXkSDGlf7HHLAujMTib3xr2V0
 CNwNRmntUJoieNUdMUBcNJnsYV1xWXUwSrzzXJLsv/Z6shza1kCCEzjmLyDd9UqpLS+9
 Z/IqUd+qHSEkR0cnpsrNb9IYN9EdtX/WSUzr7VeX+rNmYJxmlUOTKuZ/LyVO9N0hBy0H
 +v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mz7/qAWIZBgCxy/KQHnwd3kx6dvkYS2R0nAOMZwpcnc=;
 b=TDdBAASEMqeWP7dAwM/V6sQVANDuV8h4sFRG3fsDoTfLerIWLhuF+f6eEv4majfz0b
 YT8DitcN25GL8NdsftoU4wtNbmdjJsT2Q1eu5Xf/C7Ui/1TEvBiWEP9lupjGeyU1MxO4
 GWO3JnJggISZB3wzop6u5Jys1iKcysiFrpsn14NEm9dvr1F3wvLsg8UkNrBV1RBU2Hr/
 oOQdzDJH/HIedCRL+SXx6QjsdYPh+cRAoR0UgkSI51PY9hTqqqQEDuwA0LMeI4OYLdyy
 1Eu8qSpjZfUf0+X1ueIADYWmVZCqOC1jAdt9fuyPIM30RjmuibNzIK61I9IZnzP/KvFU
 t+Iw==
X-Gm-Message-State: APjAAAXmuBRmEVnLLsj331/rlBUEUROGhEuA9jarj9RSrztSvke4y08T
 IqQO41Y90KIKyJEpRr2bCsSa9Q==
X-Google-Smtp-Source: APXvYqzKzCFo/FvuC1NLn+RQOY3+pKxdmEWKNhaivBU3mFAlWiBfXc7RsPC8Fki6/1H7FPNkvF926g==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr30300379wmd.75.1563285704980; 
 Tue, 16 Jul 2019 07:01:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 15sm14734964wmk.34.2019.07.16.07.01.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 07:01:44 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B9DD31FF87;
 Tue, 16 Jul 2019 15:01:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 15:01:33 +0100
Message-Id: <20190716140133.8578-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [RFC PATCH for 4.1] linux-user: unparent CPU object
 before unref
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
Cc: 1836558@bugs.launchpad.net, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a CPU object is created it is parented during it's realize stage.
If we don't unparent before the "final" unref we will never finzalize
the object leading to a memory leak. For most setups you probably
won't notice but with anything that creates and destroys a lot of
threads this will add up. This goes especially for architectures which
allocate a lot of memory in their CPU structures.

Fixes: https://bugs.launchpad.net/qemu/+bug/1836558
Cc: 1836558@bugs.launchpad.net
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39a37496fed..4c9313fd9d0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7183,6 +7183,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                           NULL, NULL, 0);
             }
             thread_cpu = NULL;
+            object_unparent(OBJECT(cpu));
             object_unref(OBJECT(cpu));
             g_free(ts);
             rcu_unregister_thread();
-- 
2.20.1


