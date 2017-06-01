Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGSWG-0004jr-HO
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGSWB-00068i-N0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:00:16 -0400
Date: Thu, 1 Jun 2017 17:59:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170601155953.GG4987@noname.redhat.com>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-11-git-send-email-kwolf@redhat.com>
	<20170531123259.GK16733@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20170531123259.GK16733@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.05.2017 um 14:32 hat Stefan Hajnoczi geschrieben:
> On Fri, May 26, 2017 at 10:21:51PM +0200, Kevin Wolf wrote:
> >  static void qed_clear_need_check(void *opaque, int ret)
> >  {
> >      BDRVQEDState *s =3D opaque;
> > =20
> >      if (ret) {
> > -        qed_unplug_allocating_write_reqs(s);
> > -        return;
> > +        goto out;
> >      }
> > =20
> >      s->header.features &=3D ~QED_F_NEED_CHECK;
> > -    qed_write_header(s, qed_flush_after_clear_need_check, s);
> > +    ret =3D qed_write_header(s);
> > +    (void) ret;
> > +
> > +    ret =3D bdrv_flush(s->bs);
> > +    (void) ret;
> > +
> > +out:
> > +    qed_unplug_allocating_write_reqs(s);
> >  }
>=20
> Should we unplug allocating write reqs before flushing?  The async code
> kicks off a flush but doesn't wait for it to complete.

You're right that moving it up would match the old code. Not sure if it
would make much of a difference, though, isn't the request queue drained
in the kernel anyway while doing a flush? But if you prefer, I can
change it.

Kevin

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZMDn5AAoJEH8JsnLIjy/W1YUP/A6E8qnev4Y0rjqOa1QwCTsf
AW/Vh1pa3DHA/CcP9gdVbpOVCxAalxQ1pq52aANoVQzs15ELTXhYagM8oijevIjz
VMCxZVy2CjjkKAaBULKVgcood9FRNvFMrV2tkWjKU8mLHQBMa0KAGeI1ddkYNsfS
mWuAGUozcwhpl2QOl37Nh3hNCIDWt4EqHvou5LutwjqNIxmz/lYC5kndqlE7pahd
9IwGX+XUagDrZOpORD6GXq+PycEoR2UUBRwMVHM7HSzzR4BTeGB7SMpAiEF/p74Y
qyDAg/QjX0bMdojL2pK8Ok4L0KkA9Pq2cH72R2UyZE0dwB0V22fdXJVklRJzQz/O
9pr+oxWsL8HIICmd0SfF+GXjF4zBY+HZqqagfybzGd95hXMt2ZENYIBkbO1X1/7r
DvinlC7mbW1MhxpNBCQg1+Z0wWooa/tXjmDmraAZq0KNKRK/aJTqnBf7pd+sSLfA
DPhuRHBrhNWiRqv/JOQmXvUd6sIeuolt4acklyxiDCqgxFDNtq51H69C5rYbYm1D
pl+8CpWsKqVl05evyzySsIc7Y/PgxBZ3I9ePtZuUxWlDMesX7mFa2DtVRG7+qB4h
640zL6CmdPGUjnipEkzKSO+R5yoCTxEw7QpE2cK/m6mFF/Fs4yE99o4r6f0SDJUI
mNr9yf8ehpOtvWXp9PuY
=owa+
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
