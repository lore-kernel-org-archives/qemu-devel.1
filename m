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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5DC214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfMvSKJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5DC214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIFn-0001AA-VC
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyn-000689-NA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyl-0006JV-U8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=jUIawBEj1Lmb/4jvELEB+YSoX2I3nz60nPfKSGDF8qg=;
 b=NfMvSKJgk3+rnv5SbYqMHj0Ck/jH26bGAcWlT/Nr0fJuLNNdOwulNT0wAJ5cfsuMwUC9nk
 MWFYp/dQHNcGprQiIk78lo2z7FHymjNUtZMxlIZxXxehx6uXchtMRTMtoMW4E6oQtE8yUl
 a+WbtfvRYa+u23VdiYtTheM/wphpj8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-9JhGlLtOML2nHCrkemQJVA-1; Tue, 13 Oct 2020 06:56:23 -0400
X-MC-Unique: 9JhGlLtOML2nHCrkemQJVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4065A1074654;
 Tue, 13 Oct 2020 10:56:22 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3EE96EF59;
 Tue, 13 Oct 2020 10:56:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/23] scripts/ci/gitlab-pipeline-status: use more descriptive
 exceptions
Date: Tue, 13 Oct 2020 12:55:26 +0200
Message-Id: <20201013105527.20088-23-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
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

For two very different error conditions.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200904164258.240278-7-crosa@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/ci/gitlab-pipeline-status | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index ced488f27c..628150ce0b 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -23,6 +23,14 @@ import time
 import sys
 
 
+class CommunicationFailure(Exception):
+    """Failed to communicate to gitlab.com APIs."""
+
+
+class NoPipelineFound(Exception):
+    """Communication is successfull but pipeline is not found."""
+
+
 def get_local_branch_commit(branch='staging'):
     """
     Returns the commit sha1 for the *local* branch named "staging"
@@ -50,14 +58,14 @@ def get_pipeline_status(project_id, commit_sha1):
     connection.request('GET', url=url)
     response = connection.getresponse()
     if response.code != http.HTTPStatus.OK:
-        raise ValueError("Failed to receive a successful response")
+        raise CommunicationFailure("Failed to receive a successful response")
     json_response = json.loads(response.read())
 
     # As far as I can tell, there should be only one pipeline for the same
     # project + commit. If this assumption is false, we can add further
     # filters to the url, such as username, and order_by.
     if not json_response:
-        raise ValueError("No pipeline found")
+        raise NoPipelineFound("No pipeline found")
     return json_response[0]
 
 
-- 
2.18.2


