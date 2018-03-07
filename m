Received: from eggs.gnu.org ([2001:4830:134:3::10]:54514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etcVX-0002Xy-Hn
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etcVV-0007NX-Vy
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:05:39 -0500
Date: Wed, 7 Mar 2018 18:05:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180307170521.GC7917@localhost.localdomain>
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
	<2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
	<20180306134757.GH31045@stefanha-x1.localdomain>
	<20180306173718.GK7139@localhost.localdomain>
	<a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.03.2018 um 16:57 hat Max Reitz geschrieben:
> On 2018-03-06 18:37, Kevin Wolf wrote:
> > Am 06.03.2018 um 14:47 hat Stefan Hajnoczi geschrieben:
> >> On Wed, Feb 28, 2018 at 09:11:32PM +0100, Max Reitz wrote:
> >>> So...  It's more extreme than I had hoped, that's for sure.  What I
> >>> conclude from this is:
> >>>
> >>> (1) This patch is generally good for nearly fully allocated images.  =
In
> >>> the worst case (on well-behaving filesystems with well-optimized image
> >>> formats) it changes nothing.  In the best case, conversion time is
> >>> reduced drastically.
> >=20
> > This makes sense. Asking the kernel whether a block is zero only helps
> > the performance if the result is yes occasionally, otherwise it's just
> > wasted work.
> >=20
> > Maybe we could try to guess the ratio by comparing the number of
> > allocated blocks in the image file and the virtual disk size or
> > something? Then we could only call lseek() when we can actually expect
> > an improvement from it.
>=20
> Sounds like "qemu should not contain policy" to me.  If the user expects
> the image to be fully allocated, they might as well use -S 0.

Optimising special cases isn't really what is meant when we're talking
about having policy in qemu. The result doesn't change, but the
performance does potentially. And as long as you access the whole image
like in qemu-img convert, qemu can make a pretty good estimation because
it knows both physical and virtual image sizes, so why bother the
management layer with it?

The thing that could be considered policy is the threshold where you
switch from one method to the other.

> >>> (2) For sparse raw images, this is absolutely devastating.  Reading t=
hem
> >>> now takes more than (ext4) or nearly (xfs) twice as much time as read=
ing
> >>> a fully allocated image.  So much for "if a filesystem driver has any
> >>> sense".
> >=20
> > Are you sure that only the filesystem is the problem? Checking for every
> > single byte of an image whether it is zero has to cost some performance.
>=20
> Well, yes, but "read data location from FS metadata" + "realize it's a
> hole" + memset() + "repe scasb" shouldn't take twice as much time as
> "read data location from FS metadata" + "read data from SSD".
>=20
> I expected the "realize it's a hole" part to fall out for free, so this
> would that memset() + repe scasb take much longer than reading data from
> the SSD -- and that's just pretty much impossible.

Not sure where you get the SSD part from. The scenarios you're comparing
are these:

1. Query holes with lseek() and then memset() in qemu's emulation of
   bdrv_co_pwrite_zeroes() for drivers that don't implement it. (Which
   is true for your null-co, but not representative for the real-world
   use cases with an actual file-posix protocol layer. Benchmarking with
   an extended null-co that has write_zero support would probably
   better.)

2. Uncondtionally call pread() and let the kernel do a memset(), at the
   cost of having to scan the buffer afterwards because qemu doesn't
   know yet that it contains zeros.

Neither case involves disk accesses if the filesystem metadata is
cached. You're comparing a memset+scan to just a memset (and the more
realistic case should be comparing memset+scan to nothing).

(BTW, buffer_is_zero() does complicated stuff, but 'repe scasb' isn't
among it.)

> > The fully allocated image doesn't suffer from this because (a) it only
> > has to check the first byte in each block and (b) the cost was already
> > there before this patch.
> >=20
> > In fact, if null-co supported .bdrv_co_pwrite_zeroes, I think you would
> > get even worse results for your patch because then the pre-patch version
> > doesn't even have to do the memset().
> >=20
> >>> (2a) It might be worth noting that on xfs, reading the sparse file to=
ok
> >>> longer even before this patch...
> >>>
> >>> (3) qcow2 is different: It benefits from this patch on tmpfs and xfs
> >>> (note that reading a sparse qcow2 file took longer than reading a full
> >>> qcow2 file before this patch!), but it gets pretty much destroyed on
> >>> ext4, too.
> >=20
> > I suppose an empty qcow2 with metadata preallocation behaves roughly
> > like sparse raw?
>=20
> Yep, more on that below.
>=20
> > As long as the qcow2 metadata reflects the allocation status in the
> > image file (which it probably usually does, except with preallocation),
> > it makes sense that qcow2 performs better with just relying on its
> > metadata. Calling an lseek() that just returns the same result is a
> > wasted effort then.
> >=20
> >>> (4) As for sparse vmdk images...  Reading them takes longer, but it's
> >>> still fasster than reading full vmdk images, so that's not horrible.
> >=20
> > Hm, why is that? Shouldn't vmdk metadata reflect the allocation status
> > in the image file just as well as qcow2 metadata?
> >=20
> > But actually, the absolute numbers are much lower than both raw and
> > qcow2, which is a bit surprising. Is there a bug somewhere in vmdk or
> > are we missing optimisations in raw and qcow2?
>=20
> I wondered about that, too.  Maybe something to look into another time...

A first thing to try would be a larger qcow2 cluster size. VMDK has 1 MB
clusters, if I remember correctly, so maybe it just covers larger ranges
with a single call.

Kevin

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaoBvRAAoJEH8JsnLIjy/WmxgQAMSbhNhw6B3GUrSAJmej4Wo1
meIKCt0/sXJ/Kj/5zPPOopD/ZxFlTvElY6gOY0S0gAGjwfR2z9B6G6KoYdy4KTWC
EaT3hXfqczGg1KGx3M5rlbshx2+jer3dpEr582fO6k3/tjWCF7XXy/ADkYu69Yc6
kAGrZTVGjFhTJ1iBcTda66LuITxviv56Uf/ZrAc0eiERfH+wW+DUnYJIIO/Nw2i4
5q+9PZS2NooSmBQd1xUIIJHMzpf/H2ixVXVb7DYoL4fq52Nf46UkFfRrR9laA0mW
dl/WMs9+eIZ+Re0wiobxQ1cysO/72/HywwfXS+2727U/9ppW5limrltHooMm/fOr
kyopERBizXZWlwNdSKFjmhHJVlYelZ3FDEOyNRPaF5d2IcNfTlkh7QbivebPNwv2
Bxo3J4RpciqfLkLzM+rwFlroBaN8LkQdPzZDAvQqc4l8jBHfy50W1ZWSojA01hYB
cXPMiIAgIwj3VRTP2Tf1IAtHHxFMNHVsuY/uIfGATTswnCBJmB6zsZFYaWrS3UgV
wivwGVZIBgru/RtMwh63EJXppdi0XK+IPM6M4chtOMT9O3reGDMigmhDw8eWXuya
kuYGhWo39oTS8jmNY1BzbuDQbM5gvfzF/2nvM9KEx+/TW0Ae9fTM4BdW4HZx3nCL
uf1gMb1m/M/JjVlRZnLP
=S6uo
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
