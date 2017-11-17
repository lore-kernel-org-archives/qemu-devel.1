Received: from eggs.gnu.org ([2001:4830:134:3::10]:43390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCq-0001ar-5l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCp-0002gF-99
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:36 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:53 +0100
Message-Id: <20171117181653.20651-26-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/25] iotests: Make 087 pass without AIO enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

If AIO has not been enabled in the qemu build that is to be tested, we
should skip the "aio=native without O_DIRECT" test instead of failing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171115180732.31753-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/087 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 27ab6c5151..2561a14456 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -102,7 +102,14 @@ echo
 echo === aio=native without O_DIRECT ===
 echo
 
-run_qemu <<EOF
+# Skip this test if AIO is not enabled in this build
+function run_qemu_filter_aio()
+{
+    run_qemu "$@" | \
+        sed -e 's/is not supported in this build/it requires cache.direct=on, which was not specified/'
+}
+
+run_qemu_filter_aio <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "blockdev-add",
   "arguments": {
-- 
2.13.6
