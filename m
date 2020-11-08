Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B51C4741F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B8F20897
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGLnn50a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B8F20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt4R-0008ER-R1
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2g-0006Re-8x
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:20:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2b-00028B-Lq
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604874005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+24Qtjsem3z7nn8q0n3COy79qpz54BrkmBsMuZl5LU=;
 b=cGLnn50a+89gRakUnKQPSuJ84b/zbo1GTe1mgs+ZceJsEdedGjqbg5XfrXlAtQQWDa3RJT
 xwIXusKvnq/sZ1aRdrdcm5wtWqANwpHa3mLe0/IIdpy+U+TDzutvFZlOiNbBQcCboLdT73
 RVa/IGiwpuSaSL095cu3F/WkPto6De0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-WfB84FCUMxSc2XnfVbgj2A-1; Sun, 08 Nov 2020 17:20:03 -0500
X-MC-Unique: WfB84FCUMxSc2XnfVbgj2A-1
Received: by mail-wr1-f71.google.com with SMTP id e11so3478723wrw.14
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r+24Qtjsem3z7nn8q0n3COy79qpz54BrkmBsMuZl5LU=;
 b=dcfFAYUBh6ESerzoFasIhldZbAuakrFgBRaziqRibqBRtjFm3uMNhpqtysasCjAFF3
 LshqqfUqCqYT1FQwJ8PyJXRyY1v19FVLMQEYH3umqrSHCskmL/gUEdy5/khiDkSLd8kq
 TNPNFBkiayZ7/d1x5dmdh2n+pmckB+AeXJ+3kuUULTZ0FRfv/kVKAvXT8IEdZtWKxbpE
 ROEa/r8dDaFXERVvoon6XgfZqits1bPCf41ZbFsw3/BwO2+9nmfWWy50bnOrN77K2M7N
 LpfZVLI1j518HvG/gCxpXkyDptpKAXScI8bZ/Ux9qklPmD0EF+VoxeG4BZWbNAQvuk8N
 jynQ==
X-Gm-Message-State: AOAM530UhNoXvYU65V5gNOtjoIlusDcV+nUSg+Au9X9xFdt5yoUCFGtk
 nQkcwyfT0Vp4bOLxaF1RdLDBJfxUO79XIg3eL/GSNNcCut6UIQzEfZJb4Kh/g9UGBY7Kj4+70qo
 Mzq4TnI//tqlPBMk=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr14742653wro.339.1604874002115; 
 Sun, 08 Nov 2020 14:20:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIt3uSiJLzk1pUnLGjIVSg22h5INWArBzDzaXS7ePKJTEZIhAOiORr/mcvqbGu2nidIPCFww==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr14742638wro.339.1604874001996; 
 Sun, 08 Nov 2020 14:20:01 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id i11sm4135012wrm.1.2020.11.08.14.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:20:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/11] gitlab-ci: Extract common job definition as
 'cross_common_job'
Date: Sun,  8 Nov 2020 23:19:21 +0100
Message-Id: <20201108221925.2344515-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108221925.2344515-1-philmd@redhat.com>
References: <20201108221925.2344515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the common definitions shared by '.cross_system_build_job'
and '.cross_user_build_job' to '.cross_common_job'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.d/crossbuilds.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 099949aaef3..701550f028c 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,7 +1,9 @@
-
-.cross_system_build_job:
+.cross_common_job:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+
+.cross_system_build_job:
+  extends: .cross_common_job
   timeout: 80m
   script:
     - mkdir build
@@ -14,8 +16,7 @@
     - make -j$(expr $(nproc) + 1) all check-build
 
 .cross_user_build_job:
-  stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  extends: .cross_common_job
   script:
     - mkdir build
     - cd build
-- 
2.26.2


