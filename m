Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMsb-0007TX-DM
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMsa-0000UM-82
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:20:33 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
Date: Wed, 12 Apr 2017 13:20:20 -0500
MIME-Version: 1.0
In-Reply-To: <b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bB4ajdh7V1Rk2dFiCkKTqcJrQ25aA11i3"
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
To: "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bB4ajdh7V1Rk2dFiCkKTqcJrQ25aA11i3
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
In-Reply-To: <b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 12:55 PM, Denis V. Lunev wrote:
> Let me rephrase a bit.
>=20
> The proposal is looking very close to the following case:
> - raw sparse file
>=20
> In this case all writes are very-very-very fast and from the
> guest point of view all is OK. Sequential data is really sequential.
> Though once we are starting to perform any sequential IO, we
> have real pain. Each sequential operation becomes random
> on the host file system and the IO becomes very slow. This
> will not be observed with the test, but the performance will
> degrade very soon.
>=20
> This is why raw sparse files are not used in the real life.
> Hypervisor must maintain guest OS invariants and the data,
> which is nearby from the guest point of view should be kept
> nearby in host.
>=20
> This is why actually that 64kb data blocks are extremely
> small :) OK. This is offtopic.

Not necessarily. Using subclusters may allow you to ramp up to larger
cluster sizes. We can also set up our allocation (and pre-allocation
schemes) so that we always reserve an entire cluster on the host at the
time we allocate the cluster, even if we only plan to write to
particular subclusters within that cluster.  In fact, 32 subclusters to
a 2M cluster results in 64k subclusters, where you are still writing at
64k data chunks but could now have guaranteed 2M locality, compared to
the current qcow2 with 64k clusters that writes in 64k data chunks but
with no locality.

Just because we don't write the entire cluster up front does not mean
that we don't have to allocate (or have a mode that allocates) the
entire cluster at the time of the first subcluster use.

>=20
> One can easily recreate this case using the following simple
> test:
> - write each even 4kb page of the disk, one by one
> - write each odd 4 kb page of the disk
> - run sequential read with f.e. 1 MB data block
>=20
> Normally we should still have native performance, but
> with raw sparse files and (as far as understand the
> proposal) sub-clusters we will have the host IO pattern
> exactly like random.

Only if we don't pre-allocate entire clusters at the point that we first
touch the cluster.

>=20
> This seems like a big and inevitable problem of the approach
> for me. We still have the potential to improve current
> algorithms and not introduce non-compatible changes.
>=20
> Sorry if this is too emotional. We have learned above in a
> very hard way.

And your experience is useful, as a way to fine-tune this proposal.  But
it doesn't mean we should entirely ditch this proposal.  I also
appreciate that you have patches in the works to reduce bottlenecks
(such as turning sub-cluster writes into 3 IOPs rather than 5, by doing
read-head, read-tail, write-cluster, instead of the current read-head,
write-head, write-body, read-tail, write-tail), but think that both
approaches are complimentary, not orthogonal.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bB4ajdh7V1Rk2dFiCkKTqcJrQ25aA11i3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7m/kAAoJEKeha0olJ0NqBwQH/2p0rYj9jXKzxBFjup3UyUYX
iCJYTykK+kSI3UMrvoC6MrB13qoa8iwe9RHiItXVKKKxMCNbskZotXX6Rqa8I/TN
+Sy9oI/MMpVctThVCG3dBQpHnFJ1FKs4TVwRRBf3DIfQKZV6SVLUJ8tGxwcN8yRS
b7c1RSXa/9RaYNLmOq8JhRu9EeXgj03HebDmDOk4JWs+Mtlco73f1St16O8l/GAF
WbsfCw7CMY2xQ6IIeeR+wkL7sFoNey18eGV4/zQNi5JnNJ2UGpknGBg4ueNQN342
fShl4PKuEwU2UB48C6ZbCZkEeITM7X7QeiO7yYDgkp7QLq6nAAN2YvrQCYDRZnc=
=XhRK
-----END PGP SIGNATURE-----

--bB4ajdh7V1Rk2dFiCkKTqcJrQ25aA11i3--
