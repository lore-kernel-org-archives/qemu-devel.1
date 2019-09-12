Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE4BC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751FC20684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751FC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PpO-00054S-Tp
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PQz-00033X-Kk
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PQx-0001X8-RB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQt-0001TL-Qt; Thu, 12 Sep 2019 09:46:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D769730833A8;
 Thu, 12 Sep 2019 13:46:45 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDF49600C4;
 Thu, 12 Sep 2019 13:46:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:45:56 +0200
Message-Id: <20190912134604.22019-15-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 12 Sep 2019 13:46:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/22] iotests: allow Valgrind checking all QEMU
 processes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

With the '-valgrind' option, let all the QEMU processes be run under
the Valgrind tool. The Valgrind own parameters may be set with its
environment variable VALGRIND_OPTS, e.g.
$ VALGRIND_OPTS=3D"--leak-check=3Dyes" ./check -valgrind <test#>
or they may be listed in the Valgrind checked file ./.valgrindrc or
~/.valgrindrc like
--memcheck:leak-check=3Dno
--memcheck:track-origins=3Dyes
To exclude a specific process from running under the Valgrind, the
corresponding environment variable VALGRIND_QEMU_<name> is to be set
to the empty string:
$ VALGRIND_QEMU_IO=3D ./check -valgrind <test#>
When QEMU-IO process is being killed, the shell report refers to the
text of the command in _qemu_io_wrapper(), which was modified with this
patch. So, the benchmark output for the tests 039, 061 and 137 is to be
changed also.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/039.out   | 30 ++----------
 tests/qemu-iotests/061.out   | 12 +----
 tests/qemu-iotests/137.out   |  6 +--
 tests/qemu-iotests/common.rc | 88 ++++++++++++++++++++++++++++--------
 4 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index 724d7b2508..2e356d51b6 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -11,11 +11,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 incompatible_features     0x1
 ERROR cluster 5 refcount=3D0 reference=3D1
 ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D=
0
@@ -50,11 +46,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 incompatible_features     0x1
 ERROR cluster 5 refcount=3D0 reference=3D1
 Rebuilding refcount structure
@@ -68,11 +60,7 @@ incompatible_features     0x0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 incompatible_features     0x0
 No errors were found on the image.
=20
@@ -91,11 +79,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 incompatible_features     0x1
 ERROR cluster 5 refcount=3D0 reference=3D1
 ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D=
0
@@ -105,11 +89,7 @@ Data may be corrupted, or further writes to the image=
 may corrupt it.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 incompatible_features     0x0
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 1aa7d37ff9..d6a7c2af95 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -118,11 +118,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
@@ -280,11 +276,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 22d59df40c..1c6569eb2c 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -35,11 +35,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67=
108864
 qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. All=
owed are any of the following: none, constant, cached, all
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D "y=
" ]; then
-    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 incompatible_features     0x0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index ee20be8920..f574d22ea5 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -60,19 +60,68 @@ if ! . ./common.config
     exit 1
 fi
=20
+# Set the variables to the empty string to turn Valgrind off
+# for specific processes, e.g.
+# $ VALGRIND_QEMU_IO=3D ./check -qcow2 -valgrind 015
+
+: ${VALGRIND_QEMU_VM=3D$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_IMG=3D$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_IO=3D$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_NBD=3D$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_VXHS=3D$VALGRIND_QEMU}
+
+# The Valgrind own parameters may be set with
+# its environment variable VALGRIND_OPTS, e.g.
+# $ VALGRIND_OPTS=3D"--leak-check=3Dyes" ./check -qcow2 -valgrind 015
+
+_qemu_proc_exec()
+{
+    local VALGRIND_LOGFILE=3D"$1"
+    shift
+    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
+        exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcod=
e=3D99 "$@"
+    else
+        exec "$@"
+    fi
+}
+
+_qemu_proc_valgrind_log()
+{
+    local VALGRIND_LOGFILE=3D"$1"
+    local RETVAL=3D"$2"
+    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
+        if [ $RETVAL =3D=3D 99 ]; then
+            cat "${VALGRIND_LOGFILE}"
+        fi
+        rm -f "${VALGRIND_LOGFILE}"
+    fi
+}
+
 _qemu_wrapper()
 {
+    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
     (
         if [ -n "${QEMU_NEED_PID}" ]; then
             echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
         fi
-        exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
+        VALGRIND_QEMU=3D"${VALGRIND_QEMU_VM}" _qemu_proc_exec "${VALGRIN=
D_LOGFILE}" \
+            "$QEMU_PROG" $QEMU_OPTIONS "$@"
     )
+    RETVAL=3D$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
=20
 _qemu_img_wrapper()
 {
-    (exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@")
+    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
+    (
+        VALGRIND_QEMU=3D"${VALGRIND_QEMU_IMG}" _qemu_proc_exec "${VALGRI=
ND_LOGFILE}" \
+            "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@"
+    )
+    RETVAL=3D$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
=20
 _qemu_io_wrapper()
@@ -85,36 +134,39 @@ _qemu_io_wrapper()
             QEMU_IO_ARGS=3D"--object secret,id=3Dkeysec0,data=3D$IMGKEYS=
ECRET $QEMU_IO_ARGS"
         fi
     fi
-    local RETVAL
     (
-        if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
-            exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exi=
tcode=3D99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
-        else
-            exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
-        fi
+        VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIN=
D_LOGFILE}" \
+            "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
     )
     RETVAL=3D$?
-    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
-        if [ $RETVAL =3D=3D 99 ]; then
-            cat "${VALGRIND_LOGFILE}"
-        fi
-        rm -f "${VALGRIND_LOGFILE}"
-    fi
-    (exit $RETVAL)
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
=20
 _qemu_nbd_wrapper()
 {
-    "$QEMU_NBD_PROG" --pid-file=3D"${QEMU_TEST_DIR}/qemu-nbd.pid" \
-                     $QEMU_NBD_OPTIONS "$@"
+    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
+    (
+        VALGRIND_QEMU=3D"${VALGRIND_QEMU_NBD}" _qemu_proc_exec "${VALGRI=
ND_LOGFILE}" \
+            "$QEMU_NBD_PROG" --pid-file=3D"${QEMU_TEST_DIR}/qemu-nbd.pid=
" \
+             $QEMU_NBD_OPTIONS "$@"
+    )
+    RETVAL=3D$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
=20
 _qemu_vxhs_wrapper()
 {
+    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
     (
         echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
-        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
+        VALGRIND_QEMU=3D"${VALGRIND_QEMU_VXHS}" _qemu_proc_exec "${VALGR=
IND_LOGFILE}" \
+            "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
     )
+    RETVAL=3D$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
=20
 export QEMU=3D_qemu_wrapper
--=20
2.20.1


