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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4852C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234D820659
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4FMAkr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234D820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSI9H-00019p-Q6
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyd-0005hX-6Y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyb-0006H7-9q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvajP5P6yzQbC/lgdgE1RKW8daMH1hnjxrCK+4ocFWk=;
 b=c4FMAkr7qbZYap6lPCCyFi8sm22hTfalDnIK4DnMC/ef8AOYW6QLjPaVoJUDdldg43TfFP
 IX7eDuGw1vD6n1+oe0Ko4xHl9NuVmRK9etw52dITsqBl9nue9F6TyszNpDPWaBMFtg5yaC
 Uqb8CSsINt+0MdmAsN4K44E8ZM82AiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-2qnEo6UePfmaRWPiGDLMjw-1; Tue, 13 Oct 2020 06:56:14 -0400
X-MC-Unique: 2qnEo6UePfmaRWPiGDLMjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E99618829D3;
 Tue, 13 Oct 2020 10:56:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29A0E6EF41;
 Tue, 13 Oct 2020 10:56:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/23] scripts/ci/gitlab-pipeline-status: make branch name
 configurable
Date: Tue, 13 Oct 2020 12:55:21 +0200
Message-Id: <20201013105527.20088-18-thuth@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

With the utility function `get_local_staging_branch_commit()`, the
name of the branch is hard coded (including in the function name).

For extensibility reasons, let's make that configurable.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200904164258.240278-2-crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/ci/gitlab-pipeline-status | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 348a49b6a4..194dd4d0bb 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -23,20 +23,20 @@ import time
 import sys
 
 
-def get_local_staging_branch_commit():
+def get_local_branch_commit(branch='staging'):
     """
     Returns the commit sha1 for the *local* branch named "staging"
     """
-    result = subprocess.run(['git', 'rev-parse', 'staging'],
+    result = subprocess.run(['git', 'rev-parse', branch],
                             stdin=subprocess.DEVNULL,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.DEVNULL,
                             cwd=os.path.dirname(__file__),
                             universal_newlines=True).stdout.strip()
-    if result == 'staging':
-        raise ValueError("There's no local branch named 'staging'")
+    if result == branch:
+        raise ValueError("There's no local branch named '%s'" % branch)
     if len(result) != 40:
-        raise ValueError("Branch staging HEAD doesn't look like a sha1")
+        raise ValueError("Branch '%s' HEAD doesn't look like a sha1" % branch)
     return result
 
 
@@ -110,7 +110,7 @@ def main():
                               'for https://gitlab.com/qemu-project/qemu, that '
                               'is, "%(default)s"'))
     try:
-        default_commit = get_local_staging_branch_commit()
+        default_commit = get_local_branch_commit()
         commit_required = False
     except ValueError:
         default_commit = ''
-- 
2.18.2


