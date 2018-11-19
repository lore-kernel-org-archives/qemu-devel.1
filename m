Received: from eggs.gnu.org ([2001:4830:134:3::10]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnlA-0000Rf-LM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl9-0002mW-3L
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:25 -0600
Message-Id: <20181119175427.2298497-11-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/12] tests: exercise NBD server in TLS mode
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

Add tests that validate it is possible to connect to an NBD server
running TLS mode. Also test mis-matched TLS vs non-TLS connections
correctly fail.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20181116155325.22428-7-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
[eblake: rebase to iotests shell cleanups, use ss instead of socat for
port probing, sanitize port number in expected output]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.nbd |  45 +++++++++++++++
 tests/qemu-iotests/233        | 102 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/233.out    |  30 ++++++++++
 tests/qemu-iotests/group      |   1 +
 4 files changed, 178 insertions(+)
 create mode 100755 tests/qemu-iotests/233
 create mode 100644 tests/qemu-iotests/233.out

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 9f841ab4029..0f4497a7ea5 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -20,6 +20,7 @@
 #

 nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
+nbd_tcp_addr=3D"127.0.0.1"
 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"

 function nbd_server_stop()
@@ -62,3 +63,47 @@ function nbd_server_start_unix_socket()
     $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
     nbd_server_wait_for_unix_socket $!
 }
+
+function nbd_server_set_tcp_port()
+{
+    (ss --help) >/dev/null 2>&1 || _notrun "ss utility not found, skippi=
ng test"
+
+    for ((port =3D 10809; port <=3D 10909; port++))
+    do
+        if ! ss -tln | grep -sqE ":$port\b"; then
+            nbd_tcp_port=3D$port
+            return
+        fi
+    done
+
+    echo "Cannot find free TCP port for nbd in range 10809-10909"
+    exit 1
+}
+
+function nbd_server_wait_for_tcp_socket()
+{
+    pid=3D$1
+
+    for ((i =3D 0; i < 300; i++))
+    do
+        if ss -tln | grep -sqE ":$nbd_tcp_port\b"; then
+            return
+        fi
+        kill -s 0 $pid 2>/dev/null
+        if test $? !=3D 0
+        then
+            echo "qemu-nbd unexpectedly quit"
+            exit 1
+        fi
+        sleep 0.1
+    done
+    echo "Failed in check of TCP socket created by qemu-nbd"
+    exit 1
+}
+
+function nbd_server_start_tcp_socket()
+{
+    nbd_server_stop
+    $QEMU_NBD -v -t -b $nbd_tcp_addr -p $nbd_tcp_port "$@" &
+    nbd_server_wait_for_tcp_socket $!
+}
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
new file mode 100755
index 00000000000..46013cefdcd
--- /dev/null
+++ b/tests/qemu-iotests/233
@@ -0,0 +1,102 @@
+#!/bin/bash
+#
+# Test NBD TLS certificate / authorization integration
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=3Dberrange@redhat.com
+
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    nbd_server_stop
+    _cleanup_test_img
+    tls_x509_cleanup
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+. ./common.tls
+. ./common.nbd
+
+_supported_fmt raw qcow2
+_supported_proto file
+# If porting to non-Linux, consider using socat instead of ss in common.=
nbd
+_supported_os Linux
+_require_command QEMU_NBD
+
+nbd_server_set_tcp_port
+tls_x509_init
+
+echo
+echo "=3D=3D preparing TLS creds =3D=3D"
+
+tls_x509_create_root_ca "ca1"
+tls_x509_create_root_ca "ca2"
+tls_x509_create_server "ca1" "server1"
+tls_x509_create_client "ca1" "client1"
+tls_x509_create_client "ca2" "client2"
+
+echo
+echo "=3D=3D preparing image =3D=3D"
+_make_test_img 64M
+
+
+echo
+echo "=3D=3D check TLS client to plain server fails =3D=3D"
+nbd_server_start_tcp_socket "$TEST_IMG"
+
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
+    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+
+nbd_server_stop
+
+echo
+echo "=3D=3D check plain client to TLS server fails =3D=3D"
+
+nbd_server_start_tcp_socket --object tls-creds-x509,dir=3D${tls_dir}/ser=
ver1,endpoint=3Dserver,id=3Dtls0,verify-peer=3Dyes --tls-creds tls0 "$TES=
T_IMG"
+
+$QEMU_IMG info nbd://localhost:$nbd_tcp_port 2>&1 | sed "s/$nbd_tcp_port=
/PORT/g"
+
+echo
+echo "=3D=3D check TLS works =3D=3D"
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
+    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+
+echo
+echo "=3D=3D check TLS with different CA fails =3D=3D"
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client2,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
+    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
new file mode 100644
index 00000000000..616e9238c89
--- /dev/null
+++ b/tests/qemu-iotests/233.out
@@ -0,0 +1,30 @@
+QA output created by 233
+
+=3D=3D preparing TLS creds =3D=3D
+Generating a self signed certificate...
+Generating a self signed certificate...
+Generating a signed certificate...
+Generating a signed certificate...
+Generating a signed certificate...
+
+=3D=3D preparing image =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+
+=3D=3D check TLS client to plain server fails =3D=3D
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Denied by server for option 5 (starttls)
+server reported: TLS not configured
+
+=3D=3D check plain client to TLS server fails =3D=3D
+qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation require=
d before option 8 (structured reply)
+server reported: Option 0x8 not permitted before TLS
+
+=3D=3D check TLS works =3D=3D
+image: nbd://127.0.0.1:PORT
+file format: nbd
+virtual size: 64M (67108864 bytes)
+disk size: unavailable
+
+=3D=3D check TLS with different CA fails =3D=3D
+option negotiation failed: Verify failed: No certificate was found.
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': The certificate hasn't got a known issuer
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 4d194716f28..2722103381e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -229,3 +229,4 @@
 229 auto quick
 231 auto quick
 232 auto quick
+233 auto quick
--=20
2.17.2
