Received: from eggs.gnu.org ([2001:4830:134:3::10]:55381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f8nTW-0004qh-Oe
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f8nTV-0000Cj-Nu
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:50:18 -0400
Date: Wed, 18 Apr 2018 15:50:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180418135009.GF4971@localhost.localdomain>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<99b844f2-7784-225a-37c4-77dad444fbd6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <99b844f2-7784-225a-37c4-77dad444fbd6@redhat.com>
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.04.2018 um 15:26 hat Eric Blake geschrieben:
> On 04/05/2018 12:06 PM, Kevin Wolf wrote:
> > The legacy command line syntax supports a "password-secret" option that
> > allows to pass an authentication key to Ceph. This was not supported in
> > QMP so far.
> >=20
> > This patch introduces authentication options in the QAPI schema, makes
> > them do the corresponding rados_conf_set() calls and adds compatibility
> > code that translates the old "password-secret" option both for opening
> > and creating images to the new set of options.
> >=20
> > Note that the old option didn't allow to explicitly specify the set of
> > allowed authentication schemes. The compatibility code assumes that if
> > "password-secret" is given, only the cephx scheme is allowed. If it's
> > missing, both none and cephx are allowed because the configuration file
> > could still provide a key.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
>=20
> > Any thoughts on the proposed QAPI schema or the two implementation
> > problems are welcome.
> >=20
>=20
> >  qapi/block-core.json |  22 +++++++++++
> >  block/rbd.c          | 102 ++++++++++++++++++++++++++++++++++++++-----=
--------
> >  2 files changed, 99 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index c50517bff3..d5ce588add 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3170,6 +3170,19 @@
> > =20
> > =20
> >  ##
> > +# @RbdAuthCephx:
> > +#
> > +# @key-secret:         ID of a QCryptoSecret object providing a key fo=
r cephx
> > +#                      authentication. If not specified, a key from the
> > +#                      specified configuration file, or the system def=
ault
> > +#                      configuration is used, if present.
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'struct': 'RbdAuthCephx',
> > +  'data': { '*key-secret': 'str' } }
> > +
> > +##
> >  # @BlockdevOptionsRbd:
> >  #
> >  # @pool:               Ceph pool name.
> > @@ -3184,6 +3197,13 @@
> >  #
> >  # @user:               Ceph id name.
> >  #
> > +# @auth-none:          true if connecting to a server without authenti=
cation
> > +#                      should be allowed (default: false; since 2.13)
> > +#
> > +# @auth-cephx:         Configuration for cephx authentication if speci=
fied. If
> > +#                      not specified, cephx authentication is not allo=
wed.
> > +#                      (since 2.13)
> > +#
> >  # @server:             Monitor host address and port.  This maps
> >  #                      to the "mon_host" Ceph option.
> >  #
> > @@ -3195,6 +3215,8 @@
> >              '*conf': 'str',
> >              '*snapshot': 'str',
> >              '*user': 'str',
> > +            '*auth-none': 'bool',
> > +            '*auth-cephx': 'RbdAuthCephx',
> >              '*server': ['InetSocketAddressBase'] } }
>=20
> Would it be better to have this be a flat union with 'auth' with enum
> values 'none', 'cephx', 'both' as a discriminator that determines which
> additional fields can be present?  Or does that require that we first
> fix the QAPI generator to allow nesting a flat union within another flat
> union (probably doable, just no one has needed it before now)?  Is it
> also time to improve the QAPI generator to allow a default value to the
> discriminator field, rather than requiring the field to be present?

Both options can be enabled at the same time, so that the client
connects to a server no matter whether it does 'cephx' authentication or
only 'none. This is even the default for rbd driver (in the existing
command line interface, but I think we need to stay compatible with it).
With a union you would have to explicitly choose one or the other, but
could never accept both.

The other option we were considering was a list of authentication
options, which would be easier to implement, but isn't really an
accurate representation of what we really accept. There is no way we
could meaningfully implement something like this:

    'auth': [ { 'type': 'cephx', 'key-secret': 'foo' },
              { 'type': 'cephx', 'key-secret': 'bar' } ]

Because Ceph only allows us to enable the 'cephx' authentication method
and to set a single key for it.

Kevin

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa100RAAoJEH8JsnLIjy/WjKUP/id5t5PBW5Kx1O/anU6AGUtH
X/P0b26gb1vp/xBAkqR6S1W3IEKSA6+QHcB9qHzRt+q0h1mkQ2UVXsIBtmgWVpUm
rPLOYcu3DsSqhZ5PJSijb/njgqHt/aPv+DB6PD8TN/8xgf3u2DwTSDLZIdR90LJP
GNsvf/PO8nqoKJSBWZxBELSi7zR+0oCmMJ/tGmucvE46gKV7C69V0TeyFyQ9mkHa
iDbF4wUdk+HZgXZOaOxCOV6h/vpiI/EUW+XNZZrSoZbbPoVLaviI1SfZWaqWJUWh
2Aoy04lG6aP9hortr12Lgj6rjrpuGQL6BAF2IDKOSZ6lzp5vNgEMYPjL1fVboWmd
zi1n7QPlB+dee2ylKLmzCAliDz+7lc1j35MhJsqA149ka6N1G5DaPlbXyJcCZB1I
0OMs8lZQF/hmeuQ9EOuj4NOl9FnQ6zfOTppi1qRkwAePIeku46Oo/AiXt1isdEQF
tubP+fyffJfJsECkf2wsM1vHjgC3NT1cyLMiBhAlT3mfFud63RFQr7oKG5CvbVTT
zC2aB0Jw5Odqqktq1hJ9+7WqAvOvBOwBoJ0AO5Z6/Wi4WNTK7vvhLV2uziK/T1wX
65zOtFiKHiasJE2O1RtBFEaF86PBf42JOdZkADX/aYNBi9hgg5mvPVCQBrEyCfS8
a+t3uDXobidZe70n2GLg
=Bctt
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
