Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dGp35-0001Cr-5x
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dGp34-0002R8-BQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:39 -0400
Date: Fri, 2 Jun 2017 17:03:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170602160327.GA11626@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-11-git-send-email-kwolf@redhat.com>
	<20170531123259.GK16733@stefanha-x1.localdomain>
	<20170601155953.GG4987@noname.redhat.com>
	<ce3f84f1-d294-009f-a72d-8776416599c0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <ce3f84f1-d294-009f-a72d-8776416599c0@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/29] qed: Remove callback
 from qed_write_header()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 06:04:25PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 01/06/2017 17:59, Kevin Wolf wrote:
> > Am 31.05.2017 um 14:32 hat Stefan Hajnoczi geschrieben:
> >> On Fri, May 26, 2017 at 10:21:51PM +0200, Kevin Wolf wrote:
> >>>  static void qed_clear_need_check(void *opaque, int ret)
> >>>  {
> >>>      BDRVQEDState *s =3D opaque;
> >>> =20
> >>>      if (ret) {
> >>> -        qed_unplug_allocating_write_reqs(s);
> >>> -        return;
> >>> +        goto out;
> >>>      }
> >>> =20
> >>>      s->header.features &=3D ~QED_F_NEED_CHECK;
> >>> -    qed_write_header(s, qed_flush_after_clear_need_check, s);
> >>> +    ret =3D qed_write_header(s);
> >>> +    (void) ret;
> >>> +
> >>> +    ret =3D bdrv_flush(s->bs);
> >>> +    (void) ret;
> >>> +
> >>> +out:
> >>> +    qed_unplug_allocating_write_reqs(s);
> >>>  }
> >>
> >> Should we unplug allocating write reqs before flushing?  The async code
> >> kicks off a flush but doesn't wait for it to complete.
> >=20
> > You're right that moving it up would match the old code. Not sure if it
> > would make much of a difference, though, isn't the request queue drained
> > in the kernel anyway while doing a flush?
>=20
> No, it isn't AFAIK.

I was also under the impression that applications must call fsync()
only after their write() calls have completed.

Stefan

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZMYxPAAoJEJykq7OBq3PIUWsH/iuYFHN8WIUSczI6UkX6qR54
HMfr4s2ALBFzds/RdgXXawrnRERatgUKZs0xiRbltTcOR/mwA7eHoKVXgtmPrxWu
li3LH0uv3/ir56JEbmo1CSORmXkz8wMy+IWqcoxO8cji9fWU1vfvyS8gS6kRHO3K
XnKnyXt7fJMOwlVBRuACNyNG4kJfuhQy1jsxsMAP8DvItVHZoeMzRuxHaWvG7d/Q
qPhUMmKTjtBaktVKN1Kg6/d4RGCX3ACmS7Ox4lQjuE8EY05xWW3+3dgAUa+GoHjF
E2idHpT/rkAR/9tJK1+J/yefDB3e02sVjCrzQZmjYMGCAWVHSIR2h6NXtly6Mpw=
=CQ/F
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
