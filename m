Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYOvG-00047I-VG
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYOvG-0002ZM-7f
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:48:15 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 20 Jul 2017 23:47:29 -0400
Message-Id: <20170721034730.25612-3-crosa@redhat.com>
In-Reply-To: <20170721034730.25612-1-crosa@redhat.com>
References: <20170721034730.25612-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-iotests: add _require_feature()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>

With the previously introduced buildconf.py script, it's possible
to determine if a feature needed by a test is present or not.  This
adds a thin layer on top of scripts/buildconf.py, and allows tests
to be skipped when a feature is required.

The naming of the function, while different in tense from the
_supported_* family of functions, was chosen to match the style
of _require_command(), which seems pretty similar.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/check     | 2 ++
 tests/qemu-iotests/common.rc | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 2a55ec9..c0f4004 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -60,6 +60,8 @@ fi
 
 build_root="$build_iotests/../.."
 
+export BUILDCONF="$build_root/scripts/buildconf.py"
+
 if [ -x "$build_iotests/socket_scm_helper" ]
 then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 2548e58..19b3111 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -470,6 +470,13 @@ _require_command()
     [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
 }
 
+# tests whether a given configure time feature is enabled
+#
+_require_feature()
+{
+    $BUILDCONF -c -n $1 || _notrun "feature not enabled: $1"
+}
+
 _full_imgfmt_details()
 {
     if [ -n "$IMGOPTS" ]; then
-- 
2.9.4
