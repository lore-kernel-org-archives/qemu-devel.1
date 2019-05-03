Received: from eggs.gnu.org ([209.51.188.92]:55082)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hMTXu-0000ye-Qn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hMTXt-0006vm-OC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:54 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:39643
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hMTXt-0006tw-BL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:53 -0400
From: Antonio Ospite <ao2@ao2.it>
Date: Fri,  3 May 2019 10:27:28 +0200
Message-Id: <20190503082728.16485-3-ao2@ao2.it>
In-Reply-To: <20190503082728.16485-1-ao2@ao2.it>
References: <20190503082728.16485-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] configure: disallow spaces and colons
 in source path and build path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Antonio Ospite <antonio.ospite@collabora.com>, Antonio Ospite <ao2@ao2.it>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

From: Antonio Ospite <antonio.ospite@collabora.com>

The configure script breaks when the qemu source directory is in a path
containing white spaces, in particular the list of targets is not
correctly generated when calling "./configure --help" because of how the
default_target_list variable is built.

In addition to that, *building* qemu from a directory with spaces breaks
some assumptions in the Makefiles, even if the original source path does
not contain spaces like in the case of an out-of-tree build, or when
symlinks are involved.

To avoid these issues, refuse to run the configure script and the
Makefile if there are spaces or colons in the source path or the build
path, taking as inspiration what the kbuild system in linux does.

Buglink: https://bugs.launchpad.net/qemu/+bug/1817345

Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
---
 Makefile  | 4 ++++
 configure | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 1211e78c91..7f3f7a7fef 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,9 @@
 # Makefile for QEMU.
 
+ifneq ($(words $(subst :, ,$(CURDIR))), 1)
+  $(error main directory cannot contain spaces nor colons)
+endif
+
 # Always point to the root of the build tree (needs GNU make).
 BUILD_DIR=$(CURDIR)
 
diff --git a/configure b/configure
index 9832cbca5c..f7ad4381bd 100755
--- a/configure
+++ b/configure
@@ -279,6 +279,12 @@ ld_has() {
 # make source path absolute
 source_path=$(cd "$(dirname -- "$0")"; pwd)
 
+if printf "%s\n" "$source_path" | grep -q "[[:space:]:]" ||
+  printf "%s\n" "$PWD" | grep -q "[[:space:]:]";
+then
+  error_exit "main directory cannot contain spaces nor colons"
+fi
+
 # default parameters
 cpu=""
 iasl="iasl"
-- 
2.20.1
