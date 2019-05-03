Received: from eggs.gnu.org ([209.51.188.92]:48513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMZLE-0003cM-D0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMZLD-00075B-4g
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:39:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMZLC-00071s-QY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:39:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id y197so7034540wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:39:10 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  3 May 2019 15:39:04 +0100
Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output to
 for make check-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This attempts to clean-up the output to better match the output of the
rest of the QEMU check system. This includes:

  - formatting as "  TEST    iotest: nnn"
  - calculating time diff at the end
  - only dumping config on failure

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 922c5d1d3d..2ffc14113e 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -633,12 +633,6 @@ _wallclock()
     date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
 }
 
-_timestamp()
-{
-    now=$(date "+%T")
-    printf %s " [$now]"
-}
-
 _wrapup()
 {
     if $showme
@@ -709,19 +703,6 @@ trap "_wrapup; exit \$status" 0 1 2 3 15
 FULL_IMGFMT_DETAILS=$(_full_imgfmt_details)
 FULL_HOST_DETAILS=$(_full_platform_details)
 
-cat <<EOF
-QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
-QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
-QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
-QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
-IMGFMT        -- $FULL_IMGFMT_DETAILS
-IMGPROTO      -- $IMGPROTO
-PLATFORM      -- $FULL_HOST_DETAILS
-TEST_DIR      -- $TEST_DIR
-SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
-
-EOF
-
 seq="check"
 
 [ -n "$TESTS_REMAINING_LOG" ] && echo $list > $TESTS_REMAINING_LOG
@@ -729,7 +710,9 @@ seq="check"
 for seq in $list
 do
     err=false
-    printf %s "$seq"
+    reason=""
+    times=""
+
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
         mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
@@ -738,7 +721,7 @@ do
 
     if $showme
     then
-        echo
+        echo "  TEST    iotest: $seq (not actually run)"
         continue
     elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" expunged >/dev/null
     then
@@ -753,17 +736,11 @@ do
         # really going to try and run this one
         #
         rm -f $seq.out.bad
-        lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
-        if [ "X$lasttime" != X ]; then
-                printf %s " ${lasttime}s ..."
-        else
-                printf "        "        # prettier output with timestamps.
-        fi
         rm -f core $seq.notrun
         rm -f $seq.casenotrun
 
         start=$(_wallclock)
-        $timestamp && printf %s "        [$(date "+%T")]"
+        $timestamp && times="[$(date "+%T")]"
 
         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
             run_command="$PYTHON $seq"
@@ -781,26 +758,26 @@ do
                     $run_command >$tmp.out 2>&1)
         fi
         sts=$?
-        $timestamp && _timestamp
+        $timestamp && times="$times -> [$(date "+%T")]"
         stop=$(_wallclock)
 
         if [ -f core ]
         then
-            printf " [dumped core]"
             mv core $seq.core
+            reason="dumped core $seq.core"
             err=true
         fi
 
         if [ -f $seq.notrun ]
         then
-            $timestamp || printf " [not run] "
-            $timestamp && echo " [not run]" && printf %s "        $seq -- "
+            $timestamp || reason="[not run]"
+            $timestamp && reason="[not run] $seq -- "
             cat $seq.notrun
             notrun="$notrun $seq"
         else
             if [ $sts -ne 0 ]
             then
-                printf %s " [failed, exit status $sts]"
+                reason=$(printf %s "[failed, exit status $sts]")
                 err=true
             fi
 
@@ -821,22 +798,27 @@ do
 
             if [ ! -f "$reference" ]
             then
-                echo " - no qualified output"
+                reason=" - no qualified output"
                 err=true
             else
                 if diff -w "$reference" $tmp.out >/dev/null 2>&1
                 then
-                    echo ""
                     if $err
                     then
                         :
                     else
-                        echo "$seq $(expr $stop - $start)" >>$tmp.time
+                        lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
+                        thistime=$(expr $stop - $start)
+                        echo "$seq $thistime" >>$tmp.time
+
+                        if [ "X$lasttime" != X ]; then
+                            times="$times ${thistime}s (last ${lasttime}s)"
+                        fi
                     fi
                 else
-                    echo " - output mismatch (see $seq.out.bad)"
                     mv $tmp.out $seq.out.bad
                     $diff -w "$reference" "$PWD"/$seq.out.bad
+                    reason=" - output mismatch (see $seq.out.bad)"
                     err=true
                 fi
             fi
@@ -852,9 +834,24 @@ do
     #
     if $err
     then
+        echo "  TEST    iotest: $seq FAILED $reason"
+        cat <<EOF
+QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
+QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
+QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
+QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
+IMGFMT        -- $FULL_IMGFMT_DETAILS
+IMGPROTO      -- $IMGPROTO
+PLATFORM      -- $FULL_HOST_DETAILS
+TEST_DIR      -- $TEST_DIR
+SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
+
+EOF
         bad="$bad $seq"
         n_bad=$(expr $n_bad + 1)
         quick=false
+    else
+        echo "  TEST    iotest: $seq $times"
     fi
     [ -f $seq.notrun ] || try=$(expr $try + 1)
 
-- 
2.20.1
