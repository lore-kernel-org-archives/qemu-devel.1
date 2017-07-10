Received: from eggs.gnu.org ([2001:4830:134:3::10]:48393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUXDU-0000kU-E8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUXDR-0004NM-DM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dUXDR-0004Mf-7f
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:51:01 -0400
Message-ID: <1499687456.23551.17.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Jul 2017 13:50:56 +0200
In-Reply-To: <CAJ+F1C+LVOXDevrxXLvg0MPeUrZZpS1UF5k0MtF7gvc1gRbPNQ@mail.gmail.com>
References: <20170710070432.856-1-kraxel@redhat.com>
	<CAJ+F1C+LVOXDevrxXLvg0MPeUrZZpS1UF5k0MtF7gvc1gRbPNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: skip update cursor in
 post_load if we don't have one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 2017-07-10 at 09:05 +0000, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> On Mon, Jul 10, 2017 at 9:06 AM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
> > If the cursor resource id isn't set the guest didn't define a
> > cursor.
> > Skip the cursor update in post_load in that that case.
>=20
> update_cursor() deals with resource_id =3D=3D 0 already, but it also
> update the cursor position. What's the issue calling update_cursor()
> here?

Calling set_cursor(), then vnc client being confused by rich cursor.

>=20
> > Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> > =C2=A0hw/display/virtio-gpu.c | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 58dc0b2737..eef11083d7 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1092,7 +1092,9 @@ static int virtio_gpu_load(QEMUFile *f, void
> > *opaque, size_t size,
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpy_gfx_replace_surface(scanout->co=
n, scanout->ds);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpy_gfx_update(scanout->con, 0, 0, =
scanout->width,
> > scanout->height);
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(g, &scanout->cursor);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (scanout->cursor.resource_id) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(g, &scanout-=
>cursor);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res->scanout_bitmask |=3D (1 << i);
> > =C2=A0 =C2=A0 =C2=A0}
> >=20
> > --
> > 2.9.3
> >=20
> >=20
> >=20
>=20
> --=C2=A0
> Marc-Andr=C3=A9 Lureau
