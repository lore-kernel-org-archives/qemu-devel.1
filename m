Received: from eggs.gnu.org ([2001:4830:134:3::10]:44127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxW6u-0004AZ-Qr
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxW6t-0001ZF-GQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:59:48 -0400
Date: Mon, 10 Apr 2017 10:59:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410095934.GN2567@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-14-mreitz@redhat.com>
	<20170406130411.GK21895@stefanha-x1.localdomain>
	<e27e13a7-c681-dbb1-8195-3ce0aa5fbd44@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline
In-Reply-To: <e27e13a7-c681-dbb1-8195-3ce0aa5fbd44@redhat.com>
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


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 05:42:16PM +0200, Max Reitz wrote:
> On 06.04.2017 15:04, Stefan Hajnoczi wrote:
> > On Mon, Apr 03, 2017 at 06:09:33PM +0200, Max Reitz wrote:
> >> -    /* total size of refcount tables */
> >> -    nreftablee =3D nrefblocke / refblock_size;
> >> -    nreftablee =3D align_offset(nreftablee, cluster_size / sizeof(uin=
t64_t));
> >> -    meta_size +=3D nreftablee * sizeof(uint64_t);
> >> +        /* Do not add L1 table size because the only caller of this p=
ath
> >> +         * (qcow2_truncate) has increased its size already. */
> >> =20
> >> -    return aligned_total_size + meta_size;
> >> +        /* Calculate size of the additional refblocks (this assumes t=
hat all of
> >> +         * the existing image is covered by refblocks, which is extre=
mely
> >> +         * likely); this may result in overallocation because parts o=
f the newly
> >> +         * added space may be covered by existing refblocks, but that=
 is fine.
> >> +         *
> >> +         * This only considers the newly added space. Since we cannot=
 update the
> >> +         * reftable in-place, we will have to able to store both the =
old and the
> >> +         * new one at the same time, though. Therefore, we need to ad=
d the size
> >> +         * of the old reftable here.
> >> +         */
> >> +        creftable_length =3D ROUND_UP(s->refcount_table_size * sizeof=
(uint64_t),
> >> +                                    cluster_size);
> >> +        nrefblocke =3D ((aligned_total_size - aligned_cur_size) + met=
a_size +
> >> +                      creftable_length + cluster_size)
> >> +                   / (cluster_size - rces -
> >> +                      rces * sizeof(uint64_t) / cluster_size);
> >> +        meta_size +=3D DIV_ROUND_UP(nrefblocke, refblock_size) * clus=
ter_size;
> >> +
> >> +        /* total size of the new refcount table (again, may be too mu=
ch because
> >> +         * it assumes that the new area is not covered by any refcoun=
t blocks
> >> +         * yet) */
> >> +        nreftablee =3D s->max_refcount_table_index + 1 +
> >> +                     nrefblocke / refblock_size;
> >> +        nreftablee =3D align_offset(nreftablee, cluster_size / sizeof=
(uint64_t));
> >> +        meta_size +=3D nreftablee * sizeof(uint64_t);
> >> +
> >> +        return (aligned_total_size - aligned_cur_size) + meta_size;
> >=20
> > This calculation is an approximation.  Here is a simpler approximation:
> >=20
> >   current_usage =3D qcow2_calc_size_usage(current_size, ...);
> >   new_usage =3D qcow2_calc_size_usage(new_size, ...);
> >   delta =3D new_usage - current_usage;
> >=20
> > (Perhaps the new refcount_table clusters need to be added to new_size
> > too.)
> >=20
> > Is there an advantage of the more elaborate calculation implemented in
> > this patch?
>=20
> Now that you mention it... Well, the important thing is it's a
> conservative approximation. It's supposed to never underestimate the
> correct result.
>=20
> Now the existing image doesn't need to be fully allocated. However, your
> snippet assumes that it is. Often, this actually wouldn't be an issue.
> But it is for clusters that are "shared" between the existing image and
> the new area:
>=20
> 1. The old final L2 table may point into the new area. Your code assumes
> it is already present but it may not be.
>=20
> 2. current_size need not be aligned to clusters. If it isn't, the new
> area will reuse a data cluster from the existing image that now needs to
> be allocated.
>=20
> 3. Theoretically: The L1 table may be not be actually allocated. We have
> to make sure it is.
>=20
> In practice: We call qcow2_grow_l1_table() before doing any
> preallocation, and that always fully allocates the (new) L1 table. So
> we're good.
>=20
> 4. Of course, just as always, it gets *very* funny with refcount
> information. Maybe the existing image is sparsely allocated in a way
> that its allocated cluster count is aligned to refblocks so that it
> completely fills up all the refblocks it has (and those completely fill
> up, say, one reftable cluster). Now the calculation above might assume
> that we have more allocated clusters and therefore enough free entries
> in the last refblock to put everything there. But when actually doing
> the allocation... Surprise, you need to allocate one new refblock and a
> hole new reftable because that new refblock doesn't fit into the old one.
>=20
> So if I implemented your snippet and wanted to keep conservative, I'd
> have to add the following cluster counts for each of these:
>=20
> 1. 1
> 2. 1
> 3. --
> 4. 1 (refblock) + number of existing reftable clusters + 1 (resized
> reftable)
>=20
> So this is not really good. We could add checks so we keep the count lowe=
r:
>=20
> 1. Check whether current_size is aligned to L2 boundaries. If it isn't,
> check whether the final L2 table is allocated. If it isn't, add 1.
> 2. Check whether current_size is aligned to clusters. If it isn't, check
> whether the final cluster is allocated. If it isn't, add 1.
> 4. Errr... This seems hard (like all refcount stuff). Maybe check
> whether the super-conservative estimate above would fit into the last
> refblock, if it does, add 0; otherwise, add
> $number_of_refblocks_required plus the number of reftable clusters
> required for that, however we can calculate that[1].
>=20
> [1]: This brings me to another issue. When we have to resize the
> reftable, we create a copy, so we have to be able to store both the old
> and the new reftable at the same time. Your above snippet doesn't take
> this into account, so we'll have to add the number of existing reftable
> clusters to it; unless we don't have to resize the reftable...
>=20
>=20
> So all in all we could either use your snippet in a super-conservative
> approach, or we get probably the same complexity as I already have if we
> add all of the checks proposed above.
>=20
> The issue with the "super-conservative approach" is that I'm not even
> sure I found all possible corner cases.

Good points.  Calculating a conservative number really does require
detailed knowledge of the metadata state.

Stefan

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61eGAAoJEJykq7OBq3PIekkIAJIVYy6Y+DSdh1KtEK7r9HAu
ru45tjAgs9cILj33DGQDlD/TFyn0gzB24niNzA3doYUN48cLFZCJLzAjhp/yA9es
AwdE6Qnn5rVVQCJwpyEldl0HqblVinWxNCtTonrVFf9xGd/vhKTU9U1YUn+fPDOC
UejP76fkiRkJrvfgBs5uitlpLbaWzabpgk5hF0dTM1wtgw3V3IK9Q4l48PdHvLPR
G5QIeqya7rNcuLhHh4c6LmUQwmIHIJF9cYiHL8uzyfdgnNQKSw5orpivhKyjrBKo
JdXVbSWj6NZnz8OxF8Ep+bTytA2N4xt1VdEPcngeQeogat7v82gXk/kdmwklPZw=
=ZvY6
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
