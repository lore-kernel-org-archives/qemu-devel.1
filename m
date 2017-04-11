Received: from eggs.gnu.org ([2001:4830:134:3::10]:52135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxx3U-0006kv-Mx
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxx3R-0004o1-Fp
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:46:04 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
Date: Tue, 11 Apr 2017 09:45:29 -0500
MIME-Version: 1.0
In-Reply-To: <w5137dfyq1f.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QpRasjfPOtMw8PodFstJu36auO9Fk9XSl"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QpRasjfPOtMw8PodFstJu36auO9Fk9XSl
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
Subject: Re: [Qemu-block] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
In-Reply-To: <w5137dfyq1f.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 09:31 AM, Alberto Garcia wrote:
> On Tue 11 Apr 2017 04:04:53 PM CEST, Max Reitz wrote:
>>>> (We could even get one more bit if we had a subcluster-flag, because=
 I
>>>> guess we can always assume subclustered clusters to have OFLAG_COPIE=
D
>>>> and be uncompressed. But still, three bits missing.)
>>>
>>> Why can we always assume OFLAG_COPIED?
>>
>> Because partially allocated clusters cannot be used with internal
>> snapshots, and that is what OFLAG_COPIED is for.
>=20
> Why can't they be used?

An internal snapshot causes a COW to happen if another write happens
anywhere in the cluster. Setting OFLAG_COPIED is a shorthand for whether
the COW must happen, but it is always possible (but slower) to refer
back to the refcount to learn the same information.  If we have a
cluster with missing subclusters, and need to do a COW, we are already
reading from the backing file - so we might as well populate the missing
subclusters of the original cluster at that time we write the new
updated cluster, at which point we no longer need to mark the cluster as
using subclusters.  Or we could state that the action of creating an
internal snapshot takes longer, because it fully populates all
partially-populated clusters (taking an internal snapshot is something
that is not done frequently, after all, as we've gradually been trying
to steer users to external snapshots) - or we could even go so far as to
state that internal snapshots and subclusters are incompatible (you
can't use both features at the same time).

It may be possible to make OFLAG_COPIED and subclusters work usefully
together, but the point being made here is that because we're already
changing design principles, we don't necessarily have to burn a bit on
OFLAG_COPIED if subclusters are in use.

>=20
> Perhaps we can give up that bit for subclusters then, that would allow
> us to double their number. We would still have the zero flag at the
> cluster level. Opinions on this, anyone?

I already think we're leaning away from option 1, even though the above
conversation was about how to pack more state into just 64 bits if we
wanted to stick with option 1.

If we use option 2 or 3, it may still be worth burning a bit in the
original 64 bits that says whether the subcluster secondary 64-bits is
valid (it might speed up some operations if we only have to do one
64-bit read and realize that the entire cluster is uniform, compared to
operations where the subcluster flag is set so we have to do a second
64-bit read to learn about the state of each subcluster).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QpRasjfPOtMw8PodFstJu36auO9Fk9XSl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7OwJAAoJEKeha0olJ0Nq2eYH/Awbl/enuRPLDcUdoyEJSFK7
YlaIwxFmD/D3n+d0xcKVlaR2zmAmBehJRS+ldM8Gm/VkUygrLppTCU3Y9WYQEsr6
R9zYLtv5dCVvPKXpA6V6hrP1QJT2wmsjd6KEJq8dHRAfF7wWPfgB44h0rboUJjpN
w547mY8SNWcLZpgsjyyW/VJLysXN2tAnaJKXxXZwdqemIjrqANH4mnh8KG6+x87q
sUDbmVQH3AzE5+IMZ0aQrD1kE3MuvCmlAnjRSDfygizc9VeGOdoy2EI3XW/X3QPN
CyFetRpPFrnouWLqWLl/oiv/dFwskBh9tpUFJNFiFtnpOjgqlKXpbe3V1xAIpQk=
=BV36
-----END PGP SIGNATURE-----

--QpRasjfPOtMw8PodFstJu36auO9Fk9XSl--
