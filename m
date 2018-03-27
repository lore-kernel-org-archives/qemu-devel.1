Received: from eggs.gnu.org ([2001:4830:134:3::10]:60363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1f0ocC-0005cB-2d
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1f0oc6-0003Kz-5w
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:26:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1f0oc5-0003Jx-ST
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:26:10 -0400
Date: Tue, 27 Mar 2018 14:24:32 +0100
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20180327132432.hfgs4ltd4un6vl2j@dhcp-10-175-199-170.vpn.oracle.com>
References: <20180327130846.21902-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20180327130846.21902-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block-backend: simplify
 blk_get_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Tue, Mar 27, 2018 at 10:08:46AM -0300, Daniel Henrique Barboza wrote:
>blk_get_aio_context verifies if BlockDriverState bs is not NULL,
>return bdrv_get_aio_context(bs) if true or qemu_get_aio_context()
>otherwise. However, bdrv_get_aio_context from block.c already does
>this verification itself, also returning qemu_get_aio_context()
>if bs is NULL:
>
>AioContext *bdrv_get_aio_context(BlockDriverState *bs)
>{
>    return bs ? bs->aio_context : qemu_get_aio_context();
>}
>
>This patch simplifies blk_get_aio_context to simply call
>bdrv_get_aio_context instead of replicating the same logic.
>
>Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Seems to make sense.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> block/block-backend.c | 8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)
>
>diff --git a/block/block-backend.c b/block/block-backend.c
>index 681b240b12..89f47b00ea 100644
>--- a/block/block-backend.c
>+++ b/block/block-backend.c
>@@ -1865,13 +1865,7 @@ void blk_op_unblock_all(BlockBackend *blk, Error *reason)
>
> AioContext *blk_get_aio_context(BlockBackend *blk)
> {
>-    BlockDriverState *bs = blk_bs(blk);
>-
>-    if (bs) {
>-        return bdrv_get_aio_context(bs);
>-    } else {
>-        return qemu_get_aio_context();
>-    }
>+    return bdrv_get_aio_context(blk_bs(blk));
> }
>
> static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
>-- 
>2.14.3
>
>
