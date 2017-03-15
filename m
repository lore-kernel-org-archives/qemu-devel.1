Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnzR8-00037f-Ju
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnzR3-0001n9-Ml
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:17:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cnzR3-0001mm-GM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:17:13 -0400
Date: Wed, 15 Mar 2017 05:17:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170315051636-mutt-send-email-mst@kernel.org>
References: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
	<1489460502-6686-3-git-send-email-jasowang@redhat.com>
	<20170314102918.3dce0075.cornelia.huck@de.ibm.com>
	<fc240730-be1d-4b95-0106-48caf5ebc533@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc240730-be1d-4b95-0106-48caf5ebc533@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 2/3] virtio: destroy region cache during
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 15, 2017 at 10:14:48AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B403=E6=9C=8814=E6=97=A5 17:29, Cornelia Huck wrote:
> > On Tue, 14 Mar 2017 11:01:41 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >=20
> > > We don't destroy region cache during reset which can make the maps
> > > of previous driver leaked to a buggy or malicious driver that don't
> > > set vring address before starting to use the device. Fix this by
> > > destroy the region cache during reset and validate it before trying=
 to
> > > see them.
> > >=20
> > > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes from V2:
> > > - introduce a helper and assert caches !=3D NULL
> > > Changes from v1:
> > > - switch to use rcu in virtio_virtqueue_region_cache()
> > > - use unlikely() when needed
> > > ---
> > >   hw/virtio/virtio.c | 46 ++++++++++++++++++++++++++++++-----------=
-----
> > >   1 file changed, 30 insertions(+), 16 deletions(-)
> > >=20
> > > @@ -249,11 +255,10 @@ static inline void vring_used_idx_set(VirtQue=
ue *vq, uint16_t val)
> > >   /* Called within rcu_read_lock().  */
> > >   static inline void vring_used_flags_set_bit(VirtQueue *vq, int ma=
sk)
> > >   {
> > > -    VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring=
.caches);
> > > +    VRingMemoryRegionCaches *caches =3D vring_get_region_caches(vq=
);
> > >       VirtIODevice *vdev =3D vq->vdev;
> > >       hwaddr pa =3D offsetof(VRingUsed, flags);
> > >       uint16_t flags =3D virtio_lduw_phys_cached(vq->vdev, &caches-=
>used, pa);
> > > -
> > Unrelated whitespace change.
>=20
> Right. If no more comments from any others. I think Michael can probabl=
y fix
> this during merge.
>=20
> Thanks

I'd rather get patches that apply cleanly. Minor changes mean you
can keep reviewed-by tags.

> >=20
> > >       virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask)=
;
> > >       address_space_cache_invalidate(&caches->used, pa, sizeof(flag=
s));
> > >   }
> > Other than that:
> >=20
> > Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> >=20
> >=20
