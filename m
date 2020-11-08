Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2460C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617C6206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJgqfSGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617C6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbreQ-0008Rb-3M
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbY-00059s-Bn
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbW-0000YO-NJ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=008iN8GcWm31ImxzYVOcTFh32Buf8nV5TwwPQTAEsT0=;
 b=TJgqfSGyG6IjdpqT4yYmBDxn9lPoqrjhcq5PmDMWpDo9DcCRJEP7yz9nUItuM95PpWhjbC
 iTZ6zziEEC8tvFHjaKLy7Gikj0Y/0AgrR6FWBq7WVsaMoTqmIQmCMtH03UWNUGGQFTpgcN
 zqy4Wgd0r7D/6DC8p9NeyrnTVNBkqUc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-78k24L29OOitmj1BIxOxHg-1; Sun, 08 Nov 2020 15:48:00 -0500
X-MC-Unique: 78k24L29OOitmj1BIxOxHg-1
Received: by mail-wr1-f69.google.com with SMTP id w6so3388247wrk.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=008iN8GcWm31ImxzYVOcTFh32Buf8nV5TwwPQTAEsT0=;
 b=BQHMCrgU8cle9YKiIZdX84N2mwu41TjeSxXF08cdwh2Ga+AD5S4s+8XloNHPTbzBV+
 ROs2Nu1Hqjx+pus/GnWoNv6Z5IlkBYl+Ciom8/bdY4YIZY0b2VlBScS07SDhcJB4mml3
 qPLZRzflTbNMVAWPl5MkrevuuNYZ7ooJBYOvJyJdAzYYivSS+UGo356RH5/nc3z58JPX
 zyV/5uAfhxEKG9e3ovIHLCIb6TQr8AMFrFMc/XUv3yaaLxzHcc/rCIkjs7eASF3YkhgN
 FCPjF14q9Qziyd4GIRJERDBAGymPw5lSUq+BjsUh18CADS9CIlurHEiam7yyNmNcxY+V
 XYrw==
X-Gm-Message-State: AOAM530CxmrPy6gJrweRx7h+In1Ii23RyRyjWvf2FMsvPax4XRbjBIuM
 HT9AQ6k+0iX1jfePKBmDCrYb2Dr3WMHX/zuDwkeExyIZxUXWtcZgci61TxOQNRSYFpUAq/OZNVN
 4hT5f7YjjDvaBWz8=
X-Received: by 2002:adf:e28c:: with SMTP id v12mr14152005wri.230.1604868478987; 
 Sun, 08 Nov 2020 12:47:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVl+OZIMykaL4A7Gc4rcswDZSR9HC5BpNDg6jNh7a8IGqdMqWnCMBK2sHF34liWxNJvvdZPA==
X-Received: by 2002:adf:e28c:: with SMTP id v12mr14151981wri.230.1604868478857; 
 Sun, 08 Nov 2020 12:47:58 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n22sm9937902wmk.40.2020.11.08.12.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 12/17] gitlab-ci: Move coroutine tests across to
 gitlab
Date: Sun,  8 Nov 2020 21:45:30 +0100
Message-Id: <20201108204535.2319870-13-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 8cdb2cef3f1, move the coroutine tests to GitLab.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
---
 .gitlab-ci.yml | 16 ++++++++++++++++
 .travis.yml    | 14 --------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a799803afb9..6552a832939 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -475,6 +475,22 @@ build-tci:
     - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
     - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
 
+# Alternate coroutines implementations are only really of interest to KVM users
+# However we can't test against KVM on Travis so we can only run unit tests
+build-coroutine-ucontext:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --with-coroutine=ucontext --disable-tcg
+    MAKE_CHECK_ARGS: check-unit
+
+build-coroutine-sigaltstack:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --with-coroutine=sigaltstack --disable-tcg
+    MAKE_CHECK_ARGS: check-unit
+
 # Most jobs test latest gcrypt or nettle builds
 #
 # These jobs test old gcrypt and nettle from RHEL7
diff --git a/.travis.yml b/.travis.yml
index 15550fb023f..8ef31f8d8b6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -139,20 +139,6 @@ jobs:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
-    # Alternate coroutines implementations are only really of interest to KVM users
-    # However we can't test against KVM on Travis so we can only run unit tests
-    - name: "check-unit coroutine=ucontext"
-      env:
-        - CONFIG="--with-coroutine=ucontext --disable-tcg"
-        - TEST_CMD="make check-unit -j${JOBS} V=1"
-
-
-    - name: "check-unit coroutine=sigaltstack"
-      env:
-        - CONFIG="--with-coroutine=sigaltstack --disable-tcg"
-        - TEST_CMD="make check-unit -j${JOBS} V=1"
-
-
     # Check we can build docs and tools (out of tree)
     - name: "tools and docs (bionic)"
       dist: bionic
-- 
2.26.2


