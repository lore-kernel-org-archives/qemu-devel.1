Received: from eggs.gnu.org ([2001:4830:134:3::10]:49123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcuAc-0001jt-HT
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcuAZ-0005At-An
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:42 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:33304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcuAZ-00055N-4C
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:39 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 16DDB4B157
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 15:58:27 +0200 (CEST)
Date: Wed, 2 Aug 2017 15:58:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170802155816.17fd28fa@bahia.lan>
In-Reply-To: <20170802103259.25940-1-lvivier@redhat.com>
References: <20170802103259.25940-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/9nAH8zR9z5pt9KwcosmwU+r";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] cpu: don't allow negative core
 id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/9nAH8zR9z5pt9KwcosmwU+r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  2 Aug 2017 12:32:59 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> With pseries machine type a negative core-id is not managed properly:
> -1 gives an inaccurate error message ("core -1 already populated"),
> -2 crashes QEMU (core dump)
>=20
> As it seems a negative value is invalid for any architecture,
> instead of checking this in spapr_core_pre_plug() I think it's better
> to check this in the generic part, core_prop_set_core_id()
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Not sure why core_id is signed but, as you said to Philippe, it's probably
not the right time to change the API.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/cpu/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 2bf960d..bd578ab 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -33,6 +33,11 @@ static void core_prop_set_core_id(Object *obj, Visitor=
 *v, const char *name,
>          return;
>      }
> =20
> +    if (value < 0) {
> +        error_setg(errp, "Invalid core id %"PRId64, value);
> +        return;
> +    }
> +
>      core->core_id =3D value;
>  }
> =20


--Sig_/9nAH8zR9z5pt9KwcosmwU+r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmB2ngACgkQAvw66wEB28JYtACdGVS1fu8HNZX8wHH7XuynHYU7
6u0AnicWOK66nu6ni9alpfn5WnBardsT
=NPim
-----END PGP SIGNATURE-----

--Sig_/9nAH8zR9z5pt9KwcosmwU+r--
