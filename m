Received: from eggs.gnu.org ([209.51.188.92]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNaL-0003XG-4k
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNYU-00021b-PA
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:58:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 12 Jan 2019 11:58:12 -0600
Message-Id: <20190112175812.27068-20-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-1-eblake@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 19/19] iotests: Enhance 223,
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
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Any good new feature deserves some regression testing :)
Coverage includes:
- 223: what happens when there are 0 or more than 1 export,
proof that we can see multiple contexts including qemu:dirty-bitmap
- 233: proof that we can list over TLS, and that mix-and-match of
plain/TLS listings will behave sanely

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v3: Rebase to earlier changes
---
 tests/qemu-iotests/223     |  2 ++
 tests/qemu-iotests/223.out | 20 ++++++++++++++++++++
 tests/qemu-iotests/233     | 19 +++++++++++++------
 tests/qemu-iotests/233.out | 15 +++++++++++++++
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 773892dbe60..f120a016460 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -127,6 +127,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-s=
tart",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"1'"}}}}' "error" # Attempt second se=
rver
+$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
@@ -142,6 +143,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-a=
dd",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2", "writable":true,
   "bitmap":"b2"}}' "return"
+$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"

 echo
 echo "=3D=3D=3D Contrast normal status to large granularity dirty-bitmap=
 =3D=3D=3D"
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 0de5240a75e..6476b77ba20 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -30,12 +30,32 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "NBD server already running"=
}}
+exports available: 0
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch=
 nor node_name=3Dnosuch"}}
 {"error": {"class": "GenericError", "desc": "NBD server already has expo=
rt named 'n'"}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompa=
tible with readonly export"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
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
+  flags: 0x4ed ( flush fua trim zeroes df cache )
+  min block: 512
+  opt block: 4096
+  max block: 33554432
+  available meta contexts: 2
+   base:allocation
+   qemu:dirty-bitmap:b2

 =3D=3D=3D Contrast normal status to large granularity dirty-bitmap =3D=3D=
=3D

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index 1814efe3333..a6ef7b20fb4 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -68,10 +68,12 @@ echo
 echo "=3D=3D check TLS client to plain server fails =3D=3D"
 nbd_server_start_tcp_socket -f $IMGFMT "$TEST_IMG"

-$QEMU_IMG info --image-opts \
-    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtls=
0
+$QEMU_IMG info --image-opts --object $obj \
     driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj \
+    --tls-creds=3Dtls0

 nbd_server_stop

@@ -84,20 +86,25 @@ nbd_server_start_tcp_socket \
     -f $IMGFMT "$TEST_IMG"

 $QEMU_IMG info nbd://localhost:$nbd_tcp_port 2>&1 | sed "s/$nbd_tcp_port=
/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port

 echo
 echo "=3D=3D check TLS works =3D=3D"
-$QEMU_IMG info --image-opts \
-    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtls=
0
+$QEMU_IMG info --image-opts --object $obj \
     driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj \
+    --tls-creds=3Dtls0

 echo
 echo "=3D=3D check TLS with different CA fails =3D=3D"
-$QEMU_IMG info --image-opts \
-    --object tls-creds-x509,dir=3D${tls_dir}/client2,endpoint=3Dclient,i=
d=3Dtls0 \
+obj=3Dtls-creds-x509,dir=3D${tls_dir}/client2,endpoint=3Dclient,id=3Dtls=
0
+$QEMU_IMG info --image-opts --object $obj \
     driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj \
+    --tls-creds=3Dtls0

 echo
 echo "=3D=3D perform I/O over TLS =3D=3D"
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 5f416721b03..ab669488669 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -15,20 +15,35 @@ wrote 1048576/1048576 bytes at offset 1048576
 =3D=3D check TLS client to plain server fails =3D=3D
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Denied by server for option 5 (starttls)
 server reported: TLS not configured
+qemu-nbd: Denied by server for option 5 (starttls)
+server reported: TLS not configured

 =3D=3D check plain client to TLS server fails =3D=3D
 qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation require=
d before option 8 (structured reply)
 server reported: Option 0x8 not permitted before TLS
+qemu-nbd: TLS negotiation required before option 8 (structured reply)
+server reported: Option 0x8 not permitted before TLS

 =3D=3D check TLS works =3D=3D
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

 =3D=3D check TLS with different CA fails =3D=3D
 qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': The certificate hasn't got a known issuer
+qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
+qemu-nbd: The certificate hasn't got a known issuer

 =3D=3D perform I/O over TLS =3D=3D
 read 1048576/1048576 bytes at offset 1048576
--=20
2.20.1
