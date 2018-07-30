Received: from eggs.gnu.org ([2001:4830:134:3::10]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oJ-00037V-0X
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oE-00088Q-Sk
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:46 +0200
Message-Id: <20180730150958.14607-2-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/13] qcow: fix a reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: KONRAD Frederic <frederic.konrad@adacore.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow.c b/block/qcow.c
index 102d058d1c..385d935258 100644
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
2.13.6
