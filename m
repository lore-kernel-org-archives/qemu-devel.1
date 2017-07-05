Received: from eggs.gnu.org ([2001:4830:134:3::10]:56016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSqkd-0001sa-Ht
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSqkc-0001rZ-IL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:18:19 -0400
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-8-eblake@redhat.com>
	<20170705114244.GA5297@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5308afcc-dede-d670-0973-8acc3e1177c2@redhat.com>
Date: Wed, 5 Jul 2017 15:18:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170705114244.GA5297@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HculsijHDrCPLCwaw0FxjRhNbO8cPhQ0M"
Subject: Re: [Qemu-devel] [PATCH v3 07/20] mirror: Switch MirrorBlockJob to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HculsijHDrCPLCwaw0FxjRhNbO8cPhQ0M
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <5308afcc-dede-d670-0973-8acc3e1177c2@redhat.com>
Subject: Re: [PATCH v3 07/20] mirror: Switch MirrorBlockJob to byte-based
References: <20170627192458.15519-1-eblake@redhat.com>
 <20170627192458.15519-8-eblake@redhat.com>
 <20170705114244.GA5297@noname.redhat.com>
In-Reply-To: <20170705114244.GA5297@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 06:42 AM, Kevin Wolf wrote:
> Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
>> We are gradually converting to byte-based interfaces, as they are
>> easier to reason about than sector-based.  Continue by converting an
>> internal structure (no semantic change), and all references to the
>> buffer size.
>>
>> [checkpatch has a false positive on use of MIN() in this patch]
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> I wouldn't mind an assertion that granularity is a multiple of
> BDRV_SECTOR_SIZE, along with a comment that explains that this is
> required so that we avoid rounding problems when dealing with the bitma=
p
> functions.

That goes away later when series two converts the bitmap functions to be
byte-based, but you're right that the intermediate state should be
easier to follow.

>=20
> blockdev_mirror_common() does already check this, but it feels like it'=
s
> a bit far away from where the actual problem would happen in the mirror=

> job code.

Indeed.

>=20
>> @@ -768,17 +765,17 @@ static void coroutine_fn mirror_run(void *opaque=
)
>>       * the destination do COW.  Instead, we copy sectors around the
>>       * dirty data if needed.  We need a bitmap to do that.
>>       */
>> +    s->target_cluster_size =3D BDRV_SECTOR_SIZE;
>>      bdrv_get_backing_filename(target_bs, backing_filename,
>>                                sizeof(backing_filename));
>>      if (!bdrv_get_info(target_bs, &bdi) && bdi.cluster_size) {
>> -        target_cluster_size =3D bdi.cluster_size;
>> +        s->target_cluster_size =3D bdi.cluster_size;
>>      }
>=20
> Why have the unrelated bdrv_get_backing_filename() between the two
> assignments of s->target_cluster_size? Or actually, wouldn't it be
> even easier to read with an else branch?
>=20
>     if (!bdrv_get_info(target_bs, &bdi) && bdi.cluster_size) {
>         s->target_cluster_size =3D bdi.cluster_size;
>     } else {
>         s->target_cluster_size =3D BDRV_SECTOR_SIZE;
>     }

Yes, that looks nicer.

>=20
> None of these comments are critical, so anyway:
>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

I'm respinning v4 anyways, so I'll make the change (and while it is
small, it's still enough that I'll drop R-b).

>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HculsijHDrCPLCwaw0FxjRhNbO8cPhQ0M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXUl+AAoJEKeha0olJ0Nq7KcIAJLSU10pQejYJh18wSrVchzr
YxarRW9agN5e+VNOo+BeOhFFvAkzZTePqreBGale0VzaHV/hEgzjP/Ykw6fth845
PfZXECrT6Y3sn74CJJMHGulB2dg415ZyxiKF2+8OI6xOKPTLj6l53azzLkHLSWLd
6Rok7XwPLHYsuimv3xKtu7exJDTEzWM4mbf8yLEMz3s8f6SVy4fiz7Rgs5wpMnFv
tVs0x9eMPNUVyj5LViW8S+BJXFZMdI9k32g09hgTgB05SZmEKfoqqJrX5Bg/uCBX
J0gqu/yLrUcU7p0/rDyvjnEj96rIC6IJS9HR9r7Jv3094hirUn+Sjo4j026HVds=
=T+5G
-----END PGP SIGNATURE-----

--HculsijHDrCPLCwaw0FxjRhNbO8cPhQ0M--
