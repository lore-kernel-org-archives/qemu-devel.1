Received: from eggs.gnu.org ([2001:4830:134:3::10]:51615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eIBTc-0006gE-Fw
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eIBTZ-0002iv-2t
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:44:56 -0500
Date: Fri, 24 Nov 2017 10:44:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171124104447.GA11589@stefanha-x1.localdomain>
References: <1511408266-4139-1-git-send-email-jasowang@redhat.com>
	<20171123105934.GC26022@stefanha-x1.localdomain>
	<7c6f12d7-8670-2a7b-0e9a-6f6c0ec92759@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <7c6f12d7-8670-2a7b-0e9a-6f6c0ec92759@redhat.com>
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


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 10:57:11AM +0800, Jason Wang wrote:
> On 2017=E5=B9=B411=E6=9C=8823=E6=97=A5 18:59, Stefan Hajnoczi wrote:
> > On Thu, Nov 23, 2017 at 11:37:46AM +0800, Jason Wang wrote:
> > > Guest state should not be touched if VM is stopped, unfortunately we
> > > didn't check running state and tried to drain tx queue unconditionally
> > > in virtio_net_set_status(). A crash was then noticed as a migration
> > > destination when user type quit after virtqueue state is loaded but
> > > before region cache is initialized. In this case,
> > > virtio_net_drop_tx_queue_data() tries to access the uninitialized
> > > region cache.
> > >=20
> > > Fix this by only dropping tx queue data when vm is running.
> > hw/virtio/virtio.c:virtio_load() does the following:
> >=20
> >    for (i =3D 0; i < num; i++) {
> >        if (vdev->vq[i].vring.desc) {
> >            uint16_t nheads;
> >=20
> >            /*
> >             * VIRTIO-1 devices migrate desc, used, and avail ring addre=
sses so
> >             * only the region cache needs to be set up.  Legacy devices=
 need
> >             * to calculate used and avail ring addresses based on the d=
esc
> >             * address.
> >             */
> >            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >                virtio_init_region_cache(vdev, i);
> >            } else {
> >                virtio_queue_update_rings(vdev, i);
> >            }
> >=20
> > So the region caches should be initialized after virtqueue state is
> > loaded.
> >=20
> > It's unclear to me which code path triggers this issue.  Can you add a
> > backtrace or an explanation?
> >=20
> > Thanks,
> > Stefan
>=20
> Migration coroutine was yield before region cache was initialized. The
> backtrace looks like:
[...]
> #16 0x0000555555b1c199 in vmstate_load_state (f=3D0x555556f7c010,
> vmsd=3D0x5555562b8160 <vmstate_virtio>, opaque=3D0x555557d68610, version_=
id=3D1)
> =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:160
> #17 0x0000555555865cc3 in virtio_load (vdev=3D0x555557d68610,
> f=3D0x555556f7c010, version_id=3D11) at
> /home/devel/git/qemu/hw/virtio/virtio.c:2110

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks for the backtrace!  Your patch is fine but I have a larger
concern:

The backtrace shows that the virtio code is re-entrant during savevm
load.  That's probably a bad thing because set_status() and other APIs
are probably not intended to run while we are half-way through savevm
load.  The virtqueue is only partially set up at this point :(.  I
wonder if a more general cleanup is necessary to avoid problems like
this in the future...

Stefan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaF/geAAoJEJykq7OBq3PIQjoH/iKH8xPa4Sa48XT9hztW1QNi
z9aTeXDvN9rkolYgezZlJS0MkjJS8Igkk3/LzO3PSNhZOArKnOvo8fl9YFXqD/wt
EnEu4E1HPJHYQ7X0OlZ6URWoL/j4ukAzkROwXfIf/tSCl0BxZUpZep1qkc8x7gTa
obblwziraopsAbVS/6eqjS78iOJnx3SnNwvaNiJei7bg46sKJhDk8a1C19FCrxZV
MAz9OjK2VrA7J4SZMIGcKdLCDvUb73Nt9wueGTLVo1GbWJ3oL4Cix+iDjj46UH18
vK3BX1cyXmDIUpCMNsmuAUm+6CGrzuVwYMDz67qO2q8rUXAlCD8MWMaxaBRd84E=
=1ieJ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
