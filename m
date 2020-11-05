Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1394C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C3E206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGwpMenz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C3E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaj0W-0005zS-K8
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaisB-0004cT-Fk
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kais9-0000MP-LZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dh8zYanri5cUjNjRO/cAMn2XcMmJnffL6Q+0hobMChg=;
 b=OGwpMenz4YrxBDasK3tQR1BMTGqYmIqPOeR9KI5Z5dtjNyOMdTWuMzl5zITZZ28wyjALa/
 UMY9/bpfe537EJLvNEQf5SnUGbbnWifVB6v58PksvL7+IO7l0ADtwPPFJHdpqgMZ7Std/R
 VRP1xq5trj5jhqkrCrE3rFTCaN1wqGY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-Khwbfpo4P66V4NBSmF8DwQ-1; Thu, 05 Nov 2020 12:16:26 -0500
X-MC-Unique: Khwbfpo4P66V4NBSmF8DwQ-1
Received: by mail-wm1-f70.google.com with SMTP id e15so612538wme.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dh8zYanri5cUjNjRO/cAMn2XcMmJnffL6Q+0hobMChg=;
 b=IUHcOYUPrldqxxnqYxFjs0tVNYor9rGFh8S/HJ0fA94PZ77s/3uX3Jv4B714Xf579G
 Hx/2El+YSN6Lts/0z87f/17OnESM+glDXF3lFEBA6BFAPksIUKuDg0wrFaz9gpNJbtg7
 X3HoLWqeu51ClW8Wr5VIL7m/+lp947vyIN8GTdshQtMo2ey0tGM4VKl362kOk4qvAhEu
 JMRhM0Nsh6Keu+3wbpvExFArxmHswxAegaNUkseAxMZ7RxQN6v41BvUqDb98IBEFdy97
 a6TJXiuOwxAQ7kS6hRGF12tMieQHG0R0OJmszY9vXHWYMF8T+rO9HB6LQXzWULKk4FSW
 N7wQ==
X-Gm-Message-State: AOAM531flPUnyn9TbfyeDsqYWtPQscExS89iTA7adEboYC/puBuRruRr
 Bu97/GTiqJMKm7z52eXrwLb63luhJYNimHWbNJIZIVZYhQn2m8Ympl6CVpsa8RBzd7MTv33VuoP
 oiYxYXUdzcD6r+nI=
X-Received: by 2002:adf:ef02:: with SMTP id e2mr3959532wro.381.1604596585409; 
 Thu, 05 Nov 2020 09:16:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzytUtubNf9azxwy8izftM15Tlx9tFC/+UPKrgXy+qz4FcNWjoafVZs0jIWAzYx7bwxpEOVgQ==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr3959524wro.381.1604596585290; 
 Thu, 05 Nov 2020 09:16:25 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f17sm3601261wme.22.2020.11.05.09.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:16:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 11/11] gitlab-ci: Move artifacts expiry rule to common
 'native_build_job'
Date: Thu,  5 Nov 2020 18:15:26 +0100
Message-Id: <20201105171526.3763499-12-philmd@redhat.com>
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

Build jobs include the 'native_build_job' template. Move
the 'artifacts expiry' rule there. Now all build jobs benefit
from it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index debd4dea4fd..9c9a8584e4f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -74,6 +74,10 @@ include:
       then
         make -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+  artifacts:
+    expire_in: 2 days
+    paths:
+      - build
 
 .native_test_job:
   extends: .native_common_job
@@ -116,10 +120,6 @@ build-system-ubuntu:
     TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu
       moxie-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-ubuntu:
   extends: .native_test_job
@@ -146,10 +146,6 @@ build-system-debian:
     TARGETS: arm-softmmu avr-softmmu i386-softmmu mipsel-softmmu
       riscv64-softmmu sh4eb-softmmu sparc-softmmu xtensaeb-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-debian:
   extends: .native_test_job
@@ -177,10 +173,6 @@ build-system-fedora:
     TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-fedora:
   extends: .native_test_job
@@ -208,10 +200,6 @@ build-system-centos:
     TARGETS: ppc64-softmmu or1k-softmmu s390x-softmmu
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
-  artifacts:
-    expire_in: 2 days
-    paths:
-      - build
 
 check-system-centos:
   extends: .native_test_job
@@ -312,10 +300,6 @@ build-deprecated:
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


