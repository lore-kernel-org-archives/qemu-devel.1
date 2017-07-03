Received: from eggs.gnu.org ([2001:4830:134:3::10]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0Q1-0006ir-LS
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0Py-0008G0-JH
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:25:33 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Jul 2017 14:25:04 +0200
Message-Id: <20170703122505.32017-5-mreitz@redhat.com>
In-Reply-To: <20170703122505.32017-1-mreitz@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/5] iotests: Add test for non-string option
 reopening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/133     | 9 +++++++++
 tests/qemu-iotests/133.out | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 9d35a6a..af6b3e1 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -83,6 +83,15 @@ $QEMU_IO -c 'reopen -o driver=qcow2' $TEST_IMG
 $QEMU_IO -c 'reopen -o file.driver=file' $TEST_IMG
 $QEMU_IO -c 'reopen -o backing.driver=qcow2' $TEST_IMG
 
+echo
+echo "=== Check that reopening works with non-string options ==="
+echo
+
+# Using the json: pseudo-protocol we can create non-string options
+# (Invoke 'info' just so we get some output afterwards)
+IMGOPTSSYNTAX=false $QEMU_IO -f null-co -c 'reopen' -c 'info' \
+    "json:{'driver': 'null-co', 'size': 65536}"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index cc86b94..f4a85ae 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -19,4 +19,9 @@ Cannot change the option 'driver'
 
 === Check that unchanged driver is okay ===
 
+
+=== Check that reopening works with non-string options ===
+
+format name: null-co
+format name: null-co
 *** done
-- 
2.9.4
