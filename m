Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9813AC5517A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0903320702
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cK+/zKhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0903320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrjZ-0006TL-Rs
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbT-0004yj-8r
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbR-0000Xw-CH
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhakXTZKDCfk5v0jA5X38unAStmiYcMWfSFyfuJH4rI=;
 b=cK+/zKhfN2p8O1HlQgrNvB1F0tku7CDLa61mIBbGHjE7MlcQsz4I4BD0dLBPVqyM/iqqr3
 lTnMmUqhvJVqRW+zblDAzxP1FtF3fs5lMD0BvpY0DAwiENM7N09ANpLGh74ArsR4JRGGp5
 RDZ5xelEXMMduRRnC3iOUbxfGuUQ6mM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-dXnrJQ4bMyWfkzNnBaA2TA-1; Sun, 08 Nov 2020 15:47:55 -0500
X-MC-Unique: dXnrJQ4bMyWfkzNnBaA2TA-1
Received: by mail-wr1-f70.google.com with SMTP id p16so745234wrx.4
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rhakXTZKDCfk5v0jA5X38unAStmiYcMWfSFyfuJH4rI=;
 b=uoMIi8SAvQT9ItNGh7qtDQFePlI+kU4KfAwuMf3h6eVG621vB9ir324JmcLorStMaT
 gMjmHxa0IdwttuizB22cxEomSB6b7T2w1S5CRze37Qjssib53Hj05i8YJftbrKMEoeMS
 kLTJh7XBWYrxUTXN3aG2T9grSdnk8gwWQcifsfUf3f0OU3SQkizTGqiEOQv462pDag93
 LlCrUQu8GOKnAK8rv2adsUCJUj3TFFxdLof3uqrjM8SjMfFRB9XV46UoLBRTYGlMAPQF
 pAop3AomiA3QtzsUcOcFEu88SIN1pLy2PD/4EzpWSoWJwZW2VyKAJDKJLVsKtDVRv+SE
 gM0w==
X-Gm-Message-State: AOAM531MWug/Pg9GWeDDF7ti5AV3u7RE//DBBN3NyiN1HydXobXpAfth
 0wVA+jRLuvnYCFw3iULMzVv7Bum7WAkZ07n+XDmTAOuuTLsxm2TGm9WAipHGGSNXeotbyxd1C17
 KkSAJGUNAodhXpNo=
X-Received: by 2002:adf:a343:: with SMTP id d3mr14320028wrb.91.1604868473880; 
 Sun, 08 Nov 2020 12:47:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwXUsLg84qFW6TNCrr31EkRaFQ6RSke179RmTyo0mH0vTqxhUxc5Efn85PvZCBUqwPXNXVhw==
X-Received: by 2002:adf:a343:: with SMTP id d3mr14320009wrb.91.1604868473746; 
 Sun, 08 Nov 2020 12:47:53 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b14sm10713523wrx.35.2020.11.08.12.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 11/17] gitlab-ci: Move tools-only and softfloat
 tests across to gitlab
Date: Sun,  8 Nov 2020 21:45:29 +0100
Message-Id: <20201108204535.2319870-12-philmd@redhat.com>
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Emilio G . Cota" <cota@braap.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 8cdb2cef3f1, move the tools-only and softfloat
test to GitLab (splitting it in 2 different jobs).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Emilio G. Cota <cota@braap.org>
---
 .gitlab-ci.yml | 14 ++++++++++++++
 .travis.yml    |  9 ---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a91870cf85e..a799803afb9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -297,6 +297,20 @@ build-tcg-disabled:
             208 209 215 216 218 222 227 234 246 247 248 250 254 255 257 258
             260 261 262 263 264 270 272 273 277 279
 
+build-tools:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --enable-tools --disable-system --disable-user
+
+# run minimal unit and softfloat checks
+build-softfloat:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system --disable-user
+    MAKE_CHECK_ARGS: check-unit check-softfloat
+
 build-user:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index 5fb69c5fb02..15550fb023f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -119,15 +119,6 @@ after_script:
 
 jobs:
   include:
-    # Just build tools and run minimal unit and softfloat checks
-    - name: "GCC check-unit and check-softfloat"
-      env:
-        - BASE_CONFIG="--enable-tools"
-        - CONFIG="--disable-user --disable-system"
-        - TEST_CMD="make check-unit check-softfloat -j${JOBS}"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-
-
     # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
     - name: "GCC debug (main-softmmu)"
       env:
-- 
2.26.2


