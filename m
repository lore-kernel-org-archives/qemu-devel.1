Received: from eggs.gnu.org ([2001:4830:134:3::10]:39099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgah3-0003mm-53
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgah2-0004R2-Ee
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:27:09 -0500
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-8-eblake@redhat.com>
	<ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
	<5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
Date: Wed, 22 Feb 2017 18:26:57 +0100
MIME-Version: 1.0
In-Reply-To: <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kXbHCRK7GAtnal804sF10mQVEqU4Da7lI"
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
--kXbHCRK7GAtnal804sF10mQVEqU4Da7lI
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com
Message-ID: <cfab822e-e63a-7c1e-d740-309c6edd0031@redhat.com>
Subject: Re: [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE on server
References: <20170221024248.11027-1-eblake@redhat.com>
 <20170221024248.11027-8-eblake@redhat.com>
 <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
 <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
In-Reply-To: <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/02/2017 18:11, Eric Blake wrote:
>>> +    /* preferred - At least 4096, but larger as appropriate. */
>>> +    sizes[1] =3D MAX(blk_get_opt_transfer(exp->blk), 4096);
>
> The NBD specification requires a non-zero power-of-2 number if the
> server transmits the block size at all; 1 is the ideal number, followed=

> by whatever actual size we learn from the request_align of the device.

Oh, so it's the smallest "good" transfer size, or the preferred
alignment.  That's not the same as the SCSI definition, which is:

   If a device server receives one of these commands with a transfer
   size greater than this value, then the device server may incur
   delays in processing the command. An OPTIMAL TRANSFER LENGTH field
   set to 0000_0000h indicates that the device server does not report
   an optimal transfer size.

It's more similar to the physical block size:

   When using logical block access commands (see 4.2.2), application
   clients should:
   a) specify an LBA that is aligned to a physical block boundary; and
   b) access an integral number of physical blocks, provided that the
   access does not go beyond the last LBA on the medium.

So I'd rather ignore it in the client, and send 4096 in the server.

Paolo


--kXbHCRK7GAtnal804sF10mQVEqU4Da7lI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrcnhAAoJEL/70l94x66D7u0H/jzXEAVOhi3Yc2+mTIPR3qmT
x9nqiEQjefcbJaWvDDlJf7pdcpS1+q3HEtHBXYSffeuwyCWsc3wBdZfFQQZwUx2R
Iq47H3ZzDRb/pEVmtoOl6L2nvBpui8hYLJNL8gk/iHT0M0KHHbP5ojwiqZiE3a8u
afWJRF2h31661y8/E2HBk5svVcyvQ3zUTn7MS4bNzZlQMSwAttFexGyTEVYlsvM8
Fjl60/vlYqZQa2ISiaNMa63JXAJiV/ltzzRDRfAuWTj6tGHsyTkI03D85e6PXxKI
7ZuYTq6rtR1//2MPeRUEm7/9KYA4vea2MZ1LNDjpQWQ8nBLofG6ycRssQGm2ty4=
=Rl94
-----END PGP SIGNATURE-----

--kXbHCRK7GAtnal804sF10mQVEqU4Da7lI--
