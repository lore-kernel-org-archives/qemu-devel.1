Received: from eggs.gnu.org ([2001:4830:134:3::10]:40732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePq11-0003lO-4W
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePq0x-00082U-5d
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:27:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePq0w-00082A-Uq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:26:59 -0500
Date: Fri, 15 Dec 2017 13:26:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215132642.GH26982@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-13-peterx@redhat.com>
	<20171213171934.GC8317@stefanha-x1.localdomain>
	<20171215094010.GB15187@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
In-Reply-To: <20171215094010.GB15187@lemon>
Subject: Re: [Qemu-devel] [RFC v5 12/26] qmp: negociate QMP capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 05:40:10PM +0800, Fam Zheng wrote:
> On Wed, 12/13 17:19, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:51:46PM +0800, Peter Xu wrote:
> > > @@ -1037,8 +1038,42 @@ static void monitor_init_qmp_commands(void)
> > >                           qmp_marshal_qmp_capabilities, QCO_NO_OPTION=
S);
> > >  }
> > > =20
> > > -void qmp_qmp_capabilities(Error **errp)
> > > +static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
> > > +                           Error **errp)
> > > +{
> > > +    for (; list; list =3D list->next) {
> > > +        assert(list->value < QMP_CAPABILITY__MAX);
> > > +        switch (list->value) {
> > > +        case QMP_CAPABILITY_OOB:
> > > +            if (!mon->use_io_thr) {
> > > +                /*
> > > +                 * Out-Of-Band only works with monitors that are
> > > +                 * running on dedicated IOThread.
> > > +                 */
> > > +                error_setg(errp, "This monitor does not support "
> > > +                           "Out-Of-Band (OOB)");
> > > +                return;
> > > +            }
> > > +            break;
> >=20
> > QEMU always offers the 'oob' capability, even if the monitor does not
> > support it.  Should it send 'oob' only when mon->use_io_thr to make
> > things easier for clients?
>=20
> So should we firstly agree on whether the capabilities is on the current =
monitor
> connection or QEMU as a whole?

It's more flexible to allow per-connection capabilities.  Is there a
reason against it?

Stefan

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM82SAAoJEJykq7OBq3PI6EMIAKOZtbdYmxFkuV/EubJtZJnq
Tq0NHJKmRJLpgcMLoAmtQtOLmKqdKmW1oQTDnfZSp04d/TL4ojjk45DbuaOxT7Yt
TMUZ4BQynGvrekK20orGMHeb7YO78ftC2sK+nXYGOfiCNCSrtK4svyVoQOgjJ/IW
yMHZaZ7CEFK1NOkAK5Y3D4Pkpp5mCL+hxjckKVal64RjCpWXo8ysQsbewJ2y0qPE
LM5S5l44O0PY88AGj2ieYpUsjVjE5aw9lDaUnXpDw5RBrON0iGeB3dIA25+x68lX
URydkQQOtzIW1PT4vFgNNUe81rn3WBmQclzs0LDzqd13Gh1VzvS2aQzaiUfBNPQ=
=c3Ki
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
