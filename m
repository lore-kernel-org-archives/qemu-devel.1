Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1293B206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6SV0l2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1293B206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEke-0003rn-3R
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbM-0003td-Fl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbL-0004Lv-IL
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id l11so10279163wru.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GtPq8cQhyMMwLxaXu6V+chzcq9rrr5zHEfE0zhJ53RM=;
 b=s6SV0l2KdZ/w9FHB7X1rf0kNJ/VJS2q8uEUC723M1EVqHGNXNxR1xZ7ISBqJ2SzlA1
 aVAFutRHrK7fx6rabLPofhaHlH1JzisiTvxLiFwaw4r9UDfEMOCEEiJxL9N37EK6mkAw
 0kaf3xsJZywhZlVdKoNJXP5wDWhIF0B2ZztjISsqEg9V/Ojnr1tq4u8nOdBCli7HDP5a
 iaYEEi7Nr9H2ZbFle6KLl09KrsSZ6y14bLK4C7+3KyqcQdMfqiu3EZiH6jUCBtwmZ95N
 LWVk9ymKCw2z2vIPgLPiGA847HoX4VbdtOoIOCYMBRXHOyDEnYAhVhAs3iRW40SuHCxL
 3hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GtPq8cQhyMMwLxaXu6V+chzcq9rrr5zHEfE0zhJ53RM=;
 b=EnCcptItLP5g4V5CfLd4/dEnGckSZo9oyZNgipcm+pJe37XrAGtZ8J7+3CcV1sBD5C
 0HUgqFaIUgRgQJm1OIRkNaqXgQEuM2wu7aWqUgQHGeZYn+TxKJkpgjoltsCOTsnjuqSW
 VXXYtEZKCgnCOPtdeigauS/3dMj/T1zFd9TQLN687RUIiimUe9vpUGrSGn6wwiMCJkwV
 O+Z9BG/HcgdZ6ppSWWts34+ipsA3DJlNv1mJ9rKsWSIgGMYf1vdQkBShiMx0zwTCMDBC
 1cVl1eW2BsYiK8PSMrlvHDfK1SLRR9EPcb3nJQBEKD8565uMHmUm3cvST2cr0FQeIHFc
 6jnA==
X-Gm-Message-State: AOAM5319Zk1Gmcvi0YSr/b+IZoCTrOZcNOKS+mKyX5iDWXJN4bFxK5sC
 xbUUG5fgN8GJZ7r9StUYALNNaQ==
X-Google-Smtp-Source: ABdhPJzJMSnvM51NTQr8CSjTib4DM3bSWFfh3cm0pLnZqXwrwSHiOF/02iNOQjGR2b1B4WgFoXTUaQ==
X-Received: by 2002:adf:e590:: with SMTP id l16mr9823406wrm.383.1591372186163; 
 Fri, 05 Jun 2020 08:49:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t189sm11816646wma.4.2020.06.05.08.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0BF11FF98;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/14] docker: update Ubuntu to 20.04
Date: Fri,  5 Jun 2020 16:49:24 +0100
Message-Id: <20200605154929.26910-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200604231716.11354-1-pbonzini@redhat.com>
---
 tests/docker/dockerfiles/ubuntu.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index eeb3b22bf20..43872417dec 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -9,7 +9,7 @@
 # system won't pick up that it has changed.
 #
 
-FROM ubuntu:19.04
+FROM ubuntu:20.04
 ENV PACKAGES flex bison \
     ccache \
     clang \
-- 
2.20.1


