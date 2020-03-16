Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E6720658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuOF+c+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E6720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxSk-0002Bn-A3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHI-00032U-61
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHG-0002hk-GF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHG-0002eo-9u
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wa22nO3jb2R+tsyGVtCtX3AeAERtIHhXj/xa1okN7VA=;
 b=SuOF+c+T/I6ZXEZHWdHt8qMM/bToLCE+pQtbynOk0yNR/tAdXmjlBAJjkTBOhsaxWpZbvj
 xiF39etTG0y2wFRwyqqDAALAFxTcfFsGg6WUcVPZuqNMqm+V5yLiNJw3c/Nr2OUwhVok6F
 puZxfxo8JRNvVCLDtHgtzWilR3Vtc7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-LQEjZEiFOvKIOx3azaTLcg-1; Mon, 16 Mar 2020 17:27:56 -0400
X-MC-Unique: LQEjZEiFOvKIOx3azaTLcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A590800D5B;
 Mon, 16 Mar 2020 21:27:55 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 457D819C4F;
 Mon, 16 Mar 2020 21:27:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/61] modules: load modules from versioned /var/run dir
Date: Mon, 16 Mar 2020 22:26:40 +0100
Message-Id: <1584394048-44994-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Ehrhardt <christian.ehrhardt@canonical.com>

On upgrades the old .so files usually are replaced. But on the other
hand since a qemu process represents a guest instance it is usually kept
around.

That makes late addition of dynamic features e.g. 'hot-attach of a ceph
disk' fail by trying to load a new version of e.f. block-rbd.so into an
old still running qemu binary.

This adds a fallback to also load modules from a versioned directory in the
temporary /var/run path. That way qemu is providing a way for packaging
to store modules of an upgraded qemu package as needed until the next reboo=
t.

An example how that can then be used in packaging can be seen in:
https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-1847361=
-miss-old-so-on-upgrade-UBUNTU

Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20200310145806.18335-2-christian.ehrhardt@canonical.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure     | 15 +++++++++++++++
 util/module.c | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/configure b/configure
index 1a82683..a7f2c3e 100755
--- a/configure
+++ b/configure
@@ -405,6 +405,7 @@ EXESUF=3D""
 DSOSUF=3D".so"
 LDFLAGS_SHARED=3D"-shared"
 modules=3D"no"
+module_upgrades=3D"no"
 prefix=3D"/usr/local"
 mandir=3D"\${prefix}/share/man"
 datadir=3D"\${prefix}/share"
@@ -1032,6 +1033,10 @@ for opt do
   --disable-modules)
       modules=3D"no"
   ;;
+  --disable-module-upgrades) module_upgrades=3D"no"
+  ;;
+  --enable-module-upgrades) module_upgrades=3D"yes"
+  ;;
   --cpu=3D*)
   ;;
   --target-list=3D*) target_list=3D"$optarg"
@@ -1791,6 +1796,7 @@ disabled with --disable-FEATURE, default is enabled i=
f available:
   guest-agent-msi build guest agent Windows MSI installation package
   pie             Position Independent Executables
   modules         modules support (non-Windows)
+  module-upgrades try to load modules from alternate paths for upgrades
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
   sparse          sparse checker
@@ -2055,6 +2061,11 @@ if test "$modules" =3D "yes" && test "$mingw32" =3D =
"yes" ; then
   error_exit "Modules are not available for Windows"
 fi
=20
+# module_upgrades is only reasonable if modules are enabled
+if test "$modules" =3D "no" && test "$module_upgrades" =3D "yes" ; then
+  error_exit "Can't enable module-upgrades as Modules are not enabled"
+fi
+
 # Static linking is not possible with modules or PIE
 if test "$static" =3D "yes" ; then
   if test "$modules" =3D "yes" ; then
@@ -6626,6 +6637,7 @@ if test "$slirp" !=3D "no" ; then
     echo "smbd              $smbd"
 fi
 echo "module support    $modules"
+echo "alt path mod load $module_upgrades"
 echo "host CPU          $cpu"
 echo "host big endian   $bigendian"
 echo "target list       $target_list"
@@ -6980,6 +6992,9 @@ if test "$modules" =3D "yes"; then
   echo "CONFIG_STAMP=3D_$( (echo $qemu_version; echo $pkgversion; cat $0) =
| $shacmd - | cut -f1 -d\ )" >> $config_host_mak
   echo "CONFIG_MODULES=3Dy" >> $config_host_mak
 fi
+if test "$module_upgrades" =3D "yes"; then
+  echo "CONFIG_MODULE_UPGRADES=3Dy" >> $config_host_mak
+fi
 if test "$have_x11" =3D "yes" && test "$need_x11" =3D "yes"; then
   echo "CONFIG_X11=3Dy" >> $config_host_mak
   echo "X11_CFLAGS=3D$x11_cflags" >> $config_host_mak
diff --git a/util/module.c b/util/module.c
index 236a7bb..5f78968 100644
--- a/util/module.c
+++ b/util/module.c
@@ -19,6 +19,9 @@
 #endif
 #include "qemu/queue.h"
 #include "qemu/module.h"
+#ifdef CONFIG_MODULE_UPGRADES
+#include "qemu-version.h"
+#endif
=20
 typedef struct ModuleEntry
 {
@@ -170,6 +173,9 @@ bool module_load_one(const char *prefix, const char *li=
b_name)
 #ifdef CONFIG_MODULES
     char *fname =3D NULL;
     char *exec_dir;
+#ifdef CONFIG_MODULE_UPGRADES
+    char *version_dir;
+#endif
     const char *search_dir;
     char *dirs[4];
     char *module_name;
@@ -201,6 +207,14 @@ bool module_load_one(const char *prefix, const char *l=
ib_name)
     dirs[n_dirs++] =3D g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
     dirs[n_dirs++] =3D g_strdup_printf("%s/..", exec_dir ? : "");
     dirs[n_dirs++] =3D g_strdup_printf("%s", exec_dir ? : "");
+
+#ifdef CONFIG_MODULE_UPGRADES
+    version_dir =3D g_strcanon(g_strdup(QEMU_PKGVERSION),
+                             G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~=
",
+                             '_');
+    dirs[n_dirs++] =3D g_strdup_printf("/var/run/qemu/%s", version_dir);
+#endif
+
     assert(n_dirs <=3D ARRAY_SIZE(dirs));
=20
     g_free(exec_dir);
--=20
1.8.3.1



