Received: from eggs.gnu.org ([2001:4830:134:3::10]:54250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexb-0006rV-WC
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexX-0004jR-Iz
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:19 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:13 +0100
Message-Id: <20171114172417.7654-17-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 16/20] iotests: 077: Filter out 'resume' lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

In the "Overlapping multiple requests" cases, the 3rd reqs (the break
point B) doesn't wait for the 2nd, and once resumed the I/O will just
continue.  This is because the 2nd is already waiting for the 1st, and
in wait_serialising_requests() there is:

    /* If the request is already (indirectly) waiting for us, or
     * will wait for us as soon as it wakes up, then just go on
     * (instead of producing a deadlock in the former case). */
    if (!req->waiting_for) {
        /* actually break */
        ...
    }

Consequently, the following "sleep 100; resume A" command races with the
completion of that request, and sometimes results in an unexpected
order of output:

> @@ -56,9 +56,9 @@
>  wrote XXX/XXX bytes at offset XXX
>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  blkdebug: Resuming request 'B'
> +blkdebug: Resuming request 'A'
>  wrote XXX/XXX bytes at offset XXX
>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -blkdebug: Resuming request 'A'
>  wrote XXX/XXX bytes at offset XXX
>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote XXX/XXX bytes at offset XXX

Filter out the "Resuming request" lines to make the output
deterministic.

Reported-by: Patchew <no-reply@patchew.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20171113150026.4743-1-famz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/077     |  3 ++-
 tests/qemu-iotests/077.out | 16 ----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index d2d2a2d687..b3c6fb1370 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -188,7 +188,8 @@ EOF
 test_io | $QEMU_IO  | _filter_qemu_io | \
     sed -e 's,[0-9/]* bytes at offset [0-9]*,XXX/XXX bytes at offset XXX,g' \
         -e 's/^[0-9]* \(bytes\|KiB\)/XXX bytes/' \
-        -e '/Suspended/d'
+        -e '/Suspended/d' \
+        -e '/blkdebug: Resuming request/d'
 
 echo
 echo "== Verify image content =="
diff --git a/tests/qemu-iotests/077.out b/tests/qemu-iotests/077.out
index 16f951fd3d..4aae82f2e2 100644
--- a/tests/qemu-iotests/077.out
+++ b/tests/qemu-iotests/077.out
@@ -4,17 +4,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 == Some concurrent requests involving RMW ==
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
@@ -31,51 +28,38 @@ wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'B'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'B'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'B'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'B'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
-blkdebug: Resuming request 'C'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'B'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkdebug: Resuming request 'A'
 wrote XXX/XXX bytes at offset XXX
 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
-- 
2.13.6
