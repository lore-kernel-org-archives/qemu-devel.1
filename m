Received: from eggs.gnu.org ([2001:4830:134:3::10]:45202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikLZ-0007Nv-Il
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikLU-00084M-KU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:09:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cikLU-00084A-BB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:09:48 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95B3019D24B
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:09:48 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-24-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02d73850-0c88-ee05-2c24-02f0129dd175@redhat.com>
Date: Tue, 28 Feb 2017 10:09:46 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-24-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VkBEnXgO6QkMprsIJWBC6xOBQ1dNRGb6A"
Subject: Re: [Qemu-devel] [PATCH v2 23/26] qapi: Make input visitors detect
 unvisited list tails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VkBEnXgO6QkMprsIJWBC6xOBQ1dNRGb6A
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <02d73850-0c88-ee05-2c24-02f0129dd175@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 23/26] qapi: Make input visitors detect
 unvisited list tails
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-24-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Fix the design flaw demonstrated in the previous commit: new method
> check_list() lets input visitors report that unvisited input remains
> for a list, exactly like check_struct() lets them report that
> unvisited input remains for a struct or union.
>=20
> Implement the method for the qobject input visitor (straightforward),
> and the string input visitor (less so, due to the magic list syntax
> there).  The opts visitor's list magic is even more impenetrable, and
> all I can do there today is a stub with a FIXME comment.  No worse
> than before.

Yeah, I know what you mean (having worked on all three visitors in prior
patches).  The opts visitor is just painful.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 2de6377..fe7b988 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -326,6 +326,11 @@ static void prop_get_fdt(Object *obj, Visitor *v, =
const char *name,
>                      return;
>                  }
>              }
> +            visit_check_list(v, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              visit_end_list(v, NULL);

This doesn't look right.  You want the visit_end_list() call to occur
unconditionally, even when visit_check_list() fails, so as to free any
resources allocated by the visitor.


> +++ b/tests/test-string-input-visitor.c
> @@ -160,17 +160,9 @@ static void test_visitor_in_intList(TestInputVisit=
orData *data,
>      /* Would be simpler if the visitor genuinely supported virtual wal=
ks */
>      visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
>                       &error_abort);
> -    tail =3D res;
> -    visit_type_int64(v, NULL, &tail->value, &error_abort);
> -    g_assert_cmpint(tail->value, =3D=3D, 0);
> -    tail =3D (int64List *)visit_next_list(v, (GenericList *)tail, size=
of(*res));
> -    g_assert(tail);
> -    visit_type_int64(v, NULL, &tail->value, &error_abort);
> -    g_assert_cmpint(tail->value, =3D=3D, 2);
> -    tail =3D (int64List *)visit_next_list(v, (GenericList *)tail, size=
of(*res));
> -    g_assert(tail);
> +    visit_check_list(v, &err);

You are still calling visit_check_list() after a partial visit, but why
change from a 2/3 visit to a 0/3 visit?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VkBEnXgO6QkMprsIJWBC6xOBQ1dNRGb6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtaDKAAoJEKeha0olJ0NqbScH/R6Hc7teumo2NA0nM4djcsFk
trFJ3UcP0MiuGArNkkETM/PMMM0D3F6Fzlq44A9BwACF1BtthqeZtpiXHOZZB7ul
yXJYfCVhjdfKZJecS8b+xEvAJ+5k59t0NZ7/LKxpC09161xceMhpPzVmSMT7+WSW
AdjPhM9a3nxwvpq5CArge0a1bOsi8zTEo0dtkD9OKT7fyjHLGMHMwI/dmGeP8yGN
/JWwnBAJ0kLY5wuQPaNe+sLmdkuPmalL937K7x82xc4HsjVmgXe5GFRACXmUnZcG
4+NJIllJY086MF3Dw40ctLbF1ccxiffVK6wX3FhY0Z0ya9yz3oR4WJzDwMwIAy4=
=ahun
-----END PGP SIGNATURE-----

--VkBEnXgO6QkMprsIJWBC6xOBQ1dNRGb6A--
