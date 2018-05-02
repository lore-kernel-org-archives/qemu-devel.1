Received: from eggs.gnu.org ([2001:4830:134:3::10]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMh-0007cp-Dz
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMg-0000Py-GD
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:43 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 23:32:19 +0200
Message-Id: <20180502213219.7842-8-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC 7/7] iotests: Test internal option typing
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

It would be nice if qemu used the correct types for blockdev options
internally, even if the user specified string values (either through
-drive or by being not so nice and using json:{} with string values).
This patch adds a test verifying that fact.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/089     | 12 ++++++++++++
 tests/qemu-iotests/089.out |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index aa1ba4a98e..640ecbfa2a 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -145,6 +145,18 @@ $QEMU_IO -c "open -o driver=qcow2 json:{\"file.filename\":\"$TEST_IMG\"}" \
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
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 89e3e4340a..d880fd76f7 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -49,4 +49,9 @@ vm state offset: 512 MiB
 format name: IMGFMT
 cluster size: 64 KiB
 vm state offset: 512 MiB
+
+=== Testing option typing ===
+
+image: json:{"driver": "null-co", "size": 42}
+image: json:{"driver": "null-co", "size": 42}
 *** done
-- 
2.14.3
