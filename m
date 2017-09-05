Received: from eggs.gnu.org ([2001:4830:134:3::10]:35855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpEPu-0008Kw-KF
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpEPp-00031A-Fx
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dpEPp-0002zz-7k
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:21 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Sep 2017 16:01:15 +0200
Message-Id: <20170905140116.28181-2-kraxel@redhat.com>
In-Reply-To: <20170905140116.28181-1-kraxel@redhat.com>
References: <20170905140116.28181-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] pixman: drop submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Drop pixman submodule and support for the "internal" pixman build.
pixman should be reasonably well established meanwhile so we don't
need the fallback submodule any more.  While being at it also drop
some #ifdefs for pixman versions older than what we require in
configure anyway.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure        | 20 ++------------------
 Makefile         | 10 ----------
 ui/qemu-pixman.c |  4 ----
 .gitmodules      |  3 ---
 pixman           |  1 -
 5 files changed, 2 insertions(+), 36 deletions(-)
 delete mode 160000 pixman

diff --git a/configure b/configure
index dd73cce62f..73760430b0 100755
--- a/configure
+++ b/configure
@@ -930,8 +930,6 @@ for opt do
   ;;
   --with-system-pixman) pixman="system"
   ;;
-  --without-system-pixman) pixman="internal"
-  ;;
   --without-pixman) pixman="none"
   ;;
   --disable-sdl) sdl="no"
@@ -3305,8 +3303,6 @@ if test "$pixman" = ""; then
     pixman="none"
   elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
     pixman="system"
-  else
-    pixman="internal"
   fi
 fi
 if test "$pixman" = "none"; then
@@ -3323,16 +3319,8 @@ elif test "$pixman" = "system"; then
   pixman_cflags=$($pkg_config --cflags pixman-1)
   pixman_libs=$($pkg_config --libs pixman-1)
 else
-  if test ! -d ${source_path}/pixman/pixman; then
-    error_exit "pixman >= 0.21.8 not present. Your options:" \
-        "  (1) Preferred: Install the pixman devel package (any recent" \
-        "      distro should have packages as Xorg needs pixman too)." \
-        "  (2) Fetch the pixman submodule, using:" \
-        "      git submodule update --init pixman"
-  fi
-  mkdir -p pixman/pixman
-  pixman_cflags="-I\$(SRC_PATH)/pixman/pixman -I\$(BUILD_DIR)/pixman/pixman"
-  pixman_libs="-L\$(BUILD_DIR)/pixman/pixman/.libs -lpixman-1"
+  error_exit "pixman >= 0.21.8 not present." \
+      "Please install the pixman devel package."
 fi
 
 ##########################################
@@ -6527,10 +6515,6 @@ echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
 done # for target in $targets
 
-if [ "$pixman" = "internal" ]; then
-  echo "config-host.h: subdir-pixman" >> $config_host_mak
-fi
-
 if [ "$dtc_internal" = "yes" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
diff --git a/Makefile b/Makefile
index 81447b1f08..280af66628 100644
--- a/Makefile
+++ b/Makefile
@@ -325,15 +325,6 @@ $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
 subdir-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" all,)
 
-subdir-pixman: pixman/Makefile
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C pixman V="$(V)" all,)
-
-pixman/Makefile: $(SRC_PATH)/pixman/configure
-	(cd pixman; CFLAGS="$(CFLAGS) -fPIC $(extra_cflags) $(extra_ldflags)" $(SRC_PATH)/pixman/configure $(AUTOCONF_HOST) --disable-gtk --disable-shared --enable-static)
-
-$(SRC_PATH)/pixman/configure:
-	(cd $(SRC_PATH)/pixman; autoreconf -v --install)
-
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
 DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
@@ -532,7 +523,6 @@ distclean: clean
 	rm -rf $$d || exit 1 ; \
         done
 	rm -Rf .sdk
-	if test -f pixman/config.log; then $(MAKE) -C pixman distclean; fi
 	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  modifiers  no  pt-br  sv \
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 6e8b83add6..6e591ab821 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -96,17 +96,13 @@ int qemu_pixman_get_type(int rshift, int gshift, int bshift)
         if (bshift == 0) {
             type = PIXMAN_TYPE_ARGB;
         } else {
-#if PIXMAN_VERSION >= PIXMAN_VERSION_ENCODE(0, 21, 8)
             type = PIXMAN_TYPE_RGBA;
-#endif
         }
     } else if (rshift < gshift && gshift < bshift) {
         if (rshift == 0) {
             type = PIXMAN_TYPE_ABGR;
         } else {
-#if PIXMAN_VERSION >= PIXMAN_VERSION_ENCODE(0, 16, 0)
             type = PIXMAN_TYPE_BGRA;
-#endif
         }
     }
     return type;
diff --git a/.gitmodules b/.gitmodules
index 5b0c212622..84c54cdc49 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -22,9 +22,6 @@
 [submodule "roms/sgabios"]
 	path = roms/sgabios
 	url = git://git.qemu-project.org/sgabios.git
-[submodule "pixman"]
-	path = pixman
-	url = git://anongit.freedesktop.org/pixman
 [submodule "dtc"]
 	path = dtc
 	url = git://git.qemu-project.org/dtc.git
diff --git a/pixman b/pixman
deleted file mode 160000
index 87eea99e44..0000000000
--- a/pixman
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 87eea99e443b389c978cf37efc52788bf03a0ee0
-- 
2.9.3
