Received: from eggs.gnu.org ([2001:4830:134:3::10]:52034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTPVy-0006lJ-Lx
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTPVx-0007pA-E0
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:25:30 -0400
Date: Fri, 7 Jul 2017 11:25:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170707092511.GA5027@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-20-eblake@redhat.com>
	<20170706160203.GM5975@noname.redhat.com>
	<2ab0a0d0-5db0-8e5f-38ea-58b90bd92f41@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <2ab0a0d0-5db0-8e5f-38ea-58b90bd92f41@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 19/21] block: Make bdrv_is_allocated()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.07.2017 um 04:55 hat Eric Blake geschrieben:
> On 07/06/2017 11:02 AM, Kevin Wolf wrote:
>=20
> >> +++ b/qemu-img.c
> >> @@ -3229,6 +3229,7 @@ static int img_rebase(int argc, char **argv)
> >>          int64_t new_backing_num_sectors =3D 0;
> >>          uint64_t sector;
> >>          int n;
> >> +        int64_t count;
> >>          float local_progress =3D 0;
> >>
> >>          buf_old =3D blk_blockalign(blk, IO_BUF_SIZE);
> >> @@ -3276,12 +3277,14 @@ static int img_rebase(int argc, char **argv)
> >>              }
> >>
> >>              /* If the cluster is allocated, we don't need to take act=
ion */
> >> -            ret =3D bdrv_is_allocated(bs, sector, n, &n);
> >> +            ret =3D bdrv_is_allocated(bs, sector << BDRV_SECTOR_BITS,
> >> +                                    n << BDRV_SECTOR_BITS, &count);
> >>              if (ret < 0) {
> >>                  error_report("error while reading image metadata: %s",
> >>                               strerror(-ret));
> >>                  goto out;
> >>              }
> >> +            n =3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
> >>              if (ret) {
> >>                  continue;
> >>              }
> >=20
> > Same thing. Sectors that are half allocated and half free must be
> > considered completely allocated if the caller can't do byte alignment.
> > Just rounding up without looking at ret isn't correct.
>=20
> In reality, qemu-img rebase should probably be rewritten to exploit
> bdrv_get_block_status() instead of the weaker bdrv_is_allocated(). Right
> now, it is manually calling buffer_is_zero() on every sector to learn
> what sectors are candidates for optimizing, rather than being able to
> exploit BDRV_BLOCK_ZERO where possible

Yes, that's true, but also unrelated. As soon as you convert
bdrv_get_block_status() to byte granularity, you get the same thing
again.

Actually, having another look at this code, the solution for this
specific case is to convert the whole loop (or even function) to byte
granularity. The bdrv_is_allocated() call was the only thing that
required sectors.

> (yes, we may STILL want to call buffer_is_zero() on BDRV_BLOCK_DATA
> when we are trying to squeeze out all parts of an image that can be
> compressed, but maybe that should be an option, just as GNU dd has
> options for creating as much sparseness as possible (slow, because it
> reads data) vs. preserving existing sparseness (faster, because it
> relies on hole detection but leaves explicit written zeroes as
> non-sparse).

I'd expect that typically buffer_is_zero() is only slow if it's also
effective. Most data blocks start with non-zero data in the first few
bytes, so that's really quick. And I'm sure that checking whether a
buffer is zero is faster than doing disk I/O for the same buffer, so the
case of actual zero buffers should benefit, too. The only problem is
with cases where the buffer starts with many zeros and then ends in some
real data. I'm not sure how common this is.

> I guess there's still lots of ground for improving qemu-img, so for
> THIS series, I'll just leave it at an assertion that things are
> sector-aligned.

Sounds okay. If you want, you can add another patch to convert the
function to bytes, or we can do it later on top.

Kevin

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZX1N3AAoJEH8JsnLIjy/WIzYP/1Iko3hhYxFP1HWjjVTgIhw5
hXEc3+c4ebP9M9phBqiVV7gfyIdVfyvcHBuaL4Lf3wXJZhSFEzgfIK775ScYZStQ
zz7VD3l13RJ+nPZpnoE8RLIi+N8fY9TS2alEDTomBtZkeets4Xy+0EdAAZ9KsJff
H3Ef/2miWITWFfJn82f2vij0gIM6FF/RP473Nc7f10Agc00fn7Y6fMFpy0r1x4gE
DzOFWOhlxRTJGxA5r48XAub9b0FKtOU4+uLLw6/xvHXNfxZStKG0Qzsdzb6VwZzQ
yo5/i9DUECcorOqAgfbc04/YhKumcpa31wbZIaWf62xBqq9JGv5ShepIaBt+4j0D
5kDPBJaH3sSK+1CBMcQh+WoBw/mgaGm06AHD2n0Pok4RZZJqIYrGIqu2/xBF5NMn
+b2INOXLfXe4ju0OswQkU8feM1I9Cqz8rTfmXDPOj3NUHww/y4MFIRbfndIbSwps
BHnBm5CVW2zZoI6y+O9t8YRNtxu0X7svHNN6yrlbOw4YW5x8COqhUMR7R5atWlCX
6Sw/LyTCsjM1wuG6nfZY75fDyhCwKE8FBhsNGEs/QacqziGnAfCI5/9R3OKMzsQz
YyMgL3HXrpgO7IMcZ+bHyW6BAKr5mnRqO1m+yR1pbhwFrbiv335D8zUXbZp6OqW6
KYc7SO0UdGdHBHdUSeWe
=3MWV
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
