Received: from eggs.gnu.org ([209.51.188.92]:53705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goDlG-0006Fk-1y
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goDlF-00044s-0p
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:44:06 -0500
References: <1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d278f3d1-9c35-e522-603c-f26733d38659@redhat.com>
Date: Mon, 28 Jan 2019 14:43:59 -0600
MIME-Version: 1.0
In-Reply-To: <1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RM4jGOtcpqlZJxPZntg4ZxpO0Sg0SzyOf"
Subject: Re: [Qemu-devel] [PATCH v9 1/2] qemu-img info lists bitmap
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
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RM4jGOtcpqlZJxPZntg4ZxpO0Sg0SzyOf
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Message-ID: <d278f3d1-9c35-e522-603c-f26733d38659@redhat.com>
Subject: Re: [PATCH v9 1/2] qemu-img info lists bitmap directory entries
References: <1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548705688-1027522-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 2:01 PM, Andrey Shinkevich wrote:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
>=20

>=20
> As the print of the qcow2 specific information expanded by adding
> the bitmap parameters to the 'qemu-img info' command output,
> it requires amendment of the output benchmark in the following
> tests: 060, 065, 082, 198, and 206.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

> =20
> +static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)=

> +{
> +    Qcow2BitmapInfoFlagsList *list =3D NULL;
> +    Qcow2BitmapInfoFlagsList **plist =3D &list;
> +
> +    if (flags & BME_FLAG_IN_USE) {
> +        Qcow2BitmapInfoFlagsList *entry =3D g_new0(Qcow2BitmapInfoFlag=
sList, 1);
> +        entry->value =3D QCOW2_BITMAP_INFO_FLAGS_IN_USE;
> +        *plist =3D entry;
> +        plist =3D &entry->next;

This line...

> +    }
> +    if (flags & BME_FLAG_AUTO) {
> +        Qcow2BitmapInfoFlagsList *entry =3D g_new0(Qcow2BitmapInfoFlag=
sList, 1);
> +        entry->value =3D QCOW2_BITMAP_INFO_FLAGS_AUTO;
> +        *plist =3D entry;
> +    }

=2E..is omitted here. Harmless for now, but may cause grief if a later
flag is added and we forget to add it in. On the other hand, I don't
know if a static analyzer might warn about a dead assignment, so
breaking the symmetry between the two is okay if that is the justificatio=
n.

Also, thinking about future flag additions, would it make any sense to
write this code in a for loop?  Something like (untested):

    static const struct Map {
        int bme;
        int info;
    } map[] =3D {
        { BME_FLAG_IN_USE, QCOW2_BITMAP_INFO_FLAGS_IN_USE },
        { BME_FLAG_AUTO,   QCOW2_BITMAP_INFO_FLAGS_AUTO },
    };

    for (i =3D 0; i < ARRAY_LENGTH(map); i++) {
        if (flags & map[i].bme) {
            ...; entry->value =3D map[i].info;
    }

where adding a new bit is now a one-liner change to the definition of
'map' rather than a 6-line addition of a new conditional.


> +##
> +# @Qcow2BitmapInfo:
> +#
> +# Qcow2 bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# @flags: flags of the bitmap
> +#
> +# @unknown-flags: unspecified flags if detected

Maybe:

@flags: recognized flags of the bitmap

@unknown-flags: any remaining flags not recognized by this qemu version


> +++ b/tests/qemu-iotests/060.out
> @@ -18,6 +18,7 @@ cluster_size: 65536
>  Format specific information:
>      compat: 1.1
>      lazy refcounts: false
> +    bitmaps:

Hmm. I'm wondering if the human-readable output of a QAPI type with an
optional array should output "<none>" or something similar for a
0-element array, to make it obvious to the human reading the output that
there are no bitmaps.  That's not necessarily a problem in your patch;
and may have even bigger effects to other iotests, so it should be done
as a separate patch if we want it.  But even in your patch, if we did
that,...

>      refcount bits: 16
>      corrupt: true
>  can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot =
be opened read/write
> diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
> index 8bac383..86406cb 100755
> --- a/tests/qemu-iotests/065
> +++ b/tests/qemu-iotests/065
> @@ -88,23 +88,23 @@ class TestQMP(TestImageInfoSpecific):
>  class TestQCow2(TestQemuImgInfo):
>      '''Testing a qcow2 version 2 image'''
>      img_options =3D 'compat=3D0.10'
> -    json_compare =3D { 'compat': '0.10', 'refcount-bits': 16 }
> -    human_compare =3D [ 'compat: 0.10', 'refcount bits: 16' ]
> +    json_compare =3D { 'compat': '0.10', 'bitmaps': [], 'refcount-bits=
': 16 }
> +    human_compare =3D [ 'compat: 0.10', 'bitmaps:', 'refcount bits: 16=
' ]

=2E..the human_compare dict would have to account for whatever string we
output for an empty JSON array.

I'm finding the functionality useful, though, so unless there are strong
opinions presented on making further tweaks, I'm also fine giving this
version as-is:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RM4jGOtcpqlZJxPZntg4ZxpO0Sg0SzyOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxPaY8ACgkQp6FrSiUn
Q2qi2AgAktY16lo3QBL6pqC75KCwmGWtunQCyXhgwSwylBmT9B88y047xafODj4r
FApx2Km5ITmveHM09oUJznGBNSjbLgAiDq769HuAKOQoMXsgxtSRJM90UT6VBGqJ
gzRTga/1ZY4dN83Tzb61jCHH8ed5tKqPxWGJ3AXQV+9Jl0Obuqv0+DY9CC45ZSa6
2drkvWIE0vbzvmuvg7Ma/HRR74VMD2OyARkwCrKs2GoGFZo+DH0oniBfujnDM8ZJ
gNsxucG6qTfxt9YwYOdUMrYTRk6NwiwMonIng8y+F54M/PWXp4DWrvk379y5f5DY
euWEPLtSxEkp7iU9jhhF+q0XZ3f1Zw==
=/B8x
-----END PGP SIGNATURE-----

--RM4jGOtcpqlZJxPZntg4ZxpO0Sg0SzyOf--
