Received: from eggs.gnu.org ([2001:4830:134:3::10]:51834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwTCn-0001DF-To
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwTCm-0005Ve-HB
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:41:33 -0400
Date: Fri, 7 Apr 2017 14:41:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170407124121.GC4716@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.04.2017 um 18:40 hat Eric Blake geschrieben:
> On 04/06/2017 10:01 AM, Alberto Garcia wrote:
> > I thought of three alternatives for storing the subcluster bitmaps. I
> > haven't made my mind completely about which one is the best one, so
> > I'd like to present all three for discussion. Here they are:
> >=20
> > (1) Storing the bitmap inside the 64-bit entry
> >=20
> >     This is a simple alternative and is the one that I chose for my
> >     prototype. There are 14 unused bits plus the "all zeroes" one. If
> >     we steal one from the host offset we have the 16 bits that we need
> >     for the bitmap and we have 46 bits left for the host offset, which
> >     is more than enough.
>=20
> Note that because you are using exactly 8 subclusters, you can require
> that the minimum cluster size when subclusters are enabled be 4k (since
> we already have a lower-limit of 512-byte sector operation, and don't
> want subclusters to be smaller than that); at which case you are
> guaranteed that the host cluster offset will be 4k aligned.  So in
> reality, once you turn on subclusters, you have:
>=20
> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> **<----> <-----------------------------------------------><---------->*
>   Rsrved              host cluster offset of data             Reserved
>   (6 bits)                (44 bits)                           (11 bits)
>=20
> where you have 17 bits plus the "all zeroes" bit to play with, thanks to
> the three bits of host cluster offset that are now guaranteed to be zero
> due to cluster size alignment (but you're also right that the "all
> zeroes" bit is now redundant information with the 8 subcluster-is-zero
> bits, so repurposing it does not hurt)
>=20
> >=20
> >     * Pros:
> >       + Simple. Few changes compared to the current qcow2 format.
> >=20
> >     * Cons:
> >       - Only 8 subclusters per cluster. We would not be making the
> >         most of this feature.
> >=20
> >       - No reserved bits left for the future.
>=20
> I just argued you have at least one, and probably 2, bits left over for
> future in-word expansion.

I think only 8 subclusters is just too few. That the subcluster status
would be split in two halves doesn't make me like this layout much
better either.

Intuitively one might think that squeezing everything into the existing
data structures will save us memory, but as you correctly state below,
the difference between 8 and 32 subclusters means that we can use a
larger cluster size and the doubled L2 entry size uses actually less
space to cover the whole image than using the existing one.

I can see how few changes compared to the current format can look
attractive, but I also think that there is a danger of forgetting to
support subclusters in some place. When the layout is radically
different, such mistakes would be caught very quickly, so maybe being
more different is actually a plus.

> >=20
> > (2) Making L2 entries 128-bit wide.
> >=20
> >     In this alternative we would double the size of L2 entries. The
> >     first half would remain unchanged and the second one would store
> >     the bitmap. That would leave us with 32 subclusters per cluster.
>=20
> Although for smaller cluster sizes (such as 4k clusters), you'd still
> want to restrict that subclusters are at least 512-byte sectors, so
> you'd be using fewer than 32 of those subcluster positions until the
> cluster size is large enough.
>=20
> >=20
> >     * Pros:
> >       + More subclusters per cluster. We could have images with
> >         e.g. 128k clusters with 4k subclusters.
>=20
> Could allow variable-sized subclusters (your choice of 32 subclusters of
> 4k each, or 16 subclusters of 8k each)

I don't think using less subclusters is desirable if it doesn't come
with savings elsewhere. We already need to allocate two clusters for an
L2 table now, so we want to use it.

The more interesting kind of variable-sized subclusters would be if you
could select any multiple of 32, meaning three or more clusters per L2
table (with 192 bits or more per entry).

I'm doubtful if this would be worth the effort, though.

> >=20
> >     * Cons:
> >       - More space needed for L2 entries. The same cluster size would
> >         require a cache twice as large, although having subcluster
> >         allocation would compensate for this.
> >=20
> >       - More changes to the code to handle 128-bit entries.
>=20
> Dealing with variable-sized subclusters, or with unused subclsuster
> entries when the cluster size is too small (such as a 4k cluster should
> not be allowed any subclusters smaller than 512 bytes, but that's at
> most 8 out of the 32 slots available), can get tricky.

If it's too tricky, we just don't allow it. 32 * 512 =3D 16k would be the
minimal cluster size that allows enabling subclusters.

> >=20
> >       - We would still be wasting the 14 reserved bits that L2 entries
> >         have.

We discussed the concept of subclusters multiple times in the past, and
I think every time my conclusion was that option (2) is really what we
want if we implement this.

> > (3) Storing the bitmap somewhere else
> >=20
> >     This would involve storing the bitmap separate from the L2 tables
> >     (perhaps using the bitmaps extension? I haven't looked much into
> >     this).
> >=20
> >     * Pros:
> >       + Possibility to make the number of subclusters configurable
> >         by the user (32, 64, 128, ...)
> >       + All existing metadata structures would remain untouched
> >         (although the "all zeroes" bit in L2 entries would probably
> >         become unused).
>=20
> It might still remain useful for optimization purposes, although then we
> get into image consistency questions (if the all zeroes bit is set but
> subcluster map claims allocation, or if the all zeroes bit is clear but
> all subclusters claim zero, which one wins).
>=20
> >=20
> >     * Cons:
> >       - As with alternative (2), more space needed for metadata.
> >=20
> >       - The bitmap would also need to be cached for performance
> >         reasons.
> >=20
> >       - Possibly one more *_cache_size option.
> >=20
> >       - One more metadata structure to be updated for each
> >         allocation. This would probably impact I/O negatively.
>=20
> Having the subcluster table directly in the L2 means that updating the
> L2 table is done with a single write. You are definitely right that
> having the subcluster table as a bitmap in a separate cluster means two
> writes instead of one, but as always, it's hard to predict how much of
> an impact that is without benchmarks.

Note that it's not just additional write requests, but that we can't
update the L2 table entry and the bitmap atomically any more, so we have
to worry about ordering. The ordering between L2 table and refcount
blocks is already painful enough, I'm not sure if I would want to add a
third type. Ordering also means disk flushes, which are a lot slower
than just additional writes.

We wouldn't have these ordering problems with a journal (because we
could then commit things atomically), but I suppose we don't want to
make two major changes at once. :-)

> > =3D=3D=3D Compressed clusters =3D=3D=3D
> >=20
> > My idea is that compressed clusters would remain the same. They are
> > read-only anyway so they would not be affected by any of these
> > changes.

Yes, this makes sense to me. Compression already uses its own kind of
splitting clusters.

Kevin

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY54jxAAoJEH8JsnLIjy/WHksP/ieWs22XRWx4vN0WAY+J2Dv5
bQZ1m+gRpCi4kDogkBDCNPyPkkHBFyx4/I8NiW7btt/pAiYdW2Iz/kWGvNETH+In
Q3AMTElSl/Rx/7YFS7xcFjeCU2VAptp1W41ETIxN3FRrbty5WAWS5RqGntU3UK5K
xF3ehQ/y20HGdzmfsqzO0cYwrHLCA0ZWCOToFjevf5+0RW9WTqODvc+ODdVZWdrH
hJDBiHbDFs8PZsbaJIHx78gOMVAB766C2jhyf0BXKRRL4rK/6AbbR2Xgh1BjQ+aZ
4oFCC3ryZcB0sbE6vfE7hYurUJxbznEx9N2aXMFfThTx0YxApM0O7Ohf2dGNkdb9
4B2wTpkU9TQ01nrHaz1o6/TRWrtVqz+1Ftg1fmOVtm9NvGEbWVhALip2wk9W2WxI
gJ/x17DTeFe0KTa9LBOSv8Q7/2iN/wExUL7ekMOzSEnd1e4ZTjkR0NLPNpPWcg6l
WWlcjUSEqc1hgPOgeI4Tsw2lHemIrAoCilEblAHPuAzx0u7/odRCTeyNvu29PUw2
H8E2xjUmReUMVwVFPbqXaeYm3EBS0MR3hd9JQNzN0fn8Mqo7JAgcXYu4lSSdikSB
vBPuLHljMI1v3dKq9dIHxDmxNDoOQkKCXYtQ7ZOPrnrwNOogrHMPJMgnwRuFQwvh
QC6Abo2OWYBLGNep8YCl
=eqm0
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
