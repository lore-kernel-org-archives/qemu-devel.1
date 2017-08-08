Received: from eggs.gnu.org ([2001:4830:134:3::10]:46441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df4AK-0002fs-2a
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df4AF-00064y-66
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1df4AE-00064c-TL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:03:15 -0400
Date: Tue, 8 Aug 2017 15:03:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808130308.GJ4850@dhcp-200-186.str.redhat.com>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
	<CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
	<9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
	<20170808125337.GO16801@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20170808125337.GO16801@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Prasad Pandit <ppandit@redhat.com>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.08.2017 um 14:53 hat Stefan Hajnoczi geschrieben:
> On Fri, Aug 04, 2017 at 01:46:17PM +0200, Paolo Bonzini wrote:
> > On 04/08/2017 11:58, Stefan Hajnoczi wrote:
> > >> the root cause of this bug is related to this as well:
> > >> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.html
> > >>
> > >> From commit 99723548 we started assuming (incorrectly?) that blk_
> > >> functions always WILL have an attached BDS, but this is not always t=
rue,
> > >> for instance, flushing the cache from an empty CDROM.
> > >>
> > >> Paolo, can we move the flight counter increment outside of the
> > >> block-backend layer, is that safe?
> > > I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
> > > regardless of the throttling timer issue discussed below.  BB cannot
> > > assume that the BDS graph is non-empty.
> >=20
> > Can we make bdrv_aio_* return NULL (even temporarily) if there is no
> > attached BDS?  That would make it much easier to fix.
>=20
> There are many blk_aio_*() callers.  Returning NULL forces them to
> perform extra error handling.

Yes, that's my concern. We removed NULL returns a long time ago. Most
callers probably don't check for it any more.

> When you say "temporarily" do you mean it returns NULL but schedules a
> one-shot BH to invoke the callback?  I wonder if we can use a singleton
> aiocb instead of NULL for -ENOMEDIUM errors.

This doesn't help. As soon as you involve BHs, you need to consider them
during blk_drain(), otherwise the drain can return too early.

And if you want to consider them during blk_drain()... well, I made an
attempt, maybe we can make it work with some more changes. But I'm
starting to see that it's not a trivial change; though admittedly, the
NULL return thing doesn't look trivial either.

Kevin

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZibaMAAoJEH8JsnLIjy/WeckP/RhtCamQVeWrkLePX5d4jjKi
UiCaLNdhSbEfYWGqGSboiLGZoi1RO+bynBBsleGtDwQnTBNYgNIzA9xXCVNhOFl/
HpsMuR1m8rNT2Tgl0YMVVLjZXcRMfiBkdJXgiNt6Cw5PnzafHNaeKb2qg+3FS1k6
6SrQegqynV/m3/cpcXdCiWwdlS6J0j4dPTEKI9+J4hQgKLoRsrp4woAXEOxkRSHh
t4NSOvhyfuklbuW8jSZ44R2HEmpMHaemJqwnKvrhr7M5cCSEt3TUbC1odAmhuCQY
emNL/IOZikwSFrNqwvbz6HNXx1r6wcq0iJqqe6GYYmBnyWvSFR9HXU5f3Ztp3ho2
7JdqCm8JJqeWSF7NuABhQYN9C19RCW00Q6pBcPed3dBCimO+6TsgRSeCt5UmaDKr
4NOImoacDXsneQgoA1qL6Ic5OSPUXnA5L2O8mRDA50PMGBUQpRpcgsIgKkZl3WX/
CClbLkpUcqjJnB2lldPVJk6wo1+C+nMnja+PUj1usExo5/Nw6abRcHevwfHUfYPE
uQ0I0h9OnzG+HhDk4hRrffpFhcgURjU3Kg+UAxx0UWao7Z+QgJVuDL04dJlKbbL1
Q6q1BhF4nsm71Dr/ciZF61gKOZen+LfRMR95RvLWo1ilRXtD8ArGlsBTwA00YQXX
QGPwmq64NY+EGmdtsldN
=a6GZ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
