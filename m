Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpMw-00068b-4y
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpMs-00023i-TY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePpMs-000221-Kq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:45:34 -0500
Date: Fri, 15 Dec 2017 12:45:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215124524.GE26982@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-6-peterx@redhat.com>
	<20171213153702.GF7173@stefanha-x1.localdomain>
	<20171215075505.GK7780@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <20171215075505.GK7780@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 05/26] qjson: add "opaque" field to
 JSONMessageParser
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


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 03:55:06PM +0800, Peter Xu wrote:
> On Wed, Dec 13, 2017 at 03:37:02PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:51:39PM +0800, Peter Xu wrote:
> > > diff --git a/qga/main.c b/qga/main.c
> > > index 62a62755bd..3b5ebbc1ee 100644
> > > --- a/qga/main.c
> > > +++ b/qga/main.c
> > > @@ -593,7 +593,8 @@ static void process_command(GAState *s, QDict *re=
q)
> > >  }
> > > =20
> > >  /* handle requests/control events coming in over the channel */
> > > -static void process_event(JSONMessageParser *parser, GQueue *tokens)
> > > +static void process_event(JSONMessageParser *parser, GQueue *tokens,
> > > +                          void *opaque)
> > >  {
> > >      GAState *s =3D container_of(parser, GAState, parser);
> > >      QDict *qdict;
> > > @@ -1320,7 +1321,7 @@ static int run_agent(GAState *s, GAConfig *conf=
ig, int socket_activation)
> > >      s->command_state =3D ga_command_state_new();
> > >      ga_command_state_init(s, s->command_state);
> > >      ga_command_state_init_all(s->command_state);
> > > -    json_message_parser_init(&s->parser, process_event);
> > > +    json_message_parser_init(&s->parser, process_event, NULL);
> >=20
> > This patch leaves the code with 2 ways of getting at state from the
> > parser pointer:
> > 1. Use container_of() like existing users.
> > 2. Use the new (unused) opaque argument.
> >=20
> > Given that #1 exists, is this patch really necessary?
>=20
> I didn't really notice that.  Thanks for pointing out.
>=20
> However even if so I would still prefer the opaque way to do it if
> asked.  Existing #1 of course works but IMHO is less flexible and has
> dependency between structure layouts.
>=20
> How about I append another patch to convert existing users (or, I can
> post as separate patches after this series)?  It's not really a lot,
> and the conversion would be obvious:
>=20
> *** qga/main.c:
> run_agent[1324]                json_message_parser_init(&s->parser, proce=
ss_event, NULL);
> *** qobject/qjson.c:
> qobject_from_jsonv[45]         json_message_parser_init(&state.parser, pa=
rse_json, NULL);
> *** tests/libqtest.c:
> qmp_fd_receive[438]            json_message_parser_init(&qmp.parser, qmp_=
response, NULL);
>=20
> Though, if you still insist, I can drop it too.

I prefer dropping it.  Smaller patch series get reviewed quicker, cause
fewer merge conflicts, are lower risk, etc.

Stefan

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM8PkAAoJEJykq7OBq3PIWqYIAJBleHnD8BC3akwSKugfnDYl
NzByA7RSu/sNS8eofs3xaEJcIJ5QbBaV/sz1jijZH2iwM9+proQGGXLS1X+JJah5
vheB7W52ORxdNXL/q7OiSfM5awo9Fqezr/mXx60u5/+QDTnE0zLjXrPF0NWb2nB5
VaRlG7MLV13kkPQt4Y62QU36oA0LRrUpEHHfbQNb8l2PeHBHIoOuMImImM/uyy3F
jS/nIiMoHijxtPIbC4Y6upBPdJaQnEouP7SoqBsStX8Lkjus6dt2SJYGmRWmJqqi
NMBrgd4TzxR+LLcgnKW6tgEOuI4xjT3T8BzJET2R3phAd1QUF2Tgt4T8x7u1kv4=
=HYiu
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
