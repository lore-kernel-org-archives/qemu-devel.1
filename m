Received: from eggs.gnu.org ([2001:4830:134:3::10]:55896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOCoQ-0000Nw-Vm
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 21:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOCku-0004IV-28
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 21:24:12 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 17 Nov 2018 20:24:03 -0600
Message-Id: <20181118022403.2211483-1-eblake@redhat.com>
In-Reply-To: <20181116155325.22428-7-berrange@redhat.com>
References: <20181116155325.22428-7-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 7/6] iotests: Also test I/O over NBD TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Enhance test 233 to also perform I/O beyond the initial handshake.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Depends on my tweak to 2/6 to suppress an EIO error message
on a failed read after NBD_CMD_DISC.

 tests/qemu-iotests/233     | 12 +++++++++++-
 tests/qemu-iotests/233.out | 10 ++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index a1ba8c09c06..5b6982be6ad 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -61,7 +61,7 @@ tls_x509_create_client "ca2" "client2"
 echo
 echo "== preparing image =="
 _make_test_img 64M
-
+$QEMU_IO -c 'w -P 0x11 1m 1m' "$TEST_IMG" | _filter_qemu_io

 echo
 echo "== check TLS client to plain server fails =="
@@ -95,6 +95,16 @@ $QEMU_IMG info --image-opts \
     driver=nbd,host=$nbd_tcp_addr,port=$nbd_tcp_port,tls-creds=tls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"

+echo
+echo "== perform I/O over TLS =="
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+$QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m' --image-opts \
+    --object tls-creds-x509,dir=${tls_dir}/client1,endpoint=client,id=tls0 \
+    driver=nbd,host=$nbd_tcp_addr,port=$nbd_tcp_port,tls-creds=tls0 \
+    2>&1 | sed "s/$nbd_tcp_port/PORT/g" | _filter_qemu_io
+
+$QEMU_IO -f qcow2 -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 616e9238c89..94acd9b9479 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -9,6 +9,8 @@ Generating a signed certificate...

 == preparing image ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 == check TLS client to plain server fails ==
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Denied by server for option 5 (starttls)
@@ -27,4 +29,12 @@ disk size: unavailable
 == check TLS with different CA fails ==
 option negotiation failed: Verify failed: No certificate was found.
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
+
+== perform I/O over TLS ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.17.2
