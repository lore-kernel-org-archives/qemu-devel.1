Received: from eggs.gnu.org ([2001:4830:134:3::10]:53504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwW1y-0002Tp-5L
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwW1w-0007Yp-RX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:34 -0400
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-14-mreitz@redhat.com>
	<20170406130411.GK21895@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e27e13a7-c681-dbb1-8195-3ce0aa5fbd44@redhat.com>
Date: Fri, 7 Apr 2017 17:42:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170406130411.GK21895@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N9W142CMWS3A76JVSDjSUo5xjT7qUd6jE"
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N9W142CMWS3A76JVSDjSUo5xjT7qUd6jE
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <e27e13a7-c681-dbb1-8195-3ce0aa5fbd44@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 for-2.10 13/16] block/qcow2:
 qcow2_calc_size_usage() for truncate
References: <20170403160936.28293-1-mreitz@redhat.com>
 <20170403160936.28293-14-mreitz@redhat.com>
 <20170406130411.GK21895@stefanha-x1.localdomain>
In-Reply-To: <20170406130411.GK21895@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06.04.2017 15:04, Stefan Hajnoczi wrote:
> On Mon, Apr 03, 2017 at 06:09:33PM +0200, Max Reitz wrote:
>> +        BDRVQcow2State *s =3D bs->opaque;
>> +        uint64_t aligned_cur_size =3D align_offset(current_size, clus=
ter_size);
>> +        uint64_t creftable_length;
>> +        uint64_t i;
>> +
>> +        /* new total size of L2 tables */
>> +        nl2e =3D aligned_total_size / cluster_size;
>> +        nl2e =3D align_offset(nl2e, cluster_size / sizeof(uint64_t));=

>> +        meta_size +=3D nl2e * sizeof(uint64_t);
>> +
>> +        /* Subtract L2 tables which are already present */
>> +        for (i =3D 0; i < s->l1_size; i++) {
>> +            if (s->l1_table[i] & L1E_OFFSET_MASK) {
>> +                meta_size -=3D cluster_size;
>> +            }
>> +        }
>=20
> Allocated L1 table entries are 'A', unallocated L1 table entries in
> the existing image are '-', and new L1 table entries after growth are
> '+':
>=20
>   |-A-AAA--+++++|
>=20
> This for loop includes '-' entries.  Should we count them or just the
> '+' entries?

Hm, good question, thanks. I suppose we should count them if we wanted
to fully allocate the image now. But that's not the intention, we just
want to fully allocate the new area.

While you can make the calculation faster if you take that into account,
it also gets a bit more complicated: We can subtract all L2 tables that
do not point to the new area. But there may be L2 tables already which
do point there which we therefore do not have to allocate. So we'd still
need to do this loop, but the starting index would be the first L2 table
index to point into the area.

So the above loop may calculate more space to be required than actually
is the case; I could argue that's fine because this function may
overcommit (especially if the image wasn't fully allocated before). But
modifying it to ignore all L2 tables before the new area doesn't seem to
be too complicated, so I'll do it.

>> -    /* total size of refcount tables */
>> -    nreftablee =3D nrefblocke / refblock_size;
>> -    nreftablee =3D align_offset(nreftablee, cluster_size / sizeof(uin=
t64_t));
>> -    meta_size +=3D nreftablee * sizeof(uint64_t);
>> +        /* Do not add L1 table size because the only caller of this p=
ath
>> +         * (qcow2_truncate) has increased its size already. */
>> =20
>> -    return aligned_total_size + meta_size;
>> +        /* Calculate size of the additional refblocks (this assumes t=
hat all of
>> +         * the existing image is covered by refblocks, which is extre=
mely
>> +         * likely); this may result in overallocation because parts o=
f the newly
>> +         * added space may be covered by existing refblocks, but that=
 is fine.
>> +         *
>> +         * This only considers the newly added space. Since we cannot=
 update the
>> +         * reftable in-place, we will have to able to store both the =
old and the
>> +         * new one at the same time, though. Therefore, we need to ad=
d the size
>> +         * of the old reftable here.
>> +         */
>> +        creftable_length =3D ROUND_UP(s->refcount_table_size * sizeof=
(uint64_t),
>> +                                    cluster_size);
>> +        nrefblocke =3D ((aligned_total_size - aligned_cur_size) + met=
a_size +
>> +                      creftable_length + cluster_size)
>> +                   / (cluster_size - rces -
>> +                      rces * sizeof(uint64_t) / cluster_size);
>> +        meta_size +=3D DIV_ROUND_UP(nrefblocke, refblock_size) * clus=
ter_size;
>> +
>> +        /* total size of the new refcount table (again, may be too mu=
ch because
>> +         * it assumes that the new area is not covered by any refcoun=
t blocks
>> +         * yet) */
>> +        nreftablee =3D s->max_refcount_table_index + 1 +
>> +                     nrefblocke / refblock_size;
>> +        nreftablee =3D align_offset(nreftablee, cluster_size / sizeof=
(uint64_t));
>> +        meta_size +=3D nreftablee * sizeof(uint64_t);
>> +
>> +        return (aligned_total_size - aligned_cur_size) + meta_size;
>=20
> This calculation is an approximation.  Here is a simpler approximation:=

>=20
>   current_usage =3D qcow2_calc_size_usage(current_size, ...);
>   new_usage =3D qcow2_calc_size_usage(new_size, ...);
>   delta =3D new_usage - current_usage;
>=20
> (Perhaps the new refcount_table clusters need to be added to new_size
> too.)
>=20
> Is there an advantage of the more elaborate calculation implemented in
> this patch?

Now that you mention it... Well, the important thing is it's a
conservative approximation. It's supposed to never underestimate the
correct result.

Now the existing image doesn't need to be fully allocated. However, your
snippet assumes that it is. Often, this actually wouldn't be an issue.
But it is for clusters that are "shared" between the existing image and
the new area:

1. The old final L2 table may point into the new area. Your code assumes
it is already present but it may not be.

2. current_size need not be aligned to clusters. If it isn't, the new
area will reuse a data cluster from the existing image that now needs to
be allocated.

3. Theoretically: The L1 table may be not be actually allocated. We have
to make sure it is.

In practice: We call qcow2_grow_l1_table() before doing any
preallocation, and that always fully allocates the (new) L1 table. So
we're good.

4. Of course, just as always, it gets *very* funny with refcount
information. Maybe the existing image is sparsely allocated in a way
that its allocated cluster count is aligned to refblocks so that it
completely fills up all the refblocks it has (and those completely fill
up, say, one reftable cluster). Now the calculation above might assume
that we have more allocated clusters and therefore enough free entries
in the last refblock to put everything there. But when actually doing
the allocation... Surprise, you need to allocate one new refblock and a
hole new reftable because that new refblock doesn't fit into the old one.=


So if I implemented your snippet and wanted to keep conservative, I'd
have to add the following cluster counts for each of these:

1. 1
2. 1
3. --
4. 1 (refblock) + number of existing reftable clusters + 1 (resized
reftable)

So this is not really good. We could add checks so we keep the count lowe=
r:

1. Check whether current_size is aligned to L2 boundaries. If it isn't,
check whether the final L2 table is allocated. If it isn't, add 1.
2. Check whether current_size is aligned to clusters. If it isn't, check
whether the final cluster is allocated. If it isn't, add 1.
4. Errr... This seems hard (like all refcount stuff). Maybe check
whether the super-conservative estimate above would fit into the last
refblock, if it does, add 0; otherwise, add
$number_of_refblocks_required plus the number of reftable clusters
required for that, however we can calculate that[1].

[1]: This brings me to another issue. When we have to resize the
reftable, we create a copy, so we have to be able to store both the old
and the new reftable at the same time. Your above snippet doesn't take
this into account, so we'll have to add the number of existing reftable
clusters to it; unless we don't have to resize the reftable...


So all in all we could either use your snippet in a super-conservative
approach, or we get probably the same complexity as I already have if we
add all of the checks proposed above.

The issue with the "super-conservative approach" is that I'm not even
sure I found all possible corner cases.

Max


--N9W142CMWS3A76JVSDjSUo5xjT7qUd6jE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljns1gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApVAH/1k+VfP6OSaaMNxIbZV0rFHZ8j0362E0
wHubqIzbR3WTPOynF8pxp4eKuOd9CzdsYMcKW7oQjpbtG4RA5PLb1Kegz0UM2OEh
x8UhE7VWwsPNlw00Tw0Y6ZhREslakAOXpiDcKySxvk0zNT7db+9OKyQOHhLQ+BPP
AJy9AgUfpW2J9QRGygPzci7Wi3fhtsiJ0uxyyVgaScJcn0SPai8S+ALOZd7LS3bf
uPsmXGK8vlaiG9GhM0S0H5aOAM0vitnAIXKCyaxwBq6aR6M070Inaw6Pzw/JAFtH
X0n8Ahe7XlvSt47x7cpJeRE0lKNxa/YblFpBBlnuF2YMXb3lI7oQAWA=
=rqea
-----END PGP SIGNATURE-----

--N9W142CMWS3A76JVSDjSUo5xjT7qUd6jE--
