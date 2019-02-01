Received: from eggs.gnu.org ([209.51.188.92]:44266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpc4f-0004yN-Rq
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpc4e-0008R6-DZ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:53:53 -0500
Date: Fri, 1 Feb 2019 17:53:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201165340.GH5730@localhost.localdomain>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-2-kwolf@redhat.com>
	<d887367f-053e-6541-a6d7-cc84b23db841@redhat.com>
	<20190201102149.GA5730@localhost.localdomain>
	<6b5f8c4a-68de-d0ec-bb47-678fce46960d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <6b5f8c4a-68de-d0ec-bb47-678fce46960d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 01/11] qcow2: Extend spec for external
 data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.02.2019 um 17:17 hat Eric Blake geschrieben:
> On 2/1/19 4:21 AM, Kevin Wolf wrote:
> > Am 31.01.2019 um 19:43 hat Eric Blake geschrieben:
> >> On 1/31/19 11:55 AM, Kevin Wolf wrote:
> >>> This adds external data file to the qcow2 spec as a new incompatible
> >>> feature.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  docs/interop/qcow2.txt | 19 ++++++++++++++++---
> >>>  1 file changed, 16 insertions(+), 3 deletions(-)
> >>>
> >>
> >>> @@ -148,6 +158,7 @@ be stored. Each extension has a structure like th=
e following:
> >>>                          0x6803f857 - Feature name table
> >>>                          0x23852875 - Bitmaps extension
> >>>                          0x0537be77 - Full disk encryption header poi=
nter
> >>> +                        0x44415441 - External data file name
> >>>                          other      - Unknown header extension, can b=
e safely
> >>>                                       ignored
> >>
> >> Missing a section describing the new header.
> >=20
> > The header extension that have a separate section are those that contain
> > structured data. The backing file format name doesn't have one because
> > it's just a string, and so is the external data file name.
>=20
> Ah, fair enough, using "backing file format name" as precedence makes sen=
se.
>=20
> >=20
> > I guess I could add a section to describe the general concept of
> > external data files, if you think we have information to put there. All
> > that is really required should be contained in the feature bit
> > description already.
>=20
> No, you've convinced me that the feature bit should be sufficient.
>=20
> >=20
> >>> @@ -450,8 +461,10 @@ Standard Cluster Descriptor:
> >>>           1 -  8:    Reserved (set to 0)
> >>> =20
> >>>           9 - 55:    Bits 9-55 of host cluster offset. Must be aligne=
d to a
> >>> -                    cluster boundary. If the offset is 0, the cluste=
r is
> >>> -                    unallocated.
> >>> +                    cluster boundary. If the offset is 0 and bit 63 =
is clear,
> >>> +                    the cluster is unallocated. The offset may only =
be 0 with
> >>> +                    bit 63 set (indicating a host cluster offset of =
0) when an
> >>> +                    external data file is used.
> >>
> >> Does that mean that the value 0x00000000 is invalid for external data
> >> files
> >=20
> > Not sure whether you mean the L2 entry as 0x00000000 or the offset field
> > as 0x00000000 (neither of them are 32 bit like your value).
> >=20
> > In any case, 0 is a valid value for an L2 entry, it means an unallocated
> > cluster. The same offset, but with bit 63 set (0x8000000000000000) is
> > valid only for external data files and means an allocated cluster at
> > offset 0.
> >=20
> >> and that 0x00000001 is special-cased to mean read the contents of
> >> the external file (and NOT that the cluster reads as all zeroes)?
> >=20
> > No, where do you read that? This is the description of the offset
> > field, and bit 0 isn't mentioned anywhere. The zero flag works the same
> > way as it always does.
>=20
> Arrgh. I was remembering that there were special bits on both ends of L2
> entries, but then mixed up which bit you were saying had special
> behavior, and wrote my paragraph thinking you used bit 0 instead of bit
> 63 as the way to recognize an explicit reference to external cluster 0.
>=20
> So, re-reading things, bit 63 for normal qcow2 images is 0 for unused,
> compressed, or needs COW; and 1 for refcount =3D=3D 1.  Does that mean the
> bit should be cleared (for all but offset 0) for external images, or
> does it mean that bit should always be set for EVERY cluster of the
> external image (since there is no refcounting, every cluster in the
> external image implicitly has a count of 1)?  Either way, I think you
> need to update the docs for bit 63 in addition to your addition to the
> standard cluster descriptor 9-55.

It should be set for every allocated cluster because of that implicit
refcount. (This is also what the existing code automatically does, so I
didn't have to add any code to implement this.)

And because you always set it for allocated clusters in the external
file, but never for unallocated clusters, we can also use to distinguish
unallocated for allocated at offset 0. This is not really a new special
meaning, but just making use of what we already had.

But I agree that we should be more explicit in the description for bit
63 because these clusters aren't refcounted. Maybe I should also mention
somewhere that we assume an implicit refcount of 1, just in case this
matters in another place, too.

> >> Is bit 0 allowed to be set for any other clusters when there is an
> >> external data file?
> >=20
> > Wait, what are "other clusters"? Are you assuming that we have an image
> > that stores guest data both internally and externally, in some kind of a
> > mixed setup?
>=20
> No, I agree that external files are an all-or-none proposition within a
> given qcow2: if enabled, ALL guest clusters that do not defer to a
> backing file must be found at the same offset in the external file as
> the guest sees.  The only mixing, then, is whether we allow the use of
> bit 0 to flag clusters that read as all zeroes, and/or the use of
> address 0 (for unallocated) to defer to a backing file instead of the
> external file (either of which means that the external file does NOT
> represent the same set of data that the guest sees).

Ok, I agree. Yes, if you have a backing file, we obviously can't make
the external data file a valid raw image until the overlay is fully
allocated. I think we need to keep zero writes consistent, though
(potentially optional, as you suggested, but it must be possible at
least).

> > The idea is that the feature bit signals that _all_ guest data is stored
> > in the external data file. The offset in the L2 table always refers to
> > the external file then. Only metadata remains in the qcow2 file.
>=20
> Correct.
>=20
> >=20
> >> And if so, are we requiring that it only be set
> >> when the external file is known to read as zero, or can we run into
> >> the situation where qcow2 says the cluster reads as 0 but the host
> >> file contains garbage?
> >=20
> > Hm... This is a good point. Currently it behaves just like normal qcow2
> > files, but this means that the external file can contain stale data and
> > the zero flag determines the content. This makes it impossible to use
> > the external data file as a raw image. So I think we need to add a
> > requirement to write actual zeroes to the external file there.
>=20
> The same is true if we allow unallocated clusters (which can then grab
> data from a backing file).  The external file is usable as a raw image
> ONLY if ALL clusters are allocated, AND if clusters with the 0 bit set
> in the qcow2 metadata also read as zero from the external file (but
> orthogonal to whether the host file is sparse or fully-allocated).

It also works for unallocated clusters if we don't have a backing file
and the external data file is zero initialised (like a newly created
regular file would generally be). I think this is actually the most
common case.

> >> Should the external file header contain a flag
> >> that states whether writes to the image should wipe vs. leave
> >> unchanged a cluster in the external file when the qcow2 metadata
> >> prefers to grab that cluster's contents as all-0s or by reading from
> >> the backing file?  There are security vs. speed implications -
> >> security insists on wiping the host file to NOT leave stale data, but
> >> that slows things down compared to just leaving garbage if the qcow2
> >> metadata can effectively ignore those parts of the external file -
> >> hence a knob may be worth exposing?
> >=20
> > If your argument is security, wouldn't the same tradeoff apply to
> > internally stored data as well?  zero_in_l2_slice() only adds the zero
> > flag, without overwriting the data in bs->file.
>=20
> With internal storage, no one can easily access the allocated cluster to
> read the stale data (well, I guess they can if the use qemu-img map
> --output=3Djson and then read from the allocated offset - but that's not
> easy); but once the external file exists, anyone reading from the
> external file in isolation doesn't know that the image should read as
> zero, and the stale data becomes much more likely to be a problem.
>=20
> >=20
> > But then, for actual security, wouldn't we need to do an explicit write
> > rather that write_zeroes so that the same problem doesn't reoccur just
> > one layer down? Or potentially even more specialised operations?
> >=20
> > Security is a different goal than just keeping the data file consistent
> > enough to be readable as a raw image.
>=20
> True - if we ever need a knob to ensure that discarded clusters are
> wiped rather than preserving stale data, it's much harder than just
> allowing an efficient write zeroes operation.

Okay, so let's declare this a non-goal for now.

Kevin

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcVHmUAAoJEH8JsnLIjy/W2LcQAL2R11tR9GhwdvsvearINFmv
+X7fXdRI7rhSi214Nqh6dk3Fxb8ylzl9A3TldEgreOZpd2M3YyC7vAVF2x92Lrug
iEi+Cf5ParT0ixRQaUPMVAUuAeBUJGg5CWBV+RYZctqPqq/Mgih+dp79f6Az0+O5
XZC0S4nnPCbJNQiCskl4hLGhlfUi1P1zlmaa7a7j8eQE/oT9TlhrnG3KpM3TWcGc
V2QFY33hwxMV2kWhJn6vx1UoN5CffwcZ7gOeDcdLy2I1FgRqCj5aJ4BpyF3LTi2F
Hic+nN07rYmPu7S9wvZ8kppPgchavmWNly/bWGmMrWQDy7epno7ybSOJgPp/l7px
n3YxkOmgB+T8sicOadwYcDgPgIWm3k2gJQ5hbxIE0tza4gVD1rl6y3FAFP+KtD+o
kX9xENtpCfVGxL1rXQdXkvzW0twRndgLYhBn32utwGsFGayCxvUrLRx7EHxGeQnP
MKCzOwD6rJjgINK87ik708MQ6l4S9HwH7/X3ZuAd7WZAVWIOT+Ob2a8ImSJ9ESju
s6a17gpUCfVANUGD7fYc7Ec/qm/91bZRwN1liHRGLiukWp0keUK2L08tfRCfAVzv
O8ju556C3w3vSmnPYB5mJy1otVnIefiOhW40qc0x0jQClCaug0SB8bTt643E63y6
PzeksqyjpO0L20gZn1k9
=DmrL
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
