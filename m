Received: from eggs.gnu.org ([2001:4830:134:3::10]:52978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wJ-0001kF-I4
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wF-0000Ed-8x
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC0wF-0000E8-1W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:16:59 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  7 Nov 2017 10:16:37 +0000
Message-Id: <20171107101642.28016-2-berrange@redhat.com>
In-Reply-To: <20171107101642.28016-1-berrange@redhat.com>
References: <20171107101642.28016-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/6] build: allow setting a custom GIT binary
 for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Some users can't run a bare 'git' command, due to need for a transparent
proxying solution such as 'tsocks'. This adds an argument to configure to
let users specify such a thing:

  ./configure --with-git=3D"tsocks git"

The submodule script is also updated to give the user a hint about using =
this
flag, if we fail to checkout modules.

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
   git_module_status :=3D $(shell \
     cd '$(SRC_PATH)' && \
-    ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
+    GIT=3D"$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); =
\
     echo $$?; \
   )
=20
 ifeq (1,$(git_module_status))
 git-submodule-update:
 	$(call quiet-command, \
-          (cd $(SRC_PATH) && ./scripts/git-submodule.sh update $(GIT_SUB=
MODULES)), \
+          (cd $(SRC_PATH) && GIT=3D"$(GIT)" ./scripts/git-submodule.sh u=
pdate $(GIT_SUBMODULES)), \
           "GIT","$(GIT_SUBMODULES)")
 endif
 endif
diff --git a/configure b/configure
index e31d6a7fee..5af463fed6 100755
--- a/configure
+++ b/configure
@@ -271,6 +271,7 @@ then
 else
     git_submodules=3D""
 fi
+git=3D"git"
=20
 # Don't accept a target_list environment variable.
 unset target_list
@@ -1303,6 +1304,8 @@ for opt do
   ;;
   --enable-capstone=3Dsystem) capstone=3D"system"
   ;;
+  --with-git=3D*) git=3D"$optarg"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -5413,6 +5416,7 @@ echo "local state directory   queried at runtime"
 echo "Windows SDK       $win_sdk"
 fi
 echo "Source path       $source_path"
+echo "GIT binary        $git"
 echo "GIT submodules    $git_submodules"
 echo "C compiler        $cc"
 echo "Host C compiler   $host_cc"
@@ -5604,6 +5608,7 @@ echo "extra_cxxflags=3D$EXTRA_CXXFLAGS" >> $config_=
host_mak
 echo "extra_ldflags=3D$EXTRA_LDFLAGS" >> $config_host_mak
 echo "qemu_localedir=3D$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=3D$libs_softmmu" >> $config_host_mak
+echo "GIT=3D$git" >> $config_host_mak
 echo "GIT_SUBMODULES=3D$git_submodules" >> $config_host_mak
=20
 echo "ARCH=3D$ARCH" >> $config_host_mak
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 08932a35f0..039f782d81 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -3,14 +3,27 @@
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
=20
-set -e
-
 substat=3D".git-submodule-status"
=20
 command=3D$1
 shift
 modules=3D"$@"
=20
+test -z "$GIT" && GIT=3Dgit
+
+error() {
+    echo "$0: $*"
+    echo
+    echo "Unable to automatically checkout GIT submodules '$modules'."
+    echo "If you require use of an alternative GIT binary (for example t=
o"
+    echo "enable use of a transparent proxy), then please specify it by"
+    echo "running configure by with the '--with-git' argument. e.g."
+    echo
+    echo " $ ./configure --with-git=3D'tsocks git'"
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
--=20
2.13.6
