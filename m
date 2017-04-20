Received: from eggs.gnu.org ([2001:4830:134:3::10]:43459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1B14-0002BP-E6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1B0y-0000RV-BH
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:16:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d1B0y-0000R6-2W
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 034C1635D9
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 12:16:47 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 20 Apr 2017 13:16:39 +0100
Message-Id: <20170420121639.32685-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH RFC] dist: create separate dist with bundled
 roms/libs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The qemu-XXXX.tar.bz2 currently contains bundled copies of the pixman
and dtc codebases, as well as pre-built ROM binaries and their sources.

Many OS distros want to build & ship ROMs separately to ensure license
compliance. Similarly they'll build pixman/dtc code independantly to
allow sharing with the rest of the distro. Thus they'll never use these
bundled files. A further complication is that these bundled files create
extra auditing work for distros when applying for export compliance,
particularly when the bundled files contain crypto code. This burden
applies merely by having the files in the tar.bz2, even if they're not
built into the binaries. If we ever want to include UEFI ROMs for x86
or AArch64, then the size of the QEMU dist will increase significantly
more.

The bundled ROMs though are fairly useful to end-users who are building
QEMU themselves and don't want to worry about figuring out the right
BIOS bits to build manually, so they shouldn't be dropped entirely.

This change thus alters 'make dist' to generate two release archives

 - qemu-XXX.tar.bz2 - minimal archive with only QEMU source code
 - qemu-bundled-XXX.tar.bz2 - QEMU source, plus bundled ROMs & libs

NB1, as it stands this change breaks "make install" since that assumes
existance of the pre-built ROMs in tree.

NB2, an alternative approach would be:

 - qemu-XXX.tar.bz2 - minimal archive with only QEMU source code
 - qemu-roms-XXX.tar.bz2 - only bundled ROMs

and thus never ship a tar.bz2 that contains everything together,
and stop shipping pixman/dtc entirely.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile             |  5 ++++-
 scripts/make-release | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 6c359b2..78f7c0c 100644
--- a/Makefile
+++ b/Makefile
@@ -503,7 +503,10 @@ clean:
 
 VERSION ?= $(shell cat VERSION)
 
-dist: qemu-$(VERSION).tar.bz2
+dist: qemu-$(VERSION).tar.bz2 qemu-bundled-$(VERSION).tar.bz2
+
+qemu-bundled-%.tar.bz2:
+	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-bundled-%.tar.bz2,%,$@)" --bundled
 
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
diff --git a/scripts/make-release b/scripts/make-release
index fa6323f..8e4a653 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -12,14 +12,42 @@
 
 src="$1"
 version="$2"
+shift
+shift
+bundled=no
+
+for opt do
+  case "$opt" in
+      --bundled)
+	  bundled=yes
+	  ;;
+      *)
+	  echo "Unknown arg '$opt'"
+	  exit 1
+  esac
+done
+
 destination=qemu-${version}
+if test "$bundled" = "yes"
+then
+    archive=qemu-bundled-${version}.tar.bz2
+else
+    archive=qemu-${version}.tar.bz2
+fi
 
 git clone "${src}" ${destination}
 pushd ${destination}
 git checkout "v${version}"
-git submodule update --init
-(cd roms/seabios && git describe --tags --long --dirty > .version)
-rm -rf .git roms/*/.git dtc/.git pixman/.git
+if test "$bundled" = "yes"
+then
+    git submodule update --init
+    (cd roms/seabios && git describe --tags --long --dirty > .version)
+    rm -rf .git roms/*/.git dtc/.git pixman/.git
+else
+    rm -rf .git roms dtc pixman
+    rm -f pc-bios/*.{rom,bin} pc-bios/{openbios*,u-boot.s500}
+fi
+
 popd
-tar cfj ${destination}.tar.bz2 ${destination}
+tar cfj ${archive} ${destination}
 rm -rf ${destination}
-- 
2.9.3
