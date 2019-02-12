Received: from eggs.gnu.org ([209.51.188.92]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtb2Z-0005PF-6i
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtasU-0000w1-B1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtasT-0000dB-UK
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:46 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:25:23 +0100
Message-Id: <20190212162524.31504-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190212162524.31504-1-marcandre.lureau@redhat.com>
References: <20190212162524.31504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/7] build-sys: link with slirp as an external
 project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, peter.maydell@linaro.org

Use the "system" libslirp if its present or requested.

Else build with a static libslirp.a if slirp/ is checked
out ("internal") or a submodule ("git").

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/slirp.c        |  2 +-
 Makefile           |  8 +++---
 Makefile.objs      |  1 -
 Makefile.target    |  5 +---
 configure          | 65 +++++++++++++++++++++++++++++++++++++++++++---
 net/Makefile.objs  |  2 ++
 util/Makefile.objs |  1 +
 7 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index b3bb1880c7..9c69500a36 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -37,7 +37,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "slirp/src/libslirp.h"
+#include <libslirp.h>
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
diff --git a/Makefile b/Makefile
index 3658310b95..55188d9e0a 100644
--- a/Makefile
+++ b/Makefile
@@ -382,8 +382,7 @@ dummy :=3D $(call unnest-vars,, \
                 ui-obj-m \
                 audio-obj-y \
                 audio-obj-m \
-                trace-obj-y \
-                slirp-obj-y)
+                trace-obj-y)
=20
 include $(SRC_PATH)/tests/Makefile.include
=20
@@ -456,7 +455,10 @@ CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
 subdir-capstone: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=3D=
no BUILDDIR=3D"$(BUILD_DIR)/capstone" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(L=
D)" RANLIB=3D"$(RANLIB)" CFLAGS=3D"$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(B=
UILD_DIR)/capstone/$(LIBCAPSTONE))
=20
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) $(slirp-=
obj-y) \
+subdir-slirp: .git-submodule-status
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR=3D"$(BUILD_=
DIR)/slirp" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" C=
FLAGS=3D"$(QEMU_CFLAGS)")
+
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
=20
 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
diff --git a/Makefile.objs b/Makefile.objs
index b7aae33367..90a7edeb4b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -17,7 +17,6 @@ util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o=
)
 util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
-slirp-obj-$(CONFIG_SLIRP) =3D slirp/
=20
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index 401dc1ea6f..cb85eb450c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -173,7 +173,6 @@ target-obj-y :=3D
 block-obj-y :=3D
 common-obj-y :=3D
 chardev-obj-y :=3D
-slirp-obj-y :=3D
 include $(SRC_PATH)/Makefile.objs
 dummy :=3D $(call unnest-vars,,target-obj-y)
 target-obj-y-save :=3D $(target-obj-y)
@@ -186,8 +185,7 @@ dummy :=3D $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m \
-               slirp-obj-y)
+               common-obj-m)
 target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
 all-obj-y +=3D $(target-obj-y)
@@ -196,7 +194,6 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chard=
ev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
-all-obj-$(CONFIG_SOFTMMU) +=3D $(slirp-obj-y)
=20
 $(QEMU_PROG_BUILD): config-devices.mak
=20
diff --git a/configure b/configure
index fbd0825488..3664911a14 100755
--- a/configure
+++ b/configure
@@ -406,7 +406,7 @@ includedir=3D"\${prefix}/include"
 sysconfdir=3D"\${prefix}/etc"
 local_statedir=3D"\${prefix}/var"
 confsuffix=3D"/qemu"
-slirp=3D"yes"
+slirp=3D""
 oss_lib=3D""
 bsd=3D"no"
 linux=3D"no"
@@ -1106,6 +1106,10 @@ for opt do
   ;;
   --disable-slirp) slirp=3D"no"
   ;;
+  --enable-slirp=3Dgit) slirp=3D"git"
+  ;;
+  --enable-slirp=3Dsystem) slirp=3D"system"
+  ;;
   --disable-vde) vde=3D"no"
   ;;
   --enable-vde) vde=3D"yes"
@@ -5690,6 +5694,55 @@ if test "$libpmem" !=3D "no"; then
 	fi
 fi
=20
+##########################################
+# check for slirp
+
+case "$slirp" in
+  "" | yes)
+    if $pkg_config slirp; then
+      slirp=3Dsystem
+    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; t=
hen
+      slirp=3Dgit
+    elif test -e "${source_path}/slirp/Makefile" ; then
+      slirp=3Dinternal
+    elif test -z "$slirp" ; then
+      slirp=3Dno
+    else
+      feature_not_found "slirp" "Install slirp devel or git submodule"
+    fi
+    ;;
+
+  system)
+    if ! $pkg_config slirp; then
+      feature_not_found "slirp" "Install slirp devel"
+    fi
+    ;;
+esac
+
+case "$slirp" in
+  git | internal)
+    if test "$slirp" =3D git; then
+      git_submodules=3D"${git_submodules} slirp"
+    fi
+    mkdir -p slirp
+    slirp_cflags=3D"-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
+    slirp_libs=3D"-L\$(BUILD_DIR)/slirp -lslirp"
+    ;;
+
+  system)
+    slirp_version=3D$($pkg_config --modversion slirp 2>/dev/null)
+    slirp_cflags=3D$($pkg_config --cflags slirp 2>/dev/null)
+    slirp_libs=3D$($pkg_config --libs slirp 2>/dev/null)
+    ;;
+
+  no)
+    ;;
+  *)
+    error_exit "Unknown state for slirp: $slirp"
+    ;;
+esac
+
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -6047,7 +6100,8 @@ echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
 echo "python            $python ($python_version)"
-if test "$slirp" =3D "yes" ; then
+echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
+if test "$slirp" !=3D "no" ; then
     echo "smbd              $smbd"
 fi
 echo "module support    $modules"
@@ -6307,9 +6361,14 @@ fi
 if test "$profiler" =3D "yes" ; then
   echo "CONFIG_PROFILER=3Dy" >> $config_host_mak
 fi
-if test "$slirp" =3D "yes" ; then
+if test "$slirp" !=3D "no"; then
   echo "CONFIG_SLIRP=3Dy" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=3D\"$smbd\"" >> $config_host_mak
+  echo "SLIRP_CFLAGS=3D$slirp_cflags" >> $config_host_mak
+  echo "SLIRP_LIBS=3D$slirp_libs" >> $config_host_mak
+fi
+if [ "$slirp" =3D "git" -o "$slirp" =3D "internal" ]; then
+    echo "config-host.h: subdir-slirp" >> $config_host_mak
 fi
 if test "$vde" =3D "yes" ; then
   echo "CONFIG_VDE=3Dy" >> $config_host_mak
diff --git a/net/Makefile.objs b/net/Makefile.objs
index b2bf88a0ef..7282c57c94 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -5,6 +5,8 @@ common-obj-y +=3D eth.o
 common-obj-$(CONFIG_L2TPV3) +=3D l2tpv3.o
 common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
 common-obj-$(CONFIG_SLIRP) +=3D slirp.o
+slirp.o-cflags :=3D $(SLIRP_CFLAGS)
+slirp.o-libs :=3D $(SLIRP_LIBS)
 common-obj-$(CONFIG_VDE) +=3D vde.o
 common-obj-$(CONFIG_NETMAP) +=3D netmap.o
 common-obj-y +=3D filter.o
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 0820923c18..d67a31452f 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -3,6 +3,7 @@ util-obj-y +=3D bufferiszero.o
 util-obj-y +=3D lockcnt.o
 util-obj-y +=3D aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
 util-obj-y +=3D main-loop.o iohandler.o
+main-loop.o-cflags :=3D $(SLIRP_CFLAGS)
 util-obj-$(call lnot,$(CONFIG_ATOMIC64)) +=3D atomic64.o
 util-obj-$(CONFIG_POSIX) +=3D aio-posix.o
 util-obj-$(CONFIG_POSIX) +=3D compatfd.o
--=20
2.21.0.rc0.1.g036caf7885
