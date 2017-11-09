Received: from eggs.gnu.org ([2001:4830:134:3::10]:60690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCbnf-0003DV-HA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 20:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCbnb-0004DG-9a
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 20:38:35 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Nov 2017 02:38:03 +0100
Message-Id: <20171109013804.14488-5-mreitz@redhat.com>
In-Reply-To: <20171109013804.14488-1-mreitz@redhat.com>
References: <20171109013804.14488-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] iotests: Make 083 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

083 has (at least) two issues:

1. By launching the nbd-fault-injector in background, it may not be
   scheduled until the first grep on its output file is executed.
   However, until then, that file may not have been created yet -- so it
   either does not exist yet (thus making the grep emit an error), or it
   does exist but contains stale data (thus making the rest of the test
   case work connect to a wrong address).
   Fix this by explicitly overwriting the output file before executing
   nbd-fault-injector.

2. The nbd-fault-injector prints things other than "Listening on...".
   It also prints a "Closing connection" message from time to time.  We
   currently invoke sed on the whole file in the hope of it only
   containing the "Listening on..." line yet.  That hope is sometimes
   shattered by the brutal reality of race conditions, so invoke grep
   before sed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/083 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 0306f112da..2f6444eeb9 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -86,6 +86,7 @@ EOF
 
 	rm -f "$TEST_DIR/nbd.sock"
 
+        echo > "$TEST_DIR/nbd-fault-injector.out"
 	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd-fault-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
 
 	# Wait for server to be ready
@@ -94,7 +95,7 @@ EOF
 	done
 
 	# Extract the final address (port number has now been assigned in tcp case)
-	nbd_addr=$(sed 's/Listening on \(.*\)$/\1/' "$TEST_DIR/nbd-fault-injector.out")
+        nbd_addr=$(grep 'Listening on ' "$TEST_DIR/nbd-fault-injector.out" | sed 's/Listening on \(.*\)$/\1/')
 
 	if [ "$proto" = "tcp" ]; then
 		nbd_url="nbd+tcp://$nbd_addr/$export_name"
-- 
2.13.6
