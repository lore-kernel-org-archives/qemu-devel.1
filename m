Received: from eggs.gnu.org ([2001:4830:134:3::10]:38665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fTPqK-0004IS-6s
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fTPqF-0006PB-US
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:51:04 -0400
Received: from [45.249.212.255] (port=39092 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fTPqF-0006NR-JE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:50:59 -0400
From: "liujunjie (A)" <liujunjie23@huawei.com>
Date: Thu, 14 Jun 2018 10:50:47 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC5550868DC19@DGGEMM501-MBX.china.huawei.com>
References: <20180607080237.12360-1-liujunjie23@huawei.com>
In-Reply-To: <20180607080237.12360-1-liujunjie23@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ps2: check PS2Queue wptr pointer in
 post_load routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, fangying <fangying1@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

ping

> -----Original Message-----
> From: liujunjie (A)
> Sent: Thursday, June 07, 2018 4:03 PM
> To: kraxel@redhat.com; berrange@redhat.com
> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; wangxin (U)
> <wangxinxin.wang@huawei.com>; Huangweidong (C)
> <weidong.huang@huawei.com>; fangying <fangying1@huawei.com>;
> qemu-devel@nongnu.org; liujunjie (A) <liujunjie23@huawei.com>
> Subject: [PATCH] ps2: check PS2Queue wptr pointer in post_load routine
>=20
> In commit 802cbcb7300, most issues have been fixed when qemu guest
> migration. But the queue size still need to check whether is equal to
> PS2_QUEUE_SIZE. If yes, the wptr should set as 0. Or, wptr would larger t=
han
> PS2_QUEUE_SIZE and never come back when ps2_queue_noirq is called.
> This could lead to OOB access, add check to avoid it.
>=20
> Signed-off-by: liujunjie <liujunjie23@huawei.com>
> ---
>  hw/input/ps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c index eeec618..fdfcadf 10064=
4
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -927,7 +927,7 @@ static void ps2_common_post_load(PS2State *s)
>=20
>      /* reset rptr/wptr/count */
>      q->rptr =3D 0;
> -    q->wptr =3D size;
> +    q->wptr =3D (size =3D=3D PS2_QUEUE_SIZE) ? 0 : size;
>      q->count =3D size;
>      s->update_irq(s->update_arg, q->count !=3D 0);  }
> --
> 1.8.3.1
>=20
