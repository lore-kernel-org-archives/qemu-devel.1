Received: from eggs.gnu.org ([2001:4830:134:3::10]:48378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX2Gu-000630-Kk
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 04:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX2Gr-0007zF-J9
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 04:57:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eX2Gr-0007xR-9X
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 04:57:09 -0500
Date: Thu, 4 Jan 2018 09:57:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180104095700.GA10106@stefanha-x1.localdomain>
References: <20180103021456.22526-4-peterx@redhat.com>
	<20180103022418.23165-1-peterx@redhat.com>
	<20180103174152.GC21894@stefanha-x1.localdomain>
	<20180104023158.GQ2557@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180104023158.GQ2557@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v2.1 3/3] chardev: introduce
 qemu_chr_timeout_add() and use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 10:31:58AM +0800, Peter Xu wrote:
> On Wed, Jan 03, 2018 at 05:41:53PM +0000, Stefan Hajnoczi wrote:
> > On Wed, Jan 03, 2018 at 10:24:18AM +0800, Peter Xu wrote:
> > > It's a replacement of g_timeout_add[_seconds]() for chardevs.  Charde=
vs
> > > now can have dedicated gcontext, we should always bind chardev tasks
> > > onto those gcontext rather than the default main context.  Since there
> > > are quite a few of g_timeout_add[_seconds]() callers, a new function
> > > qemu_chr_timeout_add() is introduced.
> > >=20
> > > One thing to mention is that, terminal3270 is still always running on
> > > main gcontext.  However let's convert that as well since it's still p=
art
> > > of chardev codes and in case one day we'll miss that when we move it =
out
> > > of main gcontext too.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >=20
> > > v2 -> v2.1: Sorry I forgot to do the move in char.h.  Did it in this
> > > minor version.
> > >=20
> > >  chardev/char-pty.c     |  9 ++-------
> > >  chardev/char-socket.c  |  4 ++--
> > >  chardev/char.c         | 20 ++++++++++++++++++++
> > >  hw/char/terminal3270.c |  7 ++++---
> > >  include/chardev/char.h |  3 +++
> > >  5 files changed, 31 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > > index dd17b1b823..cbd8ac5eb7 100644
> > > --- a/chardev/char-pty.c
> > > +++ b/chardev/char-pty.c
> > > @@ -78,13 +78,8 @@ static void pty_chr_rearm_timer(Chardev *chr, int =
ms)
> > >          s->timer_tag =3D 0;
> > >      }
> > > =20
> > > -    if (ms =3D=3D 1000) {
> > > -        name =3D g_strdup_printf("pty-timer-secs-%s", chr->label);
> > > -        s->timer_tag =3D g_timeout_add_seconds(1, pty_chr_timer, chr=
);
> > > -    } else {
> > > -        name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
> > > -        s->timer_tag =3D g_timeout_add(ms, pty_chr_timer, chr);
> > > -    }
> > > +    name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
> > > +    s->timer_tag =3D qemu_chr_timeout_add(chr, ms, pty_chr_timer, ch=
r);
> >=20
> > The label is user-visible.  Why did you remove the seconds label format?
>=20
> It's used for g_source_set_name_by_id() below, and that's not
> user-visible AFAICT?
>=20
> I removed it because I thought it was not user visible and actually I
> didn't see a point on doing that.  Please let me know if I made a
> mistake.
>=20
> >=20
> > Please either include justification in the commit description or avoid
> > spurious changes like this so reviewers don't need to worry about code
> > changes that are not essential.
>=20
> Yes. I can add this into commit message after confirmed with you on above.

You are right, the GSource name isn't visible (it's only used for
debugging).  I was thinking of chr->label.

It's still helpful to mention that the ms =3D=3D 1000 special case is not
user-visible in the commit description.

Thanks,
Stefan

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTfpsAAoJEJykq7OBq3PIrEMH/jSbYaqTfKCX2jbpA5oHazNl
Z+at29O5df3zjmF7EjJ5DOkijDsdjU2c56G09aBGZsavTGb0zS2PnLgcmzv+5h7b
m4ztmEFbxvdlqG1G9kY7+zaIlWoKeBS/eRy89Dut7uS/sqjfPM0oFCqzepPDH6RJ
DlKqSjvxgKrGVT6X/IkG2Iy1zyS0Qi37t2bIwtAQLIRqpvewNaXIWBoULzK9q89G
qRHColgP4TbM5UZ+qUyHUjqcN3AlmR3ZkbL9XHN0qMXQNS2/gkIw1BGTpPxuGhjj
MaCzAoa9E9jcJfWR5gMPM4fZtcCdHVtGjMWGiZehdceUexUMpxT4/PcSepPzrn8=
=+ksH
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
