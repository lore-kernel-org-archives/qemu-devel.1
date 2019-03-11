Received: from eggs.gnu.org ([209.51.188.92]:42416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3R5C-0007Yr-U8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3R5B-0007EL-37
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:59:33 -0400
Date: Mon, 11 Mar 2019 20:59:25 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190311195925.GA21327@angien.pipo.sk>
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
	<2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/10] file-posix: Make auto-read-only
 dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 12:26:08 -0500, Eric Blake wrote:
> On 3/11/19 11:50 AM, Kevin Wolf wrote:
> > Until now, with auto-read-only=3Don we tried to open the file read-write
> > first and if that failed, read-only was tried. This is actually not good
> > enough for libvirt, which gives QEMU SELinux permissions for read-write
> > only as soon as it actually intends to write to the image. So we need to
> > be able to switch between read-only and read-write at runtime.
> >=20
> > This patch makes auto-read-only dynamic, i.e. the file is opened
> > read-only as long as no user of the node has requested write
> > permissions, but it is automatically reopened read-write as soon as the
> > first writer is attached. Conversely, if the last writer goes away, the
> > file is reopened read-only again.
> >=20
> > bs->read_only is no longer set for auto-read-only=3Don files even if the
> > file descriptor is opened read-only because it will be transparently
> > upgraded as soon as a writer is attached. This changes the output of
> > qemu-iotests 232.
>=20
> auto-read-only was introduced in 3.1, at which point we intentionally
> had sufficiently loose wording to permit (but not require) dynamic state
> checking; so you are not breaking the interface.  On the other hand, is
> libvirt going to have problems introspecting whether it can use
> auto-read-only and get the dynamic behavior it needs?  Or is there
> enough else in the way of libvirt's switch to -blockdev that it won't
> attempt anything that needs auto-read-only without other 4.0 interfaces
> anyway, at which point detecting the presence of the field (but not
> whether the field has a guarantee of dynamic behavior) on 3.1 doesn't
> matter?

I think we can use Stefan's capability detection mechanism he introduced
for the migration with cache enabled for local files to add a flag for
this as well.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyGvhoACgkQHGwCByjY
1GooUw//QvNCmmf8Q2thJvcxD/6tWsMcOHg2f/iNtK4qAW0DqXr4lfW5HuwQPHYG
YpNC61Ly+3mjxcFQ0OhHXxGUygOpzyvKg4uu5c3OCqi/pVCUwoMILjqkm+lLzSu0
I03LhGSyiZ0SpeHPuu74/NHjWiGsObtrnCyzHrLnvi0zowWLfJ6fuBwwcYIMJ40I
pDU/BvNm6UygxSOcwJh4bE29OJkcZs05vjIpGB0IjZ9QZOHfIT3X611QoCMQwBOr
CdtwMjmUTkAGs829pPO1MnXFDDSMYvrhWL6nigxw5MtXfcBbTFu8+wl2ebHXSR3V
Kvj/sqPizyCEwNYRbUUZzYvilVxvUjGX7IScptV9ZjBR4jlXwviaiP4eM8SVCXFd
UcMLzISGdcBzqdrgTa7F4nO2kJ8f9MPGg3V7mDz2XfOQPxfUki3oelsML4g86Kr2
Y+wmULiTzw9AuD1y+Ad2gCZy+Fw9W997fwo8Ys131OvaTd6NwVv+gXwVC9n020QB
OghzrwqQw/5BO3JXdYowm+8TX0H8IzMRosQxTgQlGCGy4iRH/KxSsOYPX3f1JkG6
kPjH7vp/Sq/IZ4GOvBfhLXO4r/jws542lCZzhviREyuegN/tJcJsr07sy622u9HQ
yu+ULbovmFJM09y4zXfVOMrr6CtlEc9tu98ENfGpUE4lw8VQK+s=
=ytGU
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
