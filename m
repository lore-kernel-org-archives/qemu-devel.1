Received: from eggs.gnu.org ([2001:4830:134:3::10]:56880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea08a-0004io-I8
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea08X-0006q0-Sv
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:16:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ea08X-0006o8-JZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:16:49 -0500
Date: Fri, 12 Jan 2018 14:16:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112141636.GA11423@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-23-peterx@redhat.com>
	<20180109142435.GG31400@stefanha-x1.localdomain>
	<20180112064455.GN2551@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20180112064455.GN2551@xz-mi>
Subject: Re: [Qemu-devel] [RFC v6 22/27] qmp: isolate responses into io
 thread
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


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 02:44:55PM +0800, Peter Xu wrote:
> On Tue, Jan 09, 2018 at 02:24:35PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 19, 2017 at 04:45:52PM +0800, Peter Xu wrote:
> > > +static void monitor_qmp_bh_responder(void *opaque)
> > > +{
> > > +    QMPResponse response;
> > > +
> > > +    while (true) {
> > > +        response =3D monitor_qmp_response_pop_one();
> > > +        if (!response.data) {
> > > +            break;
> > > +        }
> > > +        monitor_json_emitter_raw(response.mon, response.data);
> >=20
> > Have you audited all mon->out_lock users to ensure that guest memory is
> > never touched while the lock is held?
> >=20
> > If guest memory is touched then the main loop could be blocked due to
> > postcopy and when the IOThread executes monitor_qmp_bh_responder() ->
> > monitor_json_emitter_raw() -> monitor_puts() it will also hang!
>=20
> Yes, I am mostly certain that it never touches guest memory.  IMHO
> it's a pure lock for monitor's output buffer since day one of its
> occurence in 6cff3e8594c.
>=20
> An extreme case I can think of is when someone wants to dump some data
> from guest memory in QMP (I suspect who will use it though...).  In
> that case we will still be safe, since the guest memory access should
> be happening in g_strdup_vprintf() rather than monitor_puts(), so even
> if it happens we will hang at g_strdup_vprintf() without the lock taken.
>=20
> >=20
> > Please add a comment above the out_lock declaration letting users know
> > that they must not touch guest memory while holding the lock.
>=20
> I'm not sure whether adding a comment like this for the lock would be
> a bit strange, but I agree it should be better than nothing.  Thanks,

This is a case where out-of-band code depends on a mutex that non-OOB
code is used.  According to the documentation added in this patch series
all critical sections must also follow the OOB code rules.

Adding this comment informs people working with the code to follow OOB
code rules.  It certainly is safer than leaving this assumption
undocumented.

Stefan

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWMNEAAoJEJykq7OBq3PIZisIAL6C9TVoUiv4KSRROLqfPT3K
stvu/QsLURr+QotkNYcG7jiMasn/iAFXnQNrJ9/pAZ6xDf5002d2+r1wairqzbSj
jPsas/6X+2RfC6ZrhZCg20Pq9LEk05GlxhcaJM0l6BA0Z2QOQ8UA6hcx/+va9Aex
NlFXaeQR3hiuRl3+BDmuF0xHfb7UkkDmzrsqTQDAikdzWNU2wFFzGYLiLEUYNdf8
hrYFy9RbNFTQBB+P2Y5R+joJvTlPhdAQcjJbNRdEycSQ5Cuf5wc0rZf+Nke6nTXE
uzMLCYzgolxEgSTKqZNBwxKOdXQJ81JS5dMIIuZ/rnRvQxmenBa4rIcD8KB/ZBo=
=wjdm
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
