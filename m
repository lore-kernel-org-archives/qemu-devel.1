Received: from eggs.gnu.org ([2001:4830:134:3::10]:36088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5Z8k-0000Sg-Gf
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5Z8j-00021S-2h
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:23:14 -0400
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-13-eblake@redhat.com>
	<20171020150349.GC3667@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2925d880-fe98-c70b-97d7-1019b1cba89f@redhat.com>
Date: Fri, 20 Oct 2017 10:22:56 -0500
MIME-Version: 1.0
In-Reply-To: <20171020150349.GC3667@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0IgI4og25URVKUtc93GUHlvDhAD0TFu6q"
Subject: Re: [Qemu-devel] [PATCH v6 12/24] block: Convert
 bdrv_get_block_status_above() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0IgI4og25URVKUtc93GUHlvDhAD0TFu6q
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com,
 jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <2925d880-fe98-c70b-97d7-1019b1cba89f@redhat.com>
Subject: Re: [PATCH v6 12/24] block: Convert bdrv_get_block_status_above() to
 bytes
References: <20171012034720.11947-1-eblake@redhat.com>
 <20171012034720.11947-13-eblake@redhat.com>
 <20171020150349.GC3667@localhost.localdomain>
In-Reply-To: <20171020150349.GC3667@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 10:03 AM, Kevin Wolf wrote:
> Am 12.10.2017 um 05:47 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  In the common case, allocation is unlikely to ever use
>> values that are not naturally sector-aligned, but it is possible
>> that byte-based values will let us be more precise about allocation
>> at the end of an unaligned file that can do byte-based access.
>>

>>  int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t b=
ytes,
>>                        int64_t *pnum, int64_t *map, BlockDriverState *=
*file)
>>  {
>> -    int64_t ret;
>> -    int n;
>> -
>> -    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
>> -    assert(pnum);
>> -    /*
>> -     * The contract allows us to return pnum smaller than bytes, even=

>> -     * if the next query would see the same status; we truncate the
>> -     * request to avoid overflowing the driver's 32-bit interface.
>> -     */
>> -    bytes =3D MIN(bytes, BDRV_REQUEST_MAX_BYTES);
>=20
> Is the limitation to BDRV_REQUEST_MAX_BYTES going away without being
> replaced by a new one in bdrv_co_block_status()? What protects us now
> from 32-bit truncation?

As of this patch, we have this 64-bit-clean call chain:
bdrv_block_status()
  bdrv_block_status_above()
    bdrv_common_block_status_above()
      bdrv_block_status_above_co_entry()
        bdrv_co_block_status_above()
          bdrv_co_block_status()

which in turn has:
    /*
     * The contract allows us to return pnum smaller than bytes, even
     * if the next query would see the same status; we truncate the
     * request to avoid overflowing the driver's 32-bit interface.
     */
    bytes =3D MIN(bytes, BDRV_REQUEST_MAX_BYTES);

added earlier in 8/24.

At the end of series 3, the truncation prevention is still in place when
calling into the drivers, per the changes to bdrv_co_block_status() in
21/24.

Later, in series 4, all drivers are converted to 64-bit interfaces,
where the drivers are either made 64-bit clean, or do their own
truncation to 32 bits.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0IgI4og25URVKUtc93GUHlvDhAD0TFu6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqFNAACgkQp6FrSiUn
Q2oQOAf/eYvXg0keyhNm5mMLy1p7D9kJ1ghFnkh7bghAbnZbrp5Pt9DQaCksBlxL
/bAXtAYAPLApUsD88gDMbuFFrQIDOEpJL+vtg/gFf56dXLT9Cn+lX4LgU7/OmaRc
CEhJbbRGgmbtpu4Br2DJ2pvd89Rjm6uJSBp4N5sapTmiw87lg83LJ4AKXPkMCR8/
4IwnLuxJ02cLUe/L1PJaHipJLhtubJJpx+8kEu4iGprROUfFdmI1aA3sxfJRBmIZ
bdJkRa93LPkZwph9pcA/4Xg/Svtxlg4VPrRSVuPvrDuOpTdNnAZUgj97HPxPWVSV
hywYNqH7mMK68VatYRaFStx4ORwRzw==
=lTs1
-----END PGP SIGNATURE-----

--0IgI4og25URVKUtc93GUHlvDhAD0TFu6q--
