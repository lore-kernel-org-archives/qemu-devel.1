Received: from eggs.gnu.org ([2001:4830:134:3::10]:54313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etGWv-0003ML-6e
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etGWt-000396-OP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:37:37 -0500
Date: Tue, 6 Mar 2018 18:37:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306173718.GK7139@localhost.localdomain>
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
	<2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
	<20180306134757.GH31045@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20180306134757.GH31045@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.03.2018 um 14:47 hat Stefan Hajnoczi geschrieben:
> On Wed, Feb 28, 2018 at 09:11:32PM +0100, Max Reitz wrote:
> > On 2018-02-28 19:08, Max Reitz wrote:
> > > On 2018-02-27 17:17, Stefan Hajnoczi wrote:
> > >> On Mon, Feb 26, 2018 at 06:03:13PM +0100, Max Reitz wrote:
> > >>> There are filesystems (among which is tmpfs) that have a hard time
> > >>> reporting allocation status.  That is definitely a bug in them.
> > >>>
> > >>> However, there is no good reason why qemu-img convert should query =
the
> > >>> allocation status in the first place.  It does zero detection by it=
self
> > >>> anyway, so we can detect unallocated areas ourselves.
> > >>>
> > >>> Furthermore, if a filesystem driver has any sense, reading unalloca=
ted
> > >>> data should take just as much time as lseek(SEEK_DATA) + memset(). =
 So
> > >>> the only overhead we introduce by dropping the manual lseek() call =
is a
> > >>> memset() in the driver and a buffer_is_zero() in qemu-img, both of =
which
> > >>> should be relatively quick.
> > >>
> > >> This makes sense.  Which file systems did you test this patch on?
> > >=20
> > > On tmpfs and xfs, so far.
> > >=20
> > >> XFS, ext4, and tmpfs would be a good minimal test set to prove the
> > >> patch.  Perhaps with two input files:
> > >> 1. A file that is mostly filled with data.
> > >> 2. A file that is only sparsely populated with data.
> > >=20
> > > And probably with vmdk, which (by default) forbids querying any areas
> > > larger than 64 kB.
> > >=20
> > >> The time taken should be comparable with the time before this patch.
> > >=20
> > > Yep, I'll do some benchmarks.
> >=20
> > And the results are in.  I've created 2 GB images on various filesystems
> > in various formats, then I've either written 64 kB every 32 MB to them
> > ("sparse"), or left out 64 kB every 32 MB ("full").  Then I've converted
> > them to null-co:// and took the (real) time through "time". (Script is
> > attached.)
> >=20
> > I've attached the raw results before and after this patch.  Usually, I
> > did six runs for each case and dropped the most extreme outlier --
> > except for full vmdk images, where I've only done one run for each case
> > because creating these images can take a very long time.
> >=20
> > Here are the differences from before to after:
> >=20
> > sparse raw on tmpfs:    + 19 % (436 ms to 520 ms)
> > sparse qcow2 on tmpfs:  - 31 % (435 ms to 301 ms)
> > sparse vmdk on tmpfs:   + 37 % (214 ms to 294 ms)
> >=20
> > sparse raw on xfs:      + 69 % (452 ms to 762 ms)
> > sparse qcow2 on xfs:    - 34 % (462 ms to 304 ms)
> > sparse vmdk on xfs:     + 42 % (210 ms to 298 ms)
> >=20
> > sparse raw on ext4:     +360 % (144 ms to 655 ms)
> > sparse qcow2 on ext4:   +120 % (147 ms to 330 ms)
> > sparse vmdk on ext4:    + 16 % (253 ms to 293 ms)
> >=20
> >=20
> > full raw on tmpfs:      -  9 % (437 ms to 398 ms)
> > full qcow2 on tmpfs:    - 75 % (1.63 s to 403 ms)
> > full vmdk on tmpfs:     -100 % (10 min to 767 ms)
> >=20
> > full raw on xfs:        -  1 % (407 ms to 404 ms, insignificant)
> > full qcow2 on xfs:      -  1 % (410 ms to 404 ms, insignificant)
> > full vmdk on xfs:       - 33 % (1.05 s to 695 ms)
> >=20
> >=20
> >=20
> >=20
> > full raw on ext4:       -  2 % (308 ms to 301 ms, insignificant)
> > full qcow2 on ext4:     +  2 % (307 ms to 312 ms, insignificant)
> > full vmdk on ext4:      - 74 % (3.53 s to 839 ms)
> >=20
> >=20
> > So...  It's more extreme than I had hoped, that's for sure.  What I
> > conclude from this is:
> >=20
> > (1) This patch is generally good for nearly fully allocated images.  In
> > the worst case (on well-behaving filesystems with well-optimized image
> > formats) it changes nothing.  In the best case, conversion time is
> > reduced drastically.

This makes sense. Asking the kernel whether a block is zero only helps
the performance if the result is yes occasionally, otherwise it's just
wasted work.

Maybe we could try to guess the ratio by comparing the number of
allocated blocks in the image file and the virtual disk size or
something? Then we could only call lseek() when we can actually expect
an improvement from it.

> > (2) For sparse raw images, this is absolutely devastating.  Reading them
> > now takes more than (ext4) or nearly (xfs) twice as much time as reading
> > a fully allocated image.  So much for "if a filesystem driver has any
> > sense".

Are you sure that only the filesystem is the problem? Checking for every
single byte of an image whether it is zero has to cost some performance.
The fully allocated image doesn't suffer from this because (a) it only
has to check the first byte in each block and (b) the cost was already
there before this patch.

In fact, if null-co supported .bdrv_co_pwrite_zeroes, I think you would
get even worse results for your patch because then the pre-patch version
doesn't even have to do the memset().

> > (2a) It might be worth noting that on xfs, reading the sparse file took
> > longer even before this patch...
> >=20
> > (3) qcow2 is different: It benefits from this patch on tmpfs and xfs
> > (note that reading a sparse qcow2 file took longer than reading a full
> > qcow2 file before this patch!), but it gets pretty much destroyed on
> > ext4, too.

I suppose an empty qcow2 with metadata preallocation behaves roughly
like sparse raw?

As long as the qcow2 metadata reflects the allocation status in the
image file (which it probably usually does, except with preallocation),
it makes sense that qcow2 performs better with just relying on its
metadata. Calling an lseek() that just returns the same result is a
wasted effort then.

> > (4) As for sparse vmdk images...  Reading them takes longer, but it's
> > still fasster than reading full vmdk images, so that's not horrible.

Hm, why is that? Shouldn't vmdk metadata reflect the allocation status
in the image file just as well as qcow2 metadata?

But actually, the absolute numbers are much lower than both raw and
qcow2, which is a bit surprising. Is there a bug somewhere in vmdk or
are we missing optimisations in raw and qcow2?

> > So there we are.  I was wrong about filesystem drivers having any sense,
> > so this patch can indeed have a hugely negative impact.
> >=20
> > I would argue that conversion time for full images is more important,
> > because that's probably the main use case; but the thing is that here
> > this patch only helps for tmpfs and vmdk.  We don't care too much about
> > vmdk, and the fact that tmpfs takes so long simply is a bug.
> >=20
> > I guess the xfs/tmpfs results would still be in a range where they are
> > barely acceptable (because it's mainly a qcow2 vs. raw tradeoff), but
> > the ext4 horrors probably make this patch a no-go in its current form.
> >=20
> > In any case it's interesting to see that even the current qemu-img
> > convert takes longer to read sparsely allocated qcow2/raw files from xfs
> > than fully allocated images...
> >=20
> >=20
> > So I guess I'll re-send this patch where the change is done only for
> > -S 0.
>=20
> Wow, unexpected.  Thanks for doing the benchmarks!

ext4 is a bit surprising, yes. vmdk, too. The rest kind of makes sense
to me.

Kevin

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJantHOAAoJEH8JsnLIjy/W+hgQALmJUSbiPWpqgtns41Zy9QEs
72RAwoW4gtpMO/PLOjGvnwX1uocVXuIerxzy1b8wqaZou5S4xVpKbt8zZ+WuPMTl
pIhbklMmuluDAmkJKAIh2A9eUGScgFh4dFURbELCKdQdBXZlM+p58+Z8sOXcZ2mK
yajOCr0wiJ36BYcpZPj0SnaNyO4o219JGN8z5G/xA0MnOYuOiDL619x9mvfCjg1c
Gcd0vFuYYF//qfKC8O9ZfvFut4SrCMTgzC0oC7s+U5nO7X2tnYBP1jSd8qZclJDC
pNN19OHYQUVtcyJjAXcDOj5MDFJCHWV4AkZ8hzcVt+1SMIqXA0EWh2WurGZb27zi
3WWIBfcz+TFRAZS+DNB+5EYaber9vY4Ly/3eiTDj39V77qk2xUd3pi8p3FJwGuxl
4NcpwCo9z7mkYI4B2lbqKrdW0YftYm/hZaQTwWBaLCi/lX1K+I+pEIO2EffsLgY8
smgh4BIIvFQozIHRoWxuxUnO4WtnR83Xr7YR5OGgDU4YLerGhp57BCcQG58iqFAK
4V8sj56QI1BaiyqC09AG621SY/LV3j6AP072vAp+Dxx+vej47Lsa/UsXT+oAwH03
SRneE4aogepCX+kijn31dOhwJds/88cYnT07QCr8WdZKkEiIOTsl4mTA7pHDPAjc
GKFMfql+I1fH8C/iBOMC
=0p2M
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
