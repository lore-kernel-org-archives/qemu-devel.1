Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44313C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BBA206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRT2gwa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BBA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaj3k-0001Hd-Hu
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairy-0004Pl-1Y
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairv-0000Ks-3k
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOlQmfFaNvcfnBXreBEQVhcMzqQm6Lj5i87BO0gaUIY=;
 b=PRT2gwa+99qHrq2odIiOQ18dM7jbcEM7cNwXW9R7vfTgBBOVJe+h8yl2SRU5gyt5NhGLfD
 OBIc4NX/SDgx2JhW2ubrWrPZj8/c/AIxwVXNyhstqZ0HrglIivX5wJqgT0DLkmCtuOJSLq
 jSmyG7svOrTcQUoy9rGAARo+JnWV9BA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-G_DELpPeO4K7qN_tgwn4Fw-1; Thu, 05 Nov 2020 12:16:12 -0500
X-MC-Unique: G_DELpPeO4K7qN_tgwn4Fw-1
Received: by mail-wr1-f69.google.com with SMTP id m20so970158wrb.21
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tOlQmfFaNvcfnBXreBEQVhcMzqQm6Lj5i87BO0gaUIY=;
 b=KMeM5DO3IZ/T1CJ/hkIKxSJbHuTMGeXRBLKmzlRvdgELV+G2TDOSf/DoQkObApzcRK
 n+/Vb0k9UgsmIfsUEC6p+YoTsDs6fo9h+38B3Nw46xl/j9L//hNPHvbJJASAYDURa/f1
 AEw+mNvjYF0PyabEIxY5H9Y3g8Dfjz6ncahakPuBs2AtP66OOKpq0kz/9ft9roo7VhYY
 MPl8PifByPtLXzEhXAnqbUCiR6uQwisK+7gG+CUZI4MQSkKIn6h5bomcBxKgcBIfnsWF
 ZhueA3PVyMaNObHE27tM2+xD7WZLuaS21DyHxzF55dNdF38V9aYPlMTCZ+pBehleN9dF
 kraA==
X-Gm-Message-State: AOAM530eT9uLJCdKfmxLO8B4CBS9OoFxXDnd9ucxnu9mcK4MURHxKyuv
 LHUn3C/w1LPH+syDGj0xH5YZnNVoX/oGRMKdZUZGBROwVrbBT5/7YwnyyQYDYX5qgpi7/nZ4rGV
 jSIFKZTUp+pt3Uyc=
X-Received: by 2002:a1c:b0ca:: with SMTP id z193mr3789371wme.82.1604596570221; 
 Thu, 05 Nov 2020 09:16:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvfqvqlzKK5CFedjgTrZgyZyvsjS9hCmWkPCgSQBeqT4AGNpwc12lTUlxpOvo1Pafoedf8qg==
X-Received: by 2002:a1c:b0ca:: with SMTP id z193mr3789345wme.82.1604596570057; 
 Thu, 05 Nov 2020 09:16:10 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y20sm3248715wma.15.2020.11.05.09.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:16:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 08/11] gitlab-ci: Extract common job definition as
 'native_common_job'
Date: Thu,  5 Nov 2020 18:15:23 +0100
Message-Id: <20201105171526.3763499-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105171526.3763499-1-philmd@redhat.com>
References: <20201105171526.3763499-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
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
index d4526323169..f708573884e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,9 +13,12 @@ include:
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
@@ -35,8 +38,8 @@ include:
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


