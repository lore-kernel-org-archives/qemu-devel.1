Received: from eggs.gnu.org ([2001:4830:134:3::10]:32931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9bbi-00015c-Kb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9bbc-00013f-Fu
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:54:18 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-6-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <062515d2-1351-cbc1-50df-b196f631bf4e@redhat.com>
Date: Mon, 8 Oct 2018 21:54:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180817122219.16206-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2wuetlvp827AeHeSqBFUVFgPPOFV3x9UB"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] block/qcow2-refcount:
 check_refcounts_l2: split fix_l2_entry_to_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2wuetlvp827AeHeSqBFUVFgPPOFV3x9UB
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <062515d2-1351-cbc1-50df-b196f631bf4e@redhat.com>
Subject: Re: [PATCH v2 5/7] block/qcow2-refcount: check_refcounts_l2: split
 fix_l2_entry_to_zero
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
> Split entry repairing to separate function, to be reused later.
>=20
> Note: entry in in-memory l2 table (local variable in
> check_refcounts_l2) is not updated after this patch.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 147 ++++++++++++++++++++++++++++++++++++-----=
--------
>  1 file changed, 109 insertions(+), 38 deletions(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 3b057b635d..d9c8cd666b 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1554,6 +1554,99 @@ enum {
>      CHECK_FRAG_INFO =3D 0x2,      /* update BlockFragInfo counters */
>  };
> =20
> +/* Update entry in L1 or L2 table
> + *
> + * Returns: -errno if overlap check failed
> + *          0 if write failed
> + *          1 on success
> + */
> +static int write_table_entry(BlockDriverState *bs, const char *table_n=
ame,
> +                             uint64_t table_offset, int entry_index,
> +                             uint64_t new_val, int ign)
> +{
> +    int ret;
> +    uint64_t entry_offset =3D
> +            table_offset + (uint64_t)entry_index * sizeof(new_val);
> +
> +    cpu_to_be64s(&new_val);
> +    ret =3D qcow2_pre_write_overlap_check(bs, ign, entry_offset, sizeo=
f(new_val));
> +    if (ret < 0) {
> +        fprintf(stderr,
> +                "ERROR: Can't write %s table entry: overlap check fail=
ed: %s\n",

I recently complained to Berto that I don't like elisions ("can't") in
user interfaces, so I suppose I'll have to complain here, too, that I'd
prefer a "Cannot".

> +                table_name, strerror(-ret));
> +        return ret;
> +    }
> +
> +    ret =3D bdrv_pwrite_sync(bs->file, entry_offset, &new_val, sizeof(=
new_val));
> +    if (ret < 0) {
> +        fprintf(stderr, "ERROR: Failed to overwrite %s table entry: %s=
\n",
> +                table_name, strerror(-ret));
> +        return 0;
> +    }
> +
> +    return 1;
> +}
> +
> +/* Try to fix (if allowed) entry in L1 or L2 table. Update @res corres=
pondingly.
> + *
> + * Returns: -errno if overlap check failed
> + *          0 if entry was not updated for other reason
> + *            (fixing disabled or write failed)
> + *          1 on success
> + */
> +static int fix_table_entry(BlockDriverState *bs, BdrvCheckResult *res,=

> +                           BdrvCheckMode fix, const char *table_name,
> +                           uint64_t table_offset, int entry_index,
> +                           uint64_t new_val, int ign,
> +                           const char *fmt, va_list args)
> +{
> +    int ret;
> +
> +    fprintf(stderr, fix & BDRV_FIX_ERRORS ? "Repairing: " : "ERROR: ")=
;
> +    vfprintf(stderr, fmt, args);
> +    fprintf(stderr, "\n");

If you're just going to print this here, right at the start, I think it
would be better to just do it in the caller.

Sure, with this solution the caller safes an fprintf() call, but I find
it a bit over the top to start with vararg handling here when the caller
can just do an additional fprintf().

(Also, I actually find it clearer if you have to call two separate
functions.)

> +
> +    if (!(fix & BDRV_FIX_ERRORS)) {
> +        res->corruptions++;
> +        return 0;
> +    }
> +
> +    ret =3D write_table_entry(bs, table_name, table_offset, entry_inde=
x, new_val,
> +                            ign);
> +
> +    if (ret =3D=3D 1) {
> +        res->corruptions_fixed++;
> +    } else {
> +        res->check_errors++;
> +    }
> +
> +    return ret;
> +}
> +
> +/* Make L2 entry to be QCOW2_CLUSTER_ZERO_PLAIN
> + *
> + * Returns: -errno if overlap check failed
> + *          0 if write failed
> + *          1 on success
> + */
> +static int fix_l2_entry_to_zero(BlockDriverState *bs, BdrvCheckResult =
*res,
> +                                BdrvCheckMode fix, int64_t l2_offset,
> +                                int l2_index, bool active,
> +                                const char *fmt, ...)
> +{
> +    int ret;
> +    int ign =3D active ? QCOW2_OL_ACTIVE_L2 : QCOW2_OL_INACTIVE_L2;
> +    uint64_t l2_entry =3D QCOW_OFLAG_ZERO;
> +    va_list args;
> +
> +    va_start(args, fmt);
> +    ret =3D fix_table_entry(bs, res, fix, "L2", l2_offset, l2_index, l=
2_entry,
> +                          ign, fmt, args);
> +    va_end(args);
> +
> +    return ret;
> +}

If you drop the fprintf() from fix_table_entry(), this function will
make less sense as well.  Just calling fix_table_entry() directly will
be just as easy.

(Yes, I see that you use the function in patch 7 again, and yes, you'd
have to use a full line for the "active ?:" ternary, but still.)

Max


--2wuetlvp827AeHeSqBFUVFgPPOFV3x9UB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7td4ACgkQ9AfbAGHV
z0CffQgAlbHskOMQlE477ByoKgl1V/mWRq6hgNF3/0xL80WYaYwhT1MHAbAD+8qs
yDQmwXjygO6BQi2eFRp7E/XL3IhIyapRbypARF0e4tiA/eoICDHImnwdh6t5pfzk
hq01AZise0H0ycM0B0OOYv3cKRS3lUo1TBhA10logjnZUuonB79FEVjCKGBejrk5
AulEP0MnMS3+7In2yf0pFdd4o5NfRkUW+00Z7BjKOJXuyG4Qw6xw5Eb/Xjl4vHda
2K6lzPUIt02mWVKU1DLcSJvhaJjxeJULHDQrULxarZgSzkPyv1Mq/V9bgTGq45M4
M63KvVZkjcOCjQqN2rd43OO+XqlH3A==
=nlZu
-----END PGP SIGNATURE-----

--2wuetlvp827AeHeSqBFUVFgPPOFV3x9UB--
