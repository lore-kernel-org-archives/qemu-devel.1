Received: from eggs.gnu.org ([2001:4830:134:3::10]:45825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfovz-0004T4-QI
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfovv-00078t-MD
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfovv-00077y-EB
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:59:35 -0400
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ce274ba-e487-4f16-4620-8c68a3ace35d@redhat.com>
Date: Thu, 10 Aug 2017 09:59:31 -0500
MIME-Version: 1.0
In-Reply-To: <1502367921-17730-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4iW21LCQRGgEui893HcaB1BCxJUrJKHk4"
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4iW21LCQRGgEui893HcaB1BCxJUrJKHk4
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Message-ID: <7ce274ba-e487-4f16-4620-8c68a3ace35d@redhat.com>
Subject: Re: [PATCH 2/2] vl: Partial support for non-scalar properties with
 -object
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
 <1502367921-17730-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1502367921-17730-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 07:25 AM, Markus Armbruster wrote:
> We've wanted -object to support non-scalar properties for a while.
> Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
> authorization API".  Review led to the conclusion that we need to
> replace rather than add to QemuOpts.  Initial work towards that goal
> has been merged to provide -blockdev (commit 8746709), but there's
> substantial work left, mostly due to an bewildering array of
> compatibility problems.
>=20
> Even if a full solution is still out of reach, we can have a partial
> solution now: accept -object argument in JSON syntax.  This should
> unblock development work that needs non-scalar properties with -object
>=20

Trailing dot?

> The implementation is similar to -blockdev, except we use the new
> infrastructure only for the new JSON case, and stick to QemuOpts for
> the existing KEY=3DVALUE,... case, to sidestep compatibility problems.
>=20
> If we did this for more options, we'd have to factor out common code.
> But for one option, this will do.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi-schema.json | 14 +++++++++++---
>  vl.c             | 55 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  2 files changed, 66 insertions(+), 3 deletions(-)
>=20

2.11 material.

> @@ -4078,6 +4102,29 @@ int main(int argc, char **argv, char **envp)
>  #endif
>                  break;
>              case QEMU_OPTION_object:
> +                /*
> +                 * TODO Use qobject_input_visitor_new_str() instead of=

> +                 * QemuOpts, not in addition to.  Not done now because=

> +                 * keyval_parse() isn't wart-compatible with QemuOpts.=

> +                 */
> +                if (optarg[0] =3D=3D '{') {

So we DON'T allow " {...}", even though that is valid JSON.  I'm okay
with stating that { is magic only as the first byte.

Reviewed-by: Eric Blake <eblake@redhat.com>

Do we need any documentation additions (whether in --help output, or in
the man page, or ?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4iW21LCQRGgEui893HcaB1BCxJUrJKHk4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMdNMACgkQp6FrSiUn
Q2pAcgf/UFU4Cdllunb6I2M5hs2AWgiP5xodKn/hOL9nFKVzd82OsIXQRaR3pd5z
o+sedI86tsIOIg9yh0hY4ATEIq3GSWCB/6c82KLWBiUQnauDxiE64/6pjMlFZ4ZG
SjNkTH72a9Z32Ve8ou24uauxDSaG1Aa8wTf/nKewyaGEziTTRFwThKMtLY/NMd6I
+xi3NWAOc6HmEJ+e6/0ghzGafrNzmj1aKQPCJUMyHMAm4uDzxrCIoKh8vANVgxJv
P9z3D9Udk4yltKcX5SfM9TMUdLnkvNjqJR9jOZ1rLSfRbjnqd1zDEHeKHKm3T6yK
HA1AH6fXkqAyUW8UT7Zk48riLD0C9w==
=/vM+
-----END PGP SIGNATURE-----

--4iW21LCQRGgEui893HcaB1BCxJUrJKHk4--
