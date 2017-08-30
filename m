Received: from eggs.gnu.org ([2001:4830:134:3::10]:56248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Ei-0001CH-2Q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Eh-0004uE-97
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:04 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 12:52:45 -0400
Message-Id: <aea3a5d63b6937d8bd87afb3741db6c09ea7436e.1504111803.git.jcody@redhat.com>
In-Reply-To: <cover.1504111803.git.jcody@redhat.com>
References: <cover.1504111803.git.jcody@redhat.com>
In-Reply-To: <cover.1504111803.git.jcody@redhat.com>
References: <cover.1504111803.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/5] qemu-iotests: add 'blind_remove' for
 python tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

Add a function to attempt to 'blindly' remove a file, without
throwing an error if the file doesn't exist.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7233983..a2088c7 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -57,6 +57,13 @@ qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
 socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
 debug = False
 
+def blind_remove(filename):
+    try:
+        os.remove(filename)
+    except OSError, error:
+        if error.errno != errno.ENOENT:
+            raise
+
 def qemu_img(*args):
     '''Run qemu-img and return the exit code'''
     devnull = open('/dev/null', 'r+')
-- 
2.9.5
