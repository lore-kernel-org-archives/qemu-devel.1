Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF4BC4727D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D64E206DD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUm+G20v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D64E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSWz-0008AG-Im
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPSVS-0006zR-Lu
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPSVQ-0006Js-Uf
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=eZEUC1HM2LUTMoGQxZ9CuDIcI+CEV4L65Gut21+RWGo=;
 b=HUm+G20vm2GskUXVd0HNsF/GcYZTsq/ByO+6cOHebXskgcbUedJLhvoNW85C2eNPle1HSD
 IRnci+ZF/EXRadSpQzv5kJoW7MMuvW7cmzJe7QtCJMjxQ/XKO4v5X3SSoMlqVWNRnY8GYG
 C+xJeK0nWDDk16T+JWy1O3aW3OvSJA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-11VfG_IiO-2BzU9OGVAWNg-1; Mon, 05 Oct 2020 11:34:24 -0400
X-MC-Unique: 11VfG_IiO-2BzU9OGVAWNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00CF18030C7;
 Mon,  5 Oct 2020 15:34:23 +0000 (UTC)
Received: from thuth.com (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 535E0100164C;
 Mon,  5 Oct 2020 15:34:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] cirrus.yml: Add VM-based jobs to test with NetBSD and OpenBSD
Date: Mon,  5 Oct 2020 17:34:19 +0200
Message-Id: <20201005153419.94887-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since Cirrus-CI provides KVM in their Linux containers, we can also run
our NetBSD and OpenBSD build jobs there. Since the installation might
take a while, we only run the "help" target on the first invocation,
and check with the major targets afterwards, once the base image has
been cached. For the the build tests, we also only use a limited set of
target CPUs since compiling in these VMs is not very fast (especially
the build on OpenBSD seems to be incredibly slow).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 9f7d2c0a78..f4ec2d59f4 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -105,3 +105,45 @@ windows_msys2_task:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
+
+netbsd_task:
+  container:
+    image: fedora:32
+    cpu: 8
+    memory: 8Gb
+    kvm: true
+  qemu_vm_cache:
+    folder: $HOME/.cache/qemu-vm
+  install_script:
+    - dnf update -y
+    - dnf install -y git make openssh-clients qemu-img qemu-system-x86 wget
+  script:
+    - if [ -d $HOME/.cache/qemu-vm ]; then ls -lR $HOME/.cache/qemu-vm ; fi
+    - if [ -f $HOME/.cache/qemu-vm/images/netbsd.img ]; then
+        make vm-build-netbsd J=$(getconf _NPROCESSORS_ONLN)
+          EXTRA_CONFIGURE_OPTS="--target-list=aarch64-softmmu,ppc64-softmmu,sparc64-softmmu,sparc-softmmu,x86_64-softmmu,i386-bsd-user,sparc64-bsd-user,sparc-bsd-user,x86_64-bsd-user" ;
+      else
+        make vm-build-netbsd J=$(getconf _NPROCESSORS_ONLN) BUILD_TARGET=help
+          EXTRA_CONFIGURE_OPTS="--disable-system --disable-user" ;
+      fi
+
+openbsd_task:
+  container:
+    image: fedora:32
+    cpu: 8
+    memory: 8Gb
+    kvm: true
+  qemu_vm_cache:
+    folder: $HOME/.cache/qemu-vm
+  install_script:
+    - dnf update -y
+    - dnf install -y git make openssh-clients qemu-img qemu-system-x86 wget
+  script:
+    - if [ -d $HOME/.cache/qemu-vm ]; then ls -lR $HOME/.cache/qemu-vm ; fi
+    - if [ -f $HOME/.cache/qemu-vm/images/openbsd.img ]; then
+        make vm-build-openbsd J=$(getconf _NPROCESSORS_ONLN)
+          EXTRA_CONFIGURE_OPTS="--target-list=i386-softmmu,sparc-softmmu,i386-bsd-user,sparc-bsd-user" ;
+      else
+        make vm-build-openbsd J=$(getconf _NPROCESSORS_ONLN) BUILD_TARGET=help
+          EXTRA_CONFIGURE_OPTS="--disable-system --disable-user" ;
+      fi
-- 
2.18.2


