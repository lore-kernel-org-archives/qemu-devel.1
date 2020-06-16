Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60863C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4D7206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnPQ4J2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4D7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlB8O-0000Ge-Cw
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5q-0003hb-FA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5n-00005K-Gc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id l10so20620758wrr.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tgJUqLwLoRtLSvW9q3TioA1yOeOJ7FhmCuMS43Wyg4s=;
 b=EnPQ4J2+lnyyvNj1f+14SsQ0f/ityTfa4vJzMCYOgTjEhVZ7/8RGJ5+Px/sDYjfAU9
 srZv2mmQgci15AP1YNuy6YZ6gRgk6N0eOunMS5NmzBWXK5HC3EgNJNCbatQHxybXWubt
 5nalAoNfFQj2FJcnLs3CX2PHXEb3uVxdmhS9GDrlfTbKnNyFVXyzn+RFz5lRxNfGwnzr
 Y67Z8KUxR4IQ3Q9GbGQDZaV3a5Mjyw/dYi96viEaGWQIN/TAvYRqHwyzH2CP6/T82nH4
 X9n6zNrqRaZzGV1B2cOnBuTtiqEUmr11sPIviPgFRbjoYPO6RYnM6breXp8RZxlqpvNF
 3ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tgJUqLwLoRtLSvW9q3TioA1yOeOJ7FhmCuMS43Wyg4s=;
 b=JBPB/ESaNEAOl5iYhfbbM+m90juqJchfqLt9Wd6aHijK6HQ6ezzC84O9vH1ZOHZm5/
 Yk48FNa1kZ04mH3pY1nn4ysnlPPPJ8MtYpookTH77An5rxvyhiujcKWxHtlM3PdaHl8/
 E+YtiHHu/EHBHOI4T54m4zkOiSUE2tnZ0dkaORdeBmrDY8nAgOt1hTxUCmu9v2Q82X5I
 o24KKH4RRDykpvBl9GrZj1P6w/FEc1YBJdAgOpm2saakm6gmUMQbwNZa5yz6YYdWkd2U
 ADwJQgLO0OsNsh6S3bIfMe2wnC+xWLVYgn9ILq/aC+vk6j8ke1CSiA+FdE6GSaTwx9NG
 cgGQ==
X-Gm-Message-State: AOAM531H2hhJ8wC0IMDzis6fttRfnbOrYisYzM9znd+e0DEz5c9uV8w5
 Z8mlkmoEIffDqDepg79Q6Gw2cA==
X-Google-Smtp-Source: ABdhPJxmeWVE7BGojdXLZoCAt7zQ9cVMvqVlvNfboVwLNRrSEawlZwr5dBRDaFwROUFZSe/XBJC5Ag==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr3096823wru.357.1592312007082; 
 Tue, 16 Jun 2020 05:53:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z206sm3833256wmg.30.2020.06.16.05.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C8C11FF87;
 Tue, 16 Jun 2020 13:53:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/21] tests/docker: bump fedora to 32
Date: Tue, 16 Jun 2020 13:53:04 +0100
Message-Id: <20200616125324.19045-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should be keeping this up to date as Fedora goes out of support
quite quickly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200612190237.30436-2-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 92b6e11c8a8..798ddd2c3e0 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:30
+FROM fedora:32
 
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
-- 
2.20.1


