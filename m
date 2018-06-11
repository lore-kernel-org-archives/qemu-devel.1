Received: from eggs.gnu.org ([2001:4830:134:3::10]:43897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnj-0001vg-D7
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTni-0008NW-BH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:31 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:52:02 +0200
Message-Id: <20180611205203.2624-10-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/10] iotests: Test internal option typing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

It would be nice if qemu used the correct types for blockdev options
internally, even if the user specified string values (either through
-drive or by being not so nice and using json:{} with string values).
This patch adds a test verifying that fact.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/089     | 25 +++++++++++++++++++++++++
 tests/qemu-iotests/089.out |  9 +++++++++
 2 files changed, 34 insertions(+)

diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index aa1ba4a98e..0682d08f39 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -36,6 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
+. ./common.qemu
 
 _supported_fmt qcow2
 _supported_proto file
@@ -145,6 +146,30 @@ $QEMU_IO -c "open -o driver=qcow2 json:{\"file.filename\":\"$TEST_IMG\"}" \
 $QEMU_IO -c "open -o driver=qcow2 json:{\"driver\":\"raw\",\"file.filename\":\"$TEST_IMG\"}" \
          -c "info" 2>&1 | _filter_img_info
 
+echo
+echo "=== Testing option typing ==="
+echo
+
+# json:{} accepts both strings and correctly typed values (even mixed,
+# although we probably do not want to support that...), but when
+# creating a json:{} filename, it should be correctly typed.
+# Therefore, both of these should make the "size" value an integer.
+
+TEST_IMG="json:{'driver': 'null-co', 'size':  42 }" _img_info | grep '^image'
+TEST_IMG="json:{'driver': 'null-co', 'size': '42'}" _img_info | grep '^image'
+
+echo
+
+# This should even work when some driver abuses bs->options to store
+# non-QAPI options (and the given -drive options are not complete)
+# (Watch for whether file.align appears as an int or a string)
+qemu_comm_method=monitor _launch_qemu \
+    -drive if=none,id=drv0,node-name=node0,format=raw,file=blkdebug::null-co://,file.align=512
+
+_send_qemu_cmd $QEMU_HANDLE 'info block' 'json:'
+
+_cleanup_qemu
+
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 89e3e4340a..35ffbabe77 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -49,4 +49,13 @@ vm state offset: 512 MiB
 format name: IMGFMT
 cluster size: 64 KiB
 vm state offset: 512 MiB
+
+=== Testing option typing ===
+
+image: json:{"driver": "null-co", "size": 42}
+image: json:{"driver": "null-co", "size": 42}
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drv0 (node0): json:{"driver": "raw", "file": {"image": {"driver": "null-co"}, "driver": "blkdebug", "align": 512}} (raw)
 *** done
-- 
2.17.1
