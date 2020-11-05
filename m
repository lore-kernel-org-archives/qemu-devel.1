Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DE5C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23632072E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8PO/ueQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23632072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaj2T-0000Mn-Mn
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairt-0004LD-Gh
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairr-0000Jk-DX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+24Qtjsem3z7nn8q0n3COy79qpz54BrkmBsMuZl5LU=;
 b=e8PO/ueQr0gwJnMgykB+yF+neCMBWbAXVcq+dQwsH8RyrL/5Aw+26+J9gNqVO/pKshBVEI
 KkR27b6OKSz0W4w+udwWqFTyEfu078sv1YZQ0NZYmxNdQ1RHxxyYNGldk5fDf7/UkoESnH
 froe4MytEtmTYMa2vU8uaVQE3rK1YpM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-Ei5c-gCOOfCB6_4ZLQHlsQ-1; Thu, 05 Nov 2020 12:16:06 -0500
X-MC-Unique: Ei5c-gCOOfCB6_4ZLQHlsQ-1
Received: by mail-wm1-f70.google.com with SMTP id t21so612240wmt.8
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r+24Qtjsem3z7nn8q0n3COy79qpz54BrkmBsMuZl5LU=;
 b=Ljuk+onGarSMe5PuL7YLj8qdd9MdZLGrQoeSCB+6E+bVEiJkCDuetWHvr42rJfv0ae
 QVaAstdzW/zU49kyv7zgOn5tWW/+gzxXt1hJNkcQ66qzM1GZXR69MPNt0/mnaJqcD2kD
 rXZ+N0nAHigWz0c1b9ry2PBESU35XUvM0cNXXe5pptw2MBupuEX92Z5FdpFuJeWH5efk
 GwfEany5wrVJDxal36YW+LhJ6ymj9mpH9Ua+3YXqDpLuAxc3Rq3QzVauNoypokwLFmZI
 nPdMYgPJcrA4Kwxqdrrt5agdfLEDDgiMz40le1BHjTHfi+/detUd7K3Ei052QgAqteXF
 zsKQ==
X-Gm-Message-State: AOAM530Mem/i/qMI2BWoD+aJKl7GEAmOpwFZr+RQj6HUR0sxnKQT9IkB
 sUkrh7Cn+Jp1iA8ol1oMXcAjN4duMraPsQmNk8VBrFBtpqm+qcIvZOturKynxh+VzfabCwYkAsd
 58vqWYMWFM2+d+nE=
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr3762461wma.158.1604596565266; 
 Thu, 05 Nov 2020 09:16:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDbHlVX67fHTCNN0lVfK9Ga/07LUoaPVRCcZBAJhtrvvGg57+HA2b5J4CvIN80p1tOKC6rvg==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr3762444wma.158.1604596565144; 
 Thu, 05 Nov 2020 09:16:05 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y200sm3841700wmc.23.2020.11.05.09.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:16:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 07/11] gitlab-ci: Extract common job definition as
 'cross_common_job'
Date: Thu,  5 Nov 2020 18:15:22 +0100
Message-Id: <20201105171526.3763499-8-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the common definitions shared by '.cross_system_build_job'
and '.cross_user_build_job' to '.cross_common_job'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.d/crossbuilds.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 099949aaef3..701550f028c 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,7 +1,9 @@
-
-.cross_system_build_job:
+.cross_common_job:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+
+.cross_system_build_job:
+  extends: .cross_common_job
   timeout: 80m
   script:
     - mkdir build
@@ -14,8 +16,7 @@
     - make -j$(expr $(nproc) + 1) all check-build
 
 .cross_user_build_job:
-  stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  extends: .cross_common_job
   script:
     - mkdir build
     - cd build
-- 
2.26.2


