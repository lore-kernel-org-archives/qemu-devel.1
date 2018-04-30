Received: from eggs.gnu.org ([2001:4830:134:3::10]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fD4NL-0005CL-96
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fD4NK-0004Fn-Ba
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:41:35 -0400
Date: Mon, 30 Apr 2018 10:41:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180430084116.GA6488@localhost.localdomain>
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-4-mreitz@redhat.com>
	<5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
	<377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
	<ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
	<7632df03-6884-7533-f2b1-cdd8f293bea1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <7632df03-6884-7533-f2b1-cdd8f293bea1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.04.2018 um 13:19 hat Max Reitz geschrieben:
> On 2018-04-26 04:12, Eric Blake wrote:
> > On 04/25/2018 10:08 AM, Max Reitz wrote:
> >=20
> >>
> >>> Also, that does raise the question of whether you have more work to
> >>> support write-zero requests with WRITE_UNCHANGED (which indeed sounds
> >>> like something plausible to support).
> >>
> >> I'm afraid I don't quite understand the question.
> >> BDRV_REQ_WRITE_UNCHANGED support is usually rather simple because as
> >> said above it is only needed by drivers that rely on their parent to
> >> request the permissions, i.e. filter drivers.  Since filter drivers ju=
st
> >> forward the requests, all they have to do is retain the
> >> BDRV_REQ_WRITE_UNCHANGED flag, be it a zero write or a normal write.
> >=20
> > I'm trying to figure out if BDRV_REQ_WRITE_UNCHANGED makes sense for
> > bdrv_co_pwrite_zeroes as well as bdrv_co_pwrite. I think the answer is
> > yes (if we know the guest already reads zeroes, but need to write to the
> > protocol layer anyways because of a commit operation, then mixing both
> > BDRV_REQ_WRITE_UNCHANGED and BDRV_REQ_ZERO_WRITE to the block layer
> > makes sense, and supported_zero_flags should indeed pass
> > BDRV_REQ_WRITE_UNCHANGED on to a driver.
>=20
> Well, why not.
>=20
> >> It would be more complicated for format drivers, because they would ha=
ve
> >> to verify that the incoming unchanged write actually ends up as an
> >> unchanged write in their file.  But we have already recognized that th=
at
> >> would be too much to ask and that format drivers may want to generally
> >> just write anything to their child if it's writable (even regardless of
> >> whether the grandparent issues writes to the format driver node), so
> >> they always grab a WRITE permission on their file if possible.
> >> Therefore, they do not have to support this request flag.
> >=20
> > So qcow2 doesn't have to support the flag, but file-posix.c might want
> > to.  Or are you saying that only filter drivers need to advertise
> > support for the flag?
>=20
> It might make sense for file-posix, but when you think further, it
> wouldn't do anything in practice.
>=20
> First, if a protocol driver receives WRITE_UNCHANGED, there are two
> things it can do: If it knows that it only has very plain storage, it
> can just ignore the request because it won't do anything.

I think even a WRITE_UNCHANGED request is supposed to allocate a
currently unmappen block, so "very plain storage" probably has to mean
at least "supports neither backing files nor thin provisioning". Or you
would have to check the current allocation status first...

But I don't see a reason anyway why a WRITE_UNCHANGED request should end
up in the protocol layer.

Kevin

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa5tasAAoJEH8JsnLIjy/WrOMQAKo00KK8biUSbZOXH2QrQ9dC
2lQYjVU6ykpV50KhFr3p4W4VQ7Pr493eP3HVQjWxZycnYLgeXXv64ODqSmIBbcqH
PP8PUuVun2ZiOUn3LcdZbMbT0xpE/mATROX6Lnpw5tS4S87yoke1d5RST/5DDUhf
Q5MjdA51fqnbtn4zAxhCK6Bvs9swHM3H4y7pgPvP9K04QDbbDbRdViuacV1SD7oJ
1xbV7STQkvJ0B4+l7ixDoKo5LtRrE2Fr134QhpjLW4LfxohcilmNc9J7RvD47nI8
8Vk3y94v7GAyATS1OdlUPsha6ZkGgPpIncQVpL2PKpSmKLcv5uPr1dXtsUvusQHs
MY3D/fhaZaNb7JESkeCiy8qGl5K7L0JcfxaUR+08YNvlxOk7ZTtOouIVyLMrJHIt
uQznbl9Hr3Vea87bIuT7pejlU+ktLh+X/h58DK4eOLMdoHDoTf6eE8a8s/u9Fly4
hrFdLQ+Zk6BbsdHUkqwQrMoRTMPDEfYnLiO408d3P1wAWqDQxQbErRMo0sjGENip
HsCOk0Diu72WDvR7ExWFjfu188K6rodTA6RmpuF7+b2K9DcoAmLnrhfKgnxOXPQg
xsnlooBxJDGsIui2sULacS7GFgvH0NBYvNG3zLJxVl9n+iGSQvWJd3yOR3iNlztf
TuUNKT9fkmJi6a3A2Qyi
=N6Em
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
