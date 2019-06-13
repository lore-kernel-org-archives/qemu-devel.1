Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D28C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A041C218B6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A041C218B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTVa-0004fv-Tp
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35690)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbRyN-0002qi-0u
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbRy9-0006Xv-3f
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hbRy4-0006Ta-PQ; Thu, 13 Jun 2019 11:48:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C59489C33;
 Thu, 13 Jun 2019 15:48:48 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69ABF5C6D6;
 Thu, 13 Jun 2019 15:48:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 10:48:33 -0500
Message-Id: <20190613154837.21734-6-eblake@redhat.com>
In-Reply-To: <20190613154837.21734-1-eblake@redhat.com>
References: <20190613154837.21734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 13 Jun 2019 15:48:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/9] iotests: Let 233 run concurrently
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

common.nbd's nbd_server_set_tcp_port() tries to find a free port, and
then uses it for the whole test run.  However, this is racy because even
if the port was free at the beginning, there is no guarantee it will
continue to be available.  Therefore, 233 currently cannot reliably be
run concurrently with other NBD TCP tests.

This patch addresses the problem by dropping nbd_server_set_tcp_port(),
and instead finding a new port every time nbd_server_start_tcp_socket()
is invoked.  For this, we run qemu-nbd with --fork and on error evaluate
the output to see whether it contains "Address already in use".  If so,
we try the next port.

On success, we still want to continually redirect the output from
qemu-nbd to stderr.  To achieve both, we redirect qemu-nbd's stderr to a
FIFO that we then open in bash.  If the parent process exits with status
0 (which means that the server has started successfully), we launch a
background cat process that copies the FIFO to stderr.  On failure, we
read the whole content into a variable and then evaluate it.

While at it, use --fork in nbd_server_start_unix_socket(), too.  Doing
so allows us to drop nbd_server_wait_for_*_socket().

Note that the reason common.nbd did not use --fork before is that
qemu-nbd did not have --pid-file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190508211820.17851-6-mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.nbd | 100 +++++++++++++++-------------------
 tests/qemu-iotests/233        |   1 -
 2 files changed, 45 insertions(+), 56 deletions(-)

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 25fc9ffaa46b..24b01b60aae1 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -22,6 +22,11 @@
 nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
 nbd_tcp_addr=3D"127.0.0.1"
 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
+nbd_stderr_fifo=3D"${TEST_DIR}/qemu-nbd.fifo"
+
+# If bash version is >=3D 4.1, this will be overwritten by a dynamically
+# assigned file descriptor value.
+nbd_fifo_fd=3D10

 nbd_server_stop()
 {
@@ -33,77 +38,62 @@ nbd_server_stop()
             kill "$NBD_PID"
         fi
     fi
-    rm -f "$nbd_unix_socket"
-}
-
-nbd_server_wait_for_unix_socket()
-{
-    pid=3D$1
-
-    for ((i =3D 0; i < 300; i++))
-    do
-        if [ -r "$nbd_unix_socket" ]; then
-            return
-        fi
-        kill -s 0 $pid 2>/dev/null
-        if test $? !=3D 0
-        then
-            echo "qemu-nbd unexpectedly quit"
-            exit 1
-        fi
-        sleep 0.1
-    done
-    echo "Failed in check of unix socket created by qemu-nbd"
-    exit 1
+    rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"
 }

 nbd_server_start_unix_socket()
 {
     nbd_server_stop
-    $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
-    nbd_server_wait_for_unix_socket $!
+    $QEMU_NBD -v -t -k "$nbd_unix_socket" --fork "$@"
 }

-nbd_server_set_tcp_port()
+nbd_server_start_tcp_socket()
 {
-    (ss --help) >/dev/null 2>&1 || _notrun "ss utility not found, skippi=
ng test"
+    nbd_server_stop

+    mkfifo "$nbd_stderr_fifo"
     for ((port =3D 10809; port <=3D 10909; port++))
     do
-        if ! ss -tln | grep -sqE ":$port\b"; then
+        # Redirect stderr to FIFO, so we can later decide whether we
+        # want to read it or to redirect it to our stderr, depending
+        # on whether the command fails or not
+        $QEMU_NBD -v -t -b $nbd_tcp_addr -p $port --fork "$@" \
+            2> "$nbd_stderr_fifo" &
+
+        # Taken from common.qemu
+        if [[ "${BASH_VERSINFO[0]}" -ge "5" ||
+            ("${BASH_VERSINFO[0]}" -ge "4" && "${BASH_VERSINFO[1]}" -ge =
"1") ]]
+        then
+            exec {nbd_fifo_fd}<"$nbd_stderr_fifo"
+        else
+            let _nbd_fifo_fd++
+            eval "exec ${_nbd_fifo_fd}<'$nbd_stderr_fifo'"
+        fi
+        wait $!
+
+        if test $? =3D=3D 0
+        then
+            # Success, redirect qemu-nbd's stderr to our stderr
             nbd_tcp_port=3D$port
+            (cat <&$nbd_fifo_fd >&2) &
+            eval "exec $nbd_fifo_fd>&-"
             return
         fi
+
+        # Failure, read the output
+        output=3D$(cat <&$nbd_fifo_fd)
+        eval "exec $nbd_fifo_fd>&-"
+
+        if ! echo "$output" | grep -q "Address already in use"
+        then
+            # Unknown error, print it
+            echo "$output" >&2
+            rm -f "$nbd_stderr_fifo"
+            exit 1
+        fi
     done

     echo "Cannot find free TCP port for nbd in range 10809-10909"
+    rm -f "$nbd_stderr_fifo"
     exit 1
 }
-
-nbd_server_wait_for_tcp_socket()
-{
-    pid=3D$1
-
-    for ((i =3D 0; i < 300; i++))
-    do
-        if ss -tln | grep -sqE ":$nbd_tcp_port\b"; then
-            return
-        fi
-        kill -s 0 $pid 2>/dev/null
-        if test $? !=3D 0
-        then
-            echo "qemu-nbd unexpectedly quit"
-            exit 1
-        fi
-        sleep 0.1
-    done
-    echo "Failed in check of TCP socket created by qemu-nbd"
-    exit 1
-}
-
-nbd_server_start_tcp_socket()
-{
-    nbd_server_stop
-    $QEMU_NBD -v -t -b $nbd_tcp_addr -p $nbd_tcp_port "$@" &
-    nbd_server_wait_for_tcp_socket $!
-}
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index 057cad204460..a5c17c39639d 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -49,7 +49,6 @@ _supported_proto file
 # If porting to non-Linux, consider using socat instead of ss in common.=
nbd
 _require_command QEMU_NBD

-nbd_server_set_tcp_port
 tls_x509_init

 echo
--=20
2.20.1


