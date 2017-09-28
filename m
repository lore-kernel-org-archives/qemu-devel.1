Received: from eggs.gnu.org ([2001:4830:134:3::10]:52373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxUR6-0005Sf-RG
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxUR3-0005oh-FJ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxUR3-0005oD-6T
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:45 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 28 Sep 2017 09:44:25 +0100
Message-Id: <20170928084430.17059-2-berrange@redhat.com>
In-Reply-To: <20170928084430.17059-1-berrange@redhat.com>
References: <20170928084430.17059-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 1/6] build: automatically handle GIT
 submodule checkout for dtc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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
 Makefile                 | 21 +++++++++++++++++++++
 configure                | 46 ++++++++++++++++++++++++++--------------------
 scripts/git-submodule.sh | 31 +++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 20 deletions(-)
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
diff --git a/Makefile b/Makefile
index 2be61fcf1c..a0d33b7d80 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,27 @@ ifneq ($(wildcard config-host.mak),)
 all:
 include config-host.mak
 
+git-submodule-update:
+
+Makefile: git-submodule-update
+
+.PHONY: git-submodule-update
+
+ifeq (0,$(MAKELEVEL))
+  git_module_status := $(shell \
+    cd '$(SRC_PATH)'; \
+    ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
+    echo $$?; \
+  )
+
+ifeq (1,$(git_module_status))
+git-submodule-update:
+	$(call quiet-command, \
+          (cd $(SRC_PATH); ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
+          "GIT","$(GIT_SUBMODULES)")
+endif
+endif
+
 # Check that we're not trying to do an out-of-tree build from
 # a tree that's been used for an in-tree build.
 ifneq ($(realpath $(SRC_PATH)),$(realpath .))
diff --git a/configure b/configure
index 7727f6ba5b..ed4048f8b2 100755
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
+      if test -d ${source_path}/.git ; then
+	  git_submodules="${git_submodules} dtc"
+      fi
+      if test -d ${source_path}/dtc/libfdt || test -d ${source_path}/.git ; then
+	  fdt=yes
+	  dtc_internal="yes"
+	  mkdir -p dtc
+	  if [ "$pwd_is_source_path" != "y" ] ; then
+	      symlink "$source_path/dtc/Makefile" "dtc/Makefile"
+	      symlink "$source_path/dtc/scripts" "dtc/scripts"
+	  fi
+	  fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
+	  fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
+      elif test "$fdt" = "yes" ; then
+	  # have neither and want - prompt for system/submodule install
+	  error_exit "DTC (libfdt) version >= 1.4.2 not present." \
+		     "Please install the DTC (libfdt) devel package"
+      else
+	  # don't have and don't want
+	  fdt_libs=
+	  fdt=no
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
index 0000000000..f8e7d44ce6
--- /dev/null
+++ b/scripts/git-submodule.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+
+set -e
+
+command=$1
+shift
+modules="$@"
+
+test -z "$modules" && exit 0
+
+if ! test -d ".git"
+then
+    echo "$0: unexpectedly called with submodules but no git checkout exists"
+    exit 1
+fi
+
+substat=".git-submodule-status"
+
+case "$command" in
+status)
+    test -f "$substat" || exit 1
+    git submodule status $modules > "${substat}.tmp"
+    trap "rm -f ${substat}.tmp" EXIT
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
