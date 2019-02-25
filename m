Received: from eggs.gnu.org ([209.51.188.92]:36630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyI3w-0007u0-5B
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyI3t-0000IC-C6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:20:58 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 25 Feb 2019 09:20:14 -0600
Message-Id: <20190225152015.26089-3-eblake@redhat.com>
In-Reply-To: <20190225152015.26089-1-eblake@redhat.com>
References: <20190225152015.26089-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] iotests: ensure we print nbd server log on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

If we abort the iotest early the server.log file might contain useful
information for diagnosing the problem. Ensure its contents are
displayed in this case.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190220145819.30969-2-berrange@redhat.com>
[eblake: fix shell quoting]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/233 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index fc345a1a46e..adb742fafb0 100755
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
+rm -f "$TEST_DIR/server.log"

 # success, all done
 echo "*** done"
--=20
2.20.1
