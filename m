Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPm9S-0005cx-3a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPm9R-0007Gg-6v
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:51:46 -0400
Date: Mon, 4 Jun 2018 10:51:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180604095133.GE13674@stefanha-x1.localdomain>
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<20180601133202.GS8687@stefanha-x1.localdomain>
	<84ff808f-2856-808e-0a42-a1b5e0d3c64b@tuxera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline
In-Reply-To: <84ff808f-2856-808e-0a42-a1b5e0d3c64b@tuxera.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 05:24:53PM +0300, Ari Sundholm wrote:
> On 06/01/2018 04:32 PM, Stefan Hajnoczi wrote:
> > On Fri, Jun 01, 2018 at 12:17:19AM +0300, Ari Sundholm wrote:
> > > From: Aapo Vienamo <aapo@tuxera.com>
> >=20
> > Thanks for the patch!
> >=20
> > > Implements a block device write logging system, similar to Linux kern=
el
> > > device mapper dm-log-writes. The write operations that are performed
> > > on a block device are logged to a file or another block device. The
> > > write log format is identical to the dm-log-writes format. Currently,
> > > log markers are not supported.
> > >=20
> > > This functionality can be used for fail-safe and fs consistency
> > > testing. By implementing it in qemu, tests utilizing write logs can be
> > > be used to test non-Linux drivers and older kernels.
> >=20
> > This patch doesn't implement the same semantics as dm-log-writes, where
> > only completed writes are logged to make fs consistency testing easier.
> > If you intend to use it for this purpose, shouldn't it act the same way
> > as dm-log-writes?
> >=20
>=20
> I am not quite sure what you mean. I am not the original author of this
> proposed feature, but to me (admittedly with little experience of qemu
> internals), it looks like the driver accurately logs the writes and flush=
es
> performed on the guest block device. It intentionally does not concern
> itself with when the write actually hits the physical host block device or
> file, as we're interested in the direct interactions between a filesystem
> driver and the guest block device. The write hitting the various levels of
> the host-side caches and devices is left up to the caching mode. But perh=
aps
> there's something obvious I'm not seeing?

Linux dm-log-writes is specific about when logging happens:

 * We log writes only after they have been flushed, this makes the log desc=
ribe
 * close to the order in which the data hits the actual disk, not its cache=
=2E  So
 * for example the following sequence (W means write, C means complete)
 *
 * Wa,Wb,Wc,Cc,Ca,FLUSH,FUAd,Cb,CFLUSH,CFUAd
 *
 * Would result in the log looking like this:
 *
 * c,a,flush,fuad,b,<other writes>,<next flush>
 *
 * This is meant to help expose problems where file systems do not properly=
 wait
 * on data being written before invoking a FLUSH.  FUA bypasses cache so on=
ce it
 * completes it is added to the log as it should be on disk.

This patch implements the same on-disk format but the semantics are
different since it doesn't wait for a flush.

If I use dm-log-writes on a linear device-mapper target inside the guest
or on the host, then I would have expected the same output as QEMU's
dm-log-writes, but I think this is not the case.

It's worth at least documenting this quirk.

Stefan

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFQulAAoJEJykq7OBq3PIRHYH/3s3zkQP2yT5mprVFbD0WXUr
tMBBH0jSwcUUQf4W4F7q+VjGXuoi2gibaCr70Pomo6CAesw3a/zzTlJzFpbKAOiE
xWphH9bjAxAby3thoTxSxXmk+bhCpFeneHpvia1xzmPiRGOBd/uufjHk0sJq1oLz
jyscqbga8jpde7hTNdwZ8y+vNueCZePswsM0QL2ZSWPV3ZWR+mnfbxhB1LI+y6GG
Gwiy/E5ITYWj4gyvSz0mMujkyuaXtr6k009x2FN0JVGRT9tFFRnUb5JGaRfvqwSA
OUAci6scrYAWm0YXtvTXZt1uFREXBLO8IRun5D3dY0jZ4z2djAITf1egR71b/UY=
=Lkrc
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
