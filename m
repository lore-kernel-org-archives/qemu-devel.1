Received: from eggs.gnu.org ([2001:4830:134:3::10]:46958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6K-00056l-P7
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6J-000763-LG
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:16 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:36:48 +0100
Message-Id: <20170212013704.6378-3-mreitz@redhat.com>
In-Reply-To: <20170212013704.6378-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
	<20170212013704.6378-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 05/21] iotests: record separate timings per
 format, protocol pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

The 'check' program records timings for each test that
is run. These timings are only valid, however, for a
particular format/protocol combination. So if frequently
running 'check' with a variety of different formats or
protocols, the times printed can be very misleading.

Instead of having a single 'check.time' file, maintain
multiple 'check.time-$IMGPROTO-$IMGFMT' files.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170103160556.9895-1-berrange@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/Makefile   |  2 +-
 tests/qemu-iotests/.gitignore |  2 +-
 tests/qemu-iotests/check      | 12 +++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/Makefile b/tests/qemu-iotests/Makefile
index 2fb527c5b5..27380e60c1 100644
--- a/tests/qemu-iotests/Makefile
+++ b/tests/qemu-iotests/Makefile
@@ -1,5 +1,5 @@
 
-CLEANFILES= *.out.bad *.notrun check.log check.time
+CLEANFILES= *.out.bad *.notrun check.log check.time*
 
 # no default target
 default:
diff --git a/tests/qemu-iotests/.gitignore b/tests/qemu-iotests/.gitignore
index 0711cbdbf3..da62054000 100644
--- a/tests/qemu-iotests/.gitignore
+++ b/tests/qemu-iotests/.gitignore
@@ -1,5 +1,5 @@
 check.log
-check.time
+check.time*
 common.env
 *.out.bad
 *.notrun
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 4cba2151e4..4b1c6749b7 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -129,6 +129,8 @@ fi
 #    exit 1
 #fi
 
+TIMESTAMP_FILE=check.time-$IMGPROTO-$IMGFMT
+
 tmp="${TEST_DIR}"/$$
 
 _wallclock()
@@ -155,9 +157,9 @@ _wrapup()
         :
     elif $needwrap
     then
-        if [ -f check.time -a -f $tmp.time ]
+        if [ -f $TIMESTAMP_FILE -a -f $tmp.time ]
         then
-            cat check.time $tmp.time \
+            cat $TIMESTAMP_FILE $tmp.time \
             | $AWK_PROG '
         { t[$1] = $2 }
 END        { if (NR > 0) {
@@ -165,7 +167,7 @@ END        { if (NR > 0) {
           }
         }' \
             | sort -n >$tmp.out
-            mv $tmp.out check.time
+            mv $tmp.out $TIMESTAMP_FILE
         fi
 
         if [ -f $tmp.expunged ]
@@ -223,7 +225,7 @@ echo "preamble" > "${TEST_DIR}"/check.sts
 # don't leave old full output behind on a clean run
 rm -f check.full
 
-[ -f check.time ] || touch check.time
+[ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
 
 FULL_IMGFMT_DETAILS=`_full_imgfmt_details`
 FULL_IMGPROTO_DETAILS=`_full_imgproto_details`
@@ -277,7 +279,7 @@ do
         # really going to try and run this one
         #
         rm -f $seq.out.bad
-        lasttime=`sed -n -e "/^$seq /s/.* //p" <check.time`
+        lasttime=`sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE`
         if [ "X$lasttime" != X ]; then
                 echo -n " ${lasttime}s ..."
         else
-- 
2.11.0
