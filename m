Received: from eggs.gnu.org ([2001:4830:134:3::10]:35461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRfWe-00014L-Ui
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRfWb-0002EU-PP
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:11:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  9 Jun 2018 12:10:48 -0300
Message-Id: <20180609151048.9628-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] Makefile: Check for more dangling scratch
 files in out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org

It is easy to catch the generated 'config-host.mak' in the source
tree, however qemu-version.h and qemu-options.def are also generated
files and are hidden by .gitignore rules.

Improve the out-of-tree safety net rule added in d1bd2423a90,
by also checking for these two files.

This solves building issues with out-of-tree builds from a
source tree that has been built in:

- /qemu-version.h existing in source tree:

    /source/qemu/qemu-nbd.c: In function ‘version’:
    /source/qemu/qemu-nbd.c:133:6: error: expected ‘)’ before
    ‘QEMU_FULL_VERSION’
     "%s " QEMU_FULL_VERSION "\n"
          ^~~~~~~~~~~~~~~~~~
          )
    /source/qemu/qemu-nbd.c:133:3: error: format ‘%s’ expects a matching
    ‘char *’ argument [-Werror=format=]
     "%s " QEMU_FULL_VERSION "\n"
      ~^
    cc1: all warnings being treated as errors

- /qemu-options.def existing in source tree:

    /source/qemu/vl.c: In function ‘main’:
    /source/qemu/vl.c:3052:18: error: ‘QEMU_OPTION_blockdev’ undeclared
    (first use in this function); did you mean ‘QEMU_OPTION_clock’?
                 case QEMU_OPTION_blockdev:
                      ^~~~~~~~~~~~~~~~~~~~
                      QEMU_OPTION_clock
    /source/qemu/vl.c:3052:18: note: each undeclared identifier is reported
    only once for each function it appears in

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1 http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg02254.html:
Peter noticed [1] those files already are in GENERATED_FILES

[1] http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg02338.html

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 023b3437ec..521009964c 100644
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,8 @@ endif
 # Check that we're not trying to do an out-of-tree build from
 # a tree that's been used for an in-tree build.
 ifneq ($(realpath $(SRC_PATH)),$(realpath .))
-ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
+scratch_files = config-host.mak qemu-version.h qemu-options.def
+ifneq ($(wildcard $(addprefix $(SRC_PATH)/,$(scratch_files))),)
 $(error This is an out of tree build but your source tree ($(SRC_PATH)) \
 seems to have been used for an in-tree build. You can fix this by running \
 "$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree)
-- 
2.17.1
