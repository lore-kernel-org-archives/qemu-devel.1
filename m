Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330E4C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA63A214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AURDWfi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA63A214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIBt-00052y-NK
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyZ-0005YR-DA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyV-0006G0-GY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwdpEydgASwk7Xa1qzk0VcFGKtWjCj8HlX5xwek5440=;
 b=AURDWfi1/MMvK6DdmnmIQdsePXY7lNtMEb3AypmTfWErrFkttFVQWgqjTV28LYAG240+kB
 gHOPNTfdfV3LShD2haUNsznTm0anTrVV+9Is31DI3/7ClFXjvHG3KR94feviabaV7U34zc
 ov+lDZgmn8oYlHgxbSz3BfT+7Az6D2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-P6OzXzVtNzCBLEKXkUZRIw-1; Tue, 13 Oct 2020 06:56:07 -0400
X-MC-Unique: P6OzXzVtNzCBLEKXkUZRIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 560BC18829D3;
 Tue, 13 Oct 2020 10:56:06 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640596EF41;
 Tue, 13 Oct 2020 10:56:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/23] gitlab: add a CI job for running checkpatch.pl
Date: Tue, 13 Oct 2020 12:55:18 +0200
Message-Id: <20201013105527.20088-15-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

This job is advisory since it is expected that certain patches will fail
the style checks and checkpatch.pl provides no way to mark exceptions to
the rules.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200918132903.1848939-2-berrange@redhat.com>
[thuth: Use "stage: build" to let it run earlier]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/check-patch.py | 48 +++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml              | 12 ++++++++++
 2 files changed, 60 insertions(+)
 create mode 100755 .gitlab-ci.d/check-patch.py

diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
new file mode 100755
index 0000000000..5a14a25b13
--- /dev/null
+++ b/.gitlab-ci.d/check-patch.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# check-patch.py: run checkpatch.pl across all commits in a branch
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import os.path
+import sys
+import subprocess
+
+namespace = "qemu-project"
+if len(sys.argv) >= 2:
+    namespace = sys.argv[1]
+
+cwd = os.getcwd()
+reponame = os.path.basename(cwd)
+repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
+
+# GitLab CI environment does not give us any direct info about the
+# base for the user's branch. We thus need to figure out a common
+# ancestor between the user's branch and current git master.
+subprocess.check_call(["git", "remote", "add", "check-patch", repourl])
+subprocess.check_call(["git", "fetch", "check-patch", "master"],
+                      stdout=subprocess.DEVNULL,
+                      stderr=subprocess.DEVNULL)
+
+ancestor = subprocess.check_output(["git", "merge-base",
+                                    "check-patch/master", "HEAD"],
+                                   universal_newlines=True)
+
+ancestor = ancestor.strip()
+
+subprocess.check_call(["git", "remote", "rm", "check-patch"])
+
+errors = False
+
+print("\nChecking all commits since %s...\n" % ancestor)
+
+ret = subprocess.run(["scripts/checkpatch.pl", ancestor + "..."])
+
+if ret.returncode != 0:
+    print("    ❌ FAIL one or more commits failed scripts/checkpatch.pl")
+    sys.exit(1)
+
+sys.exit(0)
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 29e934fd53..f1e18d3e90 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -399,3 +399,15 @@ check-crypto-only-gnutls:
   variables:
     IMAGE: centos7
     MAKE_CHECK_ARGS: check
+
+
+check-patch:
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/centos8:latest
+  script: .gitlab-ci.d/check-patch.py
+  except:
+    variables:
+      - $CI_PROJECT_NAMESPACE == 'qemu-project' && $CI_COMMIT_BRANCH == 'master'
+  variables:
+    GIT_DEPTH: 1000
+  allow_failure: true
-- 
2.18.2


