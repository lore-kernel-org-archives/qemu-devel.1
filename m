Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB64C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947432222A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayJggQwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947432222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShKn-0003zC-CJ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEb-0005vZ-DU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEZ-0000c7-GI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602683666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+PGM3zGIKZB3I79C4CK+uDL7NNIxjqsQYt+VZFCahc=;
 b=ayJggQwDR3d1bCP0CjdebZjtBjdTV3mdrdQ4bxD6KlndA2vu0MnJc6j4t2+D5JW7f+QM9e
 ESeXBuCoy8x/QYXsGI8TnbkYEa59KVEdScIxHDFf+Yhbi4GD9hXovnKEDE2wmE0KitbEjF
 RADJk8ng6F9yXM5EKwI4e0b7V8OhwFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-wpxYsdknMdisubNtiRCn2A-1; Wed, 14 Oct 2020 09:54:24 -0400
X-MC-Unique: wpxYsdknMdisubNtiRCn2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D281084D63;
 Wed, 14 Oct 2020 13:54:23 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74B8E60C15;
 Wed, 14 Oct 2020 13:54:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] configure: move QEMU_INCLUDES to meson
Date: Wed, 14 Oct 2020 09:54:13 -0400
Message-Id: <20201014135416.1290679-5-pbonzini@redhat.com>
In-Reply-To: <20201014135416.1290679-1-pbonzini@redhat.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: berrange@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Confusingly, QEMU_INCLUDES is not used by configure tests.  Moving
it to meson.build ensures that Windows paths are specified instead of
the msys paths like /c/Users/...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 20 --------------------
 meson.build | 30 ++++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index b553288c5e..804b7115ab 100755
--- a/configure
+++ b/configure
@@ -536,8 +536,6 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
-QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
 
 # Flags that are needed during configure but later taken care of by Meson
 CONFIGURE_CFLAGS="-std=gnu99 -Wall"
@@ -795,7 +793,6 @@ Linux)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
 ;;
 esac
 
@@ -6918,22 +6915,6 @@ if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
 fi
 
-if test "$tcg_interpreter" = "yes"; then
-  QEMU_INCLUDES="-iquote ${source_path}/tcg/tci $QEMU_INCLUDES"
-elif test "$ARCH" = "sparc64" ; then
-  QEMU_INCLUDES="-iquote ${source_path}/tcg/sparc $QEMU_INCLUDES"
-elif test "$ARCH" = "s390x" ; then
-  QEMU_INCLUDES="-iquote ${source_path}/tcg/s390 $QEMU_INCLUDES"
-elif test "$ARCH" = "x86_64" || test "$ARCH" = "x32" ; then
-  QEMU_INCLUDES="-iquote ${source_path}/tcg/i386 $QEMU_INCLUDES"
-elif test "$ARCH" = "ppc64" ; then
-  QEMU_INCLUDES="-iquote ${source_path}/tcg/ppc $QEMU_INCLUDES"
-elif test "$ARCH" = "riscv32" || test "$ARCH" = "riscv64" ; then
-  QEMU_INCLUDES="-I${source_path}/tcg/riscv $QEMU_INCLUDES"
-else
-  QEMU_INCLUDES="-iquote ${source_path}/tcg/${ARCH} $QEMU_INCLUDES"
-fi
-
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
@@ -6960,7 +6941,6 @@ echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
-echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
 echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
 echo "GLIB_LIBS=$glib_libs" >> $config_host_mak
 echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 652c37cceb..a1146522e2 100644
--- a/meson.build
+++ b/meson.build
@@ -93,9 +93,35 @@ add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
                       native: false, language: 'cpp')
 add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
                            native: false, language: ['c', 'cpp', 'objc'])
-add_project_arguments(config_host['QEMU_INCLUDES'].split(),
-                      language: ['c', 'cpp', 'objc'])
 
+if targetos == 'linux'
+  add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
+                        '-isystem', 'linux-headers',
+                        language: ['c', 'cpp'])
+endif
+
+if 'CONFIG_TCG_INTERPRETER' in config_host
+  tcg_arch = 'tci'
+elif config_host['ARCH'] == 'sparc64'
+  tcg_arch = 'sparc'
+elif config_host['ARCH'] == 's390x'
+  tcg_arch = 's390'
+elif config_host['ARCH'] in ['x86_64', 'x32']
+  tcg_arch = 'i386'
+elif config_host['ARCH'] == 'ppc64'
+  tcg_arch = 'ppc'
+elif config_host['ARCH'] in ['riscv32', 'riscv64']
+  tcg_arch = 'riscv'
+else
+  tcg_arch = config_host['ARCH']
+endif
+add_project_arguments('-iquote', meson.current_source_dir() / 'tcg' / tcg_arch,
+                      '-iquote', '.',
+                      '-iquote', meson.current_source_dir(),
+                      '-iquote', meson.current_source_dir() / 'accel/tcg',
+                      '-iquote', meson.current_source_dir() / 'include',
+                      '-iquote', meson.current_source_dir() / 'disas/libvixl',
+                      language: ['c', 'cpp', 'objc'])
 
 link_language = meson.get_external_property('link_language', 'cpp')
 if link_language == 'cpp'
-- 
2.26.2



