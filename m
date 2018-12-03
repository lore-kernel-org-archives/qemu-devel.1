Received: from eggs.gnu.org ([2001:4830:134:3::10]:44846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTos3-0002E9-5Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTorc-0002PF-4m
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gTorb-0001jS-Nf
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:19 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  3 Dec 2018 15:05:33 +0100
Message-Id: <1543845937-300-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1543845937-300-1-git-send-email-thuth@redhat.com>
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 3/7] configure: Remove old -fno-gcse
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
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

Now that we require at least GCC 4.8, we don't need this als workaround
for 4.6 and 4.7 anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile.target |  3 ---
 configure       | 27 ---------------------------
 2 files changed, 30 deletions(-)

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
index 14e9722..ba95f01 100755
--- a/configure
+++ b/configure
@@ -1930,32 +1930,6 @@ else
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
-if test "$static" = "yes" ; then
-  if test "$modules" = "yes" ; then
-    error_exit "static and modules are mutually incompatible"
-  fi
-  if test "$pie" = "yes" ; then
-    error_exit "static and pie are mutually incompatible"
-  else
-    pie="no"
-  fi
-fi
-
 # Unconditional check for compiler __thread support
   cat > $TMPC << EOF
 static __thread int tls_var;
@@ -6953,7 +6927,6 @@ echo "LIBS_QGA+=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
 echo "POD2MAN=$POD2MAN" >> $config_host_mak
-echo "TRANSLATE_OPT_CFLAGS=$TRANSLATE_OPT_CFLAGS" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
   echo "GCOV=$gcov_tool" >> $config_host_mak
-- 
1.8.3.1
