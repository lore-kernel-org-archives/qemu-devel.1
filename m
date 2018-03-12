Received: from eggs.gnu.org ([2001:4830:134:3::10]:56870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evUjr-0001b6-Bg
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evUjq-0004I0-Ga
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:12:11 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 16:11:56 -0500
Message-Id: <20180312211156.452139-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Fix stuck NBD process on 33
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, qemu-block@nongnu.org, anton.nefedov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>

Commit afe35cde6 added additional actions to test 33, but forgot
to reset the image between tests.  As a result, './check -nbd 33'
fails because the qemu-nbd process from the first half is still
occupying the port, preventing the second half from starting a
new qemu-nbd process.  Worse, the failure leaves a rogue qemu-nbd
process behind even after the test fails, which causes knock-on
failures to later tests that also want to start qemu-nbd.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

I'll take this through my NBD queue (pull request within the next 16
hours), as obviously I want to test that the other patches on that
queue can get past the iotests for NBD :)

 tests/qemu-iotests/033 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index a1d8357331d..ee8a1338bbd 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -105,6 +105,7 @@ for align in 512 4k; do
 done
 done

+_cleanup_test_img

 # Trigger truncate that would shrink qcow2 L1 table, which is done by
 #   clearing one entry (8 bytes) with bdrv_co_pwrite_zeroes()
-- 
2.14.3
