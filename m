Received: from eggs.gnu.org ([2001:4830:134:3::10]:56127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtQ-0004VK-Kt
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtP-00056H-GL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:12 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:43 -0600
Message-Id: <20181130220344.3350618-15-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 14/14] iotests: Enhance 223,
 233 to cover 'qemu-nbd --list'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Any good new feature deserves some regression testing :)
Coverage includes:
- 223: what happens when there are 0 or more than 1 export,
proof that we can see multiple contexts including qemu:dirty-bitmap
- 233: proof that we can list over TLS, and that mix-and-match of
plain/TLS listings sanely

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/223     |  2 ++
 tests/qemu-iotests/223.out | 20 ++++++++++++++++++++
 tests/qemu-iotests/233     | 10 ++++++++++
 tests/qemu-iotests/233.out | 15 +++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 397b865d347..e64747a9a61 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -119,6 +119,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
+$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
@@ -127,6 +128,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n2", "bitmap":"b2"}}' "return"
+$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"

 echo
 echo "=== Contrast normal status to large granularity dirty-bitmap ==="
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index de417477de0..3342bff3447 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -29,10 +29,30 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}
 {"return": {}}
+exports available: 0
 {"return": {}}
 {"return": {}}
 {"return": {}}
 {"return": {}}
+exports available: 2
+ export: 'n'
+  size:  4194304
+  flags: 0x4ef ( readonly flush fua trim zeroes df cache )
+  min block: 512
+  opt block: 4096
+  max block: 33554432
+  available meta contexts: 2
+   base:allocation
+   qemu:dirty-bitmap:b
+ export: 'n2'
+  size:  4194304
+  flags: 0x4ef ( readonly flush fua trim zeroes df cache )
+  min block: 512
+  opt block: 4096
+  max block: 33554432
+  available meta contexts: 2
+   base:allocation
+   qemu:dirty-bitmap:b2

 === Contrast normal status to large granularity dirty-bitmap ===

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index 1814efe3333..5d694d9d242 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -72,6 +72,9 @@ $QEMU_IMG info --image-opts \
     --object tls-creds-x509,dir=${tls_dir}/client1,endpoint=client,id=tls0 \
     driver=nbd,host=$nbd_tcp_addr,port=$nbd_tcp_port,tls-creds=tls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port \
+    --object tls-creds-x509,dir=${tls_dir}/client1,endpoint=client,id=tls0 \
+    --tls-creds=tls0

 nbd_server_stop

@@ -84,6 +87,7 @@ nbd_server_start_tcp_socket \
     -f $IMGFMT "$TEST_IMG"

 $QEMU_IMG info nbd://localhost:$nbd_tcp_port 2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port

 echo
 echo "== check TLS works =="
@@ -91,6 +95,9 @@ $QEMU_IMG info --image-opts \
     --object tls-creds-x509,dir=${tls_dir}/client1,endpoint=client,id=tls0 \
     driver=nbd,host=$nbd_tcp_addr,port=$nbd_tcp_port,tls-creds=tls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port \
+    --object tls-creds-x509,dir=${tls_dir}/client1,endpoint=client,id=tls0 \
+    --tls-creds=tls0

 echo
 echo "== check TLS with different CA fails =="
@@ -98,6 +105,9 @@ $QEMU_IMG info --image-opts \
     --object tls-creds-x509,dir=${tls_dir}/client2,endpoint=client,id=tls0 \
     driver=nbd,host=$nbd_tcp_addr,port=$nbd_tcp_port,tls-creds=tls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port \
+    --object tls-creds-x509,dir=${tls_dir}/client2,endpoint=client,id=tls0 \
+    --tls-creds=tls0

 echo
 echo "== perform I/O over TLS =="
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 5f416721b03..ab669488669 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -15,20 +15,35 @@ wrote 1048576/1048576 bytes at offset 1048576
 == check TLS client to plain server fails ==
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Denied by server for option 5 (starttls)
 server reported: TLS not configured
+qemu-nbd: Denied by server for option 5 (starttls)
+server reported: TLS not configured

 == check plain client to TLS server fails ==
 qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation required before option 8 (structured reply)
 server reported: Option 0x8 not permitted before TLS
+qemu-nbd: TLS negotiation required before option 8 (structured reply)
+server reported: Option 0x8 not permitted before TLS

 == check TLS works ==
 image: nbd://127.0.0.1:PORT
 file format: nbd
 virtual size: 64M (67108864 bytes)
 disk size: unavailable
+exports available: 1
+ export: ''
+  size:  67108864
+  flags: 0x4ed ( flush fua trim zeroes df cache )
+  min block: 512
+  opt block: 4096
+  max block: 33554432
+  available meta contexts: 1
+   base:allocation

 == check TLS with different CA fails ==
 qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
+qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
+qemu-nbd: The certificate hasn't got a known issuer

 == perform I/O over TLS ==
 read 1048576/1048576 bytes at offset 1048576
-- 
2.17.2
