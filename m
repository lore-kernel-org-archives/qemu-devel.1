Received: from eggs.gnu.org ([2001:4830:134:3::10]:44084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oS-0003KW-3O
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oN-0008In-9C
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:50 +0200
Message-Id: <20180730150958.14607-6-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/13] iotests: Don't lock /dev/null in 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

On my system (Fedora 28), this script reports a 'failed to get
"consistent read" lock' error. Following docs/devel/testing.rst, it's
better to add locking=off here.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/226 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 211ea9888a..8ec3e612dd 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -56,10 +56,10 @@ for PROTO in "file" "host_device" "host_cdrom"; do
     echo
     echo "== Testing RO =="
     $QEMU_IO -c "open -r -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
-    $QEMU_IO -c "open -r -o driver=$PROTO,filename=/dev/null" 2>&1 | _filter_imgfmt
+    $QEMU_IO -c "open -r -o driver=$PROTO,filename=/dev/null,locking=off" 2>&1 | _filter_imgfmt
     echo "== Testing RW =="
     $QEMU_IO -c "open -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
-    $QEMU_IO -c "open -o driver=$PROTO,filename=/dev/null" 2>&1 | _filter_imgfmt
+    $QEMU_IO -c "open -o driver=$PROTO,filename=/dev/null,locking=off" 2>&1 | _filter_imgfmt
 done
 
 # success, all done
-- 
2.13.6
