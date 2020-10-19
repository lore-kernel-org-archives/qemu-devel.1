Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C859C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F0E222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9UG1UpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F0E222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKNC-0006of-RG
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 21:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUKJe-0001fj-Gl
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 21:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUKJY-0001Ff-Hm
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 21:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603072219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27t77hnH3Ov0M62MYQ1su/k0+zUMdrC4ifQ4bD7cDRI=;
 b=e9UG1UpTq9GoJZ/Z8AvrSNpeZJg8zxa0vOjFInlUkb8zbNxsQsOp4Xg8faY44xJD+bVjVP
 MioWYs07f5FC4GNQeq2/1WThR3nOrB3plskNnLfKOSnY3WkzTerxHUhBW0W18JxXmUehGp
 UazwTwmvPpjRYbYAcqCes9B5hlitesA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-qYpS3yxQNzCa-p7WQT1Ekw-1; Sun, 18 Oct 2020 21:50:15 -0400
X-MC-Unique: qYpS3yxQNzCa-p7WQT1Ekw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22ECC1DDFF;
 Mon, 19 Oct 2020 01:50:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C295D6EF50;
 Mon, 19 Oct 2020 01:50:12 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 1/4] Jobs based on custom runners: documentation and
 configuration placeholder
Date: Sun, 18 Oct 2020 21:50:00 -0400
Message-Id: <20201019015003.1527746-2-crosa@redhat.com>
In-Reply-To: <20201019015003.1527746-1-crosa@redhat.com>
References: <20201019015003.1527746-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 21:50:19
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As described in the included documentation, the "custom runner" jobs
extend the GitLab CI jobs already in place.

Those jobs are intended to run on hardware and/or Operating Systems
not provided by GitLab's shared runners.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/custom-runners.yml | 14 +++++++++
 .gitlab-ci.yml                  |  1 +
 docs/devel/ci.rst               | 54 +++++++++++++++++++++++++++++++++
 docs/devel/index.rst            |  1 +
 4 files changed, 70 insertions(+)
 create mode 100644 .gitlab-ci.d/custom-runners.yml
 create mode 100644 docs/devel/ci.rst

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
new file mode 100644
index 0000000000..3004da2bda
--- /dev/null
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -0,0 +1,14 @@
+# The CI jobs defined here require GitLab runners installed and
+# registered on machines that match their operating system names,
+# versions and architectures.  This is in contrast to the other CI
+# jobs that are intended to run on GitLab's "shared" runners.
+
+# Different than the default approach on "shared" runners, based on
+# containers, the custom runners have no such *requirement*, as those
+# jobs should be capable of running on operating systems with no
+# compatible container implementation, or no support from
+# gitlab-runner.  To avoid problems that gitlab-runner can cause while
+# reusing the GIT repository, let's enable the recursive submodule
+# strategy.
+variables:
+  GIT_SUBMODULE_STRATEGY: recursive
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8ffd415ca5..b33c433fd7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,6 +18,7 @@ include:
   - local: '/.gitlab-ci.d/opensbi.yml'
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
+  - local: '/.gitlab-ci.d/custom-runners.yml'
 
 .native_build_job_template: &native_build_job_definition
   stage: build
diff --git a/docs/devel/ci.rst b/docs/devel/ci.rst
new file mode 100644
index 0000000000..41a4bbddad
--- /dev/null
+++ b/docs/devel/ci.rst
@@ -0,0 +1,54 @@
+==
+CI
+==
+
+QEMU has configurations enabled for a number of different CI services.
+The most up to date information about them and their status can be
+found at::
+
+   https://wiki.qemu.org/Testing/CI
+
+Jobs on Custom Runners
+======================
+
+Besides the jobs run under the various CI systems listed before, there
+are a number additional jobs that will run before an actual merge.
+These use the same GitLab CI's service/framework already used for all
+other GitLab based CI jobs, but rely on additional systems, not the
+ones provided by GitLab as "shared runners".
+
+The architecture of GitLab's CI service allows different machines to
+be set up with GitLab's "agent", called gitlab-runner, which will take
+care of running jobs created by events such as a push to a branch.
+Here, the combination of a machine, properly configured with GitLab's
+gitlab-runner, is called a "custom runner" here.
+
+The GitLab CI jobs definition for the custom runners are located under::
+
+  .gitlab-ci.d/custom-runners.yml
+
+Current Jobs
+------------
+
+The current CI jobs based on custom runners have the primary goal of
+catching and preventing regressions on a wider number of host systems
+than the ones provided by GitLab's shared runners.
+
+Also, the mechanics of reliability, capacity and overall maintanance
+of the machines provided by the QEMU project itself for those jobs
+will be evaluated.
+
+Future Plans and Jobs
+---------------------
+
+Once the CI Jobs based on custom runners have been proved mature with
+the initial set of jobs run on machines from the QEMU project, other
+members in the community should be able provide their own machine
+configuration documentation/scripts, and accompanying job definitions.
+
+As a general rule, those newly added contributed jobs should run as
+"non-gating", until their reliability is verified.
+
+The precise minimum requirements and exact rules for machine
+configuration documentation/scripts, and the success rate of jobs are
+still to be defined.
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 77baae5c77..2fdd36e751 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -21,6 +21,7 @@ Contents:
    atomics
    stable-process
    testing
+   ci
    qtest
    decodetree
    secure-coding-practices
-- 
2.25.4


