Received: from eggs.gnu.org ([2001:4830:134:3::10]:52982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wJ-0001kH-It
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC0wH-0000GY-W6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC0wH-0000Fr-O6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:17:01 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  7 Nov 2017 10:16:39 +0000
Message-Id: <20171107101642.28016-4-berrange@redhat.com>
In-Reply-To: <20171107101642.28016-1-berrange@redhat.com>
References: <20171107101642.28016-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 3/6] build: allow automatic git submodule
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Some people building QEMU use VPATH builds where the source directory is =
on a
read-only volume. In such a case 'scripts/git-submodules.sh update' will =
always
fail and users are required to run it manually themselves on their origin=
al
writable source directory.

While this is already supported, it is nice to give users a command line =
flag
to configure to permanently disable automatic submodule updates, as it me=
ans
they won't get hard to diagnose failures from git-submodules.sh at an arb=
itrary
later date.

This patch thus introduces a flag '--disable-git-update' which will preve=
nt
'make' from ever running 'scripts/git-submodules.sh update'. It will stil=
l run
the 'status' command to determine if a submodule update is needed, but wh=
en it
does this it'll simply stop and print a message instructing the developer=
 what
todo. eg

$ ./configure  --target-list=3Dx86_64-softmmu --disable-git-update
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

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile                 | 11 +++++++++++
 configure                |  7 +++++++
 scripts/git-submodule.sh |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/Makefile b/Makefile
index d218f8f3c8..a92d7b8e14 100644
--- a/Makefile
+++ b/Makefile
@@ -26,12 +26,23 @@ ifeq (0,$(MAKELEVEL))
   )
=20
 ifeq (1,$(git_module_status))
+ifeq (no,$(GIT_UPDATE))
+git-submodule-update:
+	$(call quiet-command, \
+            echo && \
+            echo "GIT submodule checkout is out of date. Please run" && =
\
+            echo "  scripts/git-submodule.sh update $(GIT_SUBMODULES)" &=
& \
+            echo "from the source directory checkout $(SRC_PATH)" && \
+            echo && \
+            exit 1)
+else
 git-submodule-update:
 	$(call quiet-command, \
           (cd $(SRC_PATH) && GIT=3D"$(GIT)" ./scripts/git-submodule.sh u=
pdate $(GIT_SUBMODULES)), \
           "GIT","$(GIT_SUBMODULES)")
 endif
 endif
+endif
=20
 .git-submodule-status: git-submodule-update config-host.mak
=20
diff --git a/configure b/configure
index 5af463fed6..a6055c0710 100755
--- a/configure
+++ b/configure
@@ -267,8 +267,10 @@ stack_protector=3D""
=20
 if test -e "$source_path/.git"
 then
+    git_update=3Dyes
     git_submodules=3D"ui/keycodemapdb"
 else
+    git_update=3Dno
     git_submodules=3D""
 fi
 git=3D"git"
@@ -1306,6 +1308,10 @@ for opt do
   ;;
   --with-git=3D*) git=3D"$optarg"
   ;;
+  --enable-git-update) git_update=3Dyes
+  ;;
+  --disable-git-update) git_update=3Dno
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -5610,6 +5616,7 @@ echo "qemu_localedir=3D$qemu_localedir" >> $config_=
host_mak
 echo "libs_softmmu=3D$libs_softmmu" >> $config_host_mak
 echo "GIT=3D$git" >> $config_host_mak
 echo "GIT_SUBMODULES=3D$git_submodules" >> $config_host_mak
+echo "GIT_UPDATE=3D$git_update" >> $config_host_mak
=20
 echo "ARCH=3D$ARCH" >> $config_host_mak
=20
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 21909ea413..63ace6fc55 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -21,6 +21,15 @@ error() {
     echo
     echo " $ ./configure --with-git=3D'tsocks git'"
     echo
+    echo "Alternatively you may disable automatic GIT submodule checkout=
"
+    echo "with:"
+    echo
+    echo " $ ./configure --disable-git-update'"
+    echo
+    echo "and then manually update submodules prior to running make, wit=
h:"
+    echo
+    echo " $ scripts/git-sbumodule.sh update $modules"
+    echo
     exit 1
 }
=20
--=20
2.13.6
