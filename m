Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BEC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1F5206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaMnIKp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1F5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaj0m-00067K-5N
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairr-0004L3-Kp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairm-0000JM-Tu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mtvwmDQbHZS+o/2u9r9g/ECxc+lEAZnhg4b7CvVWbM=;
 b=EaMnIKp7y/sYRWiVENxZf+e5IwFiwACtMwSFzK958k7BrVLMwqXxYvOPsITwrYjdjr6gR8
 WRkjDpgIckctbqYEvjpKDC6TAx+zgjfAUwhUHwhuxKl8SyYaYuE0jejTS6Hu6Vl7S8CB4F
 5UBvDPBofwTIu6BJk6t2Kqr2L0C7YwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-KWydajFtM0yyjBC9LdSnmA-1; Thu, 05 Nov 2020 12:16:02 -0500
X-MC-Unique: KWydajFtM0yyjBC9LdSnmA-1
Received: by mail-wm1-f71.google.com with SMTP id g3so154853wmh.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9mtvwmDQbHZS+o/2u9r9g/ECxc+lEAZnhg4b7CvVWbM=;
 b=PzQHpNB92xVks89eUx4qFNlCJ5mbJYfuADhCsRZEJpqziLJpJN+thJ9SR8Llco6hbl
 YSDOOCiIWlQdJrX8WlVbIh/J9MWMDMZcR8KhlGmRQjdzgKiqPK2VDWz1lgtS0G9Tias2
 +k2uvKLwlRwoUXuTfSO2kgtRAQKd4jFpsGCJm0y9ozJVmOVx2u2tamf1NoWvZdWkyvoC
 51f783Yyu5MKSNBZL5uHxFfSZkviPp/f18K0s+RzHLA2Q3zFDT/+WdPD7PqLHs/9KyR+
 MokBiF63nP3eIO3QjGJcHraUYU6x1X+si+ZLRQvnXoJySwmcyX3bvoanOiXorMCCiMsz
 Iulg==
X-Gm-Message-State: AOAM532a88Ijo+5by2Uy2TKm5Tl+BVyQTcPanLOnC1XlFS5T/u5Oae1B
 tR+CO20ltzvnKZB2w6SztwNEZvxVF8RSaBG4pGBHUIj2BqdpVJJugnkSVl4au8zIaZOVvS8z8Pv
 GtpXYNFbgLePdFJ0=
X-Received: by 2002:a5d:5106:: with SMTP id s6mr4074326wrt.51.1604596560332;
 Thu, 05 Nov 2020 09:16:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkj4o2RlCPfQ5kGW0tOz5vV026RPPnMop4BY65acEM1tm/pEbwE3duVGM1gny7KHrh7HvnMw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr4074301wrt.51.1604596560134;
 Thu, 05 Nov 2020 09:16:00 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id j127sm3449898wma.31.2020.11.05.09.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:15:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 06/11] gitlab-ci: Rename acceptance_test_job ->
 integration_test_job
Date: Thu,  5 Nov 2020 18:15:21 +0100
Message-Id: <20201105171526.3763499-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105171526.3763499-1-philmd@redhat.com>
References: <20201105171526.3763499-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0ef814764a0..d4526323169 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,7 +42,7 @@ include:
     - find . -type f -exec touch {} +
     - make $MAKE_CHECK_ARGS
 
-.acceptance_test_job:
+.integration_test_job:
   extends: .native_test_job
   cache:
     key: "${CI_JOB_NAME}-cache"
@@ -89,8 +89,8 @@ check-system-ubuntu:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check
 
-acceptance-system-ubuntu:
-  extends: .acceptance_test_job
+integration-system-ubuntu:
+  extends: .integration_test_job
   needs:
     - job: build-system-ubuntu
       artifacts: true
@@ -119,8 +119,8 @@ check-system-debian:
     IMAGE: debian-amd64
     MAKE_CHECK_ARGS: check
 
-acceptance-system-debian:
-  extends: .acceptance_test_job
+integration-system-debian:
+  extends: .integration_test_job
   needs:
     - job: build-system-debian
       artifacts: true
@@ -150,8 +150,8 @@ check-system-fedora:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
-acceptance-system-fedora:
-  extends: .acceptance_test_job
+integration-system-fedora:
+  extends: .integration_test_job
   needs:
     - job: build-system-fedora
       artifacts: true
@@ -181,8 +181,8 @@ check-system-centos:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check
 
-acceptance-system-centos:
-  extends: .acceptance_test_job
+integration-system-centos:
+  extends: .integration_test_job
   needs:
     - job: build-system-centos
       artifacts: true
-- 
2.26.2


