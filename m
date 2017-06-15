Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXn3-0001DO-HO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXmy-00021M-Ia
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLXmy-00021G-CC
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Jun 2017 17:38:11 +0100
Message-Id: <20170615163813.7255-4-stefanha@redhat.com>
In-Reply-To: <20170615163813.7255-1-stefanha@redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

Avoid duplicating the QEMU command-line.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/068 | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 9c1687d..653e23c 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -59,14 +59,17 @@ case "$QEMU_DEFAULT_MACHINE" in
       ;;
 esac
 
-# Give qemu some time to boot before saving the VM state
-bash -c 'sleep 1; echo -e "savevm 0\nquit"' |\
+_qemu()
+{
     $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" |\
+          "$@" |\
     _filter_qemu | _filter_hmp
+}
+
+# Give qemu some time to boot before saving the VM state
+bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
 # Now try to continue from that VM state (this should just work)
-echo quit |\
-    $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" -loadvm 0 |\
-    _filter_qemu | _filter_hmp
+echo quit | _qemu -loadvm 0
 
 # success, all done
 echo "*** done"
-- 
2.9.4
