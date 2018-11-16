Received: from eggs.gnu.org ([2001:4830:134:3::10]:54607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgSE-00038Z-7n
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgS5-0000tI-9i
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:42 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 16 Nov 2018 15:53:25 +0000
Message-Id: <20181116155325.22428-7-berrange@redhat.com>
In-Reply-To: <20181116155325.22428-1-berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Add tests that validate it is possible to connect to an NBD server
running TLS mode. Also test mis-matched TLS vs non-TLS connections
correctly fail.
---
 tests/qemu-iotests/233        | 99 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/233.out    | 33 ++++++++++++
 tests/qemu-iotests/common.nbd | 47 +++++++++++++++++
 tests/qemu-iotests/group      |  1 +
 4 files changed, 180 insertions(+)
 create mode 100755 tests/qemu-iotests/233
 create mode 100644 tests/qemu-iotests/233.out

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
new file mode 100755
index 0000000000..8f3d5bd013
--- /dev/null
+++ b/tests/qemu-iotests/233
@@ -0,0 +1,99 @@
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
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+here=3D`pwd`
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
ls0
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
+$QEMU_IMG info nbd://localhost:$nbd_tcp_port
+
+echo
+echo "=3D=3D check TLS works =3D=3D"
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0
+
+echo
+echo "=3D=3D check TLS with different CA fails =3D=3D"
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client2,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
new file mode 100644
index 0000000000..eaa410c270
--- /dev/null
+++ b/tests/qemu-iotests/233.out
@@ -0,0 +1,33 @@
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
+option negotiation failed: read failed: Unexpected end-of-file before al=
l bytes were read
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls=
-creds=3Dtls0': Denied by server for option 5 (starttls)
+server reported: TLS not configured
+
+=3D=3D check plain client to TLS server fails =3D=3D
+option negotiation failed: read failed: Unexpected end-of-file before al=
l bytes were read
+qemu-img: Could not open 'nbd://localhost:10809': TLS negotiation requir=
ed before option 8 (structured reply)
+server reported: Option 0x8 not permitted before TLS
+write failed (error message): Unable to write to socket: Broken pipe
+
+=3D=3D check TLS works =3D=3D
+image: nbd://127.0.0.1:10809
+file format: nbd
+virtual size: 64M (67108864 bytes)
+disk size: unavailable
+
+=3D=3D check TLS with different CA fails =3D=3D
+option negotiation failed: Verify failed: No certificate was found.
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls=
-creds=3Dtls0': The certificate hasn't got a known issuer
+*** done
diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 61e9e90fee..0483ea7c55 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -20,6 +20,7 @@
 #
=20
 nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
+nbd_tcp_addr=3D"127.0.0.1"
 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
=20
 function nbd_server_stop()
@@ -62,3 +63,49 @@ function nbd_server_start_unix_socket()
     $QEMU_NBD -v -t -k "$nbd_unix_socket" $@ &
     nbd_server_wait_for_unix_socket $!
 }
+
+function nbd_server_set_tcp_port()
+{
+    for port in `seq 10809 10909`
+    do
+	socat TCP:$nbd_tcp_addr:$port STDIO < /dev/null 1>/dev/null 2>&1
+        if test $? !=3D 0
+	then
+	    nbd_tcp_port=3D$port
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
+        socat TCP:localhost:$nbd_tcp_port STDIO < /dev/null 1>/dev/null =
2>&1
+        if test $? =3D=3D 0
+	then
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
+    echo "Failed in check of unix socket created by qemu-nbd"
+    exit 1
+}
+
+function nbd_server_start_tcp_socket()
+{
+    nbd_server_stop
+    $QEMU_NBD -v -t -b $nbd_tcp_addr -p $nbd_tcp_port $@ &
+    nbd_server_wait_for_tcp_socket $!
+}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ebe4fe78bc..e4327efa42 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -228,3 +228,4 @@
 229 auto quick
 231 auto quick
 232 auto quick
+233 auto quick
--=20
2.19.1
