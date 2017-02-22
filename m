Received: from eggs.gnu.org ([2001:4830:134:3::10]:60829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgdcz-0007XT-FK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgdcx-0004Dw-UP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:35:09 -0500
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-8-eblake@redhat.com>
	<ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
	<5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
	<cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
Date: Wed, 22 Feb 2017 14:34:58 -0600
MIME-Version: 1.0
In-Reply-To: <cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LufaSwlejRfE5Q7JdHSnTtrRc5W3lsdxg"
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
--LufaSwlejRfE5Q7JdHSnTtrRc5W3lsdxg
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com
Message-ID: <f647c37e-a9cb-e052-6a8a-210b826f96f6@redhat.com>
Subject: Re: [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE on server
References: <20170221024248.11027-1-eblake@redhat.com>
 <20170221024248.11027-8-eblake@redhat.com>
 <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
 <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
 <cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
In-Reply-To: <cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 11:26 AM, Paolo Bonzini wrote:
>=20
>=20
> On 22/02/2017 18:11, Eric Blake wrote:
>>>> +    /* preferred - At least 4096, but larger as appropriate. */
>>>> +    sizes[1] =3D MAX(blk_get_opt_transfer(exp->blk), 4096);
>>
>> The NBD specification requires a non-zero power-of-2 number if the
>> server transmits the block size at all; 1 is the ideal number, followe=
d
>> by whatever actual size we learn from the request_align of the device.=


Oh shoot - now I notice I misread your complaint - I thought you were
complaining about sizes[0] (min_size) having a TODO comment; but you
were talking about sizes[1] (preferred_size).

The NBD spec wording can be changed if needed (after all, it is still
experimental), but it currently says:

"If block size constraints have not been advertised or agreed on
externally, then a client SHOULD assume a default minimum block size of
1, a preferred block size of 2^12 (4,096), and a maximum block size of
the smaller of the export size or 0xffffffff (effectively unlimited).

=2E..

"The preferred block size represents the minimum size at which aligned
requests will have efficient I/O, avoiding behaviour such as
read-modify-write. If advertised, this MUST be a power of 2 at least as
large as the smaller of the minimum block size and 2^12 (4,096),
although larger values (such as the minimum granularity of a hole) are
also appropriate. The preferred block size MAY be larger than the export
size, in which case the client is unable to utilize the preferred block
size for that export. The server MAY advertise an export size that is
not an integer multiple of the preferred block size."

>=20
> Oh, so it's the smallest "good" transfer size, or the preferred
> alignment.  That's not the same as the SCSI definition, which is:
>=20
>    If a device server receives one of these commands with a transfer
>    size greater than this value, then the device server may incur
>    delays in processing the command. An OPTIMAL TRANSFER LENGTH field
>    set to 0000_0000h indicates that the device server does not report
>    an optimal transfer size.

Hmm - that's yet another limit. I don't know if our block layer exposes
it, or if it should expose it.

>=20
> It's more similar to the physical block size:

Indeed; at least that was my intent (picking a size that will avoid
read-modify-write pessimations, as well as reflecting granularity of
trim/zero operations).

>=20
>    When using logical block access commands (see 4.2.2), application
>    clients should:
>    a) specify an LBA that is aligned to a physical block boundary; and
>    b) access an integral number of physical blocks, provided that the
>    access does not go beyond the last LBA on the medium.
>=20
> So I'd rather ignore it in the client, and send 4096 in the server.

Does that mean our BlockLimits structure documentation needs a tweak,
too?  It currently reads:

    /* Optimal transfer length in bytes.  A power of 2 is best but not
     * mandatory.  Must be a multiple of bl.request_alignment, or 0 if
     * no preferred size */
    uint32_t opt_transfer;

Are we trying to track both optimum size in the SCSI sense _and_ block
size in the O_DIRECT sense?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LufaSwlejRfE5Q7JdHSnTtrRc5W3lsdxg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrfXyAAoJEKeha0olJ0NqxnMIAJ6nWJSUgFZzy6vy0Ni8yOfs
kE7GESwMCssbBUXW6QJA8+RI95fcM+MJOE/c2VcrLytr0uVY7Aj9KYnC320jDy3z
3p9Tbbsr7A/FvqiZR/RhQ0hjLQVWGOBsgBpifz1uoTnx7Vex8i42RKf953rXQoXj
q/Y+PUIBl+Ut/1fhAEpammUZi9lNAjrQpKz61D+1vedIyEOuB+nJvMyhkHEfjE5o
UI+tItffgRb1GV4hvOcFldkzmsGdzjHQK511fJgDwdiSkzCIU5DGoHaZjNrIOSxy
TO8z+N95Q8ZaCOvLv6UaeTg6G9kPLxdLNGLrQJ+bzUu6EtLEQbt63ws4Npr9qH4=
=Zyxl
-----END PGP SIGNATURE-----

--LufaSwlejRfE5Q7JdHSnTtrRc5W3lsdxg--
