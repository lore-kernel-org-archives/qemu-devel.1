Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C9C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A752080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlRn8gM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A752080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRZT-0006iq-AL
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 17:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRXx-00053R-HP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRXp-0006vU-RB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604529979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCN6dfpZymVLf09y3AxbAjVnHuY6KWlk5zsogr0z+5M=;
 b=dlRn8gM6eJ2IAo/jHuZplyPA60of2suW40k03LyVY5kWxCNlg8qJRFfw1A7VxhAnUFSrIY
 yDorFNagdewhmQd2nlSwQTqpkieeD1AMkE7yzWOwnU4wWNVyrfrpm2Umd0di6rWOUDF7Zf
 n1YYK5FEe/Jg6MLsvBItCQgkg6+4x9M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-6eZ1a5yvNAa0HmNrC8xEJQ-1; Wed, 04 Nov 2020 17:46:18 -0500
X-MC-Unique: 6eZ1a5yvNAa0HmNrC8xEJQ-1
Received: by mail-wm1-f70.google.com with SMTP id u207so1809178wmu.4
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 14:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PCN6dfpZymVLf09y3AxbAjVnHuY6KWlk5zsogr0z+5M=;
 b=fRtYfyn7vaCxZs1sLF2OqTzYPhGXBBllWu5RG37NraVD7BXc93NkWkQ+SmoB4nK2IL
 mdqzoRW0LJSbnVCFsGjihiEFx1+xFyl1ew4TvAv06H983WKuCD+AsTG9O+tkln/op5Us
 7DilZFgO7jqKVcrXOvzESkc1cqEzUjFmL+KJoeJWW8FFE+dbDznmtj/OVn4kfgGXs5Jm
 d2HPZ6OZ0xgr9QjZpEqIztjdOmJznb39b4q3gonhSqZ6DqzKFHuv1JKpJUVvUJPfXOfH
 1rTQ9oRaPidf8YTva5zkl+fdfvSSABZGFmWhJIvEDxgcsQw9MWCrxiwwWODRBn+HPSAV
 hiDw==
X-Gm-Message-State: AOAM531bmWSG+D/tQCBy6r8/M+PoGp0OZk8SbmBTZcph3VppJI9XyEjS
 GGhFQzZM0ij4MVwOQYGFnSlQvPEd7u16WgviyjBxe2Uyjj9Se1wEOTrw17PBWFsVLNKCQidVmHb
 L3qQO23ArqiFYqcs=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr290250wrn.56.1604529976679;
 Wed, 04 Nov 2020 14:46:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQDxcp6PICXbfuovv6Dl9od1DCN1BfOTrENibDvKE0fFbxw1qSS8+S67r0rDJpGKalyPZ4dA==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr290238wrn.56.1604529976532;
 Wed, 04 Nov 2020 14:46:16 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h7sm5214396wrt.45.2020.11.04.14.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 14:46:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/9] gitlab-ci: Replace YAML anchors by extends
 (native_test_job)
Date: Wed,  4 Nov 2020 23:45:52 +0100
Message-Id: <20201104224558.3384595-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104224558.3384595-1-philmd@redhat.com>
References: <20201104224558.3384595-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'extends' is an alternative to using YAML anchors
and is a little more flexible and readable. See:
https://docs.gitlab.com/ee/ci/yaml/#extends

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ff3a8bd58cf..83beefa2c85 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -40,7 +40,7 @@ include:
         make -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
 
-.native_test_job_template: &native_test_job_definition
+.native_test_job:
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   script:
@@ -86,7 +86,7 @@ build-system-ubuntu:
       - build
 
 check-system-ubuntu:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-ubuntu
       artifacts: true
@@ -95,7 +95,7 @@ check-system-ubuntu:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-ubuntu:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-ubuntu
       artifacts: true
@@ -117,7 +117,7 @@ build-system-debian:
       - build
 
 check-system-debian:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-debian
       artifacts: true
@@ -126,7 +126,7 @@ check-system-debian:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-debian:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-debian
       artifacts: true
@@ -149,7 +149,7 @@ build-system-fedora:
       - build
 
 check-system-fedora:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-fedora
       artifacts: true
@@ -158,7 +158,7 @@ check-system-fedora:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-fedora:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-fedora
       artifacts: true
@@ -181,7 +181,7 @@ build-system-centos:
       - build
 
 check-system-centos:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-centos
       artifacts: true
@@ -190,7 +190,7 @@ check-system-centos:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-centos:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-centos
       artifacts: true
@@ -288,7 +288,7 @@ build-deprecated:
 # We split the check-tcg step as test failures are expected but we still
 # want to catch the build breaking.
 check-deprecated:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-deprecated
       artifacts: true
@@ -352,7 +352,7 @@ build-crypto-old-nettle:
       - build
 
 check-crypto-old-nettle:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-crypto-old-nettle
       artifacts: true
@@ -373,7 +373,7 @@ build-crypto-old-gcrypt:
       - build
 
 check-crypto-old-gcrypt:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-crypto-old-gcrypt
       artifacts: true
@@ -394,7 +394,7 @@ build-crypto-only-gnutls:
       - build
 
 check-crypto-only-gnutls:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-crypto-only-gnutls
       artifacts: true
-- 
2.26.2


