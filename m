Received: from eggs.gnu.org ([209.51.188.92]:50185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gouXX-0003fK-BG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gouXW-0006Fp-7d
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:24:47 -0500
References: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548870690-647481-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a2aa062-6b7c-91cc-650a-74a4d47b4bc3@redhat.com>
Date: Wed, 30 Jan 2019 12:24:40 -0600
MIME-Version: 1.0
In-Reply-To: <1548870690-647481-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DSarENCzFQpPfddJAhtkK4iBii0l6M0S0"
Subject: Re: [Qemu-devel] [PATCH v10 2/3] qemu-img info lists bitmap
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
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DSarENCzFQpPfddJAhtkK4iBii0l6M0S0
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <0a2aa062-6b7c-91cc-650a-74a4d47b4bc3@redhat.com>
Subject: Re: [PATCH v10 2/3] qemu-img info lists bitmap directory entries
References: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548870690-647481-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548870690-647481-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 11:51 AM, Andrey Shinkevich wrote:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
>=20

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
> +
> +    for (i =3D 0; i < map_size; ++i) {
> +        if (flags & map[i].bme) {
> +            Qcow2BitmapInfoFlagsList *entry =3D
> +                g_new0(Qcow2BitmapInfoFlagsList, 1);
> +            entry->value =3D map[i].info;
> +            *plist =3D entry;
> +            plist =3D &entry->next;

Here's an idea for having runtime verification that our mapping of BME_
flags to QAPI flags is complete. At the spots marked [1], add:

flags &=3D ~map[i].bme;

> +        }
> +    }
> +
> +    *plist =3D NULL;

Dead assignment. plist is originally pointing to list (which was
NULL-initialized at declaration), and is only ever changed to point to
the list's next entry->next (which were NULL-initialized thanks to g_new0=
).

[1]
assert(!flags);

> +
> +    return list;
> +}
> +
> +/*
> + * qcow2_get_bitmap_info_list()
> + * Returns a list of QCOW2 bitmap details.
> + * In case of no bitmaps, the function returns NULL and
> + * the @errp parameter is not set (for a 0-length list in the QMP).
> + * When bitmap information can not be obtained, the function returns
> + * NULL and the @errp parameter is set (for omitting the list in QMP).=


Comment is a bit stale, now that we aren't going to omit the list in
QMP, but instead fail the QMP command outright.

> + */
> +Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
> +                                                Error **errp)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2BitmapList *bm_list;
> +    Qcow2Bitmap *bm;
> +    Qcow2BitmapInfoList *list =3D NULL;
> +    Qcow2BitmapInfoList **plist =3D &list;
> +
> +    if (s->nb_bitmaps =3D=3D 0) {
> +        return NULL;
> +    }
> +
> +    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);
> +    if (bm_list =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +        Qcow2BitmapInfo *info =3D g_new0(Qcow2BitmapInfo, 1);
> +        Qcow2BitmapInfoList *obj =3D g_new0(Qcow2BitmapInfoList, 1);
> +        info->granularity =3D 1U << bm->granularity_bits;
> +        info->name =3D g_strdup(bm->name);
> +        info->flags =3D get_bitmap_info_flags(bm->flags);

[1]
get_bitmap_info_flags(bm->flags & ~BME_RESERVED_FLAGS)

> +        info->unknown_flags =3D bm->flags & BME_RESERVED_FLAGS;
> +        info->has_unknown_flags =3D !!info->unknown_flags;
> +        obj->value =3D info;
> +        *plist =3D obj;
> +        plist =3D &obj->next;
> +    }
> +
> +    bitmap_list_free(bm_list);
> +
> +    return list;
> +}
> +
>  int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_up=
dated,
>                                   Error **errp)
>  {
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 27e5a2c..4824ca8 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4394,6 +4394,14 @@ static ImageInfoSpecific *qcow2_get_specific_inf=
o(BlockDriverState *bs,
>              .refcount_bits      =3D s->refcount_bits,
>          };
>      } else if (s->qcow_version =3D=3D 3) {
> +        Qcow2BitmapInfoList *bitmaps;
> +        bitmaps =3D qcow2_get_bitmap_info_list(bs, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            g_free(spec_info->u.qcow2.data);
> +            g_free(spec_info);

I think it is cleaner to use qapi_free_ImageInfoSpecific(spec_info),
which takes care of recursion without you having to analyze whether two
g_free() calls are sufficient.  Of course, for THAT to work, we need to
fix the line above that does:

=2Eu.qcow2.data =3D g_new(ImageInfoSpecificQCow2, 1),

to instead use g_new0(), since recursive freeing of uninitialized data
is not a good idea (without your patch, g_new() was sufficient since all
paths through the code either fully initialize or assert).  So maybe
your patch is the shortest that works, after all.


> +##
> +# @Qcow2BitmapInfo:
> +#
> +# Qcow2 bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# @flags: recognized flags of the bitmap
> +#
> +# @unknown-flags: any remaining flags not recognized by the current qe=
mu version
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'Qcow2BitmapInfo',
> +  'data': {'name': 'str', 'granularity': 'uint32',
> +           'flags': ['Qcow2BitmapInfoFlags'],
> +           '*unknown-flags': 'uint32' } }

Not for this patch, but how hard would it be to add a field showing the
number of set bits in the bitmap?

Kevin's insistence that a failure to read bitmap headers should fail the
overall 'qemu-img info' (on the grounds that we're going to have
problems using the image anyways) is reasonable enough; thanks for
putting up with competing demands (such as my earlier ideas of how best
to ignore read failures while still reporting as much remaining useful
information as possible), even if it has taken us through v10 to get to
a consensus on the semantics we want to support.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--DSarENCzFQpPfddJAhtkK4iBii0l6M0S0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxR6+gACgkQp6FrSiUn
Q2qlewf9FgmotkZj1zewW/AoEQykNfwfSyU/behhBIGljsQ3jsofxQ0AsRkY5HFX
De3ac0nKwuM0VuOoe+bHbF+/pg1IMx8O23ng66xUadrnd7WT9A5ptYjBQ44JJiiq
0Qo0vwHqLJvU53uhO1VLMds4ThiQekkGA0U92AGi6OQv2zwFyUtFAvA4H5mUldNO
IR9qTpBcd+FP8siO3VxEJS4nY0t1IoKouLxFnqXwyUclkEOlm+qqyWfL08l9gpQa
FcLFiW6HG2qc+7oJFweEC4Q/J78dqgaLUw3qVaRT9h0oPIkquS1Tj+t0Db6nchbv
kfWN/c5cT8xau02T7Z084bRcvmmesw==
=X+uC
-----END PGP SIGNATURE-----

--DSarENCzFQpPfddJAhtkK4iBii0l6M0S0--
