Received: from eggs.gnu.org ([2001:4830:134:3::10]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ezNk9-00046s-GY
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ezNk8-0003CM-IL
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:32:33 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 23 Mar 2018 15:31:58 +0100
Message-Id: <20180323143202.28879-2-lvivier@redhat.com>
In-Reply-To: <20180323143202.28879-1-lvivier@redhat.com>
References: <20180323143202.28879-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/5] make: improve check for stale generated
 files in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

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
index 727ef118f3..d588a13687 100644
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
@@ -1028,6 +1018,25 @@ ifdef SIGNCODE
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
