Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4FC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183D5206D8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUeVrr4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183D5206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbtDP-0008HY-S4
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2x-0006x5-3y
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2v-0002Am-BV
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604874024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj6sIGQ+9d93c4eo42RqcVAC/Mp3MEsUUct8oxUxgjw=;
 b=XUeVrr4BjqaGQQFeOPWPUKcZlCEoMmmhcO6qqD9fsBkZsbDggZkwi8RBz3p9qdwpR1o844
 nGueJ2yznrzkFe2K+AoGKfK9cn/54LhbPmzxZYBQ2CExplES1BU4+1QgEDDtzPAnDZAP9j
 AjKXbeecUIzL3+6u0shM9D3JFmtwyIo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-sebKj8YUM5qjgoZ7LhkmRA-1; Sun, 08 Nov 2020 17:20:22 -0500
X-MC-Unique: sebKj8YUM5qjgoZ7LhkmRA-1
Received: by mail-wm1-f71.google.com with SMTP id z62so2844469wmb.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sj6sIGQ+9d93c4eo42RqcVAC/Mp3MEsUUct8oxUxgjw=;
 b=unc9iH1kjKU0WV/Il1WNxeKfLxENQuB/JsbTf0NdcChVpbP2/Jdb504p/tfPIr1tCY
 fQop00uR7rUEWylVZMwv+r1q9wLvmc/SnJ7BKVDLScFixHaqqNifNVJ8lgMEMIoqh7iT
 XVy8iry+uWlLT21VvZ5Nii6AoaTHhbiMz32W3VUPUBYOcyd15GOeLpo1Dbt/+RNi38Cb
 zln6fenw03+bi9DY5Sm9VAtmwsZS8Xs+L3/bM6PQkmjg9gQ2FgJZUPWDYW7WHySDBx0c
 3uAt9WvX+ayXkFJdNByThH4+prKuuNqwqhAcEK3+CX2KCS4A0+aSrINsOxpMbAKXA+Jy
 3kIQ==
X-Gm-Message-State: AOAM531CVDmQ9J/fXIRRxI0Ck/2geHenOuBOxY0tMos9TZkOqfDK690C
 kDmqN4XOygN93z9WXmiwj9yrPPzqHzDrX0O0DCYQlSnsmRHNtq1EESulrh+WaabFNLJ4ze1ZiRJ
 fcBFwXZUFnPRi8iw=
X-Received: by 2002:a1c:7301:: with SMTP id d1mr11098777wmb.141.1604874021467; 
 Sun, 08 Nov 2020 14:20:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGsNFbiyKismeVoSLSRY7716hgfdpx1TS84pPTb6hztL7bjQRmgZm9HctpUVU5/SXdH23bAQ==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr11098767wmb.141.1604874021318; 
 Sun, 08 Nov 2020 14:20:21 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b8sm10277743wmj.9.2020.11.08.14.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:20:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/11] gitlab-ci: Move artifacts expiry rule to common
 'native_build_job'
Date: Sun,  8 Nov 2020 23:19:25 +0100
Message-Id: <20201108221925.2344515-12-philmd@redhat.com>
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

Build jobs include the 'native_build_job' template. Move
the 'artifacts expiry' rule there. Now all build jobs benefit
from it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index dd5f9a4c505..27a4cbc5171 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -79,6 +79,10 @@ include:
       then
         make -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+  artifacts:
+    expire_in: 2 days
+    paths:
+      - build
 
 .native_test_job:
   extends: .native_common_job
@@ -121,10 +125,6 @@ build-system-ubuntu:
     TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu
       moxie-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-ubuntu:
   extends: .native_test_job
@@ -151,10 +151,6 @@ build-system-debian:
     TARGETS: arm-softmmu avr-softmmu i386-softmmu mipsel-softmmu
       riscv64-softmmu sh4eb-softmmu sparc-softmmu xtensaeb-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-debian:
   extends: .native_test_job
@@ -182,10 +178,6 @@ build-system-fedora:
     TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-fedora:
   extends: .native_test_job
@@ -213,10 +205,6 @@ build-system-centos:
     TARGETS: ppc64-softmmu or1k-softmmu s390x-softmmu
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-centos:
   extends: .native_test_job
@@ -317,10 +305,6 @@ build-deprecated:
     MAKE_CHECK_ARGS: build-tcg
     TARGETS: ppc64abi32-linux-user tilegx-linux-user lm32-softmmu
       unicore32-softmmu
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 # We split the check-tcg step as test failures are expected but we still
 # want to catch the build breaking.
-- 
2.26.2


