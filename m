Received: from eggs.gnu.org ([2001:4830:134:3::10]:47075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUo-0007Fv-7u
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUn-0000pN-8S
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:29 -0500
Message-Id: <20180313171345.659672-2-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 01/17] iotests: Fix stuck NBD process on 33
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Commit afe35cde6 added additional actions to test 33, but forgot
to reset the image between tests.  As a result, './check -nbd 33'
fails because the qemu-nbd process from the first half is still
occupying the port, preventing the second half from starting a
new qemu-nbd process.  Worse, the failure leaves a rogue qemu-nbd
process behind even after the test fails, which causes knock-on
failures to later tests that also want to start qemu-nbd.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180312211156.452139-1-eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
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
