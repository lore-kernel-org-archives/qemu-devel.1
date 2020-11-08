Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B08C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D675F206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUVjnfwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D675F206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbri2-0004pu-UA
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbN-0004qA-Mv
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbM-0000Xa-2k
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsWvNuNlNc6qFAcSqa9+ZF81I8Pph+t7fiqCtIRjtMk=;
 b=hUVjnfwGSFU+77GdBOJ/hg/dYJRd8CZ5WBwxGwYZ57L7uRbwIIrFBGt+sO/m7deUUAkP09
 xd2DsS7hTeCcPFQPfk8KP9n++TxYlrXUDofyqWwYtHGU9uFODfJ/+kUPdFk/hI/L2aOpj/
 x8ov6CK9oJECjeJZkfqWamLxRz77SVM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-WI0eFmTsO8iFafD8MVh_Uw-1; Sun, 08 Nov 2020 15:47:50 -0500
X-MC-Unique: WI0eFmTsO8iFafD8MVh_Uw-1
Received: by mail-wr1-f71.google.com with SMTP id i1so3367559wrb.18
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NsWvNuNlNc6qFAcSqa9+ZF81I8Pph+t7fiqCtIRjtMk=;
 b=D7ljUt9kIvC7lcP9J5mdogXa4dCGJugQE2/oyMqY/LWMZEGvP+GJN2I/99BWGele3a
 rWzKBpeLINOalGm17QL1LI2eKRUKEVpOsJmWgJvT69Qj00Bn3L6CFkvS+xVinvj2OwHw
 0hHtLb7fEaPt7ucXBN6KQ0iib25qv64eCIh2mwpmygNKQrmUoqmAWoqhZ7Nh6jEA37xM
 ZiBJ/eVR+HwfF82J6F3EbbGMO/dIPyGaveO1MK+soIE6cte/R7Ke7pxVJGC2h7+j0+a/
 q3EgZtKvk1C3cXKrFVnb8K7pzqGKLx0uN3+L87b4fSAdDBP+KKE9/dtE371V3gtFjxR6
 h6rw==
X-Gm-Message-State: AOAM533y0rxgx1rd2G/hF/nVlc8RUn4CT2nKV2vfi4lrrrSCP+Zoftg+
 xAlqbWlizQkWx4I+cutaOj+WQijmBwOpBXfqC/atuR0FbN4Ucdw01boO99iLNAdLh0cddcsYgSa
 Zh3V20XYVHcf2wgU=
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr825011wrt.38.1604868468691;
 Sun, 08 Nov 2020 12:47:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJ6+MW5RBv14BDIiP1h/yp58+GR7SaNw/0j+piYflGn11yMWn624dSjn2HxmudilxeSQC9Bw==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr824988wrt.38.1604868468524;
 Sun, 08 Nov 2020 12:47:48 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m21sm11383756wmi.3.2020.11.08.12.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 10/17] gitlab-ci: Move user-static test across to
 gitlab
Date: Sun,  8 Nov 2020 21:45:28 +0100
Message-Id: <20201108204535.2319870-11-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 8cdb2cef3f1, move the user-static test to GitLab.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
---
 .gitlab-ci.yml | 7 +++++++
 .travis.yml    | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d1583cee5db..a91870cf85e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -311,6 +311,13 @@ build-user-debug:
     CONFIGURE_ARGS: --disable-tools --disable-system --enable-debug-tcg
     MAKE_CHECK_ARGS: check-tcg
 
+build-user-static:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system --static
+    MAKE_CHECK_ARGS: check-tcg
+
 # Run check-tcg against linux-user (with plugins)
 # we skip sparc64-linux-user until it has been fixed somewhat
 # we skip cris-linux-user as it doesn't use the common run loop
diff --git a/.travis.yml b/.travis.yml
index 6087e2909cd..5fb69c5fb02 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -119,11 +119,6 @@ after_script:
 
 jobs:
   include:
-    - name: "GCC static (user)"
-      env:
-        - CONFIG="--disable-system --static"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-
     # Just build tools and run minimal unit and softfloat checks
     - name: "GCC check-unit and check-softfloat"
       env:
-- 
2.26.2


