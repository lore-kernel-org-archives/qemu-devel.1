Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxsHK-0000o5-Io
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxsHI-0008N6-Au
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:12:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxsHI-0008Mw-1U
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:12:16 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 29 Sep 2017 11:11:56 +0100
Message-Id: <20170929101201.21039-2-berrange@redhat.com>
In-Reply-To: <20170929101201.21039-1-berrange@redhat.com>
References: <20170929101201.21039-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v8 1/6] build: automatically handle GIT
 submodule checkout for dtc
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Currently if DTC is required by configure and not available in the host
OS install, we exit with an error message telling the user to checkout a
git submodule or install the library.

This introduces automatic handling of the git submodule checkout process
and enables it for dtc. This only runs if building from GIT, so users of
release tarballs still need the system library install. The current state
of the git checkout is stashed in .git-submodule-status, and a helper
program is used to determine if this state matches the desired submodule
state. A dependency against 'Makefile' ensures that the submodule state
is refreshed at the start of the build process

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .gitignore               |  1 +
 MAINTAINERS              |  6 ++++++
 Makefile                 | 25 ++++++++++++++++++++++++-
 configure                | 46 ++++++++++++++++++++++++++--------------------
 scripts/git-submodule.sh | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 21 deletions(-)
 create mode 100755 scripts/git-submodule.sh

diff --git a/.gitignore b/.gitignore
index 40acfcb9e2..06bf972fc3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,6 +112,7 @@
 /docs/version.texi
 *.tps
 .stgit-*
+.git-submodule-status
 cscope.*
 tags
 TAGS
diff --git a/MAINTAINERS b/MAINTAINERS
index 932443df41..7708bbb21d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1947,3 +1947,9 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/build-system.txt
 
+Build System
+------------
+GIT submodules
+M: Daniel P. Berrange <berrange@redhat.com>
+S: Odd Fixes
+F: scripts/git-submodule.sh
diff --git a/Makefile b/Makefile
index 2be61fcf1c..c00ed7141a 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,29 @@ ifneq ($(wildcard config-host.mak),)
 all:
 include config-host.mak
 
+git-submodule-update:
+
+.PHONY: git-submodule-update
+
+ifeq (0,$(MAKELEVEL))
+  git_module_status := $(shell \
+    cd '$(SRC_PATH)' && \
+    ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
+    echo $$?; \
+  )
+
+ifeq (1,$(git_module_status))
+git-submodule-update:
+	$(call quiet-command, \
+          (cd $(SRC_PATH) && ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
+          "GIT","$(GIT_SUBMODULES)")
+endif
+endif
+
+.git-submodule-status: git-submodule-update
+
+Makefile: .git-submodule-status
+
 # Check that we're not trying to do an out-of-tree build from
 # a tree that's been used for an in-tree build.
 ifneq ($(realpath $(SRC_PATH)),$(realpath .))
@@ -329,7 +352,7 @@ DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_src
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
 DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
 
-subdir-dtc:dtc/libfdt dtc/tests
+subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
 	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
 
 dtc/%:
diff --git a/configure b/configure
index 7727f6ba5b..b324e057f1 100755
--- a/configure
+++ b/configure
@@ -264,6 +264,7 @@ cc_i386=i386-pc-linux-gnu-gcc
 libs_qga=""
 debug_info="yes"
 stack_protector=""
+git_submodules=""
 
 # Don't accept a target_list environment variable.
 unset target_list
@@ -3580,27 +3581,30 @@ EOF
   if compile_prog "" "$fdt_libs" ; then
     # system DTC is good - use it
     fdt=yes
-  elif test -d ${source_path}/dtc/libfdt ; then
-    # have submodule DTC - use it
-    fdt=yes
-    dtc_internal="yes"
-    mkdir -p dtc
-    if [ "$pwd_is_source_path" != "y" ] ; then
-       symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-       symlink "$source_path/dtc/scripts" "dtc/scripts"
-    fi
-    fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
-    fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
-  elif test "$fdt" = "yes" ; then
-    # have neither and want - prompt for system/submodule install
-    error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:" \
-        "  (1) Preferred: Install the DTC (libfdt) devel package" \
-        "  (2) Fetch the DTC submodule, using:" \
-        "      git submodule update --init dtc"
   else
-    # don't have and don't want
-    fdt_libs=
-    fdt=no
+      # have GIT checkout, so activate dtc submodule
+      if test -e "${source_path}/.git" ; then
+          git_submodules="${git_submodules} dtc"
+      fi
+      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
+          fdt=yes
+          dtc_internal="yes"
+          mkdir -p dtc
+          if [ "$pwd_is_source_path" != "y" ] ; then
+              symlink "$source_path/dtc/Makefile" "dtc/Makefile"
+              symlink "$source_path/dtc/scripts" "dtc/scripts"
+          fi
+          fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
+          fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
+      elif test "$fdt" = "yes" ; then
+          # Not a git build & no libfdt found, prompt for system install
+          error_exit "DTC (libfdt) version >= 1.4.2 not present." \
+                     "Please install the DTC (libfdt) devel package"
+      else
+          # don't have and don't want
+          fdt_libs=
+          fdt=no
+      fi
   fi
 fi
 
@@ -5290,6 +5294,7 @@ echo "local state directory   queried at runtime"
 echo "Windows SDK       $win_sdk"
 fi
 echo "Source path       $source_path"
+echo "GIT submodules    $git_submodules"
 echo "C compiler        $cc"
 echo "Host C compiler   $host_cc"
 echo "C++ compiler      $cxx"
@@ -5477,6 +5482,7 @@ echo "extra_cxxflags=$EXTRA_CXXFLAGS" >> $config_host_mak
 echo "extra_ldflags=$EXTRA_LDFLAGS" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
+echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
new file mode 100755
index 0000000000..9f73f0e6e3
--- /dev/null
+++ b/scripts/git-submodule.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+
+set -e
+
+substat=".git-submodule-status"
+
+command=$1
+shift
+modules="$@"
+
+if test -z "$modules"
+then
+    test -e $substat || touch $substat
+    exit 0
+fi
+
+if ! test -e ".git"
+then
+    echo "$0: unexpectedly called with submodules but no git checkout exists"
+    exit 1
+fi
+
+case "$command" in
+status)
+    test -f "$substat" || exit 1
+    trap "rm -f ${substat}.tmp" EXIT
+    git submodule status $modules > "${substat}.tmp"
+    diff "${substat}" "${substat}.tmp" >/dev/null
+    exit $?
+    ;;
+update)
+    git submodule update --init $modules 1>/dev/null 2>&1
+    git submodule status $modules > "${substat}"
+    ;;
+esac
-- 
2.13.5
