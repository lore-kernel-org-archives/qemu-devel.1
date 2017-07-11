Received: from eggs.gnu.org ([2001:4830:134:3::10]:46567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxle-0001S9-S0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxla-0006wZ-7p
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:47 +0200
Message-Id: <20170711160814.20941-59-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 58/85] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

A user may specify a relative path for accessing qemu, qemu-img, etc.
through environment variables ($QEMU_PROG and friends) or a symlink.

If a test decides to change its working directory, relative paths will
cease to work, however. Work around this by making all of the paths to
programs that should undergo testing absolute. Besides "realpath", we
also have to use "type -p" to support programs in $PATH.

As a side effect, this fixes specifying these programs as symlinks for
out-of-tree builds: Before, you would have to create two symlinks, one
in the build and one in the source tree (the first one for common.config
to find, the second one for the iotest to use). Now it is sufficient to
create one in the build tree because common.config will resolve it.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170702150510.23276-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.config | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index d1b45f5..e0883a0 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -103,6 +103,17 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
     export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
 fi
 
+export QEMU_PROG=$(realpath -- "$(type -p "$QEMU_PROG")")
+export QEMU_IMG_PROG=$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
+export QEMU_IO_PROG=$(realpath -- "$(type -p "$QEMU_IO_PROG")")
+export QEMU_NBD_PROG=$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
+
+# This program is not built as part of qemu but (possibly) provided by the
+# system, so it may not be present at all
+if [ -n "$QEMU_VXHS_PROG" ]; then
+    export QEMU_VXHS_PROG=$(realpath -- "$(type -p "$QEMU_VXHS_PROG")")
+fi
+
 _qemu_wrapper()
 {
     (
-- 
2.9.4
