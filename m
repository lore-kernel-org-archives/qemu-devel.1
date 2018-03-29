Received: from eggs.gnu.org ([2001:4830:134:3::10]:45378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1YGa-0001iz-Af
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1YGZ-0005FI-6Y
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:11:00 -0400
References: <20180322124155.16257-1-berto@igalia.com>
	<de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
	<a60b56cd-c786-fa4f-1405-8017140ff801@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <de1a759f-731f-2cdc-f02e-fadd5f44be6b@redhat.com>
Date: Thu, 29 Mar 2018 16:10:42 +0200
MIME-Version: 1.0
In-Reply-To: <a60b56cd-c786-fa4f-1405-8017140ff801@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3cdrZWRPyPCkXI0sWd8eaR9cwjUL7GGnl"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v4] iotests: Test abnormally large
 size in compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3cdrZWRPyPCkXI0sWd8eaR9cwjUL7GGnl
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <de1a759f-731f-2cdc-f02e-fadd5f44be6b@redhat.com>
Subject: Re: [PATCH for-2.12 v4] iotests: Test abnormally large size in
 compressed cluster descriptor
References: <20180322124155.16257-1-berto@igalia.com>
 <de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
 <a60b56cd-c786-fa4f-1405-8017140ff801@redhat.com>
In-Reply-To: <a60b56cd-c786-fa4f-1405-8017140ff801@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-28 19:58, Eric Blake wrote:
> On 03/28/2018 12:34 PM, Max Reitz wrote:

[...]

>> The OFLAG_COPIED repair looks a bit interesting, but, er, well.
>>
>> Max
>>
>> (Since a compressed cluster does not correspond 1:1 to a host cluster,=

>> you cannot say that a compressed cluster has a refcount -- only host
>> clusters are refcounted.=C2=A0 So what is it supposed to mean that a
>> compressed cluster has a refcount of 1?
>=20
> A compressed cluster may affect the refcount of multiple clusters: the
> cluster that contains the initial offset, and the cluster that contains=

> any of the nb_sectors that did not fit in the first cluster.=C2=A0 So, =
if I
> have a 4k-cluster image (where each character is a sector), and where
> the compressed clusters are nicely sector-aligned:
>=20
> |1-------|2-------|3-------|
> |AAAAAABB|BBBBCCCC|CC------|
>=20
> Here, the L2 entry for A, B, and C each list nb_sectors of 5, as it
> takes 6 sectors to list the entire image, but nb_sectors does not
> include the sector that includes the original offset.=C2=A0 The refcoun=
t for
> cluster 1 is 2 (the full contents of compressed A and the first half of=

> compressed B); for cluster 2 is 2 (the second half of compressed B and
> the first half of compressed C); and for cluster 3 is 1 (the second hal=
f
> of compressed C).
>=20
> But what this patch is dealing with is when nb_sectors is larger than
> required.=C2=A0 With 4k sectors, qemu will never populate nb_clusters m=
ore
> than 8 (if the output is not nicely aligned, and 4096 bytes compresses
> down to only 4095, we can end up with 1 byte in the first sector, then =
7
> complete sectors, then 510 bytes in a final sector, for 8 sectors beyon=
d
> the initial offset).=C2=A0 But the qcow2 image is still valid even if t=
he L2
> entry claims nb_sectors of 15; if that happens, then a compressed
> cluster can now affect the refcount of 3 clusters rather than the usual=

> 1 or 2.
>=20
>>
>> I'd argue from a point of usefulness.=C2=A0 In theory, you could modif=
y
>> compressed clusters in-place, and then you'd need the information
>> whether you are allowed to.=C2=A0 But that doesn't really depend on wh=
ether
>> the host clusters touched by the compressed cluster have a refcount of=

>> 1, instead if depends on how many times the compressed cluster itself =
is
>> referenced.=C2=A0 Unfortunately we have no refcounting structure for t=
hat.
>>
>> So all in all OFLAG_COPIED is just useless for compressed clusters.)
>=20
> In general, because we intentionally allow multiple compressed clusters=

> to (try to) share a single host cluster, the refcount for compressed
> clusters will usually be larger than 1.=C2=A0 And OFLAG_COPIED is only =
useful
> when the refcount is 1, right?

OFLAG_COPIED is only useful when it reflects the number of references to
the data cluster, because only then can we update it in-place without
having to worry about other users.  For normal clusters, one data
cluster is one host cluster, so we can get the number of references from
the refcount structures (which contain the reference counts for host
clusters, but *not* for data clusters).

But for compressed clusters, the data cluster may be part of a host
cluster, or it may even be multiple host clusters.  So the information
we get from the refcount structures is totally useless here, it doesn't
tell us how many references there are to that compressed data cluster.

There is only one exception: If all of the host clusters the compressed
cluster touches have a refcount of 1, we can be certain that there are
no other users, so then we know there is only one reference to the
compressed cluster.  But as soon as they have a higher refcount... We
don't know whether that's because of multiple references to this
compressed cluster or because of multiple compressed cluster sharing a
single host cluster.

In practice it doesn't really matter of course because modifying
compressed clusters in-place seems like a whole different can of worms.

Max


--3cdrZWRPyPCkXI0sWd8eaR9cwjUL7GGnl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq88+IACgkQ9AfbAGHV
z0B3QAgAm8t3WaqjGcG1HCE5FF3myonuMAU/N6FH9TAg2t7T97z5FQIsRNh9RpOZ
JQeGIB10ZuT68+zVRDZjeE65RUjL31W+I0VgukA+FPkpswlOvkx+8Kwjxa0AafDw
VvsNN3NaExKRDOzWphE2Tr3IhCg9mPls0f+/HlzT09lcj2ACbaKniKVait3gbekb
C/c6shkBpSClCOU11YXl5/CdGkK6bFFbJP0wn3D4D9RBMek5meRJ4WmuDF8cGado
bp52Cr+VCRIRRLTJ7O5Eb9rlWMGrhuYP1l6t8AF4c5RtvbiR/zsGx8s1NmDjWzmF
B/OBR/rQpiq05Tw0tksueAj6FKNO4Q==
=UFfY
-----END PGP SIGNATURE-----

--3cdrZWRPyPCkXI0sWd8eaR9cwjUL7GGnl--
