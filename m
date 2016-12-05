Received: from eggs.gnu.org ([2001:4830:134:3::10]:56391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cDugz-0001Gn-1x
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cDugv-0002BX-U7
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:56:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cDugv-0002B9-LC
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 09:56:29 -0500
Date: Mon, 5 Dec 2016 14:56:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161205145626.GF30434@stefanha-x1.localdomain>
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161205102549.GA23432@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <20161205102549.GA23432@lemon>
Subject: Re: [Qemu-devel] [PATCH v4 00/13] aio: experimental virtio-blk
 polling mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 06:25:49PM +0800, Fam Zheng wrote:
> On Thu, 12/01 19:26, Stefan Hajnoczi wrote:
> > One way to avoid the costly exit is to use polling instead of notificat=
ion.
>=20
> Testing with fio on virtio-blk backed by NVMe device, I can see significa=
nt
> performance improvement with this series:
>=20
>     poll-max-ns    iodepth=3D1    iodepth=3D32
>     --------------------------------------
>     0              24806.94     151430.36
>     1              24435.02     155285.59
>     100            24702.41     149937.2
>     1000           24457.08     152936.3
>     10000          24605.05     156158.12
>     13000          24412.95     154908.73
>     16000          30654.24     185731.58
>     18000          36365.69     185538.78
>     20000          35640.48     188640.61
>     30000          37411.05     184198.39
>     60000          35230.66     190427.42
>=20
> So this definitely helps synchronous I/O with queue depth =3D 1. Great!

Nice.  Even with iodepth=3D32 the improvement is significant.

> I have a small concern with high queue depth, though. The more frequent w=
e check
> the virtqueue, the less likely the requests can be batched, and the more
> submissions (both from guest to QEMU and from QEMU to host) are needed to
> achieve the same bandwidth, because we'd do less plug/unplug. This could =
be a
> problem under heavy workload.  We may want to consider the driver's trans=
ient
> state when it is appending requests to the virtqueue. For example, virtio=
-blk
> driver in Linux updates avail idx after adding each request. If QEMU look=
s at
> the index in the middle, it will miss the opportunities to plug/unplug an=
d merge
> requests. On the other hand, though virtio-blk driver doesn't have IO sch=
eduler,
> it does have some batch submission semantics passed down by blk-mq (see t=
he
> "notify" condition in drivers/block/virtio_blk.c:virtio_queue_rq()).  So =
I'm
> wondering whether it makes sense to wait for the whole batch of requests =
to be
> added to the virtqueue before processing it? This can be done by changing=
 the
> driver to only update "avail" index after all requests are added to the q=
ueue,
> or even adding a flag in the virtio ring descriptor to suppress busy poll=
ing.

Only benchmarking can tell.  It would be interesting to extract the
vq->vring.avail->idx update from virtqueue_add().  I don't think a new
flag is necessary.

> > The main drawback of polling is that it consumes CPU resources.  In ord=
er to
> > benefit performance the host must have extra CPU cycles available on ph=
ysical
> > CPUs that aren't used by the guest.
> >=20
> > This is an experimental AioContext polling implementation.  It adds a p=
olling
> > callback into the event loop.  Polling functions are implemented for vi=
rtio-blk
> > virtqueue guest->host kick and Linux AIO completion.
> >=20
> > The -object iothread,poll-max-ns=3DNUM parameter sets the number of nan=
oseconds
> > to poll before entering the usual blocking poll(2) syscall.  Try settin=
g this
> > parameter to the time from old request completion to new virtqueue kick=
=2E  By
> > default no polling is done so you must set this parameter to get busy p=
olling.
>=20
> Given the self tuning, should we document the best practice in setting the
> value?  Is it okay for user or even QEMU to use a relatively large value =
by
> default and expect it to tune itself sensibly?

Karl: do you have time to run a bigger suite of benchmarks to identify a
reasonable default poll-max-ns value?  Both aio=3Dnative and aio=3Dthreads
are important.

If there is a sweet spot that improves performance without pathological
cases then we could even enable polling by default in QEMU.

Otherwise we'd just document the recommended best polling duration as a
starting point for users.

Stefan

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRYAaAAoJEJykq7OBq3PIFpMIAIGpbMJj+hlwBQxqXQz1OINL
5jEcCzjVO2bkEebLR1dKr1zoBU4XR/NGlR2SWYqB5lEUp7lFA70t0boLv83chDLd
zTifjBjMldxLO5MgGK8Q0N1xBKcDjGLkQRhpZOH+wdPSVvGSaush61mzUJG8a7Tg
58Si/0Ns+gxykYLBoHUPrrfPX0Pk0y96H09wvCAtTTWlISocKeU97bJ7kJUNsYGG
LlnXSe6w7lHCiCIbuL1JraYqKaUWzJDRhHNscUrxt+dl0o/g0oaQ3pxdT6lYn3/1
ck2nEId2mYdvMPqmgwLVq2xGqb4nhGLWbwysgs8P/NmOpebPe1cgIPQ4o9ufm8U=
=Sy0N
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
