Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C81DC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97362064E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJaT1YQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97362064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEtQ-0004tS-1x
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEEo1-0006jp-I0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:43:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEEnz-0000BZ-Rr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599237795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHHf3/LDAtbo5xhGvAYZ98cUty3t4ZOTgFXkNR2xX2g=;
 b=iJaT1YQ1LS/Wc4cSuKEVAeZrXpbXcM7f5KfOevR+KwA3d9zuitqVj881wDani+hxPqgIfM
 +8qJepdXi+Hwm2LktQZx2pmzhuv8zvPehNcCdIMowa81p3kqPfL6vmVO9i4N/JPcfNohO4
 QS5wCgQ9l190KGobyPyIrISc59NQJMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-aIOyD_UsNhS50HbIP2RRaQ-1; Fri, 04 Sep 2020 12:43:13 -0400
X-MC-Unique: aIOyD_UsNhS50HbIP2RRaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 942B81074650;
 Fri,  4 Sep 2020 16:43:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A4F319C59;
 Fri,  4 Sep 2020 16:43:11 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 7/7] scripts/ci/gitlab-pipeline-status: wait for pipeline
 creation
Date: Fri,  4 Sep 2020 12:42:58 -0400
Message-Id: <20200904164258.240278-8-crosa@redhat.com>
In-Reply-To: <20200904164258.240278-1-crosa@redhat.com>
References: <20200904164258.240278-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When called in wait mode, this script will also wait for the pipeline
to be get to a "running" state.  Because many more status may be seen
until a pipeline gets to "running", and those need to be handle too.

Reference: https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/ci/gitlab-pipeline-status | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 628150ce0b..bac8233079 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -83,13 +83,22 @@ def wait_on_pipeline_success(timeout, interval,
             print(msg)
             return False
 
-        status = get_pipeline_status(project_id, commit_sha)
-        if status['status'] == 'running':
-            print('running...')
+        try:
+            status = get_pipeline_status(project_id, commit_sha)
+        except NoPipelineFound:
+            print('Pipeline has not been found, it may not have been created yet.')
+            time.sleep(1)
+            continue
+
+        pipeline_status = status['status']
+        status_to_wait = ('created', 'waiting_for_resource', 'preparing',
+                          'pending', 'running')
+        if pipeline_status in status_to_wait:
+            print('%s...' % pipeline_status)
             time.sleep(interval)
             continue
 
-        if status['status'] == 'success':
+        if pipeline_status == 'success':
             return True
 
         msg = "Pipeline failed, check: %s" % status['web_url']
-- 
2.25.4


