Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AA122527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyWjwGOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AA122527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNzQ-0004V0-Sp
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxn-0002aF-1R
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxl-0005ZF-PF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:02 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxl-0005Xm-I5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:01 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so2600580wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=hQa8RQN93P2TBfJsyGVMdsfgVEPZ5APj9EiA07gMxPg=;
 b=QyWjwGOnr3b9/8G4o2TmPcgrsDOau5C4XHfkw9SWDrbtSUU5EK8CJNqrK/rvFAG77v
 lJoBmrcW1RWyBGy0OdPwugIY13/4c+JMto4IFoQXjTG4SLRaWVIBnT1rRWjA/oYUI74a
 +bg7rRXjzYgFkqBxBzZLLD62qsGA8w3uJ9UnSCVn2kXttoPFrHSFXLFCbApdoMwZ83/0
 z5wZhcYBPp7kclffEYyM3E5oAeNvB9E64cspbmrrI7lBtSvJ42VYy6fotEQYfNFQ/+0l
 QpdDzbBJNVPIYL4I+2hfEppTvKaIU7sUyxEH6NoG8Yn3aYppmqFQuogf8H2I5KhqewBq
 n5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=hQa8RQN93P2TBfJsyGVMdsfgVEPZ5APj9EiA07gMxPg=;
 b=HOty7AXd53pWUiex1qJ+115srh/CZ8CPB0/6F/8EKhDzYz07d1LcZMQbP6LmEwBNRK
 YBMaXdHV9NIZX9GQH2CxBylEqOtAd2IXjjXDyWm1UAmeny5olmBvkk2jX7v6xi2jtV5q
 SJf+BO6WKpv1vYhHOE1S/3uuT9BcXGL6Fkmr3aQ0yfe8OLKpDd8k+WHxVEPJVqZ5ftbr
 fH/oYu8CQoNbg+8D4sQcYmdLH9TtbD5Xp1O55cinds8xmxBAlO6Ibgyey/GPPqMXrdZN
 S8jWsfo2gLWoyeNgcfzR0Y5tC1J0szcyBKMdhtUrCxfQK79OZ2VdUtWWGLlfX1ncM8ZU
 ClLA==
X-Gm-Message-State: APjAAAVmLuXiNOJv9oFnZr4n7Ji9T7iFRXuLXUDm0PB13e7CGsslYBA2
 kyW1fbtslMHDbB06qljdBQcvpwyr
X-Google-Smtp-Source: APXvYqyU1mh0Ih1PGRKpQobpBS68+LaDbE56GDzxRsBMNN8Up43LPi8T7OdnrS/cGLEWKBBC+14LSw==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr5992612wri.47.1576155180321; 
 Thu, 12 Dec 2019 04:53:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.52.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:52:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 002/132] configure: do not include $(...) variables in
 config-host.mak
Date: Thu, 12 Dec 2019 13:50:46 +0100
Message-Id: <1576155176-2464-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

This ensures that Meson will be able to reuse the results of
the tests that are performed in the configure script.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index f50314f..9745b87 100755
--- a/configure
+++ b/configure
@@ -589,8 +589,8 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu99 $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/accel/tcg -iquote \$(SRC_PATH)/include"
-QEMU_INCLUDES="$QEMU_INCLUDES -iquote \$(SRC_PATH)/disas/libvixl"
+QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
+QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
     LDFLAGS="-g $LDFLAGS"
@@ -881,7 +881,7 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-I${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
   libudev="yes"
 ;;
@@ -4038,8 +4038,8 @@ EOF
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
               symlink "$source_path/dtc/scripts" "dtc/scripts"
           fi
-          fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
-          fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
+          fdt_cflags="-I${source_path}/dtc/libfdt"
+          fdt_ldflags="-L$PWD/dtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -4988,13 +4988,13 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    QEMU_CFLAGS="$QEMU_CFLAGS -I${source_path}/capstone/include"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    libs_cpu="-L\$(BUILD_DIR)/capstone -lcapstone $libs_cpu"
+    libs_cpu="-L$PWD/capstone -lcapstone $libs_cpu"
     ;;
 
   system)
@@ -5888,8 +5888,8 @@ case "$slirp" in
       git_submodules="${git_submodules} slirp"
     fi
     mkdir -p slirp
-    slirp_cflags="-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
-    slirp_libs="-L\$(BUILD_DIR)/slirp -lslirp"
+    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
+    slirp_libs="-L$PWD/slirp -lslirp"
     if test "$mingw32" = "yes" ; then
       slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
     fi
@@ -7235,21 +7235,21 @@ if test "$sheepdog" = "yes" ; then
 fi
 
 if test "$tcg_interpreter" = "yes"; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/sparc $QEMU_INCLUDES"
 elif test "$ARCH" = "s390x" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/s390 $QEMU_INCLUDES"
 elif test "$ARCH" = "x86_64" || test "$ARCH" = "x32" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" = "ppc64" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/ppc $QEMU_INCLUDES"
 elif test "$ARCH" = "riscv32" || test "$ARCH" = "riscv64" ; then
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
+  QEMU_INCLUDES="-I${source_path}/tcg/riscv $QEMU_INCLUDES"
 else
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
-QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
+QEMU_INCLUDES="-iquote ${source_path}/tcg $QEMU_INCLUDES"
 
 echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
-- 
1.8.3.1



