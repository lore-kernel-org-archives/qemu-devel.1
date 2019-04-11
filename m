Received: from eggs.gnu.org ([209.51.188.92]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-0004ch-VH
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-000120-18
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:08 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 11 Apr 2019 17:23:45 +0300
Message-Id: <f1f5fd6b89d74151dda9dbe758ae9f5f53e744e2.1554992449.git.berto@igalia.com>
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-4.1 1/2] block: Fix check for default
 backing files in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

x-blockdev-reopen requires that the 'backing' parameter is specified
when an image has a backing file attached or when there is a default
backing file in the image metadata.

The latter can be checked by reading bs->auto_backing_file, but
bdrv_reopen_prepare() is using bs->backing_file.

This bug should be detected by iotest 245, but unfortunately the test
expectation is wrong so it must be corrected as well.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Max Reitz <mreitz@redhat.com>
---
 block.c                | 3 ++-
 tests/qemu-iotests/245 | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 16615bc876..e496999e2f 100644
--- a/block.c
+++ b/block.c
@@ -3634,7 +3634,8 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * its metadata. Otherwise the 'backing' option can be omitted.
      */
     if (drv->supports_backing && reopen_state->backing_missing &&
-        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[0])) {
+        (backing_bs(reopen_state->bs) ||
+         reopen_state->bs->auto_backing_file[0])) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret = -EINVAL;
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 7891a210c1..9784ca3ced 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -716,7 +716,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
         # Detach hd2 from hd0.
         self.reopen(opts, {'backing': None})
-        self.reopen(opts, {}, "backing is missing for 'hd0'")
+        self.reopen(opts)
 
         # Remove both hd0 and hd2
         result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-- 
2.11.0
