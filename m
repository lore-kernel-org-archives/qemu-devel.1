Received: from eggs.gnu.org ([2001:4830:134:3::10]:32897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ff0Gg-0003zr-Ax
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ff0Gd-00088g-9z
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:58:10 -0400
From: =?utf-8?B?0K7RgNC40Lkg0JrQvtGC0L7Qsg==?= <yury-kotov@yandex-team.ru>
In-Reply-To: <20180713191451-mutt-send-email-mst@kernel.org>
References: <1531490645-10989-1-git-send-email-yury-kotov@yandex-team.ru>
	<20180713191451-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Jul 2018 12:58:02 +0300
Message-Id: <55231531735082@iva4-ed922e5c836e.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: fix invalid downcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Jia He <hejianet@gmail.com>, qemu-stable@nongnu.org

+ qemu-stable@

13.07.2018, 19:16, "Michael S. Tsirkin" <mst@redhat.com>:
> On Fri, Jul 13, 2018 at 05:04:05PM +0300, Yury Kotov wrote:
>> =C2=A0virtio_queue_get_desc_addr returns 64-bit hwaddr while int is us=
ually 32-bit.
>> =C2=A0If returned hwaddr is not equal to 0 but least-significant 32 bi=
ts are
>> =C2=A0equal to 0 then this code will not actually stop running queue.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>
> So IIUC
>
> Fixes: fb20fbb764aa1 ("vhost: avoid to start/stop virtqueue which is no=
t ready")
> And
> Cc: qemu-stable@nongnu.org
>

Ok, done. Or did you mean I have to resend the patch-message to qemu-stab=
le?

>> =C2=A0---
>> =C2=A0=C2=A0hw/virtio/vhost.c | 4 +---
>> =C2=A0=C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>>
>> =C2=A0diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> =C2=A0index b129cb9..7edeee7 100644
>> =C2=A0--- a/hw/virtio/vhost.c
>> =C2=A0+++ b/hw/virtio/vhost.c
>> =C2=A0@@ -1071,10 +1071,8 @@ static void vhost_virtqueue_stop(struct v=
host_dev *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.index =3D=
 vhost_vq_index,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int r;
>> =C2=A0- int a;
>>
>> =C2=A0- a =3D virtio_queue_get_desc_addr(vdev, idx);
>> =C2=A0- if (a =3D=3D 0) {
>> =C2=A0+ if (virtio_queue_get_desc_addr(vdev, idx) =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Don't s=
top the virtqueue which might have not been started */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0--
>> =C2=A02.7.4
