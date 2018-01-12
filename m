Received: from eggs.gnu.org ([2001:4830:134:3::10]:60781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0Kr-0004co-9L
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0Ko-0001U9-5h
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:29:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ea0Kn-0001TP-SC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:29:30 -0500
Date: Fri, 12 Jan 2018 14:28:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112142832.GE11423@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-16-peterx@redhat.com>
	<20171221112738.GL10812@lemon> <20171225032613.GD2443@xz-mi>
	<20180108164936.GG11758@stefanha-x1.localdomain>
	<20180112045149.GH2551@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20180112045149.GH2551@xz-mi>
Subject: Re: [Qemu-devel] [RFC v6 15/27] monitor: let suspend/resume work
 even with QMPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 12:51:49PM +0800, Peter Xu wrote:
> On Mon, Jan 08, 2018 at 04:49:36PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Dec 25, 2017 at 11:26:13AM +0800, Peter Xu wrote:
> > > On Thu, Dec 21, 2017 at 07:27:38PM +0800, Fam Zheng wrote:
> > > > On Tue, 12/19 16:45, Peter Xu wrote:
> > > > > One thing to mention is that for QMPs that are using IOThreads, w=
e need
> > > > > an explicit kick for the IOThread in case it is sleeping.
> > > > >=20
> > > > > Since at it, add traces for the operations.
> > > > >=20
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  monitor.c    | 26 +++++++++++++++++++++-----
> > > > >  trace-events |  1 +
> > > > >  2 files changed, 22 insertions(+), 5 deletions(-)
> > > > >=20
> > > > > diff --git a/monitor.c b/monitor.c
> > > > > index 844508d134..5f05f2e9da 100644
> > > > > --- a/monitor.c
> > > > > +++ b/monitor.c
> > > > > @@ -3992,19 +3992,35 @@ static void monitor_command_cb(void *opaq=
ue, const char *cmdline,
> > > > > =20
> > > > >  int monitor_suspend(Monitor *mon)
> > > > >  {
> > > > > -    if (!mon->rs)
> > > > > -        return -ENOTTY;
> > > >=20
> > > > Please add to the commit message why the mon->rs check is dropped, =
for this and
> > > > the other one.
> > >=20
> > > I thought it would be clear enough since mon->rs is only used by HMP
> > > and the subject tells us that this patch is adding support for QMP.
> > > But... sure I can add one more sentence for that!
> >=20
> > This change breaks hmp.c:hmp_migrate():
> >=20
> >   if (monitor_suspend(mon) < 0) {
> >       monitor_printf(mon, "terminal does not allow synchronous "
> >                      "migration, continuing detached\n");
> >       return;
> >   }
> >=20
> > mon->rs is used by HMP code to determine whether this is an interactive
> > terminal.  Both live migration and password prompting rely on this
> > because they must be forbidden when doing so would be impossible (e.g.
> > GDB stub tunneling HMP commands).
> >=20
> > Suspending the QMP monitor is useful, but please don't break the HMP
> > code.
>=20
> Could you elaborate a bit on how this patch breaks anything?
>=20
> IMHO HMP monitors always have Monitor.rs setup, so here in
> hmp_migrate() I don't really understand why we need this check, since
> IIUC monitor_suspend() for a HMP monitor will never fail before.

No, HMP monitors do not always have ->rs.  I mentioned that the GDB stub
uses a non-interactive HMP monitor.

Here is the code from gdbstub.c:

  /* Initialize a monitor terminal for gdb */
  mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                             NULL, &error_abort);
  monitor_init(mon_chr, 0);

flags=3D0 means !MONITOR_USE_CONTROL (HMP) and !MONITOR_USE_READLINE
(non-interactive).

Your patch breaks this feature.

Stefan

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWMYQAAoJEJykq7OBq3PIQaIH/RTjeU58bq+0z2nOO/GzzHQa
WO4bokE/XukiKsZHa8KTUtcV49ddyvhqm2ulLp/oGMQykjJfv1q8R66lO4qALTZ+
STEyW/eGVN/S+Q5aC4P44gwWvNGYxhls1ytSnXOwD8op+Pagh+KnZ59c5gqMw0y9
Hh4FaD0mwT96zr9yL9JR9Ken/4zWjKlccGA7O7SAOWSVKRta8YRIWOGrpwUfqG1F
CysMb5tro0jOEr/BBEYDcxa4oCE4ipBGGQtSPwNYnagtweekcxEvlst9QITZoP5N
a0indtQ2SJ3JhFw093IR2R1XpIjcdO7JEaZ0O7AypZXJDO+bdJjo53TmmeU62ho=
=DmSg
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
