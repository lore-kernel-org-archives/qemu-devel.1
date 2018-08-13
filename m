Received: from eggs.gnu.org ([2001:4830:134:3::10]:34338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFFL-0006aD-7J
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFFK-0003rL-CM
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:59:07 -0400
Date: Mon, 13 Aug 2018 17:58:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813155856.GL4323@localhost.localdomain>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<20180813112333.GD4323@localhost.localdomain>
	<e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.08.2018 um 17:11 hat Max Reitz geschrieben:
> >> My personal opinion is this: Most users should be fine with 8 GB of
> >> randomly accessible image space (this may be wrong).  Whenever a user
> >> does have an application that uses more than 8 GB, they are probably in
> >> an area where they want to do some performance tuning anyway.  Requiri=
ng
> >> them to set l2-cache-full in that case seems reasonable to me.
> >=20
> > In principle, I'd agree. I'd even say that management tools should
> > always explicitly set those options instead of relying on our defaults.
> > But management tools have been ignoring these options for a long time
> > and keep doing so.
> >=20
> > And honestly, if you can't spend a few megabytes for the caches, it's
> > just as reasonable that you should set l2-cache to a lower value. You'll
> > need some more tweaking anyway to reduce the memory footprint.
>=20
> It isn't, because as I explained above, it is more reasonable to expect
> people to find out about disk options because their disk performance is
> abysmal than because their RAM is exhausted.
>=20
> I would like to say "but it is nearly as reasonable", but I really don't
> think so.

Maybe in a perfect world, finding the option when their disk performance
is abysmal is what users would do. In this world, they either just use
raw and scream for backing files and dirty bitmaps and whatnot for raw,
or they just directly go to some other hypervisor.

Realistically, the cache options don't exist. They are hard to discover
in the QEMU command line and management tools don't support them.

Conclusion: We're doomed to find a one-size-fits-all default that works
well in all common use cases, including benchmarks. We can try and make
it adapt to the situation, but we can't reasonably expect users to
manually override it.

> >                                                         Our choice of a
> > default should reflect that, especially considering that we only use
> > the memory on demand. If your image is only 32 GB, you'll never use more
> > than 4 MB of cache.
>=20
> Well, OK, yes.  This is an especially important point when it really is
> about hosts that have limited memory.  In those cases, users probably
> won't run huge images anyway.
>=20
> >                     And if your image is huge, but only access part of
> > it, we also won't use the full 32 MB.
>=20
> On Linux. O:-)

No, on any system where qemu_try_blockalign() results in a COW zero
page.

The Linux-only addition is returning memory even after an access.

> So it's good that you have calmed my nerves about how this might be
> problematic on Linux systems (it isn't in practice, although I disagree
> that people will find qcow2 to be the fault when their memory runs out),
> but you haven't said anything about non-Linux systems.  I understand
> that you don't care, but as I said here, this was my only substantial
> concern anyway.

I don't actually think it's so bad to keep the cache permanently
allocated, but I wouldn't object to a lower default for non-Linux hosts
either. 1 MB may still be a little too low, 4 MB (covers up to 32 GB)
might be more adequate. My typical desktop VMs are larger than 8 GB, but
smaller than 32 GB.

Kevin

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbcarAAAoJEH8JsnLIjy/W+OkQAKsrfV44ag/bUUegQLzowWFj
HmCvGURLew79yiTAv7rldxxoEU3x+O4t0lv/o3bJOSrqrApNCfdmBV+kBb1teaJM
yfysIJ/nWl3h7ddpi0Ec8f+V0DwPqLtbLQKQrLk5vjIVIaDQMTpLeG7im9nvxY33
QCF4RW6xrQPqH7AObLmv3Y/3+hpYfLHcgIl1jch8Pu6H7ADK3r8cUjyWUjISIECs
TMJLMcIsp6jOEP4/bZsVWkDTzveQP9OieKkOEdaKhpYHuqNMtNaydoWhLofbPLYq
xZrKv9cgJfVaIOhiCh/XzFIbEEHAer8TLeoAQGibwT5eOsjJb2SpddQErZGcpft5
/de5YfpS8qMxnM85WSHM3H6kQFzHGUiKp4tWP404rt00VrnScN/fKowc8NhAQdLB
CmqK6UlF0p3V6Xa44ciLMKg0JzmFaqxKLpgVySQd/apMoYlBXiH38MBQXMKKyo9X
aZvaMR8ArZ1Li1YrCnLc+3d6pt1mg0xLGbMJHFtIlwfI1K47AkzEsGHbz0COVnAa
QNDNdYiBqhJt5IywHmFT3wZfU13Z7UlIPSJhpiP5mGfHTS8s/IyqtZLiz6ANAoIL
rBq5h+IeLUuBziLboHif3V623IKseMgI4usVgGFtyoMCDHtqv4kHMh4ZbZeMY1ID
moGf4GDj9aCklvcxGn74
=O44Y
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
