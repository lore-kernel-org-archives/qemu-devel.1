Received: from eggs.gnu.org ([2001:4830:134:3::10]:47142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyIBN-0004nl-CE
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyIBH-00075L-Ki
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:24:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eyIBH-00074p-Fp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:24:03 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 20 Mar 2018 14:23:43 +0000
Message-Id: <20180320142343.13867-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] make: improve check for stale generated files
 in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When doing a build with builddir !=3D srcdir, if any generated files are
accidentally present in srcdir from a previous build, these can cause
unexpected failures.

Currently there is a rule that checks for existance of config-host.mak,
but there have been cases where config-host.mak is absent, while other
generated files still exist.

Update the check to look at every file listed in $(GENERATED_FILES). To
do this we must move the check further down after $(GENERATED_FILES) has
been populated.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index c8116694a0..73caabc019 100644
--- a/Makefile
+++ b/Makefile
@@ -52,16 +52,6 @@ endif
=20
 .git-submodule-status: git-submodule-update config-host.mak
=20
-# Check that we're not trying to do an out-of-tree build from
-# a tree that's been used for an in-tree build.
-ifneq ($(realpath $(SRC_PATH)),$(realpath .))
-ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
-$(error This is an out of tree build but your source tree ($(SRC_PATH)) =
\
-seems to have been used for an in-tree build. You can fix this by runnin=
g \
-"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree=
)
-endif
-endif
-
 CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
 CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_DIRS)),y)
 CONFIG_XEN :=3D $(CONFIG_XEN_BACKEND)
@@ -1027,6 +1017,25 @@ ifdef SIGNCODE
 endif # SIGNCODE
 endif # CONFIG_WIN
=20
+define nl
+
+
+endef
+
+CHECK_FILES =3D config-host.mak $(filter-out .git-submodule-status, $(GE=
NERATED_FILES))
+UNEXPECTED_FILES =3D $(wildcard $(CHECK_FILES:%=3D$(SRC_PATH)/%))
+
+# Check that we're not trying to do an out-of-tree build from
+# a tree that's been used for an in-tree build.
+ifneq ($(realpath $(SRC_PATH)),$(realpath .))
+ifneq ($(UNEXPECTED_FILES),)
+$(error Stale files in source tree:${nl}${nl} $(UNEXPECTED_FILES:%=3D  %=
${nl}) ${nl}\
+This is an out of tree build but your source tree ($(SRC_PATH)) \
+seems to have been used for an in-tree build. You can fix this by runnin=
g \
+"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree=
)
+endif
+endif
+
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
 ifneq ($(wildcard config-host.mak),)
--=20
2.14.3
