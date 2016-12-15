Received: from eggs.gnu.org ([2001:4830:134:3::10]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHVDk-0000XK-CF
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHVDg-0001S6-Ec
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:33:12 -0500
Received: from ozlabs.org ([103.22.144.67]:43635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cHVDg-0001RD-2R
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:33:08 -0500
Date: Thu, 15 Dec 2016 21:30:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161215103052.GP32647@umbus>
References: <148173506053.2583.5116401313254785036.stgit@bahia>
	<87zijx34t9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hXth9cGL35Nvpk4x"
Content-Disposition: inline
In-Reply-To: <87zijx34t9.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] qapi: add explicit null to
 string input and output visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--hXth9cGL35Nvpk4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 10:44:02AM +0100, Markus Armbruster wrote:
> Greg Kurz <groug@kaod.org> writes:
>=20
> > This may be used for deprecated object properties that are kept for
> > backwards compatibility.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: - input visitor to reject non-empty strings
> >
> > This is needed for David's patch to work:
> >
> > [RFCv2 10/12] pseries: Move CPU compatibility property to machine
>=20
> Recommend to insert this patch less the fixup to David's patch before
> David's patch, then squash in the fixup, if it's needed.

That series of mine needs a bunch of rework for several things
including this.  It'll probably be a while before I can get back to
that, so don't hold this up on my account.

>=20
> > Messag-Id: <1479248275-18889-11-git-send-email-david@gibson.dropbear.id=
=2Eau>
> >
> > Since this v2 changes the behavior to reject non-empty null properties,
> > it is up to getset_compat_deprecated() to ignore the error. The followi=
ng
> > folded into patch [RFCv2 10/12] does the trick:
> >
> > --- a/target-ppc/translate_init.c
> > +++ b/target-ppc/translate_init.c
> > @@ -8446,7 +8446,7 @@ static void getset_compat_deprecated(Object *obj,=
 Visitor
> >      if (!qtest_enabled()) {
> >          error_report("CPU 'compat' property is deprecated and has no e=
ffect; us
> >      }
> > -    visit_type_null(v, name, errp);
> > +    visit_type_null(v, name, NULL);
>=20
> Are you sure we want to ignore errors here?
>=20
> >  }
> >
> >  static PropertyInfo ppc_compat_deprecated_propinfo =3D {
> > ---
> >  qapi/string-input-visitor.c  |   11 +++++++++++
> >  qapi/string-output-visitor.c |   14 ++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> > index 8dfa5612522b..9e9d2a1d2865 100644
> > --- a/qapi/string-input-visitor.c
> > +++ b/qapi/string-input-visitor.c
> > @@ -314,6 +314,16 @@ static void parse_type_number(Visitor *v, const ch=
ar *name, double *obj,
> >      *obj =3D val;
> >  }
> > =20
> > +static void parse_type_null(Visitor *v, const char *name, Error **errp)
> > +{
> > +    StringInputVisitor *siv =3D to_siv(v);
> > +
> > +    if (siv->string && siv->string[0]) {
> > +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "n=
ull",
> > +                   "null");
> > +    }
> > +}
>=20
> When !siv->string, the other parse_type_FOO() generally do
>=20
>     error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                ... a description of the expected type...);
>=20
> This one doesn't.  Why?
>=20
> Should the conditional be !siv->string || siv->string[0]?
>=20
> > +
> >  static void parse_optional(Visitor *v, const char *name, bool *present)
> >  {
> >      StringInputVisitor *siv =3D to_siv(v);
> > @@ -348,6 +358,7 @@ Visitor *string_input_visitor_new(const char *str)
> >      v->visitor.type_bool =3D parse_type_bool;
> >      v->visitor.type_str =3D parse_type_str;
> >      v->visitor.type_number =3D parse_type_number;
> > +    v->visitor.type_null =3D parse_type_null;
> >      v->visitor.start_list =3D start_list;
> >      v->visitor.next_list =3D next_list;
> >      v->visitor.end_list =3D end_list;
> > diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> > index 94ac8211d144..5ec5352ca87c 100644
> > --- a/qapi/string-output-visitor.c
> > +++ b/qapi/string-output-visitor.c
> > @@ -266,6 +266,19 @@ static void print_type_number(Visitor *v, const ch=
ar *name, double *obj,
> >      string_output_set(sov, g_strdup_printf("%f", *obj));
> >  }
> > =20
> > +static void print_type_null(Visitor *v, const char *name, Error **errp)
> > +{
> > +    StringOutputVisitor *sov =3D to_sov(v);
> > +    char *out;
> > +
> > +    if (sov->human) {
> > +        out =3D g_strdup("<null>");
> > +    } else {
> > +        out =3D g_strdup("");
> > +    }
> > +    string_output_set(sov, out);
> > +}
> > +
> >  static void
> >  start_list(Visitor *v, const char *name, GenericList **list, size_t si=
ze,
> >             Error **errp)
> > @@ -351,6 +364,7 @@ Visitor *string_output_visitor_new(bool human, char=
 **result)
> >      v->visitor.type_bool =3D print_type_bool;
> >      v->visitor.type_str =3D print_type_str;
> >      v->visitor.type_number =3D print_type_number;
> > +    v->visitor.type_null =3D print_type_null;
> >      v->visitor.start_list =3D start_list;
> >      v->visitor.next_list =3D next_list;
> >      v->visitor.end_list =3D end_list;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hXth9cGL35Nvpk4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUnDZAAoJEGw4ysog2bOS6uIQALV7zB8fmVwoM27Jt2vi4rPI
pKmOK6D8SisLsbYDWnWKi6Bb5NKYUvFYXkPwutT4zXVND1WxUV7RvREIUEQlXmcG
PapqXDlbtDNkGhRbud181yxFfq48depvsxlemggDHOX/S7EpByGToZNjrCWT+046
BSI9ED+Lan6Y5IgNdh2Jo1xNVbZWdwXeg+ms/mJfxKxJUMgdd7Yeb/aCJADgJAmY
hcJTX6lOjoB1YZ/dsROCU2obcN/wPBgU4N5Zy5cv9LoCYEXvibeHPWXE+HJdqeZj
30mJwmLQ1GsWKqwKr3VooXL1ODqrp5GlOK7YtFTFbKfLq2jSQJbjamr84vinrUif
mfLMeLNlG4ANgPw4SrrFVca0S9+UYJHvt2dYLwP7O4ppkxSVM6lk1a5qA60ZB6Ma
KjGeUzCAYNw9MSi92y0mgsYdC5gFiCkcVNhktGSZM1kGGOiPAxHR13BHcXHlVxrx
OZ6LT4Jfv2+sIXze2JLPFPtoQ+aMpERaP2KKBMl3jhhua+2Un8di5OP5iYKIi675
9fkYQHwTOM83A1Tl0jhy2JWA+W1A5ZjAuZWoUV85qoEjN33ZMLCUvWYJkrdqDYys
YFhqupUkalNGDv69Kb+qs84Hj6X5nw1L2fxCAzL3DqaL0NxaYj7K2flkAdd/kjT1
pMwRaEXEuuEm42toe/g+
=PiHH
-----END PGP SIGNATURE-----

--hXth9cGL35Nvpk4x--
