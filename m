Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910C12339E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910C12339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5RQe-0001FS-81
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 05:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5RKH-0003yy-Id
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5RKF-0004mh-BD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:11:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:47462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i5RKE-0004ku-Ud; Wed, 04 Sep 2019 05:11:39 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i5RKB-000708-E7; Wed, 04 Sep 2019 12:11:35 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed,  4 Sep 2019 12:11:19 +0300
Message-Id: <1567588284-975381-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567588284-975381-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1567588284-975381-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 1/6] iotests: allow Valgrind checking all
 QEMU processes
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the '-valgrind' option, let all the QEMU processes be run under
the Valgrind tool. The Valgrind own parameters may be set with its
environment variable VALGRIND_OPTS, e.g.
$ VALGRIND_OPTS="--leak-check=yes" ./check -valgrind <test#>
or they may be listed in the Valgrind checked file ./.valgrindrc or
~/.valgrindrc like
--memcheck:leak-check=no
--memcheck:track-origins=yes
To exclude a specific process from running under the Valgrind, the
corresponding environment variable VALGRIND_QEMU_<name> is to be set
to the empty string:
$ VALGRIND_QEMU_IO= ./check -valgrind <test#>
When QEMU-IO process is being killed, the shell report refers to the
text of the command in _qemu_io_wrapper(), which was modified with this
patch. So, the benchmark output for the tests 039, 061 and 137 is to be
changed also.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/039.out   | 30 +++------------
 tests/qemu-iotests/061.out   | 12 +-----
 tests/qemu-iotests/137.out   |  6 +--
 tests/qemu-iotests/common.rc | 88 +++++++++++++++++++++++++++++++++++---------
 4 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index 724d7b2..2e356d5 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -11,11 +11,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     0x1
 ERROR cluster 5 refcount=0 reference=1
 ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
@@ -50,11 +46,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     0x1
 ERROR cluster 5 refcount=0 reference=1
 Rebuilding refcount structure
@@ -68,11 +60,7 @@ incompatible_features     0x0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     0x0
 No errors were found on the image.
 
@@ -91,11 +79,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     0x1
 ERROR cluster 5 refcount=0 reference=1
 ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
@@ -105,11 +89,7 @@ Data may be corrupted, or further writes to the image may corrupt it.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     0x0
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 1aa7d37..d6a7c2a 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -118,11 +118,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
@@ -280,11 +276,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 22d59df..1c6569e 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -35,11 +35,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
-    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-else
-    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
-fi )
+./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     0x0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 5502c3d..48f4bc0 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -60,19 +60,68 @@ if ! . ./common.config
     exit 1
 fi
 
+# Set the variables to the empty string to turn Valgrind off
+# for specific processes, e.g.
+# $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015
+
+: ${VALGRIND_QEMU_VM=$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_IMG=$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_IO=$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_NBD=$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_VXHS=$VALGRIND_QEMU}
+
+# The Valgrind own parameters may be set with
+# its environment variable VALGRIND_OPTS, e.g.
+# $ VALGRIND_OPTS="--leak-check=yes" ./check -qcow2 -valgrind 015
+
+_qemu_proc_exec()
+{
+    local VALGRIND_LOGFILE="$1"
+    shift
+    if [ "${VALGRIND_QEMU}" == "y" ]; then
+        exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$@"
+    else
+        exec "$@"
+    fi
+}
+
+_qemu_proc_valgrind_log()
+{
+    local VALGRIND_LOGFILE="$1"
+    local RETVAL="$2"
+    if [ "${VALGRIND_QEMU}" == "y" ]; then
+        if [ $RETVAL == 99 ]; then
+            cat "${VALGRIND_LOGFILE}"
+        fi
+        rm -f "${VALGRIND_LOGFILE}"
+    fi
+}
+
 _qemu_wrapper()
 {
+    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
     (
         if [ -n "${QEMU_NEED_PID}" ]; then
             echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
         fi
-        exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
+        VALGRIND_QEMU="${VALGRIND_QEMU_VM}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
+            "$QEMU_PROG" $QEMU_OPTIONS "$@"
     )
+    RETVAL=$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
 
 _qemu_img_wrapper()
 {
-    (exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@")
+    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
+    (
+        VALGRIND_QEMU="${VALGRIND_QEMU_IMG}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
+            "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@"
+    )
+    RETVAL=$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
 
 _qemu_io_wrapper()
@@ -85,36 +134,39 @@ _qemu_io_wrapper()
             QEMU_IO_ARGS="--object secret,id=keysec0,data=$IMGKEYSECRET $QEMU_IO_ARGS"
         fi
     fi
-    local RETVAL
     (
-        if [ "${VALGRIND_QEMU}" == "y" ]; then
-            exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
-        else
-            exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
-        fi
+        VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
+            "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
     )
     RETVAL=$?
-    if [ "${VALGRIND_QEMU}" == "y" ]; then
-        if [ $RETVAL == 99 ]; then
-            cat "${VALGRIND_LOGFILE}"
-        fi
-        rm -f "${VALGRIND_LOGFILE}"
-    fi
-    (exit $RETVAL)
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
 
 _qemu_nbd_wrapper()
 {
-    "$QEMU_NBD_PROG" --pid-file="${QEMU_TEST_DIR}/qemu-nbd.pid" \
-                     $QEMU_NBD_OPTIONS "$@"
+    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
+    (
+        VALGRIND_QEMU="${VALGRIND_QEMU_NBD}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
+            "$QEMU_NBD_PROG" --pid-file="${QEMU_TEST_DIR}/qemu-nbd.pid" \
+             $QEMU_NBD_OPTIONS "$@"
+    )
+    RETVAL=$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
 
 _qemu_vxhs_wrapper()
 {
+    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
     (
         echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
-        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
+        VALGRIND_QEMU="${VALGRIND_QEMU_VXHS}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
+            "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
     )
+    RETVAL=$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
 }
 
 export QEMU=_qemu_wrapper
-- 
1.8.3.1


