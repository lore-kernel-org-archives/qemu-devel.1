Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSpb6-00044L-4a
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSpb5-0005wx-BE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:04:24 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  5 Jul 2017 21:04:03 +0200
Message-Id: <20170705190404.22449-5-mreitz@redhat.com>
In-Reply-To: <20170705190404.22449-1-mreitz@redhat.com>
References: <20170705190404.22449-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/5] iotests: Add test for non-string option
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

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
