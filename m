Received: from eggs.gnu.org ([2001:4830:134:3::10]:60336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtKr-0002wL-Di
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtKm-0005fv-Lz
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:57:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjtKm-0005fV-Cy
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:57:48 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A74EC0567A1
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:57:48 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-8-git-send-email-armbru@redhat.com>
	<e3776dbf-f2d3-b2ef-4454-9b9dc46d7f20@redhat.com>
	<8760jqjgam.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7edb67e-c8c7-5bd4-32fa-f00b4135a1e2@redhat.com>
Date: Fri, 3 Mar 2017 13:57:45 -0600
MIME-Version: 1.0
In-Reply-To: <8760jqjgam.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LEtIvaGbIHeM6NejTe5Q8dInoHJlWXR1r"
Subject: Re: [Qemu-devel] [PATCH v4 07/28] qmp: Clean up how we enforce
 capability negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LEtIvaGbIHeM6NejTe5Q8dInoHJlWXR1r
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <e7edb67e-c8c7-5bd4-32fa-f00b4135a1e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/28] qmp: Clean up how we enforce
 capability negotiation
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-8-git-send-email-armbru@redhat.com>
 <e3776dbf-f2d3-b2ef-4454-9b9dc46d7f20@redhat.com>
 <8760jqjgam.fsf@dusky.pond.sub.org>
In-Reply-To: <8760jqjgam.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 01:45 PM, Markus Armbruster wrote:

>>> -    rsp =3D qmp_dispatch(&qmp_commands, req);
>>> +    qdict =3D qdict_get_qdict(qobject_to_qdict(rsp), "error");
>>> +    if (qdict) {
>>> +        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands
>>> +            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
>>> +                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FO=
UND])) {
>>
>> Could join these two 'if' into one, for less {}, but that's cosmetic.
>=20
> Or maybe get reshuffle so that qdict_get_qdict() is called only when
> needed:
>=20
>     if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
>         qdict =3D qdict_get_qdict(qobject_to_qdict(rsp), "error");
>         if (qdict
>             && !g_strcmp0(qdict_get_try_str(qdict, "class"),
>                     QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND=
])) {
>             /* Provide a more useful error message */

Yes, that's even nicer (it's probably in the noise, but
micro-optimizations are fun!)


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LEtIvaGbIHeM6NejTe5Q8dInoHJlWXR1r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYucq5AAoJEKeha0olJ0Nq8Z4IAI96zrPdIRZelRaGiwCkBxhM
BnPfVGz4DyRcyomY2fo/JVqK3xAFKhYJFBPAPbojCqbrGjORDb4/xW1QwoQJVTOs
QJyHLlfyVJT8wXfCuNmO4+NHLSG1PJa2zS81kuPoM+nXwMoFEZ+7STlFgAXJKelP
5ndvfRsSyyK9ySUkXppDmvDsjhc8ZXrOkWZQSQQAONBfyGJcbh/QeSwqRHFonC7a
ZGpYPoY6FMGix0dpJRWqMhmB/PjBrCZLJdWeN4BypH9WaTkdSK7gS+Y8F2tdlz1g
hrCA5GldTsXUfXgumk/FGjsFknz3bo9/BkIBJ3JO1Oc+J+139oB6hHrAKC4LcTQ=
=B1vX
-----END PGP SIGNATURE-----

--LEtIvaGbIHeM6NejTe5Q8dInoHJlWXR1r--
