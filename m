Received: from eggs.gnu.org ([2001:4830:134:3::10]:49024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJHRn-0006zy-6o
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJHRi-0008Gv-5I
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:19:35 -0500
Date: Mon, 27 Nov 2017 11:19:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171127111925.GK16527@stefanha-x1.localdomain>
References: <1511408266-4139-1-git-send-email-jasowang@redhat.com>
	<20171123105934.GC26022@stefanha-x1.localdomain>
	<7c6f12d7-8670-2a7b-0e9a-6f6c0ec92759@redhat.com>
	<20171124104447.GA11589@stefanha-x1.localdomain>
	<096a9e5b-d622-17d1-2713-764800a11608@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <096a9e5b-d622-17d1-2713-764800a11608@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.11] virtio-net: don't touch virtqueue
 if vm is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 11:26:34AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B411=E6=9C=8824=E6=97=A5 18:44, Stefan Hajnoczi wrote:
> > On Fri, Nov 24, 2017 at 10:57:11AM +0800, Jason Wang wrote:
> > > On 2017=E5=B9=B411=E6=9C=8823=E6=97=A5 18:59, Stefan Hajnoczi wrote:
> > > > On Thu, Nov 23, 2017 at 11:37:46AM +0800, Jason Wang wrote:
> > > > > Guest state should not be touched if VM is stopped, unfortunately=
 we
> > > > > didn't check running state and tried to drain tx queue unconditio=
nally
> > > > > in virtio_net_set_status(). A crash was then noticed as a migrati=
on
> > > > > destination when user type quit after virtqueue state is loaded b=
ut
> > > > > before region cache is initialized. In this case,
> > > > > virtio_net_drop_tx_queue_data() tries to access the uninitialized
> > > > > region cache.
> > > > >=20
> > > > > Fix this by only dropping tx queue data when vm is running.
> > > > hw/virtio/virtio.c:virtio_load() does the following:
> > > >=20
> > > >     for (i =3D 0; i < num; i++) {
> > > >         if (vdev->vq[i].vring.desc) {
> > > >             uint16_t nheads;
> > > >=20
> > > >             /*
> > > >              * VIRTIO-1 devices migrate desc, used, and avail ring =
addresses so
> > > >              * only the region cache needs to be set up.  Legacy de=
vices need
> > > >              * to calculate used and avail ring addresses based on =
the desc
> > > >              * address.
> > > >              */
> > > >             if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > > >                 virtio_init_region_cache(vdev, i);
> > > >             } else {
> > > >                 virtio_queue_update_rings(vdev, i);
> > > >             }
> > > >=20
> > > > So the region caches should be initialized after virtqueue state is
> > > > loaded.
> > > >=20
> > > > It's unclear to me which code path triggers this issue.  Can you ad=
d a
> > > > backtrace or an explanation?
> > > >=20
> > > > Thanks,
> > > > Stefan
> > > Migration coroutine was yield before region cache was initialized. The
> > > backtrace looks like:
> > [...]
> > > #16 0x0000555555b1c199 in vmstate_load_state (f=3D0x555556f7c010,
> > > vmsd=3D0x5555562b8160 <vmstate_virtio>, opaque=3D0x555557d68610, vers=
ion_id=3D1)
> > >  =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:160
> > > #17 0x0000555555865cc3 in virtio_load (vdev=3D0x555557d68610,
> > > f=3D0x555556f7c010, version_id=3D11) at
> > > /home/devel/git/qemu/hw/virtio/virtio.c:2110
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Thanks for the backtrace!  Your patch is fine but I have a larger
> > concern:
> >=20
> > The backtrace shows that the virtio code is re-entrant during savevm
> > load.  That's probably a bad thing because set_status() and other APIs
> > are probably not intended to run while we are half-way through savevm
> > load.  The virtqueue is only partially set up at this point :(.  I
> > wonder if a more general cleanup is necessary to avoid problems like
> > this in the future...
> >=20
> > Stefan
>=20
> Yes, this needs some thought. An idea is to guarantee the atomicity of the
> virtio state and don't expose partial state. But looks like this needs lo=
ts
> of changes.
>=20
> Anyway, I will apply this patch first.

Sounds good, thanks!

Stefan

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaG/S9AAoJEJykq7OBq3PIDO4H/0aN1rlSwJiGdzS0CwmP+1Uw
8FdWaO/WYECzkgSb3b4ofQKwRu5srEaUE0Tfcb9b4LvtkdU8JMwFqAq7ETeuwFZV
NTh3MMa/eSGSSsuFRAALtdH5lTzx++w3xrziIS2xv2dq4Dy8hJwgKcAqwtYmSDMS
nya1pz1oQtXrMhTa8H/FtJLYcyY91HwTakxVFgE9HIqkh9hHJXPaC3TF+egjv7aW
Ds3fKvk2xBOESgq5Ko1RRcw3JD+afRY4tn7aJG0WbTba3j4tN8xXFL7vl3j8lXBN
vCF4yPuQeFxqYluOd+PT0uK957IZpUOkTjJk0gLUUtIOiMMbD2xFZ4y/+Olj7vc=
=Qu1+
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
