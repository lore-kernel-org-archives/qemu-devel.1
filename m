Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC87C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A6320825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3miVVeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A6320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRdP-00040W-QR
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 17:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRYP-0005eJ-Ds
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRYM-0006yc-4a
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604530013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11lY/RGidWh4E+Dz/TixgXDK1Sn2olK+Ru2uFDMNMxs=;
 b=L3miVVeAwJXDhXrw/lefgah3WH2Dsi7C7M+2omlEw3CnNpVAc0vFJpijNEqXXR/3fc9h/Y
 A/mg+Um6I5yU3HzrzsM8h6Sm6UEcPxlUBDoJhw9RvDKDFx6HLu2VrDUT7vuKCSJDrhQ8d9
 6v2GXWCa045ct9d7e9E5FbH4voq5s0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-BMJVguebNAGq03JvXsZc7Q-1; Wed, 04 Nov 2020 17:46:39 -0500
X-MC-Unique: BMJVguebNAGq03JvXsZc7Q-1
Received: by mail-wm1-f72.google.com with SMTP id a130so1692954wmf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 14:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=11lY/RGidWh4E+Dz/TixgXDK1Sn2olK+Ru2uFDMNMxs=;
 b=hICd3r1sjKkGN22kWfzFIcGdgTHaMbQlbsY8JUaApMVPm0x4z71T+JKMbhnda0MRjy
 6pvxQRiW3a9NlD9h1HjYJbESXHAA9qQ4WJJWyttK53hjDrmXA7ecneiLaKchwmTdVg01
 44ekIjkKM6UB41lPHVO7Pzbg9O7v0RkNJrXEpLNPohG+eAi+d/c8EcJoR8p6/C0NDhIy
 i1Yl1nLpBkzBjK7/jtO7IDY7bgq3tlMdVBRsZaXcXMSNHXLGBBog5jFAtF0WSAsnGGXZ
 c3pjbMw7rm6xX8jaMPu2Ima5YSMf9HK1wTSaA5MeYav/Agt8nICe8l3DEjLt75BZpOmZ
 AAGg==
X-Gm-Message-State: AOAM532xm0hY66y99UIewRKZGk5yrw4CxIMue3hzkid9MYA9Tnp/ecAP
 mOI8Wehx3uW7zOQkg4IqVFpU8PrUDzaPBuiLdKBD17R5FeOi1q/vd+/oAYfZcIH5yjTyEAmFHSt
 OguRa2JaJ0ZxGYXk=
X-Received: by 2002:a7b:c2ef:: with SMTP id e15mr7338024wmk.180.1604529998250; 
 Wed, 04 Nov 2020 14:46:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyODpSqnyI9EbB/njgYOa87vdZh8HgEhdBt8QSAE952wM4G23Scni4+0ZdTCbOIdN0T6yHFQQ==
X-Received: by 2002:a7b:c2ef:: with SMTP id e15mr7338008wmk.180.1604529998046; 
 Wed, 04 Nov 2020 14:46:38 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t23sm4096810wmn.13.2020.11.04.14.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 14:46:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 7/9] gitlab-ci: Extract common job definition as
 'native_common_job'
Date: Wed,  4 Nov 2020 23:45:56 +0100
Message-Id: <20201104224558.3384595-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104224558.3384595-1-philmd@redhat.com>
References: <20201104224558.3384595-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the common definitions shared by '.native_build_job'
and '.native_test_job' to '.native_common_job'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0b77a90dd73..961070d2cbe 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -19,9 +19,12 @@ include:
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
 
-.native_build_job:
-  stage: build
+.native_common_job:
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+
+.native_build_job:
+  extends: .native_common_job
+  stage: build
   before_script:
     - JOBS=$(expr $(nproc) + 1)
     - sed -i s,git.qemu.org/git,gitlab.com/qemu-project, .gitmodules
@@ -41,8 +44,8 @@ include:
       fi
 
 .native_test_job:
+  extends: .native_common_job
   stage: test
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   script:
     - cd build
     - find . -type f -exec touch {} +
-- 
2.26.2


