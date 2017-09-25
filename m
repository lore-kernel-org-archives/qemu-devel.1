Received: from eggs.gnu.org ([2001:4830:134:3::10]:35158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOu-0003Io-Id
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOq-0003yX-It
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dwaOq-0003xr-AB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PKsSTm080636
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:42 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d74amqcp4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:42 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 16:54:41 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170922144353.4220-1-vsementsov@virtuozzo.com>
References: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 15:53:51 -0500
Message-Id: <150637283194.26688.566191416574073994@sif>
Subject: Re: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix use of
 uninitialized pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

Quoting Vladimir Sementsov-Ogievskiy (2017-09-22 09:43:53)
> Without initialization to zero dirty_bitmap field may be not zero
> for a bitmap which should not be stored and
> qcow2_store_persistent_dirty_bitmaps will erroneously call
> store_bitmap for it which leads to SYGSEGV on bdrv_dirty_bitmap_name.
> =

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

FYI: this patch has been tagged for stable 2.10.1, but is not yet
upstream. Patch freeze for 2.10.1 is September 27th.

> ---
>  block/qcow2-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index e8d3bdbd6e..14f41d0427 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -602,7 +602,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverS=
tate *bs, uint64_t offset,
>              goto fail;
>          }
> =

> -        bm =3D g_new(Qcow2Bitmap, 1);
> +        bm =3D g_new0(Qcow2Bitmap, 1);
>          bm->table.offset =3D e->bitmap_table_offset;
>          bm->table.size =3D e->bitmap_table_size;
>          bm->flags =3D e->flags;
> -- =

> 2.11.1
> =

>=20
