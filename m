Received: from eggs.gnu.org ([2001:4830:134:3::10]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dGp4J-0002GZ-GY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dGp4I-0003HH-J5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:04:55 -0400
Date: Fri, 2 Jun 2017 17:04:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170602160444.GB11626@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-11-git-send-email-kwolf@redhat.com>
	<20170531123259.GK16733@stefanha-x1.localdomain>
	<20170601155953.GG4987@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20170601155953.GG4987@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 05:59:53PM +0200, Kevin Wolf wrote:
> Am 31.05.2017 um 14:32 hat Stefan Hajnoczi geschrieben:
> > On Fri, May 26, 2017 at 10:21:51PM +0200, Kevin Wolf wrote:
> > >  static void qed_clear_need_check(void *opaque, int ret)
> > >  {
> > >      BDRVQEDState *s =3D opaque;
> > > =20
> > >      if (ret) {
> > > -        qed_unplug_allocating_write_reqs(s);
> > > -        return;
> > > +        goto out;
> > >      }
> > > =20
> > >      s->header.features &=3D ~QED_F_NEED_CHECK;
> > > -    qed_write_header(s, qed_flush_after_clear_need_check, s);
> > > +    ret =3D qed_write_header(s);
> > > +    (void) ret;
> > > +
> > > +    ret =3D bdrv_flush(s->bs);
> > > +    (void) ret;
> > > +
> > > +out:
> > > +    qed_unplug_allocating_write_reqs(s);
> > >  }
> >=20
> > Should we unplug allocating write reqs before flushing?  The async code
> > kicks off a flush but doesn't wait for it to complete.
>=20
> You're right that moving it up would match the old code. Not sure if it
> would make much of a difference, though, isn't the request queue drained
> in the kernel anyway while doing a flush? But if you prefer, I can
> change it.

I prefer keeping the behavior of the existing code where possible.

Stefan

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZMYycAAoJEJykq7OBq3PIb1cIAIBa5/L4hYdQ7iQtKOQ9IwN6
RbBdxudEaDQGq6DH6gG0gLjZwlywA/1Zj5d+JSwKfLVIDcK61Nq7CFT+SWl6D6Zh
7grVzNTE6A3QFHDF3ZRlbuK5QZgZKXxSwUZyYH6w9JEkp5gTabz7Zo/KVmoHXPu5
YT5TfzGiYyKk5tJqI5fVJOa4+7VhJeQy/1QgwihapVa37adKZekuXUtBzWX0IPAL
2UJsDyMqVWUXPvb3H2b4UIOIi3du0Qyeg32rt3iVijKJkiJUK6Q692z6iPrqDXv8
CfVAqCZvoJmerPeLoZpo40BPPnUr4YEJ8JalT56sNzRn0fNImJOX5NXpC/y3GzQ=
=bQXl
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
