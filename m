Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46831C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC1820727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC1820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgYw-00021p-4V
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKk-0004j4-Vi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKj-0001Sf-H0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:58:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKj-0001RB-B1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:58:13 -0400
Received: from 2.general.paelzer.uk.vpn ([10.172.196.173]
 helo=localhost.localdomain) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKi-0004kR-EK; Tue, 10 Mar 2020 14:58:12 +0000
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] modules: load modules from versioned /var/run dir
Date: Tue, 10 Mar 2020 15:58:06 +0100
Message-Id: <20200310145806.18335-2-christian.ehrhardt@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310145806.18335-1-christian.ehrhardt@canonical.com>
References: <20200310145806.18335-1-christian.ehrhardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 pkg-qemu-devel@lists.alioth.debian.org, Cole Robinson <crobinso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On upgrades the old .so files usually are replaced. But on the other
hand since a qemu process represents a guest instance it is usually kept
around.

That makes late addition of dynamic features e.g. 'hot-attach of a ceph
disk' fail by trying to load a new version of e.f. block-rbd.so into an
old still running qemu binary.

This adds a fallback to also load modules from a versioned directory in the
temporary /var/run path. That way qemu is providing a way for packaging
to store modules of an upgraded qemu package as needed until the next reboot.

An example how that can then be used in packaging can be seen in:
https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=bug-1847361-miss-old-so-on-upgrade-UBUNTU

Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
---
 configure     | 15 +++++++++++++++
 util/module.c | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/configure b/configure
index cbf864bff1..5911bf1a82 100755
--- a/configure
+++ b/configure
@@ -405,6 +405,7 @@ EXESUF=""
 DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
 modules="no"
+module_upgrades="no"
 prefix="/usr/local"
 mandir="\${prefix}/share/man"
 datadir="\${prefix}/share"
@@ -1032,6 +1033,10 @@ for opt do
   --disable-modules)
       modules="no"
   ;;
+  --disable-module-upgrades) module_upgrades="no"
+  ;;
+  --enable-module-upgrades) module_upgrades="yes"
+  ;;
   --cpu=*)
   ;;
   --target-list=*) target_list="$optarg"
@@ -1786,6 +1791,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   guest-agent-msi build guest agent Windows MSI installation package
   pie             Position Independent Executables
   modules         modules support (non-Windows)
+  module-upgrades try to load modules from alternate paths for upgrades
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
   sparse          sparse checker
@@ -2049,6 +2055,11 @@ if test "$modules" = "yes" && test "$mingw32" = "yes" ; then
   error_exit "Modules are not available for Windows"
 fi
 
+# module_upgrades is only reasonable if modules are enabled
+if test "$modules" = "no" && test "$module_upgrades" = "yes" ; then
+  error_exit "Can't enable module-upgrades as Modules are not enabled"
+fi
+
 # Static linking is not possible with modules or PIE
 if test "$static" = "yes" ; then
   if test "$modules" = "yes" ; then
@@ -6584,6 +6595,7 @@ if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
 fi
 echo "module support    $modules"
+echo "alt path mod load $module_upgrades"
 echo "host CPU          $cpu"
 echo "host big endian   $bigendian"
 echo "target list       $target_list"
@@ -6937,6 +6949,9 @@ if test "$modules" = "yes"; then
   echo "CONFIG_STAMP=_$( (echo $qemu_version; echo $pkgversion; cat $0) | $shacmd - | cut -f1 -d\ )" >> $config_host_mak
   echo "CONFIG_MODULES=y" >> $config_host_mak
 fi
+if test "$module_upgrades" = "yes"; then
+  echo "CONFIG_MODULE_UPGRADES=y" >> $config_host_mak
+fi
 if test "$have_x11" = "yes" && test "$need_x11" = "yes"; then
   echo "CONFIG_X11=y" >> $config_host_mak
   echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
diff --git a/util/module.c b/util/module.c
index 236a7bb52a..5f7896870a 100644
--- a/util/module.c
+++ b/util/module.c
@@ -19,6 +19,9 @@
 #endif
 #include "qemu/queue.h"
 #include "qemu/module.h"
+#ifdef CONFIG_MODULE_UPGRADES
+#include "qemu-version.h"
+#endif
 
 typedef struct ModuleEntry
 {
@@ -170,6 +173,9 @@ bool module_load_one(const char *prefix, const char *lib_name)
 #ifdef CONFIG_MODULES
     char *fname = NULL;
     char *exec_dir;
+#ifdef CONFIG_MODULE_UPGRADES
+    char *version_dir;
+#endif
     const char *search_dir;
     char *dirs[4];
     char *module_name;
@@ -201,6 +207,14 @@ bool module_load_one(const char *prefix, const char *lib_name)
     dirs[n_dirs++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
     dirs[n_dirs++] = g_strdup_printf("%s/..", exec_dir ? : "");
     dirs[n_dirs++] = g_strdup_printf("%s", exec_dir ? : "");
+
+#ifdef CONFIG_MODULE_UPGRADES
+    version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
+                             G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~",
+                             '_');
+    dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
+#endif
+
     assert(n_dirs <= ARRAY_SIZE(dirs));
 
     g_free(exec_dir);
-- 
2.25.1


