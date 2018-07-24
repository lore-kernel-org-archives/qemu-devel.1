Received: from eggs.gnu.org ([2001:4830:134:3::10]:60536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fhszG-0006ov-Ip
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fhszF-0000Vu-R5
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:48:06 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 24 Jul 2018 16:47:39 +0800
Message-Id: <20180724084739.580-3-famz@redhat.com>
In-Reply-To: <20180724084739.580-1-famz@redhat.com>
References: <20180724084739.580-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: Don't lock /dev/null in 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

On my system (Fedora 28), this script reports a 'failed to get
"consistent read" lock' error. Following docs/devel/testing.rst, it's
better to add locking=off here.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.17.1
