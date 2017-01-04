Received: from eggs.gnu.org ([2001:4830:134:3::10]:40308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cP4L2-0006Xk-L9
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 04:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cP4Kx-0003wi-P9
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 04:28:00 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cP4Kx-0003wS-IL
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 04:27:55 -0500
Received: by mail-wm0-x242.google.com with SMTP id l2so70071083wml.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 01:27:53 -0800 (PST)
Date: Wed, 4 Jan 2017 13:51:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170104135137.GA6908@stefanha-x1.localdomain>
References: <1479333189-20082-1-git-send-email-stefanha@redhat.com>
	<20161117001658-mutt-send-email-mst@kernel.org>
	<20161117132749.GI24138@stefanha-x1.localdomain>
	<20161117193826-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20161117193826-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] virtio: disable notifications in blk
 and scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, zhunxun@gmail.com, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2016 at 07:38:45PM +0200, Michael S. Tsirkin wrote:
> On Thu, Nov 17, 2016 at 01:27:49PM +0000, Stefan Hajnoczi wrote:
> > On Thu, Nov 17, 2016 at 12:17:57AM +0200, Michael S. Tsirkin wrote:
> > > On Wed, Nov 16, 2016 at 09:53:06PM +0000, Stefan Hajnoczi wrote:
> > > > Disabling notifications during virtqueue processing reduces the num=
ber of
> > > > exits.  The virtio-net device already uses virtio_queue_set_notific=
ations() but
> > > > virtio-blk and virtio-scsi do not.
> > > >=20
> > > > The following benchmark shows a 15% reduction in virtio-blk-pci MMI=
O exits:
> > > >=20
> > > >   (host)$ qemu-system-x86_64 \
> > > >               -enable-kvm -m 1024 -cpu host \
> > > >               -drive if=3Dvirtio,id=3Ddrive0,file=3Df24.img,format=
=3Draw,\
> > > >                      cache=3Dnone,aio=3Dnative
> > > >   (guest)$ fio # jobs=3D4, iodepth=3D8, direct=3D1, randread
> > > >   (host)$ sudo perf record -a -e kvm:kvm_fast_mmio
> > > >=20
> > > > Number of kvm_fast_mmio events:
> > > > Unpatched: 685k
> > > > Patched: 592k (-15%, lower is better)
> > >=20
> > > Any chance to see a gain in actual benchmark numbers?
> > > This is important to make sure we are not just
> > > shifting overhead around.
> >=20
> > Good idea.  I reran this morning without any tracing and compared
> > against bare metal.
> >=20
> > Total reads for a 30-second 4 KB random read benchmark with 4 processes
> > x iodepth=3D8:
> >=20
> > Bare metal: 26440 MB
> > Unpatched:  19799 MB
> > Patched:    21252 MB
> >=20
> > Patched vs Unpatched: +7% improvement
> > Patched vs Bare metal: 20% virtualization overhead
> >=20
> > The disk image is a 8 GB raw file on XFS on LVM on dm-crypt on a Samsung
> > MZNLN256HCHP 256 GB SATA SSD.  This is just my laptop.
> >=20
> > Seems like a worthwhile improvement to me.
> >=20
> > Stefan
>=20
> Sure. Pls remember to ping or re-post after the release.

The block pull request I just sent with AioContext polling includes
these patches.  Just noticed this and remembered this email thread.
Feel free to NACK the pull request if you wish to discuss this series
again: <20170104133414.6524-1-stefanha@redhat.com>

Stefan

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYbP3pAAoJEJykq7OBq3PIGCUH+wTyrWDjpDbkEZMwLkMRi2WY
LdH2CzsAjVuS5u/3jCMoeAAAup5jg2ugwQmjkLQoRbT75oOeIrzi9V6sBgCjBsBt
2puhEb65IOGBApt2SP+KY3/192e8xGA5kmihKaMlMwFluXIADOX2NpfevFpLyOqQ
fCi+Pi31VaCH/LmzhldPTmEN5Evv6//XtXm2Nx/URs+5phGKOxnsIzoKMdgBu7YA
kF3yFt05hGgRiVq+VrPliYQ0K8aGdDYxm+pvmuVtjHI69EM0s1B1j9b/ndw3cLY4
k0fMGAC3EkEbTz5VnZU5QltoAnnwfW5+ITImna5ZnOHJAcT+762ZbFG6rEy5Ccg=
=tPXo
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
