Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9829C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 21:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E1A206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 21:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5ow46BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrna-0001f0-8k
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 16:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbj-0005Q8-Lg
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbh-0000Za-OL
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWMQsAvtqC0WE8v0M1RNJ2U+39lhWWyJUeSsL34QAK8=;
 b=K5ow46BEeqvxx0rWEiYoXgeJGS9He4SwUNfOzfcgBeC/uu9Um7GzaE3J8RBGXPQLY0EAW1
 WEPb5pHK0jfItoQ7STjmXed1i2pFZz0iRwvz0PLkVuKRdtJbUDrB6vRzaIr/DVUGQ+8HSL
 8bXmQGhzOeToMN1AbgsaUrqr7rIhxQc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-kN5Ae5iMO9ybiWyUvmuh6w-1; Sun, 08 Nov 2020 15:48:11 -0500
X-MC-Unique: kN5Ae5iMO9ybiWyUvmuh6w-1
Received: by mail-wr1-f70.google.com with SMTP id f4so323754wru.21
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rWMQsAvtqC0WE8v0M1RNJ2U+39lhWWyJUeSsL34QAK8=;
 b=Sb5DiWYpLffUu3wrbZLuGCj3DanIyfenS6AoLgCO9CtrR7YMlx4z0ewTrAEp5N8TVv
 lACd9cBfvEg+nJSr982vtGNX8KWBjM/b+mbNwqZeTbKO+Di4BvxW3dQSEP1XcscDq8eV
 EMyScEN6f+NQoac2pQNOufVya33LdH8jetxJo11ZSV3OBtIG8IHS6AwZwwbs4ZB35ZZ5
 qjsZa7xbelTkCRv2qKMrT0aYIXBC0QOTjEDsIoO2Ejnj3VPD8Y/cHokoqbbSpJS/iKgi
 Zox8Zj5ym0prCF3HSSy7j59hxpLzK3ePvyVnYuodXWi4Ga8CtV3Rkdfgg2mo4Z/uWuaM
 gNFA==
X-Gm-Message-State: AOAM530zZKqQuPVlZQCaTetMmpRiH1w7ROKr+FUVeG8y2+XMIrlVqYxH
 3NnzEvQRxT/amDFNEWY6zJSwtLrW+6NSYwpqlWDhKgUIzVhZojtk2way/q2QsUE3IqHoovf/4Gd
 eR4VYuyov2J5FZxQ=
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr14219543wru.369.1604868489815; 
 Sun, 08 Nov 2020 12:48:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5KIw28IEKLopghF8Sog5NuhQrebzg0pLnt+1F+zZtnsS/GWhe5p+4QuAmzbLUY97J9CqaQQ==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr14219526wru.369.1604868489635; 
 Sun, 08 Nov 2020 12:48:09 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z191sm10506016wme.30.2020.11.08.12.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:48:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 14/17] gitlab-ci: Move trace backend tests across
 to gitlab
Date: Sun,  8 Nov 2020 21:45:32 +0100
Message-Id: <20201108204535.2319870-15-philmd@redhat.com>
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 8cdb2cef3f1, move the trace backend
tests to GitLab.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitlab-ci.yml | 18 ++++++++++++++++++
 .travis.yml    | 19 -------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6552a832939..2f0da7b3dc1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -557,6 +557,24 @@ check-crypto-only-gnutls:
     IMAGE: centos7
     MAKE_CHECK_ARGS: check
 
+# We don't need to exercise every backend with every front-end
+build-trace-multi-user:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --enable-trace-backends=log,simple,syslog --disable-system
+
+build-trace-ftrace-system:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --enable-trace-backends=ftrace --target-list=aarch64-softmmu
+
+build-trace-ust-system:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: fedora
+    CONFIGURE_ARGS: --enable-trace-backends=ust --target-list=x86_64-softmmu --disable-tcg
 
 check-patch:
   stage: build
diff --git a/.travis.yml b/.travis.yml
index 8ef31f8d8b6..ff5d5ead579 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -182,25 +182,6 @@ jobs:
       compiler: clang
 
 
-    # We don't need to exercise every backend with every front-end
-    - name: "GCC trace log,simple,syslog (user)"
-      env:
-        - CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
-        - TEST_CMD=""
-
-
-    - name: "GCC trace ftrace (x86_64-softmmu)"
-      env:
-        - CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
-        - TEST_CMD=""
-
-
-    - name: "GCC trace ust (x86_64-softmmu)"
-      env:
-        - CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
-        - TEST_CMD=""
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       dist: bionic
-- 
2.26.2


