Received: from eggs.gnu.org ([209.51.188.92]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpcJo-0000dk-4J
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpcJ9-0006n0-JO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:08:53 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b513b442-a6e3-c21a-673e-095112d26343@redhat.com>
Date: Fri, 1 Feb 2019 11:08:22 -0600
MIME-Version: 1.0
In-Reply-To: <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7GJRYRWpXO88aVqWK888OBScN8JpkAi1z"
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7GJRYRWpXO88aVqWK888OBScN8JpkAi1z
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <b513b442-a6e3-c21a-673e-095112d26343@redhat.com>
Subject: Re: [PATCH v11 2/3] qemu-img info lists bitmap directory entries
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 7:46 AM, Andrey Shinkevich wrote:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
>=20

> +
> +static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)=

> +{
> +    Qcow2BitmapInfoFlagsList *list =3D NULL;
> +    Qcow2BitmapInfoFlagsList **plist =3D &list;
> +    int i;
> +
> +    static const struct {
> +        int bme;  /* Bitmap directory entry flags */
> +        int info; /* The flags to report to the user */
> +    } map[] =3D {
> +        { BME_FLAG_IN_USE, QCOW2_BITMAP_INFO_FLAGS_IN_USE },
> +        { BME_FLAG_AUTO,   QCOW2_BITMAP_INFO_FLAGS_AUTO },
> +    };
> +
> +    int map_size =3D sizeof(map) / sizeof(map[0]);

We have the ARRAY_SIZE() macro for this.

> +
> +    for (i =3D 0; i < map_size; ++i) {
> +        if (flags & map[i].bme) {
> +            Qcow2BitmapInfoFlagsList *entry =3D
> +                g_new0(Qcow2BitmapInfoFlagsList, 1);
> +            entry->value =3D map[i].info;
> +            *plist =3D entry;
> +            plist =3D &entry->next;
> +            flags &=3D ~map[i].bme;
> +        }
> +    }
> +    /* Check if the BME_* mapping above is complete */
> +    assert(!flags);
> +

> +        info->flags =3D get_bitmap_info_flags(bm->flags & ~BME_RESERVE=
D_FLAGS);
> +        info->unknown_flags =3D bm->flags & BME_RESERVED_FLAGS;
> +        info->has_unknown_flags =3D !!info->unknown_flags;

Glad you liked my idea for better sanity checking.

If that's the only change needed, I don't mind making it as part of
staging for a pull request (of course, review comments on 3/3 may still
result in a v12 for other reasons).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7GJRYRWpXO88aVqWK888OBScN8JpkAi1z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUfQYACgkQp6FrSiUn
Q2o5ugf/WQqZQ+Psc/yT1DHj5wPDhzx2404n0LUIIHP3IzdlD1xRoTE2x2W6QYUh
g21f10cQhxBHDTYO0D7efHx8Bi3naGYtx6Utj/9UMjYLfcdasBT8zR/2f4diFKQg
QwwRUbJ2W1LFgvb7uR2PIWP5qjRIbFhe4M/kNiP1nESMyPm1GdJIgLH7wUxHDTEW
fu1xdlMJSAvPLTa/saTWVT2Vfcd4/ZpMwxgq2CqPCESX+fhu85sYe/hGR1QQQteF
hIpvfUzBVaztSqZj/1dCwRh7Hf0NPp6x9zVd44yfqHjPYCRe0oaXU0OcudnrXseM
RBnmI+Wk7lbPugWpLvj7D9icZVdzvw==
=zjE5
-----END PGP SIGNATURE-----

--7GJRYRWpXO88aVqWK888OBScN8JpkAi1z--
