Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5624BC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC9921D40
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haDpBEcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC9921D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZZdM-00085J-OQ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZZai-0004Mi-Ax
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZZag-0003Ln-GF
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604322581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xy2HRjSSA05hef6gIxAcCqdg0PtsNzO75QaSgj9hCZQ=;
 b=haDpBEcnPL3zf/I/GDTH0S0ZSAI5haLDctldTkxK7ugcPCspAHDzHXXWWhjZ9PgqYIrxa1
 oYAtfJtunUs6Cc+nQ6l3Cp4nVGd2+Yz9xDIRaNGpUw3ioSXaI5lUH66abAR75MyV7e22Pf
 m04MwhVdGL5UeOOBOEmmJREieFTYKHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-oy2SrOtlODOIpzKwZKyguA-1; Mon, 02 Nov 2020 08:09:37 -0500
X-MC-Unique: oy2SrOtlODOIpzKwZKyguA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AF451074655;
 Mon,  2 Nov 2020 13:09:36 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B3A9109F1B9;
 Mon,  2 Nov 2020 13:09:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] gitlab: publish the docs built during CI
Date: Mon,  2 Nov 2020 13:09:23 +0000
Message-Id: <20201102130926.161183-2-berrange@redhat.com>
In-Reply-To: <20201102130926.161183-1-berrange@redhat.com>
References: <20201102130926.161183-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of the build jobs will create the sphinx documentation. If we
expose this as an artifact of a "pages" job in a "public" directory, it
will get published using GitLab Pages. This means a user can push a
branch with docs changes to GitLab and view the results at

  https://yourusername.gitlab.io/qemu/

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b15ae5c30..a41725d6f7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -423,3 +423,17 @@ check-dco:
       - $CI_PROJECT_NAMESPACE == 'qemu-project' && $CI_COMMIT_BRANCH == 'master'
   variables:
     GIT_DEPTH: 1000
+
+pages:
+  image: $CI_REGISTRY_IMAGE/qemu/ubuntu2004:latest
+  stage: test
+  needs:
+    - job: build-system-ubuntu
+      artifacts: true
+  script:
+    - mkdir public
+    - mv build/docs/index.html public/
+    - for i in devel interop specs system tools user ; do mv build/docs/$i public/ ; done
+  artifacts:
+    paths:
+      - public
-- 
2.28.0


