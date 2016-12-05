Received: from eggs.gnu.org ([2001:4830:134:3::10]:52257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cDuX8-0005p1-Gh
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cDuX5-00070Q-AF
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:46:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cDuX5-00070G-1B
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:46:19 -0500
Date: Mon, 5 Dec 2016 14:46:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161205144615.GE30434@stefanha-x1.localdomain>
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161201192652.9509-5-stefanha@redhat.com>
	<20161205005459.GA21702@lemon>
	<20161205101452.GB22443@stefanha-x1.localdomain>
	<1548288582.1411113.1480935595505.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <1548288582.1411113.1480935595505.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/13] virtio: poll virtqueues for new
 buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, borntraeger@de.ibm.com, Karl Rister <krister@redhat.com>, qemu-devel@nongnu.org, v.maffione@gmail.com


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 05:59:55AM -0500, Paolo Bonzini wrote:
>=20
>=20
> ----- Original Message -----
> > From: "Stefan Hajnoczi" <stefanha@gmail.com>
> > To: "Fam Zheng" <famz@redhat.com>
> > Cc: "Stefan Hajnoczi" <stefanha@redhat.com>, borntraeger@de.ibm.com, "K=
arl Rister" <krister@redhat.com>,
> > qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>
> > Sent: Monday, December 5, 2016 11:14:52 AM
> > Subject: Re: [Qemu-devel] [PATCH v4 04/13] virtio: poll virtqueues for =
new buffers
> >=20
> > On Mon, Dec 05, 2016 at 08:54:59AM +0800, Fam Zheng wrote:
> > > On Thu, 12/01 19:26, Stefan Hajnoczi wrote:
> > > > Add an AioContext poll handler to detect new virtqueue buffers with=
out
> > > > waiting for a guest->host notification.
> > > >=20
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  hw/virtio/virtio.c | 16 +++++++++++++++-
> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 6f8ca25..3870411 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -2047,13 +2047,27 @@ static void
> > > > virtio_queue_host_notifier_aio_read(EventNotifier *n)
> > > >      }
> > > >  }
> > > > =20
> > > > +static bool virtio_queue_host_notifier_aio_poll(void *opaque)
> > > > +{
> > > > +    EventNotifier *n =3D opaque;
> > > > +    VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> > > > +
> > > > +    if (virtio_queue_empty(vq)) {
> > >=20
> > > I notice this call path gets very hot in the profile:
> > >=20
> > > #0  address_space_translate_internal (d=3D0x7f853c22e970, addr=3D2140=
788738,
> > >     xlat=3Dxlat@entry=3D0x7f8549db59e8, plen=3Dplen@entry=3D0x7f8549d=
b5a68,
> > >     resolve_subpage=3Dresolve_subpage@entry=3Dtrue) at
> > >     /root/qemu-nvme/exec.c:419
> > > #1  0x00007f854d3e8449 in address_space_translate (as=3D<optimized ou=
t>,
> > > addr=3D2140788738,
> > >     xlat=3Dxlat@entry=3D0x7f8549db5a70, plen=3Dplen@entry=3D0x7f8549d=
b5a68,
> > >     is_write=3Dis_write@entry=3Dfalse) at /root/qemu-nvme/exec.c:462
> > > #2  0x00007f854d3ee2fd in address_space_lduw_internal
> > > (endian=3DDEVICE_LITTLE_ENDIAN,
> > >     result=3D0x0, attrs=3D..., addr=3D<optimized out>, as=3D<optimize=
d out>)
> > >     at /root/qemu-nvme/exec.c:3299
> > > #3  address_space_lduw_le (result=3D0x0, attrs=3D..., addr=3D<optimiz=
ed out>,
> > > as=3D<optimized out>)
> > >     at /root/qemu-nvme/exec.c:3351
> > > #4  lduw_le_phys (as=3D<optimized out>, addr=3D<optimized out>) at
> > > /root/qemu-nvme/exec.c:3369
> > > #5  0x00007f854d475978 in virtio_lduw_phys (vdev=3D<optimized out>,
> > > pa=3D<optimized out>)
> > >     at /root/qemu-nvme/include/hw/virtio/virtio-access.h:46
> > > #6  vring_avail_idx (vq=3D<optimized out>, vq=3D<optimized out>)
> > >     at /root/qemu-nvme/hw/virtio/virtio.c:143
> > > #7  virtio_queue_empty (vq=3Dvq@entry=3D0x7f854fd0c9e0) at
> > > /root/qemu-nvme/hw/virtio/virtio.c:246
> > > #8  0x00007f854d475d20 in virtio_queue_empty (vq=3D0x7f854fd0c9e0)
> > >     at /root/qemu-nvme/hw/virtio/virtio.c:2074
> > > #9  virtio_queue_host_notifier_aio_poll (opaque=3D0x7f854fd0ca48)
> > >     at /root/qemu-nvme/hw/virtio/virtio.c:2068
> > > #10 0x00007f854d69116e in run_poll_handlers_once (ctx=3D<optimized ou=
t>) at
> > > aio-posix.c:493
> > > #11 0x00007f854d691b08 in run_poll_handlers (max_ns=3D<optimized out>,
> > > ctx=3D0x7f854e908850)
> > >     at aio-posix.c:530
> > > #12 try_poll_mode (blocking=3Dtrue, ctx=3D0x7f854e908850) at aio-posi=
x.c:558
> > > #13 aio_poll (ctx=3D0x7f854e908850, blocking=3Dblocking@entry=3Dtrue)=
 at
> > > aio-posix.c:601
> > > #14 0x00007f854d4ff12e in iothread_run (opaque=3D0x7f854e9082f0) at
> > > iothread.c:53
> > > #15 0x00007f854c249dc5 in start_thread () from /lib64/libpthread.so.0
> > > #16 0x00007f854acd973d in clone () from /lib64/libc.so.6
> > >=20
> > > Is it too costly to do an address_space_translate per poll?
> >=20
> > Good insight.
> >=20
> > If we map guest RAM we should consider mapping the vring in
> > hw/virtio/virtio.c.  That way not just polling benefits.
> >=20
> > The map/unmap API was not designed for repeated memory accesses.  In the
> > bounce buffer case you have a stale copy - repeated reads will not
> > update it.  Vrings should be in guest RAM so we don't really need to
> > support bounce buffering but it's still a hack to use the map/unmap API.
> >=20
> > Paolo: Thoughts about the memory API?
>=20
> Yeah, I had discussed this recently with Fam, and prototyped (read: compi=
led
> the code) an API like this:
>=20
> int64_t address_space_cache_init(MemoryRegionCache *cache,
>                                  AddressSpace *as,
>                                  hwaddr addr,
>                                  hwaddr len,
>                                  bool is_write);
> /* Only for is_write =3D=3D true.  */
> void address_space_cache_invalidate(MemoryRegionCache *cache,
>                                     hwaddr addr,
>                                     hwaddr access_len);
> uint32_t address_space_lduw_cached(MemoryRegionCache *cache, hwaddr addr,
>                                    MemTxAttrs attrs, MemTxResult *result);
> ...
>=20
> It's basically the same API as usual, but with address_space_translate
> reduced to
>=20
>     *xlat =3D addr - cache->xlat;
>     *plen =3D MIN(*plen, cache->len - *xlat);
>     return cache->mr;
>=20
> and likewise for other hot spots of the ld/st API.  Originally I thought
> of two ways we could use it:
>=20
> 1) update the cache with a MemoryListener
>=20
> 2) hoist the cache out of the hot loops, but still initialize it
> once per iteration.
>=20
> This was before Fam tested your patches, and the polling case makes
> (1) the only practical way.
>=20
> (2) of course would have been less code, but if the idea is used by other
> devices (Vincenzo and the netmap gang wanted something similar in e1000,
> for example) perhaps we could just add a method to PCIDeviceClass and
> VirtioDeviceClass.
>=20
> Separate from this, and unrelated to polling, we can and should use
> the map/unmap API for descriptors, both direct and indirect.  This is
> simple and I hope to test it some time this week.

That sounds promising.

Another cache invalidation approach is to give MemoryRegions generation
numbers so that the cached address translation can be refreshed if the
MemoryRegion has changed.

Anyway, I'm glad the polling series on its own is already showing good
performance results.  I'd like to merge it at the beginning of QEMU 2.9
so we can work on further improvements that build on top of it.

Stefan

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRX23AAoJEJykq7OBq3PIVsAH/RNtYGR6maGHO4nGORIRqJqH
djyxZML3hV3aTl5NpOpMwE0ZV/pDuPbwniKRHeX4mQBs0FM5GBw/TJqZkDmy/qPe
H4/zTmQ6R8JrrKB+c1feSHeoS3SFT0Y3McVQ6YFVCAHYv2Awmuda6q+mf8tu6UwT
IIDQATooF7KBmSOVwcdwY9fdRs6ch0Opq+/ygjJZWjSPAzyjR3y1z1RvuTe1Y+Q/
qjiEAtdT8K6+FpDNsLt6xYbTFBs2Z5MTOJ72Rv2ad4sBj11erk6qiyAVsEufCug/
haMe2p0dEOkKoPpSmFtCiPtgUwLIhwGAg9fjNP4u00SCgfn8MAp5KM85pSoEoNA=
=BuBE
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
