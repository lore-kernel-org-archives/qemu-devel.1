Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B33CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA63E20748
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHhD4IMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA63E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94JG-0005Qr-W4
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94D4-0000WC-QP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94D1-0001Qf-S1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjOVdeZdU8flg52xFPrCav0JQnR66QHJMCvoKZaLbqI=;
 b=CHhD4IMTGSeew80Vk81InNxkywuDCfAaI50CYgHAzfNOSHHRkiRIiG0N8jxrlKNNLzsH0X
 EF9zdg+P7eO3sAvwiecSjRJKin+Ns2d+mP/SLR3KqKEhyZX9dzh2HPlmO8YhJ7dpjQHsVu
 QfhZOa/IQtWhQ/6IMqC74TpLX314JIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-bfN9wXosODiMIE_W86N50g-1; Fri, 21 Aug 2020 06:23:40 -0400
X-MC-Unique: bfN9wXosODiMIE_W86N50g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C8228030C4
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F038319C78;
 Fri, 21 Aug 2020 10:23:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 008/152] tests/vm: do not pollute configure with
 --efi-aarch64
Date: Fri, 21 Aug 2020 06:21:05 -0400
Message-Id: <20200821102329.29777-9-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just make EFI_AARCH64 a variable in the makefile that defaults to the efi
firmware included with QEMU.  It can be redefined on the "make" command
line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                 | 19 -------------------
 tests/vm/Makefile.include |  2 ++
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465..1c17a0f27f 100755
--- a/configure
+++ b/configure
@@ -418,7 +418,6 @@ prefix="/usr/local"
 mandir="\${prefix}/share/man"
 datadir="\${prefix}/share"
 firmwarepath="\${prefix}/share/qemu-firmware"
-efi_aarch64=""
 qemu_docdir="\${prefix}/share/doc/qemu"
 bindir="\${prefix}/bin"
 libdir="\${prefix}/lib"
@@ -1109,8 +1108,6 @@ for opt do
   ;;
   --firmwarepath=*) firmwarepath="$optarg"
   ;;
-  --efi-aarch64=*) efi_aarch64="$optarg"
-  ;;
   --host=*|--build=*|\
   --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
@@ -3650,20 +3647,6 @@ EOF
   fi
 fi
 
-############################################
-# efi-aarch64 probe
-# Check for efi files needed by aarch64 VMs.
-# By default we will use the efi included with QEMU.
-# Allow user to override the path for efi also.
-if ! test -f "$efi_aarch64"; then
-  if test -f $source_path/pc-bios/edk2-aarch64-code.fd.bz2; then
-    # valid after build
-    efi_aarch64=$PWD/pc-bios/edk2-aarch64-code.fd
-  else
-    efi_aarch64=""
-  fi
-fi
-
 ##########################################
 # libcap-ng library probe
 if test "$cap_ng" != "no" ; then
@@ -6861,7 +6844,6 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
-echo "efi_aarch64       $efi_aarch64"
 echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
@@ -7963,7 +7945,6 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
-echo "EFI_AARCH64=$efi_aarch64" >> $config_host_mak
 echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index f21948c46a..a599d1994d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,6 +2,8 @@
 
 .PHONY: vm-build-all vm-clean-all
 
+EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
+
 IMAGES := freebsd netbsd openbsd centos fedora
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
-- 
2.26.2



