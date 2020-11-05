Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC561C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23404206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIcpldxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23404206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaixk-0002lS-2M
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaisA-0004ZX-7Y
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kais6-0000MC-8p
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTSVN3oUuqR2+G30Aw9N7n9SpQDpAdEdj3jqg7jW23U=;
 b=dIcpldxAeMz9BMFNzC0eQ3AJYPPbN8GGLzedXng9NYjMP0raZ2CJspv8rmh5P95+XZy2X1
 6HTcU1gDf+pZPZkJel5ZvMFqFXY+8WoVr3lCAV+T1HIpdeP8RLJIChEiN4N6Adn7Foczi+
 +nNrBb9M8grVzbhF3WNqdmlAkWcgFWE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Q_2PYruRPY-uECQoG2DTlg-1; Thu, 05 Nov 2020 12:16:22 -0500
X-MC-Unique: Q_2PYruRPY-uECQoG2DTlg-1
Received: by mail-wm1-f71.google.com with SMTP id t21so612521wmt.8
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aTSVN3oUuqR2+G30Aw9N7n9SpQDpAdEdj3jqg7jW23U=;
 b=SSYfoH1LRZVAbzubShxL5HlDoNDUl7sGYcIJ/fiLvUpDrK5xPBycgLKAfsMOukNaxe
 y6LmSwa1KkjA9kkgpjl6uyUm0WzwKTWMPR3GfkjW577IHJH2tirQXjcuV8eTfdbj/0oy
 YXL61Uoi7pttHOjN4r8HdJB7/hHL43MbBNNEciBJ0JhjzlHCYGWE/VWGywovDOgQpRSv
 np6fjtKaZs0Fh8CJ0djkGdDl/XGpSW3eNxSFv9PtHp0CzQyeowO4u3UXnLE5qbEQy02y
 dJUO39GpeTT8uJfY9+/nX9i5m/ZVvzzwGQzDk/F4KBO1GSwTYbnvriCL6zccfbcXhtNe
 zXuA==
X-Gm-Message-State: AOAM532Mod74DezLmhCwJ2cr8SefhqmeaEK5VCx3fbf6YPD1YZe92yDY
 0oMyvg7Smx/eikedoxuhrmVmU6Heeu4ODIt1zNP6NkaYExPWZ6jZ9IIMUQYvDVDSotYx52LfTMK
 Al/4cvoUUaiIWI2Q=
X-Received: by 2002:a1c:3c84:: with SMTP id j126mr3899186wma.151.1604596580369; 
 Thu, 05 Nov 2020 09:16:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwuR8+oLVW+15w+g5aC0JpLhZrw0paviDb6+TKlGgM/OvHyWCAcrah//qFPg5TiS6nT+M9mQ==
X-Received: by 2002:a1c:3c84:: with SMTP id j126mr3899160wma.151.1604596580146; 
 Thu, 05 Nov 2020 09:16:20 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t6sm3351615wrp.68.2020.11.05.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:16:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 10/11] gitlab-ci: Add rules to select building/testing
 native jobs
Date: Thu,  5 Nov 2020 18:15:25 +0100
Message-Id: <20201105171526.3763499-11-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add rules to select various build/test jobs.

The following tags are available to restrict CI jobs:
- user        (user-mode jobs)
- system      (system-mode jobs)
- centos      (jobs based on CentOS distribution image)
- debian      (...           Debian)
- fedora      (...           Fedora)
- ubuntu      (...           Ubuntu)
- crypto      (jobs testing the crypto feature)
- tci         (jobs testing TCI feature)
- fuzz        (fuzzer job)
- integration (integration tests)
- $ARCH       (select an architecture: arm/mips/ppc/sparc/...)

Developers can combine tags in the QEMU_BUILD variable when
pushing a branch (or tag) to repositories. Examples:

  $ git push -o ci.variable="QEMU_BUILD=user"                    myrepo mybranch
  $ git push -o ci.variable="QEMU_BUILD=user,debian,crypto,fuzz" myrepo mybranch

References:
- https://docs.gitlab.com/ee/ci/yaml/#rulesif
- https://docs.gitlab.com/ee/user/project/push_options.html#push-options-for-gitlab-cicd

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f708573884e..debd4dea4fd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -15,6 +15,44 @@ include:
 
 .native_common_job:
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  rules:
+    # If the if statement is true, the job is added to the pipeline.
+    # We only filter for push events
+    - if: '$CI_PIPELINE_SOURCE != "push"'
+    # Build all when no variable defined, or set to "all"
+    - if: $QEMU_BUILD == null || $QEMU_BUILD =~ /^all$/
+    # Build specific job name
+    - if: $QEMU_BUILD == $CI_JOB_NAME
+    # Build jobs using particular distribution image
+    - if: $QEMU_BUILD =~ /centos/ && $IMAGE =~ /^centos/
+    - if: $QEMU_BUILD =~ /debian/ && $IMAGE =~ /^debian/
+    - if: $QEMU_BUILD =~ /fedora/ && $IMAGE =~ /^fedora/
+    - if: $QEMU_BUILD =~ /ubuntu/ && $IMAGE =~ /^ubuntu/
+    # Build set of jobs by feature
+    - if: $QEMU_BUILD =~ /system/ && ($TARGETS =~ /softmmu/ || $CONFIGURE_ARGS =~ /disable-user/)
+    - if: $QEMU_BUILD =~ /user/ && ($TARGETS =~ /user/ || $CONFIGURE_ARGS =~ /disable-system/)
+    - if: $QEMU_BUILD =~ /integration/ && ($CI_JOB_NAME =~ /^integration/ || $CI_JOB_NAME =~ /^build-system/ || $MAKE_CHECK_ARGS =~ /check-acceptance/) # integration depends on build-system
+    - if: $QEMU_BUILD =~ /crypto/ && $CI_JOB_NAME =~ /crypto/
+    - if: $QEMU_BUILD =~ /tci/ && $CI_JOB_NAME =~ /tci$/
+    - if: $QEMU_BUILD =~ /fuzz/ && $CI_JOB_NAME =~ /fuzz$/
+    # Build set of jobs by arch
+    - if: $QEMU_BUILD =~ /aarch64/ && ($CI_JOB_NAME =~ /aarch64/ || $TARGETS =~ /aarch64/)
+    - if: $QEMU_BUILD =~ /alpha/ && ($CI_JOB_NAME =~ /alpha/ || $TARGETS =~ /alpha/)
+    - if: $QEMU_BUILD =~ /arm/ && ($CI_JOB_NAME =~ /arm/ || $TARGETS =~ /arm/)
+    - if: $QEMU_BUILD =~ /avr/ && ($CI_JOB_NAME =~ /avr/ || $TARGETS =~ /avr/)
+    - if: $QEMU_BUILD =~ /hppa/ && ($CI_JOB_NAME =~ /hppa/ || $TARGETS =~ /hppa/)
+    - if: $QEMU_BUILD =~ /i386/ && ($CI_JOB_NAME =~ /i386/ || $TARGETS =~ /i386/)
+    - if: $QEMU_BUILD =~ /lm32/ && ($CI_JOB_NAME =~ /lm32/ || $TARGETS =~ /lm32/)
+    - if: $QEMU_BUILD =~ /m68k/ && ($CI_JOB_NAME =~ /m68k/ || $TARGETS =~ /m68k/)
+    - if: $QEMU_BUILD =~ /ppc/ && ($CI_JOB_NAME =~ /ppc/ || $TARGETS =~ /ppc/)
+    - if: $QEMU_BUILD =~ /riscv/ && ($CI_JOB_NAME =~ /riscv/ || $TARGETS =~ /riscv/)
+    - if: $QEMU_BUILD =~ /s390x/ && ($CI_JOB_NAME =~ /s390x/ || $TARGETS =~ /s390x/)
+    - if: $QEMU_BUILD =~ /sparc/ && ($CI_JOB_NAME =~ /sparc/ || $TARGETS =~ /sparc/)
+    - if: $QEMU_BUILD =~ /tricore/ && ($CI_JOB_NAME =~ /tricore/ || $TARGETS =~ /tricore/)
+    - if: $QEMU_BUILD =~ /x86/ && ($CI_JOB_NAME =~ /x86/ || $TARGETS =~ /x86/)
+    - if: $QEMU_BUILD =~ /xtensa/ && ($CI_JOB_NAME =~ /xtensa/ || $TARGETS =~ /xtensa/)
+    # In all other cases, the job is excluded from a pipeline.
+    - when: never
 
 .native_build_job:
   extends: .native_common_job
-- 
2.26.2


