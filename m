Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2046C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D356206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNYqi7ZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D356206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGUr-0001pE-GC
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJGS2-0007YI-Pt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJGRz-0002TW-MH
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600435758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNk3faC8kc7Le9bXtWKm3igpLtEky47pmixLCfruOtA=;
 b=BNYqi7ZFtobfBAaie+Y0Hll68LVtYSFF9spUg021qJYXkx7e2uQdm7Ee/GEa4z/blcVsTy
 lr8Sni6+oyjkF2FH8DpAyVFyCVBGBrNgpbCN/5IKt8ZR1YaUmSLQHRf7rZ6gZR71TdCYQq
 x+bd99SPiY67ukcD4NYTp2BHhJbx0lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-_caV-DlRPWKdSJ4C-B9zPA-1; Fri, 18 Sep 2020 09:29:14 -0400
X-MC-Unique: _caV-DlRPWKdSJ4C-B9zPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA92C1966324;
 Fri, 18 Sep 2020 13:29:13 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-199.ams2.redhat.com
 [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01F8F9CBA;
 Fri, 18 Sep 2020 13:29:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] gitlab: add a CI job to validate the DCO sign off
Date: Fri, 18 Sep 2020 14:29:02 +0100
Message-Id: <20200918132903.1848939-3-berrange@redhat.com>
In-Reply-To: <20200918132903.1848939-1-berrange@redhat.com>
References: <20200918132903.1848939-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While checkpatch.pl can validate DCO sign off that job must always be
advisory only since it is expected that certain patches will fail some
code style rules.

We require the DCO sign off to be mandatory for all commits though, so
it benefits from being validated in a standalone job.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/check-dco.py | 94 +++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml            | 10 +++++
 2 files changed, 104 insertions(+)
 create mode 100755 .gitlab-ci.d/check-dco.py

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
new file mode 100755
index 0000000000..632c8bcce8
--- /dev/null
+++ b/.gitlab-ci.d/check-dco.py
@@ -0,0 +1,94 @@
+#!/usr/bin/env python3
+#
+# check-dco.py: validate all commits are signed off
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
+subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
+subprocess.check_call(["git", "fetch", "check-dco", "master"],
+                      stdout=subprocess.DEVNULL,
+                      stderr=subprocess.DEVNULL)
+
+ancestor = subprocess.check_output(["git", "merge-base",
+                                    "check-dco/master", "HEAD"],
+                                   universal_newlines=True)
+
+ancestor = ancestor.strip()
+
+subprocess.check_call(["git", "remote", "rm", "check-dco"])
+
+errors = False
+
+print("\nChecking for 'Signed-off-by: NAME <EMAIL>' " +
+      "on all commits since %s...\n" % ancestor)
+
+log = subprocess.check_output(["git", "log", "--format=%H %s",
+                               ancestor + "..."],
+                              universal_newlines=True)
+
+if log == "":
+    commits = []
+else:
+    commits = [[c[0:40], c[41:]] for c in log.strip().split("\n")]
+
+for sha, subject in commits:
+
+    msg = subprocess.check_output(["git", "show", "-s", sha],
+                                  universal_newlines=True)
+    lines = msg.strip().split("\n")
+
+    print("🔍 %s %s" % (sha, subject))
+    sob = False
+    for line in lines:
+        if "Signed-off-by:" in line:
+            sob = True
+            if "localhost" in line:
+                print("    ❌ FAIL: bad email in %s" % line)
+                errors = True
+
+    if not sob:
+        print("    ❌ FAIL missing Signed-off-by tag")
+        errors = True
+
+if errors:
+    print("""
+
+❌ ERROR: One or more commits are missing a valid Signed-off-By tag.
+
+
+This project requires all contributors to assert that their contributions
+are provided in compliance with the terms of the Developer's Certificate
+of Origin 1.1 (DCO):
+
+  https://developercertificate.org/
+
+To indicate acceptance of the DCO every commit must have a tag
+
+  Signed-off-by: REAL NAME <EMAIL>
+
+This can be achieved by passing the "-s" flag to the "git commit" command.
+
+To bulk update all commits on current branch "git rebase" can be used:
+
+  git rebase -i master -x 'git commit --amend --no-edit -s'
+
+""")
+
+    sys.exit(1)
+
+sys.exit(0)
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3ed724c720..b672f4ff23 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -381,3 +381,13 @@ check-patch:
   variables:
     GIT_DEPTH: 1000
   allow_failure: true
+
+check-dco:
+  stage: test
+  image: $CI_REGISTRY_IMAGE/qemu/centos8:latest
+  script: .gitlab-ci.d/check-dco.py
+  except:
+    variables:
+      - $CI_PROJECT_NAMESPACE == 'qemu-project' && $CI_COMMIT_BRANCH == 'master'
+  variables:
+    GIT_DEPTH: 1000
-- 
2.26.2


