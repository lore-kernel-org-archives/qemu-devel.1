Received: from eggs.gnu.org ([2001:4830:134:3::10]:60503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d5tSk-00074o-4L
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d5tSh-000470-01
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:32:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1d5tSg-00045y-NY
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:32:54 -0400
Date: Wed, 3 May 2017 08:32:48 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <873732298.6521406.1493814768361.JavaMail.zimbra@redhat.com>
In-Reply-To: <f2d892bd-9a95-a470-0490-042c98d8b0d9@amsat.org>
References: <20170503121143.14925-1-marcandre.lureau@redhat.com>
	<f2d892bd-9a95-a470-0490-042c98d8b0d9@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] libvhost-user: fix
 vu_queue_get_avail_bytes() crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, mst@redhat.com

Hi

----- Original Message -----
> Hi Marc-Andr=C3=A9,
>=20
> On 05/03/2017 09:11 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Calling vu_queue_get_avail_bytes() when the queue doesn't yet have
> > addresses will result in the following crash:
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x000055c414112ce4 in vring_avail_idx (vq=3D0x55c41582fd68,
> > vq=3D0x55c41582fd68)
> >     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:94=
0
> > 940            vq->shadow_avail_idx =3D vq->vring.avail->idx;
> > (gdb) p vq
> > $1 =3D (VuVirtq *) 0x55c41582fd68
> > (gdb) p vq->vring
> > $2 =3D {num =3D 0, desc =3D 0x0, avail =3D 0x0, used =3D 0x0, log_guest=
_addr =3D 0,
> > flags =3D 0}
> >
> >     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:94=
0
> > No locals.
> >     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:96=
0
> >         num_heads =3D <optimized out>
> >     out_bytes=3Dout_bytes@entry=3D0x7fffd035d7c4,
> >     max_in_bytes=3Dmax_in_bytes@entry=3D0,
> >     max_out_bytes=3Dmax_out_bytes@entry=3D0) at
> >     /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1034
> >
> > Check if vring.avail !=3D null before accessing it.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c
> > b/contrib/libvhost-user/libvhost-user.c
> > index af4faad60b..f9680b6279 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -1031,6 +1031,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq=
,
> > unsigned int *in_bytes,
> >      idx =3D vq->last_avail_idx;
> >
> >      total_bufs =3D in_total =3D out_total =3D 0;
> > +    if (!vq->vring.avail) {
> > +        goto done;
> > +    }
> > +
> >      while ((rc =3D virtqueue_num_heads(dev, vq, idx)) > 0) {
> >          unsigned int max, num_bufs, indirect =3D 0;
> >          struct vring_desc *desc;
> >
>=20
> It seems to me safer to fix instead vring_avail_ring(), and fix
> neighbours vring_avail_flags() and vring_avail_idx() while here.

Those are internal/static functions, possibly on hot paths. So I would rath=
er keep the check on the external/public functions only.
