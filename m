Received: from eggs.gnu.org ([2001:4830:134:3::10]:38793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpw6-0008RH-1c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpw2-0005BK-0p
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:21:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePpw1-0005Am-NG
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:21:53 -0500
Date: Fri, 15 Dec 2017 13:21:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215132142.GG26982@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-10-peterx@redhat.com>
	<20171213162022.GJ7173@stefanha-x1.localdomain>
	<20171215083108.GO7780@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
In-Reply-To: <20171215083108.GO7780@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 09/26] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 04:31:08PM +0800, Peter Xu wrote:
> On Wed, Dec 13, 2017 at 04:20:22PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:51:43PM +0800, Peter Xu wrote:
> > > @@ -208,6 +209,12 @@ struct Monitor {
> > >      QTAILQ_ENTRY(Monitor) entry;
> > >  };
> > > =20
> > > +struct MonitorGlobal {
> > > +    IOThread *mon_iothread;
> > > +};
> > > +
> > > +static struct MonitorGlobal mon_global;
> >=20
> > structs can be anonymous.  That avoids the QEMU coding style violation
> > (structs must be typedefed):
> >=20
> >   static struct {
> >       IOThread *mon_iothread;
> >   } mon_global;
>=20
> Will fix this up.  Thanks.
>=20
> >=20
> > In general global variables are usually top-level variables in QEMU.
> > I'm not sure why wrapping globals in a struct is useful.
>=20
> Because I see too many global variables for monitor code, and from
> this patch I wanted to start moving them altogether into this global
> struct.  I didn't really do that in current series because it's more
> like a clean up, but if you see future patches,

You cannot expect reviewers to jump around a 26 patch series to check
for possible future changes.  Each patch must be self-contained and the
changes need to be justified.

> I can add a comment in the commit message, like: "Let's start to
> create a struct to keep monitor global variables together".  Would
> that help?

It's better to add a comment in the code:

/* Add monitor global variables to this struct */

so that other people modifying the code know what this is about and can
participate.

Other people might not want to do it since it leads to repetitive and
long names like mon_global.mon_iothread.  Or they might just not see the
struct when defining a global.

The chance of the struct being used consistently is low and therefore I
wouldn't do it.

> >=20
> > > @@ -4117,6 +4136,16 @@ void monitor_cleanup(void)
> > >  {
> > >      Monitor *mon, *next;
> > > =20
> > > +    /*
> > > +     * We need to explicitly stop the iothread (but not destroy it),
> > > +     * cleanup the monitor resources, then destroy the iothread.  See
> > > +     * again on the glib bug mentioned in 2b316774f6 for a reason.
> > > +     *
> > > +     * TODO: the bug is fixed in glib 2.28, so we can remove this ha=
ck
> > > +     * as long as we won't support glib versions older than it.
> > > +     */
> >=20
> > I find this comment confusing.  There is no GSource .finalize() in
> > monitor.c so why does monitor_cleanup() need to work around the bug?
> >=20
> > I see that monitor_data_destroy() is not thread-safe so the IOThread
> > must be stopped first.  That is unrelated to glib.
>=20
> Yeah actually that's a suggestion by Dave and Dan in previous review
> comments which makes sense to me:
>=20
>   http://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04344.html
>=20
> I'm fine with either way: keep it as it is,

The meaning of the comment is unclear to me and you haven't been able to
explain it.  Therefore, merging this comment isn't justified.

> or instead saying
> "monitor_data_destroy() is not thread-safe" (which finally will still
> root cause to that glib bug).

This is incorrect.  The problem is that the IOThread may run chardev
handler functions while the main loop thread invokes
monitor_data_destroy().  There is nothing protecting the chardev itself
(it's not thread-safe!) nor the monitor state that is being freed, so a
running chardev handler function could crash.

This means that even without the glib bug, it's not safe to call
monitor_data_destroy() while the chardev is still attached to the
IOThread event loop.

> But how about we just keep it in case
> it may be helpful some day?

Please see above.

Stefan

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM8xmAAoJEJykq7OBq3PIGNAH/RY5Xy1Uli6nX2Wq7d6a4fkf
J5v+DxOI0CRpMMyGkB/43bPGovn8ihpDMkRFjbBxxZWTmR+rzenkfkUrNZp0OiVz
CJyLsAtnwyBmQxuf3PtArmkus2AOjlYsKKNt5/VU6TycWHwgE4QHLilleTK7oZoY
KotJLo+lTfi3Nx2pmKEsKUqESkWjIlQYQ1htYMjIQ39XI4sADx9FiVYgA0gNutoB
8bNIoCNEXIk+QV534RmiD91ZvfeBzG1jqlCRLAhqrHxuR8aRBqRWwaI2oeHLDogw
kSoPQ2mTvKVOZOu9ozW8WtnSSMH8w+LYV8OfCyWcgGTPQ+kJgKRc32AJ46ZeIIk=
=EoG2
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--
