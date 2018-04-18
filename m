Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8n6u-0002J9-Ft
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8n6t-0004ek-5L
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:26:56 -0400
References: <20180405170619.20480-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99b844f2-7784-225a-37c4-77dad444fbd6@redhat.com>
Date: Wed, 18 Apr 2018 08:26:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180405170619.20480-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vGPgxWeb5EKqVq3RE0dj1YCKp4vZvRK7i"
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
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vGPgxWeb5EKqVq3RE0dj1YCKp4vZvRK7i
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <99b844f2-7784-225a-37c4-77dad444fbd6@redhat.com>
Subject: Re: [RFC][BROKEN] rbd: Allow configuration of authentication scheme
References: <20180405170619.20480-1-kwolf@redhat.com>
In-Reply-To: <20180405170619.20480-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/05/2018 12:06 PM, Kevin Wolf wrote:
> The legacy command line syntax supports a "password-secret" option that=

> allows to pass an authentication key to Ceph. This was not supported in=

> QMP so far.
>=20
> This patch introduces authentication options in the QAPI schema, makes
> them do the corresponding rados_conf_set() calls and adds compatibility=

> code that translates the old "password-secret" option both for opening
> and creating images to the new set of options.
>=20
> Note that the old option didn't allow to explicitly specify the set of
> allowed authentication schemes. The compatibility code assumes that if
> "password-secret" is given, only the cephx scheme is allowed. If it's
> missing, both none and cephx are allowed because the configuration file=

> could still provide a key.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> Any thoughts on the proposed QAPI schema or the two implementation
> problems are welcome.
>=20

>  qapi/block-core.json |  22 +++++++++++
>  block/rbd.c          | 102 ++++++++++++++++++++++++++++++++++++++-----=
--------
>  2 files changed, 99 insertions(+), 25 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c50517bff3..d5ce588add 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3170,6 +3170,19 @@
> =20
> =20
>  ##
> +# @RbdAuthCephx:
> +#
> +# @key-secret:         ID of a QCryptoSecret object providing a key fo=
r cephx
> +#                      authentication. If not specified, a key from th=
e
> +#                      specified configuration file, or the system def=
ault
> +#                      configuration is used, if present.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'RbdAuthCephx',
> +  'data': { '*key-secret': 'str' } }
> +
> +##
>  # @BlockdevOptionsRbd:
>  #
>  # @pool:               Ceph pool name.
> @@ -3184,6 +3197,13 @@
>  #
>  # @user:               Ceph id name.
>  #
> +# @auth-none:          true if connecting to a server without authenti=
cation
> +#                      should be allowed (default: false; since 2.13)
> +#
> +# @auth-cephx:         Configuration for cephx authentication if speci=
fied. If
> +#                      not specified, cephx authentication is not allo=
wed.
> +#                      (since 2.13)
> +#
>  # @server:             Monitor host address and port.  This maps
>  #                      to the "mon_host" Ceph option.
>  #
> @@ -3195,6 +3215,8 @@
>              '*conf': 'str',
>              '*snapshot': 'str',
>              '*user': 'str',
> +            '*auth-none': 'bool',
> +            '*auth-cephx': 'RbdAuthCephx',
>              '*server': ['InetSocketAddressBase'] } }

Would it be better to have this be a flat union with 'auth' with enum
values 'none', 'cephx', 'both' as a discriminator that determines which
additional fields can be present?  Or does that require that we first
fix the QAPI generator to allow nesting a flat union within another flat
union (probably doable, just no one has needed it before now)?  Is it
also time to improve the QAPI generator to allow a default value to the
discriminator field, rather than requiring the field to be present?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vGPgxWeb5EKqVq3RE0dj1YCKp4vZvRK7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXR48ACgkQp6FrSiUn
Q2qn3ggAsMMrj3nI9ZB0R7SlL/QbevW3ujv//GmnWvjyakkjiwJa2NebsqNdIWak
FFniODvh3x0EXARZGcR/zDTkBOnUl913gKBGl0D9P3iTCV82fako88QGjg2vzLQh
hgy5jGy8V818PIDUkn4jMervvKUBEBGH83rQUEoZ6oL4Htl5gTyfI2sBgMDZSF9o
/k2nhpgY+CQfR/FzRW/JzkU4EtpMG+Xr1IsaJoc5/i848+mUilsqZ5+9BQZeOSs6
sOsyaKB4yHv1wf2pYKHBjXIEu5sPmLcFUwkEFTZlVBJq3HbRkXMFpLHDpJzLCaUg
poc3S/cPlTI3I20jvWo2AvLERxjiag==
=dH2c
-----END PGP SIGNATURE-----

--vGPgxWeb5EKqVq3RE0dj1YCKp4vZvRK7i--
