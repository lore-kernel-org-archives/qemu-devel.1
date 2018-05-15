Received: from eggs.gnu.org ([2001:4830:134:3::10]:38999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4a-0006rD-RN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4Z-0001fk-Sb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:19 +0200
Message-Id: <20180515154033.19899-24-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/37] iotests: Skip 181 and 201 without
 userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

userfaultfd support depends on the host kernel, so it may not be
available.  If so, 181 and 201 should be skipped.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180406151731.4285-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/181 | 13 +++++++++++++
 tests/qemu-iotests/201 | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 5e767c6195..e02979378d 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -96,6 +96,19 @@ echo
 # Enable postcopy-ram capability both on source and destination
 silent=yes
 _send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
+
+qemu_error_no_exit=yes success_or_failure=yes \
+    _send_qemu_cmd $dest '' "(qemu)" "Postcopy is not supported"
+if [ ${QEMU_STATUS[$dest]} -lt 0 ]; then
+    _send_qemu_cmd $dest '' "(qemu)"
+
+    _send_qemu_cmd $src 'quit' ""
+    _send_qemu_cmd $dest 'quit' ""
+    wait=1 _cleanup_qemu
+
+    _notrun 'Postcopy is not supported'
+fi
+
 _send_qemu_cmd $src 'migrate_set_speed 4k' "(qemu)"
 _send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
 _send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index 11f640f5df..c1a1e00077 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -82,6 +82,19 @@ echo
 
 silent=yes
 _send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
+
+qemu_error_no_exit=yes success_or_failure=yes \
+    _send_qemu_cmd $dest '' "(qemu)" "Postcopy is not supported"
+if [ ${QEMU_STATUS[$dest]} -lt 0 ]; then
+    _send_qemu_cmd $dest '' "(qemu)"
+
+    _send_qemu_cmd $src 'quit' ""
+    _send_qemu_cmd $dest 'quit' ""
+    wait=1 _cleanup_qemu
+
+    _notrun 'Postcopy is not supported'
+fi
+
 _send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
 _send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
 
-- 
2.13.6
