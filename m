Received: from eggs.gnu.org ([2001:4830:134:3::10]:52534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mh-0000zp-8t
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mf-0000PQ-5v
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:59 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6Me-0000Oa-RQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:57 -0500
Received: by mail-wr1-x42b.google.com with SMTP id t27so18088015wra.6
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:56 +0100
Message-Id: <1544628195-37728-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/54] configure: Remove old -fno-gcse
 workaround for GCC 4.6.x and 4.7.[012]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Now that we require at least GCC 4.8, we don't need this als workaround
for 4.6 and 4.7 anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543937577-28256-4-git-send-email-thuth@redhat.com>
---
 Makefile.target |  3 ---
 configure       | 16 ----------------
 2 files changed, 19 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 4d56298..44ec4b6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -158,9 +158,6 @@ GENERATED_FILES += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
 
-# Workaround for http://gcc.gnu.org/PR55489, see configure.
-%/translate.o: QEMU_CFLAGS += $(TRANSLATE_OPT_CFLAGS)
-
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
diff --git a/configure b/configure
index 3e401b7..131eae5 100755
--- a/configure
+++ b/configure
@@ -1933,21 +1933,6 @@ else
   QEMU_CFLAGS="$QEMU_CFLAGS -Wno-missing-braces"
 fi
 
-# Workaround for http://gcc.gnu.org/PR55489.  Happens with -fPIE/-fPIC and
-# large functions that use global variables.  The bug is in all releases of
-# GCC, but it became particularly acute in 4.6.x and 4.7.x.  It is fixed in
-# 4.7.3 and 4.8.0.  We should be able to delete this at the end of 2013.
-cat > $TMPC << EOF
-#if __GNUC__ == 4 && (__GNUC_MINOR__ == 6 || (__GNUC_MINOR__ == 7 && __GNUC_PATCHLEVEL__ <= 2))
-int main(void) { return 0; }
-#else
-#error No bug in this compiler.
-#endif
-EOF
-if compile_prog "-Werror -fno-gcse" "" ; then
-  TRANSLATE_OPT_CFLAGS=-fno-gcse
-fi
-
 if test "$static" = "yes" ; then
   if test "$modules" = "yes" ; then
     error_exit "static and modules are mutually incompatible"
@@ -6980,7 +6965,6 @@ echo "LIBS_QGA+=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
-echo "TRANSLATE_OPT_CFLAGS=$TRANSLATE_OPT_CFLAGS" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
   echo "GCOV=$gcov_tool" >> $config_host_mak
-- 
1.8.3.1
