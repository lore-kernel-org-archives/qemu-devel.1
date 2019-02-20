Received: from eggs.gnu.org ([209.51.188.92]:48418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwUYu-0003Vi-M1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwTwK-0006du-K4
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:50 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 20 Feb 2019 14:58:18 +0000
Message-Id: <20190220145819.30969-2-berrange@redhat.com>
In-Reply-To: <20190220145819.30969-1-berrange@redhat.com>
References: <20190220145819.30969-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] iotests: ensure we print nbd server log
 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

If we abort the iotest early the server.log file might contain useful
information for diagnosing the problem. Ensure its contents are
displayed in this case.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/233 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index fc345a1a46..27932df075 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -30,6 +30,8 @@ _cleanup()
 {
     nbd_server_stop
     _cleanup_test_img
+    # If we aborted early we want to see this log for diagnosis
+    test -f "$TEST_DIR/server.log" && cat "$TEST_DIR/server.log"
     rm -f "$TEST_DIR/server.log"
     tls_x509_cleanup
 }
@@ -120,6 +122,7 @@ $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST=
_IMG" | _filter_qemu_io
 echo
 echo "=3D=3D final server log =3D=3D"
 cat "$TEST_DIR/server.log"
+rm -f $TEST_DIR/server.log
=20
 # success, all done
 echo "*** done"
--=20
2.20.1
