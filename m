Received: from eggs.gnu.org ([2001:4830:134:3::10]:47706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgtDM-0007zS-Jm
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgtDL-0002yT-K1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:13:44 -0500
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-8-eblake@redhat.com>
	<ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
	<5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
	<cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
	<f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6432baa5-7d6a-0e03-e543-693be6a363d7@redhat.com>
Date: Thu, 23 Feb 2017 14:13:32 +0100
MIME-Version: 1.0
In-Reply-To: <f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MaV3hWcdqb0NvgcAgUWR9djmA1dEUmwlf"
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MaV3hWcdqb0NvgcAgUWR9djmA1dEUmwlf
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com
Message-ID: <6432baa5-7d6a-0e03-e543-693be6a363d7@redhat.com>
Subject: Re: [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE on server
References: <20170221024248.11027-1-eblake@redhat.com>
 <20170221024248.11027-8-eblake@redhat.com>
 <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
 <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
 <cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
 <f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
In-Reply-To: <f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/02/2017 21:34, Eric Blake wrote:
>=20
>> Oh, so it's the smallest "good" transfer size, or the preferred
>> alignment.  That's not the same as the SCSI definition, which is:
>>
>>    If a device server receives one of these commands with a transfer
>>    size greater than this value, then the device server may incur
>>    delays in processing the command. An OPTIMAL TRANSFER LENGTH field
>>    set to 0000_0000h indicates that the device server does not report
>>    an optimal transfer size.
> Hmm - that's yet another limit. I don't know if our block layer exposes=

> it, or if it should expose it.

It exposes it in opt_transfer. :)  The only driver that sets
opt_transfer is the iSCSI driver and uses the SCSI meaning.

>> It's more similar to the physical block size:
>
> Indeed; at least that was my intent (picking a size that will avoid
> read-modify-write pessimations, as well as reflecting granularity of
> trim/zero operations).

The two are not necessarily related.  Granularity of trim/zero is
usually a multiple of the sector size (for example qcow2 will have
physical block size =3D host physical block size, and unmap granularity =3D=

cluster size).

>>    When using logical block access commands (see 4.2.2), application
>>    clients should:
>>    a) specify an LBA that is aligned to a physical block boundary; and=

>>    b) access an integral number of physical blocks, provided that the
>>    access does not go beyond the last LBA on the medium.
>>
>> So I'd rather ignore it in the client, and send 4096 in the server.
> Does that mean our BlockLimits structure documentation needs a tweak,
> too?  It currently reads:
>=20
>     /* Optimal transfer length in bytes.  A power of 2 is best but not
>      * mandatory.  Must be a multiple of bl.request_alignment, or 0 if
>      * no preferred size */
>     uint32_t opt_transfer;
>=20
> Are we trying to track both optimum size in the SCSI sense _and_ block
> size in the O_DIRECT sense?

As of now, just in the SCSI sense.

Paolo


--MaV3hWcdqb0NvgcAgUWR9djmA1dEUmwlf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrt/8AAoJEL/70l94x66D+DUH/00KD55KWL04y6KR/L/cnDqT
y6+RA1ubll0TOPcTC6SE6vvwHcgGD3iHtKbuED9DarbBX3pIET68q4MS0vd9zGt3
yw7NGc8Dsey0rZfBhpsP4PoaMhSB5ygCocbAEFAtSAiFgwKPDPVq3oLDPjKgZTTz
v3SLFgxz2KpwawhzVWNSFBDLzdWizy725IyTa/7uOlJ/iMsK4PsQYwjULsOk/GrO
sEYlLBJmo/4iayKFcL6xTSl2uLrC8RkxvnxvKWc+ec1+1/z897iqN4EKakdC/sMT
/7HUWt17dRvz/3TX2JV1sU/p3ymIEBvWDTTWIu3gsjugehfZBHFWeS13iUwL4Fc=
=c987
-----END PGP SIGNATURE-----

--MaV3hWcdqb0NvgcAgUWR9djmA1dEUmwlf--
