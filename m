Received: from eggs.gnu.org ([2001:4830:134:3::10]:54199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZq-0001dn-GP
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZm-0005cp-EV
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:34:02 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 00:32:46 -0400
Message-Id: <d973b71da9a98762b5667a62ecd9a37ea53dc2bb.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/10] qemu-iotests: add support for running
 multi-threaded iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

This adds support for running qemu-iotests in an arbitrary number
of sub-processes, so that tests can be run in parallel.

This necessarily changes the output format, although it should still
be familiar.  If you run in a single thread, the output format will
largely be the same as before this patch.

To run in more than one process, use the '-j num' option, e.g.:
  ./check -qcow2 -j 5

Some caveats:

    * Some output format options, such as timestamps, are currently
      not compatible with multiple jobs.  If you select multiple
      jobs, timestamps will be disabled.

    * Some tests may be more prone to failure with multiple jobs.
      This isn't a flaw of multiple jobs per se, but rather of
      fragile tests.  Some tests (181, 183) are very sensitive in
      timing, and high cpu loads can cause them to fail.  It may be
      worth adding support for 'single-thread only' tests in subsequent
      patches, that complete designated single-thread jobs at the end.

    * Running protocol tests multi-threaded may fail, as multiple
      tests may try to bind the same address.

If '-j' is not specified, the default is a single iotest being run
at a time.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/check | 425 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 293 insertions(+), 132 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 7908a9d..4f06715 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -26,6 +26,8 @@ n_bad=0
 bad=""
 notrun=""
 interrupt=true
+TEST_DIR_SEQ="$TEST_DIR"
+MAX_JOBS=1
 
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
@@ -125,6 +127,7 @@ sortme=false
 expunge=true
 have_test_arg=false
 cachemode=false
+multijob=false
 save_on_err=false
 
 tmp="${TEST_DIR}"/$$
@@ -220,6 +223,11 @@ s/ .*//p
         CACHEMODE_IS_DEFAULT=false
         cachemode=false
         continue
+    elif $multijob
+    then
+        MAX_JOBS="$r"
+        multijob=false
+        continue
     fi
 
     xpand=true
@@ -262,9 +270,10 @@ other options
     -misalign           misalign memory allocations
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
-    -T                  output timestamps
+    -T                  output timestamps, disabled if using '-j'
     -c mode             cache mode
     -s                  save test scratch directory on test failure
+    -j num              run tests in 'num' processes
 
 
 testlist options
@@ -442,6 +451,10 @@ testlist options
             save_on_err=true
             xpand=false
             ;;
+        -j)
+            multijob=true
+            xpand=false
+            ;;
         '[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
             echo "No tests?"
             status=1
@@ -506,6 +519,20 @@ BEGIN        { for (t='$start'; t<='$end'; t++) printf "%03d\n",t }' \
 
 done
 
+# No need for multi-process support, and this keeps output simpler
+if $showme
+then
+    MAX_JOBS=1
+fi
+
+# TODO: Change test output format so that this can be useful
+#       with multi-process jobs
+if $timestamp && [ $MAX_JOBS -gt 1 ]
+then
+    echo "Not showing timestamps with multi-job test"
+    timestamp=false
+fi
+
 # Set qemu-io cache mode with $CACHEMODE we have
 QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --cache $CACHEMODE"
 
@@ -670,8 +697,11 @@ END        { if (NR > 0) {
 
         if [ ! -z "$notrun" ]
         then
-            echo "Not run:$notrun"
-            echo "Not run:$notrun" >>check.log
+            # if run with $MAX_JOBS > 1, this will likely be
+            # out of order
+            notrun=$(echo $notrun|tr " " "\n"|sort|tr "\n" " ")
+            echo "Not run: $notrun"
+            echo "Not run: $notrun" >>check.log
         fi
         if [ ! -z "$n_bad" -a $n_bad != 0 ]
         then
@@ -694,7 +724,7 @@ END        { if (NR > 0) {
     rm -f $tmp.*
 }
 
-trap "_wrapup; exit \$status" 0 1 2 3 15
+trap "_wait_to_finish; _wrapup; exit \$status" 0 1 2 3 15
 
 [ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
 
@@ -718,11 +748,234 @@ seq="check"
 
 [ -n "$TESTS_REMAINING_LOG" ] && echo $list > $TESTS_REMAINING_LOG
 
+# Execute actual test.  This will be run in a background process.
+_do_test()
+{
+    local seq=$1
+    local err=false
+    local tmp="${TEST_DIR}/$seq/$seq"
+    local TEST_DIR_SEQ=$TEST_DIR/$seq
+
+    _wallclock > "${TEST_DIR}/$seq.start.clock"
+    $timestamp && printf %s "        [$(date "+%T")]"
+
+    if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
+        run_command="$PYTHON $seq"
+    else
+        run_command="./$seq"
+    fi
+    export OUTPUT_DIR=$PWD
+    if $debug; then
+        # Do this in a sub-shell, so we are operating on the right
+        # TEST_DIR / QEMU_TEST_DIR
+        (
+        export TEST_DIR=$TEST_DIR_SEQ
+        . "$source_iotests/common.config"
+        . "$source_iotests/common.rc"
+        cd "$source_iotests" &&
+            MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
+            $run_command -d 2>&1 | tee $tmp.out
+        )
+    else
+        # Do this in a sub-shell, so we are operating on the right
+        # TEST_DIR / QEMU_TEST_DIR
+        (
+        export TEST_DIR=$TEST_DIR_SEQ
+        . "$source_iotests/common.config"
+        . "$source_iotests/common.rc"
+        cd "$source_iotests" &&
+            MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
+            $run_command >$tmp.out 2>&1
+        )
+    fi
+    sts=$?
+    $timestamp && _timestamp
+    _wallclock > "${TEST_DIR}/$seq.stop.clock"
+
+    if [ -f core ]
+    then
+        printf " [dumped core]"
+        mv core $seq.core
+        err=true
+    fi
+
+    if [ ! -f $seq.notrun ]
+    then
+        if [ $sts -ne 0 ]
+        then
+            printf %s " [failed, exit status $sts]" > "$TEST_DIR/$seq.err"
+            err=true
+        fi
+    fi
+
+
+    # Do this in a sub-shell, so we are operating on the right
+    # TEST_DIR / QEMU_TEST_DIR
+    (
+    export TEST_DIR=$TEST_DIR_SEQ
+    . "$source_iotests/common.config"
+    . "$source_iotests/common.rc"
+    . "$source_iotests/common.qemu"
+
+    _cleanup_protocols
+    _cleanup_qemu
+    )
+
+    if [ "$err" == "true" ]
+    then
+        touch "$TEST_DIR/$seq.err"
+    fi
+}
+
+# Runs after we detect a test has completed
+function _check_results()
+{
+    local seq=$1
+    local err=false
+    local localtmp="${TEST_DIR}/$seq/$seq"
+    local TEST_DIR_SEQ=$TEST_DIR/$seq
+
+    if [ -f $seq.notrun ]
+    then
+        if [ $MAX_JOBS -gt 1 ]
+        then
+            printf "$seq   "
+        fi
+        $timestamp || printf " | not run | "
+        $timestamp && echo " | not run |" && printf %s "        $seq -- "
+        cat $seq.notrun
+        notrun="$notrun $seq"
+    else
+        reference="$source_iotests/$seq.out"
+        reference_machine="$source_iotests/$seq.$QEMU_DEFAULT_MACHINE.out"
+        if [ -f "$reference_machine" ]; then
+            reference="$reference_machine"
+        fi
+
+        reference_format="$source_iotests/$seq.out.$IMGFMT"
+        if [ -f "$reference_format" ]; then
+            reference="$reference_format"
+        fi
+
+        if [ "$CACHEMODE" = "none" ]; then
+            [ -f "$source_iotests/$seq.out.nocache" ] && reference="$source_iotests/$seq.out.nocache"
+        fi
+
+        if [ ! -f "$reference" ]
+        then
+            echo " - no qualified output"
+        else
+            if diff -w "$reference" $localtmp.out >/dev/null 2>&1
+            then
+                if $err
+                then
+                    :
+                else
+                    stop=$(cat "$TEST_DIR/$seq.stop.clock")
+                    start=$(cat "$TEST_DIR/$seq.start.clock")
+                    echo "$seq `expr $stop - $start`" >>$tmp.time
+                fi
+            else
+                printf " - output mismatch (see $seq.out.bad)"
+                mv $localtmp.out $seq.out.bad
+                $diff -w "$reference" $(realpath $seq.out.bad)
+                err=true
+            fi
+        fi
+    fi
+
+    if [ "$err" == "true" ] || [ -f "$TEST_DIR/$seq.err" ]
+    then
+        if [ $MAX_JOBS -gt 1 ]
+        then
+            printf "$seq    |   fail  | "
+        fi
+        if [ -f "$TEST_DIR/$seq.err" ]
+        then
+            cat "$TEST_DIR/$seq.err"
+        fi
+        err=true
+        bad="$bad $seq"
+        n_bad=`expr $n_bad + 1`
+        quick=false
+    elif [ $MAX_JOBS -gt 1 ]
+    then
+        printf "$seq    |  finish | "
+    fi
+
+    echo ""
+
+    if [ "$save_on_err" != "true" ] || [ "$err" != "true" ]
+    then
+        rm -rf "$TEST_DIR_SEQ"
+    fi
+
+    [ -f $seq.notrun ] || try=`expr $try + 1`
+
+    rm -f "$TEST_DIR/$seq.stop.clock" "$TEST_DIR/$seq.start.clock"
+}
+
+# Even if interrupted, we want to wait until
+# all tests have completed, so we can properly clean
+# up after them via _check_results
+function _wait_to_finish()
+{
+    while [ $jobs_running -gt 0 ]
+    do
+        i=0
+        while [ $jobs_running -gt 0 ]
+        do
+            job=${job_slots[$i]}
+            if [ $job -gt 0 ]
+            then
+                if [ -z "$(ps -o pid -h -p $job)" ]
+                then
+                    _check_results ${job_seq[$i]}
+                    job_slots[$i]=0
+                    job_seq[$i]=-1
+                    let jobs_running--
+                fi
+            fi
+            let i++
+            let i=`expr $i % $MAX_JOBS`
+            sleep 0.1
+        done
+    done
+}
+
+job_slots=
+
+jobs_running=0
+
+for i in `seq 0 $MAX_JOBS`
+do
+    job_slots[$i]=0
+done
+
+
+# Now iterate of the list of tests
 for seq in $list
 do
-    TEST_DIR_SEQ=$TEST_DIR/$seq
-    err=false
+
+    rm -f $seq.out.bad
+    lasttime=`sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE`
     printf %s "$seq"
+    if [ $MAX_JOBS -gt 1 ]
+    then
+        printf "    |   start |"
+    fi
+    if [ "X$lasttime" != X ]; then
+        printf %s " ${lasttime}s ..."
+    else
+        printf "        "        # prettier output with timestamps.
+    fi
+    rm -f core $seq.notrun
+    if [ $MAX_JOBS -gt 1 ]
+    then
+        printf "\n"
+    fi
+
+    err=false
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
         mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
@@ -743,143 +996,51 @@ do
         echo " - no such test?"
         echo "/^$seq\$/d" >>$tmp.expunged
     else
-        # really going to try and run this one
-        #
-        rm -f $seq.out.bad
-        lasttime=`sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE`
-        if [ "X$lasttime" != X ]; then
-                printf %s " ${lasttime}s ..."
-        else
-                printf "        "        # prettier output with timestamps.
-        fi
-        rm -f core $seq.notrun
 
-        start=`_wallclock`
-        $timestamp && printf %s "        [$(date "+%T")]"
-
-        if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
-            run_command="$PYTHON $seq"
-        else
-            run_command="./$seq"
-        fi
-        export OUTPUT_DIR=$PWD
-        if $debug; then
-            # Do this in a sub-shell, so we are operating on the right
-            # TEST_DIR / QEMU_TEST_DIR
-            (
-            export TEST_DIR=$TEST_DIR_SEQ
-            . "$source_iotests/common.config"
-            . "$source_iotests/common.rc"
-            cd "$source_iotests" &&
-            MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command -d 2>&1 | tee $tmp.out
-            )
-        else
-            # Do this in a sub-shell, so we are operating on the right
-            # TEST_DIR / QEMU_TEST_DIR
-            (
-            export TEST_DIR=$TEST_DIR_SEQ
-            . "$source_iotests/common.config"
-            . "$source_iotests/common.rc"
-             cd "$source_iotests" &&
-            MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command >$tmp.out 2>&1
-            )
-        fi
-        sts=$?
-        $timestamp && _timestamp
-        stop=`_wallclock`
-
-        if [ -f core ]
-        then
-            printf " [dumped core]"
-            mv core $seq.core
-            err=true
-        fi
-
-        if [ -f $seq.notrun ]
+        if [ $MAX_JOBS -eq 1 ]
         then
-            $timestamp || printf " [not run] "
-            $timestamp && echo " [not run]" && printf %s "        $seq -- "
-            cat $seq.notrun
-            notrun="$notrun $seq"
+            # This way we can mimic the same output format before multi-process test
+            # support was added, if we are running one test at a time
+            _do_test $seq
+            _check_results $seq
         else
-            if [ $sts -ne 0 ]
-            then
-                printf %s " [failed, exit status $sts]"
-                err=true
-            fi
-
-            reference="$source_iotests/$seq.out"
-            reference_machine="$source_iotests/$seq.$QEMU_DEFAULT_MACHINE.out"
-            if [ -f "$reference_machine" ]; then
-                reference="$reference_machine"
-            fi
-
-            reference_format="$source_iotests/$seq.out.$IMGFMT"
-            if [ -f "$reference_format" ]; then
-                reference="$reference_format"
-            fi
-
-            if [ "$CACHEMODE" = "none" ]; then
-                [ -f "$source_iotests/$seq.out.nocache" ] && reference="$source_iotests/$seq.out.nocache"
-            fi
-
-            if [ ! -f "$reference" ]
-            then
-                echo " - no qualified output"
-                err=true
-            else
-                if diff -w "$reference" $tmp.out >/dev/null 2>&1
+            # loop until a job slot becomes free
+            i=0
+            while true
+            do
+                job=${job_slots[$i]}
+                if [ $job -le 0 ]
+                then
+                    let jobs_running++
+                    job_seq[$i]=$seq
+                    # Execute the test in the background
+                    _do_test $seq &
+                    job_slots[$i]=$!
+                    break
+                elif [ -z "$(ps -o pid -h -p $job)" ]
                 then
-                    echo ""
-                    if $err
-                    then
-                        :
-                    else
-                        echo "$seq `expr $stop - $start`" >>$tmp.time
-                    fi
-                else
-                    echo " - output mismatch (see $seq.out.bad)"
-                    mv $tmp.out $seq.out.bad
-                    $diff -w "$reference" $(realpath $seq.out.bad)
-                    err=true
+                    # job has completed
+                    _check_results ${job_seq[$i]}
+                    job_slots[$i]=0
+                    job_seq[$i]=-1
+                    let jobs_running--
+                    continue
                 fi
-            fi
-        fi
-
-        # Do this in a sub-shell, so we are operating on the right
-        # TEST_DIR / QEMU_TEST_DIR
-        (
-        export TEST_DIR=$TEST_DIR_SEQ
-        . "$source_iotests/common.config"
-        . "$source_iotests/common.rc"
-        . "$source_iotests/common.qemu"
 
-        _cleanup_protocols
-        _cleanup_qemu
-        )
+                let i++
+                let i=`expr $i % $MAX_JOBS`
 
-        if [ "$save_on_err" != "true" ] || [ "$err" != "true" ]
-        then
-            rm -rf "$TEST_DIR_SEQ"
+                if [ $i -eq 0 ]
+                then
+                    sleep 0.25
+                fi
+            done
         fi
-
     fi
-
-    # come here for each test, except when $showme is true
-    #
-    if $err
-    then
-        bad="$bad $seq"
-        n_bad=`expr $n_bad + 1`
-        quick=false
-    fi
-    [ -f $seq.notrun ] || try=`expr $try + 1`
-
-    seq="after_$seq"
 done
 
+_wait_to_finish
+
 interrupt=false
 status=`expr $n_bad`
 exit
-- 
2.9.5
