Received: from eggs.gnu.org ([2001:4830:134:3::10]:52355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgvU7-0008Ja-OO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgvU4-00061N-KR
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:39:11 -0500
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-8-eblake@redhat.com>
	<ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
	<5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
	<cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
	<f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
	<6432baa5-7d6a-0e03-e543-693be6a363d7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b0b0894-e9a8-55dd-ebbb-cd62f0b877d3@redhat.com>
Date: Thu, 23 Feb 2017 09:38:56 -0600
MIME-Version: 1.0
In-Reply-To: <6432baa5-7d6a-0e03-e543-693be6a363d7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kbrW3Q8Jlg4DcTX0MnC24UmE6vpd33nVu"
Subject: Re: [Qemu-devel] [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE
 on server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kbrW3Q8Jlg4DcTX0MnC24UmE6vpd33nVu
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com
Message-ID: <5b0b0894-e9a8-55dd-ebbb-cd62f0b877d3@redhat.com>
Subject: Re: [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE on server
References: <20170221024248.11027-1-eblake@redhat.com>
 <20170221024248.11027-8-eblake@redhat.com>
 <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
 <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
 <cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
 <f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
 <6432baa5-7d6a-0e03-e543-693be6a363d7@redhat.com>
In-Reply-To: <6432baa5-7d6a-0e03-e543-693be6a363d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 07:13 AM, Paolo Bonzini wrote:
>=20
>=20
> On 22/02/2017 21:34, Eric Blake wrote:
>>
>>> Oh, so it's the smallest "good" transfer size, or the preferred
>>> alignment.  That's not the same as the SCSI definition, which is:
>>>
>>>    If a device server receives one of these commands with a transfer
>>>    size greater than this value, then the device server may incur
>>>    delays in processing the command. An OPTIMAL TRANSFER LENGTH field=

>>>    set to 0000_0000h indicates that the device server does not report=

>>>    an optimal transfer size.
>> Hmm - that's yet another limit. I don't know if our block layer expose=
s
>> it, or if it should expose it.
>=20
> It exposes it in opt_transfer. :)  The only driver that sets
> opt_transfer is the iSCSI driver and uses the SCSI meaning.

>> Does that mean our BlockLimits structure documentation needs a tweak,
>> too?  It currently reads:
>>
>>     /* Optimal transfer length in bytes.  A power of 2 is best but not=

>>      * mandatory.  Must be a multiple of bl.request_alignment, or 0 if=

>>      * no preferred size */
>>     uint32_t opt_transfer;
>>
>> Are we trying to track both optimum size in the SCSI sense _and_ block=

>> size in the O_DIRECT sense?
>=20
> As of now, just in the SCSI sense.

Okay, sounds like I need a pre-requisite patch to beef up the
BlockLimits documentation, and maybe adding in a preferred size for yet
another parameter that we learn from stat() on files (there really are
performance benefits for performing I/O on a file in aligned requests,
even if it can do byte-wise manipulations).  And maybe the NBD
documentation needs a tweak too - which values are the most beneficial
to expose over the wire?  Should NBD be exposing more than just
min/preferred/max?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kbrW3Q8Jlg4DcTX0MnC24UmE6vpd33nVu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrwIQAAoJEKeha0olJ0Nq5GAIAKSG2hd3kf2mcmLMiobjQh0v
UVxevASKvrjNr2/rq4mwoJQ813JkVuXKSYg6+DxbdPlVqMXCAI24DItVNRYxFfjZ
tf/a4qBpxQWkxu+l5IXdb0D5z1fiMG4LcGWrsHWsAHzW0/H7pvWhPpq5wGP9H0IC
Mlb3HRyKi53HqZ+J9miexeHWwEUHOWkcBYCIa5RXPD1z7VIwauc/+k43zSm1QLrL
9wG2LjE7rbnqRs7WJmwTexsDkusMe8ZPFEkar/desVKmRSNlFGMreiVYW2JmDxQG
Nvjq8XgrqQJxDHFeX+HSGZdTjMkVH/R32uD/88EqGtkY49epcrz9Y17pNvNrbXo=
=NLAk
-----END PGP SIGNATURE-----

--kbrW3Q8Jlg4DcTX0MnC24UmE6vpd33nVu--
