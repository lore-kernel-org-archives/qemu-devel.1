Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A44C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959A6206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JycKt7mQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959A6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaixW-0002Cw-JI
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kais4-0004US-AW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairz-0000Lt-J7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuM/NV4PbLQPpbKnL+diVRLlTqVchxOKQRecSqdKDQY=;
 b=JycKt7mQ/8Ja5qwisbK2EWRukXmOBoUwiN/94LnXeT+cAjOSGlmFvnvoEPh7VVSL3JTSpz
 M7ZZUKDXRCkh4Ss1jDAz1TVEAxUycw4mxJA2k0EeFDkgd+w6NlgAi86SUcZrLh7aex0gAT
 TqIKptNsAOqHDMetO+ADjQwBzS7tgT0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-9XYD4yS-N9S8_PrNsjctlQ-1; Thu, 05 Nov 2020 12:16:16 -0500
X-MC-Unique: 9XYD4yS-N9S8_PrNsjctlQ-1
Received: by mail-wr1-f71.google.com with SMTP id 67so263808wra.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SuM/NV4PbLQPpbKnL+diVRLlTqVchxOKQRecSqdKDQY=;
 b=b4DTdlHA9ZmkO3ZlLKpRZSKh+itUvmyI3frAWM/eOzRNlM/bB1FpAcn7a7Z5raXqYV
 zewcDBd3v5jGTnXfMiUrh2ZWhyGqBesjp4F9GTJ/XHH/ax2Sg6xpG2EmglMGMxJMwGK1
 /0RjSFmXsDVVWKbwfeq2Ri6dAnKKfvdx/oQyfUbvFrEg2n5xejqNccWEwbTjAEfHuWdK
 85lH/YCOnzcIYXdyN8sd675BQf2yZ536NUCUUTS46NQlKIdSJ/+7nZYvu/Bq5Uh9zZEZ
 DkSxWlvKKWm1dyTairVuGDaJHUW23pYBpLg24hk4mf8eYFp5AXWiKd2uVqpJLD2a8ICr
 D/2Q==
X-Gm-Message-State: AOAM532tPrmEL/9shJzxcsW7ua6xfit+how6JZnx3IoJzp7u+ONOppRv
 J80EJ0dkmAnVWAyohgy0uI6trrPxdvF9uNvT5OC1h2O5qxcFkruG58+xXI3nPRUN3kOp/oauxSb
 0gHWZH2SNNjx0+ck=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr3683603wmj.159.1604596575390; 
 Thu, 05 Nov 2020 09:16:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzacydmB61d0VpJd9NJ5llLAgk6WvBW7odPftBvtDa+a2Gi+gsoVQOr+26h4472RuZlajkglQ==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr3683577wmj.159.1604596575203; 
 Thu, 05 Nov 2020 09:16:15 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u202sm3663443wmu.23.2020.11.05.09.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:16:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 09/11] gitlab-ci: Add rules to select cross-jobs to
 build
Date: Thu,  5 Nov 2020 18:15:24 +0100
Message-Id: <20201105171526.3763499-10-philmd@redhat.com>
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

Add rules to select some crossbuild jobs.

The following tags are available to restrict the CI jobs:
- all    (select all jobs, this is default)
- cross  (select all cross-jobs)
- system (select all cross-system jobs)
- user   (select all cross-user jobs)
- $ARCH  (select an architecture: arm/mips/ppc/sparc/...)

Developers can combine tags in the QEMU_BUILD variable when
pushing a branch (or tag) to repositories. Examples:

  $ git push -o ci.variable="QEMU_BUILD=user"        myrepo mybranch
  $ git push -o ci.variable="QEMU_BUILD=user,system" myrepo mybranch

References:
- https://docs.gitlab.com/ee/ci/yaml/#rulesif
- https://docs.gitlab.com/ee/user/project/push_options.html#push-options-for-gitlab-cicd

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.d/crossbuilds.yml | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 701550f028c..7503d24a57b 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,6 +1,36 @@
 .cross_common_job:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  rules:
+    # If the if statement is true, the job is added to the pipeline.
+    # We only filter for push events
+    - if: '$CI_PIPELINE_SOURCE != "push"'
+    # Build all when no variable defined, or set to "all"
+    - if: $QEMU_BUILD == null || $QEMU_BUILD =~ /^all$/
+    # Build specific job name
+    - if: $QEMU_BUILD =~ /^$CI_JOB_NAME$/
+    # Build set of jobs by feature
+    - if: $QEMU_BUILD =~ /cross/
+    - if: $QEMU_BUILD =~ /system/ && $CI_JOB_NAME =~ /system/
+    - if: $QEMU_BUILD =~ /user/ && $CI_JOB_NAME =~ /user/
+    # Build set of jobs by arch
+    - if: $QEMU_BUILD =~ /aarch64/ && ($CI_JOB_NAME =~ /aarch64/ || $IMAGE =~ /aarch64/)
+    - if: $QEMU_BUILD =~ /alpha/ && ($CI_JOB_NAME =~ /alpha/ || $IMAGE =~ /alpha/)
+    - if: $QEMU_BUILD =~ /arm/ && ($CI_JOB_NAME =~ /arm/ || $IMAGE =~ /arm/)
+    - if: $QEMU_BUILD =~ /avr/ && ($CI_JOB_NAME =~ /avr/ || $IMAGE =~ /avr/)
+    - if: $QEMU_BUILD =~ /hppa/ && ($CI_JOB_NAME =~ /hppa/ || $IMAGE =~ /hppa/)
+    - if: $QEMU_BUILD =~ /i386/ && ($CI_JOB_NAME =~ /i386/ || $IMAGE =~ /i386/)
+    - if: $QEMU_BUILD =~ /lm32/ && ($CI_JOB_NAME =~ /lm32/ || $IMAGE =~ /lm32/)
+    - if: $QEMU_BUILD =~ /m68k/ && ($CI_JOB_NAME =~ /m68k/ || $IMAGE =~ /m68k/)
+    - if: $QEMU_BUILD =~ /ppc/ && ($CI_JOB_NAME =~ /ppc/ || $IMAGE =~ /ppc/)
+    - if: $QEMU_BUILD =~ /riscv/ && ($CI_JOB_NAME =~ /riscv/ || $IMAGE =~ /riscv/)
+    - if: $QEMU_BUILD =~ /s390x/ && ($CI_JOB_NAME =~ /s390x/ || $IMAGE =~ /s390x/)
+    - if: $QEMU_BUILD =~ /sparc/ && ($CI_JOB_NAME =~ /sparc/ || $IMAGE =~ /sparc/)
+    - if: $QEMU_BUILD =~ /tricore/ && ($CI_JOB_NAME =~ /tricore/ || $IMAGE =~ /tricore/)
+    - if: $QEMU_BUILD =~ /x86/ && ($CI_JOB_NAME =~ /x86/ || $IMAGE =~ /x86/)
+    - if: $QEMU_BUILD =~ /xtensa/ && ($CI_JOB_NAME =~ /xtensa/ || $IMAGE =~ /xtensa/)
+    # In all other cases, the job is excluded from a pipeline.
+    - when: never
 
 .cross_system_build_job:
   extends: .cross_common_job
-- 
2.26.2


