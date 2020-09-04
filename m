Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C880C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CCA2064E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCKtF9T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CCA2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEpx-0001mG-20
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEEnv-0006g7-On
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEEnt-0000AH-Pk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599237788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afv68zSSKhrJyHAblKUIOTaNZ9p55vBWA5wqKbMlDZA=;
 b=JCKtF9T9CpQgZNJ9IDzFolfwP+KSj24uSkhjfD4Cy9x6OPy01OggBUGb3XfF3vrFZnpV9X
 jP6slLDgXKdPcFlcKHRWLXY4LCitQlbHnJzjz3dVOPoY70EaUuzDVF0HfdtSLSaMPhPcUA
 Q0RWFgVO1Wf8Jms5vqEaxKjiGjeXUvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-kVNvbccAMOe9hCLr8C2MxA-1; Fri, 04 Sep 2020 12:43:07 -0400
X-MC-Unique: kVNvbccAMOe9hCLr8C2MxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32EB780BCA1;
 Fri,  4 Sep 2020 16:43:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B49519C59;
 Fri,  4 Sep 2020 16:43:05 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/7] scripts/ci/gitlab-pipeline-status: improve message
 regarding timeout
Date: Fri,  4 Sep 2020 12:42:53 -0400
Message-Id: <20200904164258.240278-3-crosa@redhat.com>
In-Reply-To: <20200904164258.240278-1-crosa@redhat.com>
References: <20200904164258.240278-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 11:45:25
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
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The script has its own timeout, which is about how long the script
will wait (when called with --wait) for the pipeline to complete, and
not necessarily for the pipeline to complete.

Hopefully this will new wording will be clearer.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/ci/gitlab-pipeline-status | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 194dd4d0bb..2a36f74696 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -69,7 +69,10 @@ def wait_on_pipeline_success(timeout, interval,
     start = time.time()
     while True:
         if time.time() >= (start + timeout):
-            print("Waiting on the pipeline timed out")
+            msg = ("Timeout (-t/--timeout) of %i seconds reached, "
+                   "won't wait any longer for the pipeline to complete")
+            msg %= timeout
+            print(msg)
             return False
 
         status = get_pipeline_status(project_id, commit_sha)
-- 
2.25.4


