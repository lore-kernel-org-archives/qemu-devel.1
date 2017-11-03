Received: from eggs.gnu.org ([2001:4830:134:3::10]:38126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdya-0007xu-1s
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdyZ-000142-0p
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAdyY-00011z-OA
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:42 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Nov 2017 15:33:29 +0000
Message-Id: <20171103153333.6416-2-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-1-berrange@redhat.com>
References: <20171103153333.6416-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/5] build: allow setting a custom GIT
 binary for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

Some users can't run a bare 'git' command, due to need for a transparent
proxying solution such as 'tsocks'. This adds an argument to configure to
let users specify such a thing:

  ./configure --with-git="tsocks git"

The submodule script is also updated to give the user a hint about using this
flag, if we fail to checkout modules.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile                 |  4 ++--
 configure                |  5 +++++
 scripts/git-submodule.sh | 29 ++++++++++++++++++++++++-----
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index ec73acfa9a..d218f8f3c8 100644
--- a/Makefile
+++ b/Makefile
@@ -21,14 +21,14 @@ git-submodule-update:
 ifeq (0,$(MAKELEVEL))
   git_module_status := $(shell \
     cd '$(SRC_PATH)' && \
-    ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
+    GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
     echo $$?; \
   )
 
 ifeq (1,$(git_module_status))
 git-submodule-update:
 	$(call quiet-command, \
-          (cd $(SRC_PATH) && ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
+          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
           "GIT","$(GIT_SUBMODULES)")
 endif
 endif
diff --git a/configure b/configure
index 285d123dbf..28ff481fe1 100755
--- a/configure
+++ b/configure
@@ -271,6 +271,7 @@ then
 else
     git_submodules=""
 fi
+git="git"
 
 # Don't accept a target_list environment variable.
 unset target_list
@@ -1303,6 +1304,8 @@ for opt do
   ;;
   --enable-capstone=system) capstone="system"
   ;;
+  --with-git=*) git="$optarg"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -5400,6 +5403,7 @@ echo "local state directory   queried at runtime"
 echo "Windows SDK       $win_sdk"
 fi
 echo "Source path       $source_path"
+echo "GIT binary        $git"
 echo "GIT submodules    $git_submodules"
 echo "C compiler        $cc"
 echo "Host C compiler   $host_cc"
@@ -5591,6 +5595,7 @@ echo "extra_cxxflags=$EXTRA_CXXFLAGS" >> $config_host_mak
 echo "extra_ldflags=$EXTRA_LDFLAGS" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
+echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 08932a35f0..039f782d81 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -3,14 +3,27 @@
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
 
-set -e
-
 substat=".git-submodule-status"
 
 command=$1
 shift
 modules="$@"
 
+test -z "$GIT" && GIT=git
+
+error() {
+    echo "$0: $*"
+    echo
+    echo "Unable to automatically checkout GIT submodules '$modules'."
+    echo "If you require use of an alternative GIT binary (for example to"
+    echo "enable use of a transparent proxy), then please specify it by"
+    echo "running configure by with the '--with-git' argument. e.g."
+    echo
+    echo " $ ./configure --with-git='tsocks git'"
+    echo
+    exit 1
+}
+
 if test -z "$modules"
 then
     test -e $substat || touch $substat
@@ -27,12 +40,18 @@ case "$command" in
 status)
     test -f "$substat" || exit 1
     trap "rm -f ${substat}.tmp" EXIT
-    git submodule status $modules > "${substat}.tmp"
+    $GIT submodule status $modules > "${substat}.tmp"
+    test $? -ne 0 && error "failed to query git submodule status"
     diff "${substat}" "${substat}.tmp" >/dev/null
     exit $?
     ;;
 update)
-    git submodule update --init $modules 1>/dev/null
-    git submodule status $modules > "${substat}"
+    $GIT submodule update --init $modules 1>/dev/null
+    test $? -ne 0 && error "failed to update modules"
+
+    $GIT submodule status $modules > "${substat}"
+    test $? -ne 0 && error "failed to save git submodule status" >&2
     ;;
 esac
+
+exit 0
-- 
2.13.6
