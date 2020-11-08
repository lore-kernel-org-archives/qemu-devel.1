Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6ABC5517A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EC4206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMSo9Kdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EC4206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrgz-0003UC-RI
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbr-0005hV-9L
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbp-0000Zw-Jp
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JaO3dtFj5WhHKtEHsZu2VQNZlyIz3aXfJ70aU8Z8ugU=;
 b=FMSo9KduK12oOyn0FMV19Wve2+3gMAyPw6N4B5ByRAI3cAjoYvSkjoKLPvyrcVTvOKHwpt
 pC+tfvkZ3EVyNR+uSx+vq7h3r+sTb/AP0qTR9Qie6qqjvryZ5VoyC2xAphPjdI1GbmP43z
 vGP9C4mb1CAvLgilHO2W0zGBeyRXbkk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-lebsaV-_P7WD9WUqpnz2yA-1; Sun, 08 Nov 2020 15:48:16 -0500
X-MC-Unique: lebsaV-_P7WD9WUqpnz2yA-1
Received: by mail-wr1-f69.google.com with SMTP id x16so3366697wrg.7
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JaO3dtFj5WhHKtEHsZu2VQNZlyIz3aXfJ70aU8Z8ugU=;
 b=ktRY9EKHq2eMTuwF4g/9ji9DNpuCzj0tpEwEXOWjNWmHOUui82l8wENYT7184T+zNU
 EWluqhWHWJJ4sxuV602lhsK2Mjw8iTYC52FoVKQPpyHSttIUtmkj3Ud19Q+YD2Lj3Uqi
 BohVKC4KekqkJnQI16w1olAe3Rx8WjLP2D9qh9CgKcznLCSXvbSkRYaJwbpqTJVjOY6Y
 kribjt0Nx8Jld47F4+h8y7ZkDckA+/ZA0Ccatnf40xenSfsRDgu025nrL5HyQUJYrDGU
 4Cr2hWYw1zhiRTJg9TFIYcSzXlVeJrSGsveEEW5wV34l5Mwa/mjkgv2OvjU/gZFlKpQa
 k1Iw==
X-Gm-Message-State: AOAM531v3RGuuDR/uu3u+rM3ZAICjoErg1PU8yNR+X/supPTt2Su+0Ki
 6lUJl53xC9MqILtu9xjksQLn/kC/8lmXgi3eKm7l4xj0TE9U6jGyF3UE1YUOwNWjySN8ExtlkBS
 WtPLJCQbfBdEsN1M=
X-Received: by 2002:adf:dc4c:: with SMTP id m12mr14577108wrj.177.1604868495166; 
 Sun, 08 Nov 2020 12:48:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznq1KGLX1Fjb9gaA2+nc6mWhBkui9o+7ISQgnfxHqJ/igupLFrf03tBjTb6p55sq27Y5Ymbg==
X-Received: by 2002:adf:dc4c:: with SMTP id m12mr14577088wrj.177.1604868494995; 
 Sun, 08 Nov 2020 12:48:14 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n9sm10582699wmd.4.2020.11.08.12.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:48:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 15/17] gitlab-ci: Add test for Xen (on CentOS 7)
Date: Sun,  8 Nov 2020 21:45:33 +0100
Message-Id: <20201108204535.2319870-16-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
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
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 xen-devel@lists.xenproject.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen packages are available in CentOS 7, but have been
removed from CentOS 8. Use the CentOS 7 container.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org
---
 .gitlab-ci.yml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2f0da7b3dc1..8e15266c277 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -557,6 +557,27 @@ check-crypto-only-gnutls:
     IMAGE: centos7
     MAKE_CHECK_ARGS: check
 
+build-xen-centos:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: centos7
+    TARGETS: i386-softmmu x86_64-softmmu
+    CONFIGURE_ARGS: --enable-xen
+    MAKE_CHECK_ARGS: check-build
+  artifacts:
+    paths:
+      - build
+
+check-xen-centos:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-xen-centos
+      artifacts: true
+  variables:
+    IMAGE: centos7
+    MAKE_CHECK_ARGS: check
+
+
 # We don't need to exercise every backend with every front-end
 build-trace-multi-user:
   <<: *native_build_job_definition
-- 
2.26.2


