Received: from eggs.gnu.org ([2001:4830:134:3::10]:44427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQu4L-0007Wv-Lu
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQu4K-0000PI-DB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:31:09 -0400
Date: Thu, 7 Jun 2018 13:30:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607123056.GG19032@stefanha-x1.localdomain>
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<20180601133202.GS8687@stefanha-x1.localdomain>
	<84ff808f-2856-808e-0a42-a1b5e0d3c64b@tuxera.com>
	<20180604095133.GE13674@stefanha-x1.localdomain>
	<9bd3376a-f7b3-5f51-7fe0-79888898da7f@tuxera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <9bd3376a-f7b3-5f51-7fe0-79888898da7f@tuxera.com>
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


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 03:10:47PM +0300, Ari Sundholm wrote:
> On 06/04/2018 12:51 PM, Stefan Hajnoczi wrote:
> > On Fri, Jun 01, 2018 at 05:24:53PM +0300, Ari Sundholm wrote:
> > > On 06/01/2018 04:32 PM, Stefan Hajnoczi wrote:
> > > > On Fri, Jun 01, 2018 at 12:17:19AM +0300, Ari Sundholm wrote:
> > > > > From: Aapo Vienamo <aapo@tuxera.com>
> > > >=20
> > > > Thanks for the patch!
> > > >=20
> > > > > Implements a block device write logging system, similar to Linux =
kernel
> > > > > device mapper dm-log-writes. The write operations that are perfor=
med
> > > > > on a block device are logged to a file or another block device. T=
he
> > > > > write log format is identical to the dm-log-writes format. Curren=
tly,
> > > > > log markers are not supported.
> > > > >=20
> > > > > This functionality can be used for fail-safe and fs consistency
> > > > > testing. By implementing it in qemu, tests utilizing write logs c=
an be
> > > > > be used to test non-Linux drivers and older kernels.
> > > >=20
> > > > This patch doesn't implement the same semantics as dm-log-writes, w=
here
> > > > only completed writes are logged to make fs consistency testing eas=
ier.
> > > > If you intend to use it for this purpose, shouldn't it act the same=
 way
> > > > as dm-log-writes?
> > > >=20
> > >=20
> > > I am not quite sure what you mean. I am not the original author of th=
is
> > > proposed feature, but to me (admittedly with little experience of qemu
> > > internals), it looks like the driver accurately logs the writes and f=
lushes
> > > performed on the guest block device. It intentionally does not concern
> > > itself with when the write actually hits the physical host block devi=
ce or
> > > file, as we're interested in the direct interactions between a filesy=
stem
> > > driver and the guest block device. The write hitting the various leve=
ls of
> > > the host-side caches and devices is left up to the caching mode. But =
perhaps
> > > there's something obvious I'm not seeing?
> >=20
> > Linux dm-log-writes is specific about when logging happens:
> >=20
> >   * We log writes only after they have been flushed, this makes the log=
 describe
> >   * close to the order in which the data hits the actual disk, not its =
cache.  So
> >   * for example the following sequence (W means write, C means complete)
> >   *
> >   * Wa,Wb,Wc,Cc,Ca,FLUSH,FUAd,Cb,CFLUSH,CFUAd
> >   *
> >   * Would result in the log looking like this:
> >   *
> >   * c,a,flush,fuad,b,<other writes>,<next flush>
> >   *
> >   * This is meant to help expose problems where file systems do not pro=
perly wait
> >   * on data being written before invoking a FLUSH.  FUA bypasses cache =
so once it
> >   * completes it is added to the log as it should be on disk.
> >=20
> > This patch implements the same on-disk format but the semantics are
> > different since it doesn't wait for a flush.
> >=20
> > If I use dm-log-writes on a linear device-mapper target inside the guest
> > or on the host, then I would have expected the same output as QEMU's
> > dm-log-writes, but I think this is not the case.
> >=20
> > It's worth at least documenting this quirk.
>=20
> Oh, now I see what you mean.
>=20
> I was under the impression that when we do the logging at the level it is
> done now, we see the actual writes to the guest block device to completio=
n,
> as far as the guest is concerned (being safely in the host's page cache is
> enough for this). Is this understanding incorrect?

=2Ebdrv_co_pwritev is called on request submission.
blk_log_writes_co_log() spawns a coroutine for
blk_log_writes_co_do_log(), which appends a struct log_write_entry to
the log file independently of the other coroutine that is doing the
actual write to the underlying file.

This means the entry could be added to the log file before the write
request completes.

If you want to log on request completion then you cannot spawn the log
coroutine in parallel with the write coroutine.  Instead you would have
to complete the write and then update the log.

> Regarding the issue of waiting for flushes, as it is now, the driver only
> updates the superblock of the log on flush, and everything in the log
> file/device beyond the limits set by the values in the superblock is
> typically ignored as garbage by tools handling dm-log-writes logs. (I won=
der
> if dm-log-writes actually works similarly by exploiting this fact?)

This does work in the current patch because the log is updated before
the write has completed.

Stefan

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGSWAAAoJEJykq7OBq3PIAU0IAMI+fQ29idAIjlbxTgfMStwo
yrP8WKoHw7oDYse/3Mpbm5D4sotBbwENA2tl7GeECdeQYJEjzfDw/kQyXvwux5bE
Rr0OL8h+tRhqw1dGdQcDFek4EpdJgUei/AGcMBUiazoZ+xStK81Ouk2+/6VbJaoI
RGHH5J62Sp1sxczysjcEURqE6Oec1e1722CP5IZG3WutMAyVERMy2/pz0Dj02wzb
QcEsauY6j4qAPgRaQkG6bFkivJXdRPXM5/TA+eMzb2hVoClyDWbPkIfoXGN23jFD
76mGgVHH/hT/WIgJOfdhSBFzNCyFlajXq4eUY/1QsV29p2yDKApaiSgAlivqUUQ=
=mIcc
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
