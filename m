Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ACEC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294692220E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me0E87E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294692220E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWAR-0005Ey-6w
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVvH-0007V5-2u
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVvE-0008E2-6L
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pgmW3Tgw3grA4G0aHb8Y9UjrOv7Bu7D0uP3/KogksY=;
 b=Me0E87E4I/H4qbA9Npyb5jPQdyl+gDvG8r3q9ITUPH5RXfxCI1xnLonXEMHBJSbefvNY9A
 uzX2/2UwgUiFswb/HH5ZUN/6MYMpbuU3PKa38boiGx6SgeDvF68nHQczSA5y1G41DDE3bk
 bkXjj+iPjAiVcXPwn2eNLpAz6Qk/d2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-Hl_fFd_qMGSxsnR2bGKQpg-1; Wed, 16 Sep 2020 07:48:12 -0400
X-MC-Unique: Hl_fFd_qMGSxsnR2bGKQpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A8F186DD2B;
 Wed, 16 Sep 2020 11:48:11 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DE735DA71;
 Wed, 16 Sep 2020 11:48:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/24] cirrus: Building freebsd in a single shot
Date: Wed, 16 Sep 2020 13:47:31 +0200
Message-Id: <20200916114731.102080-25-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
References: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
("cirrus.yml: Split FreeBSD job into two parts").

freebsd 1 hour limit not hit anymore

I think we going to a wrong direction, I think there is some tests a stall the test runner,
please look at
https://cirrus-ci.com/task/5110577531977728
When its running properly, the consumed time are little, but when tests running too long,
look at the cpu usage, the cpu usage are nearly zero. doesn't consuming time.

And look at
https://cirrus-ci.com/task/6119341601062912

If the tests running properly, the time consuming are little
We should not hide the error by split them

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Ed Maste <emaste@FreeBSD.org>
Message-Id: <20200915121318.247-16-luoyonggang@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index e5feb53b54..d58782ce67 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,38 +1,19 @@
 env:
   CIRRUS_CLONE_DEPTH: 1
 
-freebsd_1st_task:
+freebsd_12_task:
   freebsd_instance:
     image_family: freebsd-12-1
-    cpu: 4
-    memory: 4G
-  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
-    bash curl cyrus-sasl git glib gmake gnutls gsed
-    nettle perl5 pixman pkgconf png usbredir
+    cpu: 8
+    memory: 8G
+  install_script:
+    - ASSUME_ALWAYS_YES=yes pkg bootstrap -f ;
+    - pkg install -y bash curl cyrus-sasl git glib gmake gnutls gsed
+          nettle perl5 pixman pkgconf png usbredir
   script:
     - mkdir build
     - cd build
-    - ../configure --disable-user --target-list-exclude='alpha-softmmu
-        ppc64-softmmu ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
-        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu'
-        --enable-werror || { cat config.log; exit 1; }
-    - gmake -j$(sysctl -n hw.ncpu)
-    - gmake -j$(sysctl -n hw.ncpu) check
-
-freebsd_2nd_task:
-  freebsd_instance:
-    image_family: freebsd-12-1
-    cpu: 4
-    memory: 4G
-  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
-    bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed libepoxy mesa-libs
-    nettle perl5 pixman pkgconf png SDL2 usbredir
-  script:
-    - ./configure --enable-werror --target-list='alpha-softmmu ppc64-softmmu
-        ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
-        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu
-        sparc-bsd-user sparc64-bsd-user x86_64-bsd-user i386-bsd-user'
-        || { cat config.log; exit 1; }
+    - ../configure --enable-werror || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake -j$(sysctl -n hw.ncpu) check
 
-- 
2.18.2


