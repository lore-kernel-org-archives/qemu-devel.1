Received: from eggs.gnu.org ([209.51.188.92]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtcdJ-0004D2-Oq
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtcd3-0003CJ-Rk
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:18:02 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ff3d746-ac29-561a-3076-8ee67ff4595a@redhat.com>
Date: Tue, 12 Feb 2019 12:17:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190212010248.11056-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="18TIU2dhkHdmujReKS0rKYsSwts5xcz17"
Subject: Re: [Qemu-devel] [PATCH 1/5] block/dirty-bitmap: add recording and
 busy properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--18TIU2dhkHdmujReKS0rKYsSwts5xcz17
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <2ff3d746-ac29-561a-3076-8ee67ff4595a@redhat.com>
Subject: Re: [PATCH 1/5] block/dirty-bitmap: add recording and busy properties
References: <20190212010248.11056-1-jsnow@redhat.com>
 <20190212010248.11056-2-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 7:02 PM, John Snow wrote:
> The current API allows us to report a single status, which we've define=
d as:
>=20
> Frozen: has a successor, treated as qmp_locked, may or may not be enabl=
ed.
> Locked: no successor, qmp_locked. may or may not be enabled.
> Disabled: Not frozen or locked, disabled.
> Active: Not frozen, locked, or disabled.
>=20
> The problem is that both "Frozen" and "Locked" mean nearly the same thi=
ng,
> and that both of them do not intuit whether they are recording guest wr=
ites
> or not.
>=20
> This patch deprecates that status field and introduces two orthogonal
> properties instead to replace it.
> ---

No S-o-b?


> +++ b/qapi/block-core.json
> @@ -455,7 +455,13 @@
>  #
>  # @granularity: granularity of the dirty bitmap in bytes (since 1.4)
>  #
> -# @status: current status of the dirty bitmap (since 2.4)
> +# @status: Deprecated in favor of @recording and @locked. (since 4.0)

I'd leave this one as (since 2.4). The deprecation clock is starting in
4.0, but the field has been present longer, and it is still obvious to
readers...

> +#
> +# @recording: true if the bitmap is recording new writes from the gues=
t.
> +#             Replaces `active` status. (since 4.0)

=2E..that the replacement fields are only usable in 4.0 and newer.

> +#
> +# @busy: true if the bitmap is in-use by some operation (NBD or jobs)
> +#        and cannot be modified via QMP right now. (since 4.0)
>  #
>  # @persistent: true if the bitmap will eventually be flushed to persis=
tent
>  #              storage (since 4.0)
> @@ -464,6 +470,7 @@
>  ##
>  { 'struct': 'BlockDirtyInfo',
>    'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
> +           'recording': 'bool', 'busy': 'bool',
>             'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }

The UI changes look reasonable.

No iotests coverage of "busy":true?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--18TIU2dhkHdmujReKS0rKYsSwts5xcz17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjDbQACgkQp6FrSiUn
Q2o06AgAnooLW8reStypdXLAE4ApfjxM2PPFotob2iTchqvp+bjRK99wO8DcjGur
stuYzoaKcCdxnXOmQ30IbpXJ9xg828M6hbQqJvB+/AtnACE0wNeoaeZzecBEHSqG
t8XtuZI4zL+0YoK6pF25AJ4/t3PPsd0Moq4/j3dYev1+1BJ4YqWnmsV038sOvmAt
zwwHIWYg4BObZArs2866CKGSPFLm7jmYqwGelYHRoaZIIKw0+a96t7Q6VAK466XP
1oG9lRG0Y+H9Lxp1MsR3O9pc7jksVbjvNaaIO48AIogZcNow+zbZdE5VymEvir4a
zEpkDOPfnZL1tP+yFEiNNIUNraySDw==
=vvyM
-----END PGP SIGNATURE-----

--18TIU2dhkHdmujReKS0rKYsSwts5xcz17--
