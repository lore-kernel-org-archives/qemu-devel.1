Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepNz-0008Cg-7s
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepNy-0007SA-0P
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:44:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cepNx-0007R3-Ni
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:44:09 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D339D7FB7F
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:44:09 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-15-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40e2f699-6ae7-fc82-1d71-25a7a35a11c2@redhat.com>
Date: Fri, 17 Feb 2017 14:44:07 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-15-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PdrgmignL5AVDuFVKIIoJRkD6tVWVjISk"
Subject: Re: [Qemu-devel] [PATCH 14/24] util/cutils: New
 qemu_strtosz_metric()
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
--PdrgmignL5AVDuFVKIIoJRkD6tVWVjISk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <40e2f699-6ae7-fc82-1d71-25a7a35a11c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/24] util/cutils: New qemu_strtosz_metric()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-15-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> To parse numbers with metric suffixes, we use
>=20
>     qemu_strtosz_suffix_unit(nptr, &eptr, QEMU_STRTOSZ_DEFSUFFIX_B, 100=
0)
>=20
> Capture this in a new function for legibility:
>=20
>     qemu_strtosz_metric(nptr, &eptr)
>=20
> Replace test_qemu_strtosz_suffix_unit() by test_qemu_strtosz_metric().
>=20
> Rename qemu_strtosz_suffix_unit() to do_strtosz() and give it internal
> linkage.

I don't know if you do this later, but coreutils (via gnulib) has a nice
convention that:

1k   =3D> 1024
1kB  =3D> 1000
1kiB =3D> 1024

where the suffix can be used to express metric or power-of-two, letting
the user choose which scale they want rather than hard-coding the scale.
 But implementing that is beyond this scope of this particular patch.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -251,7 +251,7 @@ fail:
>  int64_t qemu_strtosz_suffix(const char *nptr, char **end,
>                              const char default_suffix)
>  {
> -    return qemu_strtosz_suffix_unit(nptr, end, default_suffix, 1024);
> +    return do_strtosz(nptr, end, default_suffix, 1024);
>  }
> =20
>  int64_t qemu_strtosz(const char *nptr, char **end)
> @@ -259,6 +259,11 @@ int64_t qemu_strtosz(const char *nptr, char **end)=

>      return qemu_strtosz_suffix(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB);

Do you also want to convert this one to do_strtosz() to avoid
double-forwarding?

Either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PdrgmignL5AVDuFVKIIoJRkD6tVWVjISk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2CXAAoJEKeha0olJ0NqPToH/ROc4sdvjzBS9cffZdQIFNUj
JhIoWq6Esua8nUDwDAuWXWTUpDA4eCjjz+YKyeq8KwrE8IZuzxgIss2t0YFC/jFy
srnvaOPVMzIPYlNOF8xhuYXC+DvNxnpomVvBH0gQIZHXK5NFa1Dlx47GUR8xt5dW
+uMs90Ia9K5OHpv/rzPCfbfm0hXO09o3vk+DsGueiev5BOJCbC0VliDDsZVnoUCP
ICK9ZZNRSJZ63JQ/ZW+DJBgbZNZPnjvAImsXuD8zGiKpA+CJ8sXm+HRIJ4tSNJ0n
Zx3Kcq13gPLC35VQ6SDxYSiv74FvksogOaFKJ8ROD8uEMuaPoNEEdgV3BaxHQFU=
=i26s
-----END PGP SIGNATURE-----

--PdrgmignL5AVDuFVKIIoJRkD6tVWVjISk--
