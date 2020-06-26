Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DEA207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6pr6qax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DEA207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josun-0003oo-9n
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrX-0007KA-1u
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrT-0001FM-Nh
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id f7so7363171wrw.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tZC0B8qZBNh5ZHLpWECSXwcvz7Y/QMYlsT+820N3gaU=;
 b=g6pr6qaxIvJtD+EoG2TELUkHs5gPfwzSh1O9xG40dgzMh0mmkOYmu0cKnsYUVgDIDR
 B2HsgOnWrpKfagdqiLWp0BSQTOU0pNPiRrVDpSg8aYfwy8Ocm1/qY4N1p+RwKaEAN1di
 jZb+YGb/F/6Tzt9+pxUa4hmjiqulYEOKMl054g4hAhhsYVVQw1REw/dUxyCYPkaTLxqD
 kSESORhFcLWpOS3SADyl6w5jNEmNPlHxaHUSyI0AGS1UfGqiLe7MamJMM5wEjn6HlM0L
 UyzURUy7Q2pgScQrDwfermg5dpoK9XNLOgBrzU6VrwAihAlYCAR7mUyrkRRo1FiWROvI
 lckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tZC0B8qZBNh5ZHLpWECSXwcvz7Y/QMYlsT+820N3gaU=;
 b=LShoIcwJ3iF+xKVeJKpkGOPTdvpNkiJWSCaNaE3Ns23r6Uu3nuQgpb9Xt30aar+56u
 WflhgFGGwVu4W8eOdO3hNp+ZO4jLQGGYrtp9Z49pcktnQ2lwvefFVaigfJ+SMDBz4I3J
 idaMIIicWDcvjSGyZLvjA2ZozYc8lcCnQ71l0NEcsCM3X8g4FBxiSPpnbkZQPOBaylge
 HFbSDBl5J4jnXAHCLL5yNRu2kS/3cvl9QP6T1bIb35ULW/ezVgdDfxFhwQfw7T1WR5r4
 kc2iupmL4OLr/OYKa3bCtcvTmErkYsGFGYP/9oLPxvC8nf530sB0FekV/VlvOZPUPeW+
 ukug==
X-Gm-Message-State: AOAM532dR4A82Srame68nvkoJZ27HpswEXB9HM6lT28I92f9dSInZbSx
 5F3P8anVP3QnAqxwFdnu317cVg==
X-Google-Smtp-Source: ABdhPJwKG0nxoK+odtcaosBcM5TK07wFU0p6AT2Wm77BAvnRY+GSt2t3ZvldS8N32XQm5chxDXBsOQ==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr4885014wrs.353.1593195242276; 
 Fri, 26 Jun 2020 11:14:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e5sm37859634wrs.33.2020.06.26.11.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:13:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 12B9F1FF8C;
 Fri, 26 Jun 2020 19:13:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/30] crypto/linux_keyring: fix 'secret_keyring' configure
 test
Date: Fri, 26 Jun 2020 19:13:29 +0100
Message-Id: <20200626181357.26211-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 David Edmondson <david.edmondson@oracle.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Edmondson <david.edmondson@oracle.com>

The configure test for 'secret_keyring' incorrectly checked the
'have_keyring' variable.

Fixes: 54e7aac0562452e4fcab65ca5001d030eef2de15
Signed-off-by: David Edmondson <david.edmondson@oracle.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200618092636.71832-1-david.edmondson@oracle.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index ae8737d5a2c..25b65981142 100755
--- a/configure
+++ b/configure
@@ -6437,7 +6437,7 @@ EOF
 fi
 if test "$secret_keyring" != "no"
 then
-    if test "$have_keyring" == "yes"
+    if test "$have_keyring" = "yes"
     then
 	secret_keyring=yes
     else
-- 
2.20.1


