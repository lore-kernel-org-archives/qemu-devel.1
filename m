Received: from eggs.gnu.org ([2001:4830:134:3::10]:52931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF26E-0001ID-Kr
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF26D-0003v5-Mo
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:07:46 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 15 Nov 2017 19:07:32 +0100
Message-Id: <20171115180732.31753-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Make 087 pass without AIO enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

If AIO has not been enabled in the qemu build that is to be tested, we
should skip the "aio=native without O_DIRECT" test instead of failing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Cleber wanted to fix this in July with his "build configuration query
tool and conditional (qemu-io)test skip" series
(https://lists.gnu.org/archive/html/qemu-block/2017-07/msg01303.html),
but unfortunately there hasn't been any activity on that (as far as I
can see), so let's just solve it the simple way.
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
