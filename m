Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5502C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF4720867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfnORgKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF4720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRZU-0006l7-4D
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 17:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRY3-00055t-7D
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRXz-0006vz-06
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604529985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKfst5p/Yonp+OSkXV2uundvG0uzrAH2pf1hHzEsgM4=;
 b=hfnORgKAyH4OJodCb8yIDi4OolJSkvIMFZjbezGofU5VRyTlBfY9R50jf+X8o1e6M04y0Y
 J/CWgpH9aVPy/91AniuqggqJXJ2LetAhbMC4DCyQZ6LP/H4Li2RRoRgrIXxUC9Zjf3FKAb
 gjQJd96AVhr6V4ATgZ4QB1MTe1K5Qtw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293--0hy2ukrNsi9WKPRiZcSww-1; Wed, 04 Nov 2020 17:46:23 -0500
X-MC-Unique: -0hy2ukrNsi9WKPRiZcSww-1
Received: by mail-wr1-f70.google.com with SMTP id w1so18944wrr.5
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 14:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZKfst5p/Yonp+OSkXV2uundvG0uzrAH2pf1hHzEsgM4=;
 b=p4zdzl0/3j2aSnSRz2Z4IkVOBSyeANuI6NkGWc/sAGg0oLkju35X1H3dXxkda848l6
 9W5jHiY3DJl4hqQv/uxiTkDq1+f0UVadRtfjB/wnoarlUrDM51Il9pl1jRgUepNj6tBk
 5OLP417k6CtzK8uAh3BujTFNUU/KoUXKM+GiRUkMajrj/Fg9Myhm9m0hs7d67tKsXHSY
 6ivE8XVuJTevSpuIijxJMNJ6XGSm+xCh0pEhBVMiHX/X9bUlig8SX0+GA6qUDosbWrPn
 9vMuN8xDb72MCskOCtsFQJ72cBESyR3qYkZKlOv/tMorahxVtKZU8w1g45vsSmbpbAsc
 WHUw==
X-Gm-Message-State: AOAM531ZJvJL87h4E9YghIqlkJKE34DiiOpLXGQ1oZMEZVnU8f6DZoXB
 Rs5QQydpwStsAuU/omtJhytY10GIl8v5XI9AZcDsi7gyvv205HRWkqLpNqeeeUylYImCDwoNb3N
 Yi276RiteG9GcP5k=
X-Received: by 2002:adf:9d44:: with SMTP id o4mr237731wre.229.1604529982196;
 Wed, 04 Nov 2020 14:46:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLWgFBRsIxOORcIl8oGxoHMtQohAZNd6JQsf9KAYKSjAODunQq//FHmHWUQ5ouji8micahOg==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr237719wre.229.1604529982047;
 Wed, 04 Nov 2020 14:46:22 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y10sm4813357wru.94.2020.11.04.14.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 14:46:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/9] gitlab-ci: Replace YAML anchors by extends
 (acceptance_test_job)
Date: Wed,  4 Nov 2020 23:45:53 +0100
Message-Id: <20201104224558.3384595-5-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
 .gitlab-ci.yml | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 83beefa2c85..5c64e477c9d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -48,7 +48,8 @@ include:
     - find . -type f -exec touch {} +
     - make $MAKE_CHECK_ARGS
 
-.acceptance_template: &acceptance_definition
+.acceptance_test_job:
+  extends: .native_test_job
   cache:
     key: "${CI_JOB_NAME}-cache"
     paths:
@@ -95,14 +96,13 @@ check-system-ubuntu:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-ubuntu:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-ubuntu
       artifacts: true
   variables:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-system-debian:
   extends: .native_build_job
@@ -126,14 +126,13 @@ check-system-debian:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-debian:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-debian
       artifacts: true
   variables:
     IMAGE: debian-amd64
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-system-fedora:
   extends: .native_build_job
@@ -158,14 +157,13 @@ check-system-fedora:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-fedora:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-fedora
       artifacts: true
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-system-centos:
   extends: .native_build_job
@@ -190,14 +188,13 @@ check-system-centos:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-centos:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-centos
       artifacts: true
   variables:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-disabled:
   extends: .native_build_job
-- 
2.26.2


