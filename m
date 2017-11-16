Received: from eggs.gnu.org ([2001:4830:134:3::10]:59689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7Q-0007QP-Qu
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7P-0002sx-Mw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:28 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:01 -0500
Message-Id: <20171116173810.16457-2-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] qemu-iotests: make execution of tests
 agnostic to test type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>

check makes a distinction on how it runs Python based tests.  The
current approach is inconsistent because:

1) a large number of Python tests are already set as executable files
(eg: 030, 040, 041, 044, 045, 055, 056, 057, 065, 093, 118, 147, 149,
155, 165 and 194)

2) a smaller number of Python tests are not set as executable files

3) the true purpose of a shebang line is to make a file executable,
while it currently is used (inconsistently) as a test type flag

4) the same logic could in theory be applied to shell based tests,
that is, if first line contains a shell shebang, run it with
"$SHELL $test_file", but it'd be pointless

IMO, there's no value in the distinction that check makes.  Dropping
this distinction makes the interface simpler: check requires an
executable file.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/096   | 0
 tests/qemu-iotests/124   | 0
 tests/qemu-iotests/129   | 0
 tests/qemu-iotests/132   | 0
 tests/qemu-iotests/136   | 0
 tests/qemu-iotests/139   | 0
 tests/qemu-iotests/148   | 0
 tests/qemu-iotests/152   | 0
 tests/qemu-iotests/163   | 0
 tests/qemu-iotests/check | 9 ++-------
 10 files changed, 2 insertions(+), 7 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/096
 mode change 100644 => 100755 tests/qemu-iotests/124
 mode change 100644 => 100755 tests/qemu-iotests/129
 mode change 100644 => 100755 tests/qemu-iotests/132
 mode change 100644 => 100755 tests/qemu-iotests/136
 mode change 100644 => 100755 tests/qemu-iotests/139
 mode change 100644 => 100755 tests/qemu-iotests/148
 mode change 100644 => 100755 tests/qemu-iotests/152
 mode change 100644 => 100755 tests/qemu-iotests/163

diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e6b6ff7a04..08741328d0 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -741,20 +741,15 @@ do
         start=`_wallclock`
         $timestamp && printf %s "        [$(date "+%T")]"
 
-        if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
-            run_command="$PYTHON $seq"
-        else
-            run_command="./$seq"
-        fi
         export OUTPUT_DIR=$PWD
         if $debug; then
             (cd "$source_iotests";
             MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command -d 2>&1 | tee $tmp.out)
+                    ./$seq -d 2>&1 | tee $tmp.out)
         else
             (cd "$source_iotests";
             MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command >$tmp.out 2>&1)
+                    ./$seq >$tmp.out 2>&1)
         fi
         sts=$?
         $timestamp && _timestamp
-- 
2.13.6
