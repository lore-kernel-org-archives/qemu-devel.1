Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7057620842
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQ8jS5tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7057620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19OE-0002Ql-Jp
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k19Jf-0002Ie-7P
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:13:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54905
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k19Jc-0004NS-MN
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7TPV44PoUc+9Q0lmQXillEDQrne/MHBn47UVLzrINI=;
 b=JQ8jS5tF17V6I0+2thGxv+YYsFYrtKZd2TtyXjjLYm/ZJ7z6Jjgr4yYB4Vi+mVHR16APiW
 ZTkvVzRfGaa6bsTWn0aBJf7kbje3mHfU0rXg/rcijduCPbIlT0meNrwzcQ+FWv+8lg1EMP
 HA7pSh9rh4Ojr4GnCogmLAGZ47aHyXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-SrAnCSH_MCyp47W_X2-SPw-1; Thu, 30 Jul 2020 10:13:46 -0400
X-MC-Unique: SrAnCSH_MCyp47W_X2-SPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4152F107BEFF;
 Thu, 30 Jul 2020 14:13:45 +0000 (UTC)
Received: from thuth.com (ovpn-112-85.ams2.redhat.com [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBB97BEBD;
 Thu, 30 Jul 2020 14:13:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 4/4] gitlab-ci: Fix Avocado cache usage
Date: Thu, 30 Jul 2020 16:13:26 +0200
Message-Id: <20200730141326.8260-5-thuth@redhat.com>
In-Reply-To: <20200730141326.8260-1-thuth@redhat.com>
References: <20200730141326.8260-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 6957fd98dc ("gitlab: add avocado asset caching") we
tried to save the Avocado cache (as in commit c1073e44b4 with
Travis-CI) however it doesn't work as expected. For some reason
Avocado uses /root/avocado_cache/ which we can not select later.

Manually generate a Avocado config to force the use of the
current job's directory.

This patch is based on an earlier version from Philippe Mathieu-Daudé.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e96bcd50f8..9820066379 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -47,11 +47,24 @@ include:
     - find . -type f -exec touch {} +
     - make $MAKE_CHECK_ARGS
 
-.post_acceptance_template: &post_acceptance
+.acceptance_template: &acceptance_definition
+  cache:
+    key: "${CI_JOB_NAME}-cache"
+    paths:
+      - ${CI_PROJECT_DIR}/avocado-cache
+    policy: pull-push
+  before_script:
+    - mkdir -p ~/.config/avocado
+    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
+    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado-cache']"
+           >> ~/.config/avocado/avocado.conf
+    - if [ -d ${CI_PROJECT_DIR}/avocado-cache ]; then
+        du -chs ${CI_PROJECT_DIR}/avocado-cache ;
+      fi
   after_script:
     - cd build
     - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-    - du -chs $HOME/avocado/data/cache
+    - du -chs ${CI_PROJECT_DIR}/avocado-cache
 
 build-system-ubuntu:
   <<: *native_build_job_definition
@@ -81,7 +94,7 @@ acceptance-system-ubuntu:
   variables:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
+  <<: *acceptance_definition
 
 build-system-debian:
   <<: *native_build_job_definition
@@ -111,7 +124,7 @@ acceptance-system-debian:
   variables:
     IMAGE: debian-amd64
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
+  <<: *acceptance_definition
 
 build-system-fedora:
   <<: *native_build_job_definition
@@ -141,7 +154,7 @@ acceptance-system-fedora:
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
+  <<: *acceptance_definition
 
 build-system-centos:
   <<: *native_build_job_definition
@@ -171,7 +184,7 @@ acceptance-system-centos:
   variables:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
+  <<: *acceptance_definition
 
 build-disabled:
   <<: *native_build_job_definition
-- 
2.18.1


