Received: from eggs.gnu.org ([2001:4830:134:3::10]:34289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlO-0001br-41
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlN-0007XE-1a
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:31 +0100
Message-Id: <20180309161933.8168-55-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 54/56] iotests: Skip test for ENOMEM error
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

From: Fam Zheng <famz@redhat.com>

The AFL image is to exercise the code validating image size, which
doesn't work on 32 bit or when out of memory (there is a large
allocation before the interesting point). So check that and skip the
test, instead of faking the result.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180301011413.11531-1-famz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/059 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 40f89eae18..530bbbe6ce 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -152,9 +152,8 @@ done
 echo
 echo "=== Testing afl image with a very large capacity ==="
 _use_sample_img afl9.vmdk.bz2
-# The sed makes this test pass on machines with little RAM
-# (and also with 32 bit builds)
-_img_info | sed -e 's/Cannot allocate memory/Invalid argument/'
+_img_info | grep -q 'Cannot allocate memory' && _notrun "Insufficent memory, skipped test"
+_img_info
 _cleanup_test_img
 
 # success, all done
-- 
2.13.6
