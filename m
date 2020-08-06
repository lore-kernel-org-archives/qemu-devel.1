Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B966C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3A52177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCpeLN3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3A52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lRx-00044q-6x
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNd-0003Tj-RH
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNb-0006MO-V0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=yq1ucztHwlGcQzpGmEo8EM7HiC4hRXcqCJdE65v5Ps0=;
 b=iCpeLN3Q2JFShiaYMRJfKXcyYPA/e3yfeGLqYnx5dEzBM0iyrmgCx4h9tJ9nx+ts1kyW2A
 f9VEzf7zvRYVtshH3C2A6F0hfu/nNtYZ5mJSSXWgACD8/9gT/43Wno4BNPVFjQ3MEI/EaP
 YQ4nXOqnSS/bKppeHDNL/xFMbQclWEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-xZ8glHoaNI-Vm7OXvn1L_g-1; Thu, 06 Aug 2020 15:16:41 -0400
X-MC-Unique: xZ8glHoaNI-Vm7OXvn1L_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8D50800468
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:40 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F20045FC3B
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 008/143] tests/vm: check for Python YAML parser in the Makefile
Date: Thu,  6 Aug 2020 21:14:04 +0200
Message-Id: <1596741379-12902-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No need to do it in the configure file if it is only used for a help message.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                 | 9 ---------
 tests/vm/Makefile.include | 4 +++-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 1c17a0f..625c14c 100755
--- a/configure
+++ b/configure
@@ -959,13 +959,6 @@ do
     fi
 done
 
-# Check for existence of python3 yaml, needed to
-# import yaml config files into vm-build.
-python_yaml="no"
-if $(python3 -c "import yaml" 2> /dev/null); then
-    python_yaml="yes"
-fi
-
 : ${smbd=${SMBD-/usr/sbin/smbd}}
 
 # Default objcc to clang if available, otherwise use CC
@@ -6844,7 +6837,6 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
-echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7945,7 +7937,6 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
-echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 29f5a1f..70263b2 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -17,6 +17,8 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
 .PRECIOUS: $(IMAGE_FILES)
 
+HAVE_PYTHON_YAML = $(shell $(PYTHON) -c "import yaml" 2> /dev/null && echo yes)
+
 # 'vm-help' target was historically named 'vm-test'
 vm-help vm-test:
 	@echo "vm-help: Test QEMU in preconfigured virtual machines"
@@ -56,7 +58,7 @@ endif
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
-ifeq ($(PYTHON_YAML),yes)
+ifeq ($(HAVE_PYTHON_YAML),yes)
 	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
 else
 	@echo "    (install python3-yaml to enable support for yaml file to configure a VM.)"
-- 
1.8.3.1



