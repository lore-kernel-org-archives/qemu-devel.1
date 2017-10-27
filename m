Received: from eggs.gnu.org ([2001:4830:134:3::10]:46128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84T4-0003YP-8S
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84T0-0006dW-23
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e84Sz-0006bK-Pq
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:29 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 27 Oct 2017 14:14:11 +0100
Message-Id: <20171027131412.18830-4-berrange@redhat.com>
In-Reply-To: <20171027131412.18830-1-berrange@redhat.com>
References: <20171027131412.18830-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] build: allow automatic git submodule
 updates to be disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Some people building QEMU use VPATH builds where the source directory is on a
read-only volume. In such a case 'scripts/git-submodules.sh update' will always
fail and users are required to run it manually themselves on their original
writable source directory.

While this is already supported, it is nice to give users a command line flag
to configure to permanently disable automatic submodule updates, as it means
they won't get hard to diagnose failures from git-submodules.sh at an arbitrary
later date.

This patch thus introduces a flag '--disable-git-update' which will prevent
'make' from ever running 'scripts/git-submodules.sh update'. It will still run
the 'status' command to determine if a submodule update is needed, but when it
does this it'll simply stop and print a message instructing the developer what
todo. eg

$ ./configure  --target-list=x86_64-softmmu --disable-git-update
...snip...

$ make
  GEN     config-host.h
  GEN     trace/generated-tcg-tracers.h
  GEN     trace/generated-helpers-wrappers.h
  GEN     trace/generated-helpers.h
  GEN     trace/generated-helpers.c
  GEN     module_block.h

GIT submodule checkout is out of date. Please run
  scripts/git-submodule.sh update ui/keycodemapdb
from the source directory checkout /home/berrange/src/virt/qemu

make: *** [Makefile:31: git-submodule-update] Error 1

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile                 | 11 +++++++++++
 configure                |  9 ++++++++-
 scripts/git-submodule.sh |  9 +++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4c9d0eaef2..cefb75dc8d 100644
--- a/Makefile
+++ b/Makefile
@@ -26,12 +26,23 @@ ifeq (0,$(MAKELEVEL))
   )
 
 ifeq (1,$(git_module_status))
+ifeq (no,$(GIT_UPDATE))
+git-submodule-update:
+	$(call quiet-command, \
+            echo && \
+            echo "GIT submodule checkout is out of date. Please run" && \
+            echo "  scripts/git-submodule.sh update $(GIT_SUBMODULES)" && \
+            echo "from the source directory checkout $(SRC_PATH)" && \
+            echo && \
+            exit 1)
+else
 git-submodule-update:
 	$(call quiet-command, \
           (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
           "GIT","$(GIT_SUBMODULES)")
 endif
 endif
+endif
 
 .git-submodule-status: git-submodule-update config-host.mak
 
diff --git a/configure b/configure
index 65765968f3..8a569e1770 100755
--- a/configure
+++ b/configure
@@ -267,8 +267,10 @@ stack_protector=""
 
 if test -e "$source_path/.git"
 then
+    git_update=yes
     git_submodules="ui/keycodemapdb"
 else
+    git_update=no
     git_submodules=""
 fi
 git="git"
@@ -1297,11 +1299,15 @@ for opt do
   ;;
   --with-git=*) git="$optarg"
   ;;
+  --enable-git-update) git_update=yes
+  ;;
+  --disable-git-update) git_update=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
       exit 1
-  ;;
+      ;;
   esac
 done
 
@@ -5534,6 +5540,7 @@ echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
+echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 586ff32293..30fd83db55 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -48,6 +48,15 @@ update)
         echo
         echo " $ ./configure --with-git='tsocks git'"
         echo
+        echo "Alternatively you may disable automatic GIT submodule checkout"
+        echo "with:"
+        echo
+        echo " $ ./configure --disable-git-update'"
+        echo
+        echo "and then manually update submodules prior to running make, with:"
+        echo
+        echo " $ scripts/git-sbumodule.sh update $modules"
+        echo
         exit 1
     fi
     $GIT submodule status $modules > "${substat}"
-- 
2.13.6
