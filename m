Received: from eggs.gnu.org ([2001:4830:134:3::10]:35671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fiOCT-0001hY-Hx
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 14:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fiOCQ-0004PL-Gw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 14:07:49 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Wed, 25 Jul 2018 20:07:29 +0200
Message-Id: <1532542049-21893-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-3.0] qcow: fix a reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>

Since 42a3e1ab367cdf38cce093de24eb406b99a4ef96 qemu asserts when using the
vvfat driver:

git clone git://qemu.org/qemu.git
cd qemu
./configure --target-list=ppc-softmmu --enable-debug
make -j8
mkdir foo
touch foo/hello
./ppc-softmmu/qemu-system-ppc -M prep --nographic --monitor null             \
                              -hda fat:rw:./foo

"Ctrl-C"

qemu-system-ppc: block.c:3368: bdrv_close_all: Assertion                     \
   `((&all_bdrv_states)->tqh_first == ((void *)0))' failed.

This is because we reference bs twice in qcow_co_create(..) one time in
bdrv_open_blockdev_ref(..) and in blk_insert_bs(..) but we unref it only once
in blk_unref which leads to the reference leak.

Note that I didn't tested much QCOW after this change as I don't use it much.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 block/qcow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow.c b/block/qcow.c
index 102d058..385d935 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -938,6 +938,7 @@ static int coroutine_fn qcow_co_create(BlockdevCreateOptions *opts,
     ret = 0;
 exit:
     blk_unref(qcow_blk);
+    bdrv_unref(bs);
     qcrypto_block_free(crypto);
     return ret;
 }
-- 
1.8.3.1
