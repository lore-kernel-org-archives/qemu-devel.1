Received: from eggs.gnu.org ([2001:4830:134:3::10]:48539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw75K-0002rM-Ce
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw75J-00059L-7Q
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:04:22 -0400
Date: Thu, 6 Apr 2017 14:04:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406130411.GK21895@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-14-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
Content-Disposition: inline
In-Reply-To: <20170403160936.28293-14-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 for-2.10 13/16]
 block/qcow2: qcow2_calc_size_usage() for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 06:09:33PM +0200, Max Reitz wrote:
> +        BDRVQcow2State *s =3D bs->opaque;
> +        uint64_t aligned_cur_size =3D align_offset(current_size, cluster=
_size);
> +        uint64_t creftable_length;
> +        uint64_t i;
> +
> +        /* new total size of L2 tables */
> +        nl2e =3D aligned_total_size / cluster_size;
> +        nl2e =3D align_offset(nl2e, cluster_size / sizeof(uint64_t));
> +        meta_size +=3D nl2e * sizeof(uint64_t);
> +
> +        /* Subtract L2 tables which are already present */
> +        for (i =3D 0; i < s->l1_size; i++) {
> +            if (s->l1_table[i] & L1E_OFFSET_MASK) {
> +                meta_size -=3D cluster_size;
> +            }
> +        }

Allocated L1 table entries are 'A', unallocated L1 table entries in
the existing image are '-', and new L1 table entries after growth are
'+':

  |-A-AAA--+++++|

This for loop includes '-' entries.  Should we count them or just the
'+' entries?

> =20
> -    /* total size of refcount tables */
> -    nreftablee =3D nrefblocke / refblock_size;
> -    nreftablee =3D align_offset(nreftablee, cluster_size / sizeof(uint64=
_t));
> -    meta_size +=3D nreftablee * sizeof(uint64_t);
> +        /* Do not add L1 table size because the only caller of this path
> +         * (qcow2_truncate) has increased its size already. */
> =20
> -    return aligned_total_size + meta_size;
> +        /* Calculate size of the additional refblocks (this assumes that=
 all of
> +         * the existing image is covered by refblocks, which is extremely
> +         * likely); this may result in overallocation because parts of t=
he newly
> +         * added space may be covered by existing refblocks, but that is=
 fine.
> +         *
> +         * This only considers the newly added space. Since we cannot up=
date the
> +         * reftable in-place, we will have to able to store both the old=
 and the
> +         * new one at the same time, though. Therefore, we need to add t=
he size
> +         * of the old reftable here.
> +         */
> +        creftable_length =3D ROUND_UP(s->refcount_table_size * sizeof(ui=
nt64_t),
> +                                    cluster_size);
> +        nrefblocke =3D ((aligned_total_size - aligned_cur_size) + meta_s=
ize +
> +                      creftable_length + cluster_size)
> +                   / (cluster_size - rces -
> +                      rces * sizeof(uint64_t) / cluster_size);
> +        meta_size +=3D DIV_ROUND_UP(nrefblocke, refblock_size) * cluster=
_size;
> +
> +        /* total size of the new refcount table (again, may be too much =
because
> +         * it assumes that the new area is not covered by any refcount b=
locks
> +         * yet) */
> +        nreftablee =3D s->max_refcount_table_index + 1 +
> +                     nrefblocke / refblock_size;
> +        nreftablee =3D align_offset(nreftablee, cluster_size / sizeof(ui=
nt64_t));
> +        meta_size +=3D nreftablee * sizeof(uint64_t);
> +
> +        return (aligned_total_size - aligned_cur_size) + meta_size;

This calculation is an approximation.  Here is a simpler approximation:

  current_usage =3D qcow2_calc_size_usage(current_size, ...);
  new_usage =3D qcow2_calc_size_usage(new_size, ...);
  delta =3D new_usage - current_usage;

(Perhaps the new refcount_table clusters need to be added to new_size
too.)

Is there an advantage of the more elaborate calculation implemented in
this patch?

Stefan

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5jzLAAoJEJykq7OBq3PI4N0H/21+5nolHi8SdFzKxXSp55YG
ALKfLGj/JV31F187EBsqVrdQfJbap0hfzXITS8PbCJKRQNF8BuKZ928LqYV4m/Rx
EU+Tes1X1c8xbd3EX0FFLQEtTvPHD5i0MkTNAg0xjxlk4SfuL07FGBoigbPLZfcA
hQAfeEHvfR/YJ1MJmZCgSO7SO6ZMo0X0VkbvzeQsJKqMJGfUj1XsNfFEvTMMWhtz
NZttakhcLnyk6E8V81Nfm/wlEt6oajzsov1eDeW2JeJn+B/FrtByq2sJHBx7ory2
/8A/0+c+Yv8CcVDQTPBJpDQ8NPH9Rtfzfa5L2PhSJw1niaAeinZu9Ex59E2Iyac=
=M2xm
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--
