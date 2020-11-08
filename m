Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA17C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0C8206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoYdFWUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0C8206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrff-0001OL-9g
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrb8-0004bL-Rf
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrb7-0000Vn-2y
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBh8aiEaP2k9mw4XU/53Ceir9POzL1w17rzpRU+z11k=;
 b=DoYdFWUNwCSoBnlt4MSI3/mxmorQqCl6lRCyGNMceEDJeOY6H6mqa9NhEbyiPUHYD/2Pai
 7MMug5J2j6RTe5Le0zckCRH0kG1vhFdU8BAJga2rMJXvF3f+B98RHnSir9F+hpgEzz9yfV
 CFO7x7dRUS6SrLg6AhdaX0uU7Fn5RIk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-8pYHFxKwM8KaitLfSjUmFg-1; Sun, 08 Nov 2020 15:47:35 -0500
X-MC-Unique: 8pYHFxKwM8KaitLfSjUmFg-1
Received: by mail-wr1-f70.google.com with SMTP id v5so3403342wrr.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QBh8aiEaP2k9mw4XU/53Ceir9POzL1w17rzpRU+z11k=;
 b=k+ttKYetSjDsPLcqEsUxQ/ClywBABClO/PKmlzdPI7IcqvE6ESxzWhXSA+6BBq1OTP
 G0ciEJfPcdr2O4VLiEbX04uX8ZyOp374luZIDrykbD4aB8VORIwN/fNuo985Up/eLdr3
 dKCdMva+DG0nzHnTOV0HhgoRIIaYDgXwSoczEVn43ljHYgol0EBTC5kt2Wn/w2vqXgGr
 cGOrnxUPNomlHlUSs22uQVn9uUxuE2xrJwxMqldZbEmraMsemn0URcfWREn7khoTJKlK
 YUpsry9FxZQnzGQw+/9jBGeHQhiSao0P5gjFu8tpfPycbFPj/6ajDZPlSTXPuVVsRblB
 jquQ==
X-Gm-Message-State: AOAM530wKdSYclAW1YcPJA+f6bD/rjcV7H5P9gkBBPt00zH+OTVO4pM0
 1ddTBU9rMCgVnyNgJW6xlkRvu1ki31ntkK4pmffkOkWUvgnmjKlVyElv9qsl0r2Ln765RJrI7Jj
 t5iKWaVNQoIGFykI=
X-Received: by 2002:a5d:4690:: with SMTP id u16mr4268001wrq.263.1604868453462; 
 Sun, 08 Nov 2020 12:47:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyv46DYDjpvatnZS1HQX9BYEBUaYL6/ZyFGLHAdE9d7ma94o31cYwwHL10rB79bKtGO30GEA==
X-Received: by 2002:a5d:4690:: with SMTP id u16mr4267986wrq.263.1604868453338; 
 Sun, 08 Nov 2020 12:47:33 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u195sm10585996wmu.18.2020.11.08.12.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 07/17] gitlab-ci: Move job testing
 --without-default-devices across to gitlab
Date: Sun,  8 Nov 2020 21:45:25 +0100
Message-Id: <20201108204535.2319870-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 8cdb2cef3f1, move the job testing the
'--without-default-devices' configure option to GitLab.

Since building all softmmu targets takes too long, split
the job in 2.

As smoke test, run the qtests on the AVR and m68k targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>

v3 had:
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 .travis.yml    |  8 --------
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b98800462ed..3fc3d0568c6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -315,6 +315,52 @@ build-user-plugins:
     MAKE_CHECK_ARGS: check-tcg
   timeout: 1h 30m
 
+build-system-ubuntu-without-default-devices 1/2:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --without-default-devices --disable-tools --disable-docs
+    TARGETS:
+      aarch64-softmmu
+      alpha-softmmu
+      arm-softmmu
+      avr-softmmu
+      cris-softmmu
+      hppa-softmmu
+      i386-softmmu
+      m68k-softmmu
+      microblazeel-softmmu
+      microblaze-softmmu
+      mips64el-softmmu
+      mips64-softmmu
+      mipsel-softmmu
+      mips-softmmu
+      moxie-softmmu
+    MAKE_CHECK_ARGS: check-qtest-avr check-qtest-m68k
+
+build-system-ubuntu-without-default-devices 2/2:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --without-default-devices --disable-tools --disable-docs
+    TARGETS:
+      nios2-softmmu
+      or1k-softmmu
+      ppc64-softmmu
+      ppc-softmmu
+      riscv32-softmmu
+      riscv64-softmmu
+      rx-softmmu
+      s390x-softmmu
+      sh4eb-softmmu
+      sh4-softmmu
+      sparc64-softmmu
+      sparc-softmmu
+      tricore-softmmu
+      x86_64-softmmu
+      xtensaeb-softmmu
+      xtensa-softmmu
+
 build-clang:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index a3d78171cab..15d92291358 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -224,14 +224,6 @@ jobs:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
 
-    # We manually include builds which we disable "make check" for
-    - name: "GCC without-default-devices (softmmu)"
-      env:
-        - CONFIG="--without-default-devices --disable-user"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-        - TEST_CMD=""
-
-
     # We don't need to exercise every backend with every front-end
     - name: "GCC trace log,simple,syslog (user)"
       env:
-- 
2.26.2


