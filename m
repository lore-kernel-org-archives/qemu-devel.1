Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C7C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1B8206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPp1TYXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1B8206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt3q-0007eJ-EM
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2H-0005z1-W4
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2G-00025Q-1t
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604873983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkmWM8pdBxBAkh2ux+VVNAnnOD7tHToqsp9wNXfrvV8=;
 b=CPp1TYXVVxvASYwOyT8pfrA4r2G9awIRk0uOref4l2t9yb5p8wMXulMkWxuyOaqv8rwZiV
 kod4kleiA4VKEvkNE28E1nH+j6T50i83mR9A+qb6qrumOYY0ISlMKHinFI7BhsQXnNpy80
 n3jQdZtjJiBYJknWWzb9ZuXUiRCXsyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-pf-lwfoHPQ6FpJ1jka1VmA-1; Sun, 08 Nov 2020 17:19:39 -0500
X-MC-Unique: pf-lwfoHPQ6FpJ1jka1VmA-1
Received: by mail-wr1-f70.google.com with SMTP id q15so3464688wrw.8
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HkmWM8pdBxBAkh2ux+VVNAnnOD7tHToqsp9wNXfrvV8=;
 b=A8bFfI1DNy5JaPr7TNQPomaie8f3XcRQlIKr5HU1hnZG/GcYvbEzou5OSjQyYNymUt
 YDTQrB7bp4hYQkvhgoW3J3LGU/M/fmyVIbMJxzMI99nbpCRGgTcx6mefzTlpUtsWnIzp
 EFByo1/FvCJCq9jQ+YWlZ4fW40mp2iBbOTTGFUwxUQZej2iiTqkkCHWvdZcoPJarm0T2
 rbsmRr+yZMCBHHf5YVEtcn+mqHABijTm6yWQe8lHy1RZQ74Y07pdgTeleB4DN1wRLU5I
 RiKkTJnPN0D6L0paM19HicMHqeCLCpYU1+pbHIJ0PpuvTlUVoCdEwlCSzMMcmkd7HSd2
 SWBw==
X-Gm-Message-State: AOAM531GsSNiFVIs+yDv7kCGJ1SDbE4fuRZ9gMHoWwMK6nOYxABXsnlt
 3JqTgEbp6dlAGUEWf1sa2xpeXGcB1hPAzbQADSvaAAjOkGhSQBWo6W40Wsht1Go5uAhLTWagIZx
 3mG9cnr8URGHQRh8=
X-Received: by 2002:a1c:a185:: with SMTP id k127mr8244223wme.23.1604873977762; 
 Sun, 08 Nov 2020 14:19:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeK5Iw3T3r0WchIm2XyJfBXdfpPPUWMmNwiialhbHsJs9HGg02JgTxPqhLVa3bKnrU0ubY1g==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr8244211wme.23.1604873977633; 
 Sun, 08 Nov 2020 14:19:37 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u202sm10881001wmu.23.2020.11.08.14.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:19:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/11] gitlab-ci: Replace YAML anchors by extends
 (cross_system_build_job)
Date: Sun,  8 Nov 2020 23:19:16 +0100
Message-Id: <20201108221925.2344515-3-philmd@redhat.com>
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

'extends' is an alternative to using YAML anchors
and is a little more flexible and readable. See:
https://docs.gitlab.com/ee/ci/yaml/#extends

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.d/crossbuilds.yml | 40 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 03ebfabb3fa..099949aaef3 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,5 +1,5 @@
 
-.cross_system_build_job_template: &cross_system_build_job_definition
+.cross_system_build_job:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   timeout: 80m
@@ -13,7 +13,7 @@
           xtensa-softmmu"
     - make -j$(expr $(nproc) + 1) all check-build
 
-.cross_user_build_job_template: &cross_user_build_job_definition
+.cross_user_build_job:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   script:
@@ -24,91 +24,91 @@
     - make -j$(expr $(nproc) + 1) all check-build
 
 cross-armel-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-armel-cross
 
 cross-armel-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-armel-cross
 
 cross-armhf-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-armhf-cross
 
 cross-armhf-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-armhf-cross
 
 cross-arm64-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-arm64-cross
 
 cross-arm64-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-arm64-cross
 
 cross-mips-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-mips-cross
 
 cross-mips-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-mips-cross
 
 cross-mipsel-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-mipsel-cross
 
 cross-mipsel-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-mipsel-cross
 
 cross-mips64el-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-mips64el-cross
 
 cross-mips64el-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-mips64el-cross
 
 cross-ppc64el-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-ppc64el-cross
 
 cross-ppc64el-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-ppc64el-cross
 
 cross-s390x-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: debian-s390x-cross
 
 cross-s390x-user:
-  <<: *cross_user_build_job_definition
+  extends: .cross_user_build_job
   variables:
     IMAGE: debian-s390x-cross
 
 cross-win32-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: fedora-win32-cross
 
 cross-win64-system:
-  <<: *cross_system_build_job_definition
+  extends: .cross_system_build_job
   variables:
     IMAGE: fedora-win64-cross
-- 
2.26.2


