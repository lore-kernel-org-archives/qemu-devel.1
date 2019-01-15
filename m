Received: from eggs.gnu.org ([209.51.188.92]:56792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQfq-0006NY-N6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQfo-0005Fe-K6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:30:42 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-5-eblake@redhat.com>
	<3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8312fb33-1724-d0b0-c5af-763963250ced@redhat.com>
Date: Tue, 15 Jan 2019 09:25:10 -0600
MIME-Version: 1.0
In-Reply-To: <3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XrCfHqzaIvJNoGbHGNpVLb5bM0qDlbGKS"
Subject: Re: [Qemu-devel] [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XrCfHqzaIvJNoGbHGNpVLb5bM0qDlbGKS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <8312fb33-1724-d0b0-c5af-763963250ced@redhat.com>
Subject: Re: [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-5-eblake@redhat.com>
 <3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
In-Reply-To: <3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 3:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:57, Eric Blake wrote:
>> We only had two callers to nbd_export_new; qemu-nbd.c always
>> passed a valid offset/length pair (because it already checked
>> the file length, to ensure that offset was in bounds), while
>> blockdev-nbd always passed 0/-1.  Then nbd_export_new reduces
>> the size to a multiple of BDRV_SECTOR_SIZE (can only happen
>> when offset is not sector-aligned, since bdrv_getlength()
>> currently rounds up), which can result in offset being greater
>> than the enforced length, but that's not fatal (the server
>> rejects client requests that exceed the advertised length).
>>
>> However, I'm finding it easier to work with the code if we are
>> consistent on having both callers pass in a valid length, and
>> just assert that things are sane in nbd_export_new.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +++ b/nbd/server.c
>> @@ -1499,13 +1499,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs,=
 off_t dev_offset, off_t size,
>>       exp->name =3D g_strdup(name);
>>       exp->description =3D g_strdup(description);
>>       exp->nbdflags =3D nbdflags;
>> -    exp->size =3D size < 0 ? blk_getlength(blk) : size;
>> -    if (exp->size < 0) {
>> -        error_setg_errno(errp, -exp->size,
>> -                         "Failed to determine the NBD export's length=
");
>> -        goto fail;
>> -    }
>> -    exp->size -=3D exp->size % BDRV_SECTOR_SIZE;
>> +    assert(dev_offset <=3D size);
>=20
> @size is not size of the image, but size of the export, so it may be le=
ss than dev_offset
> (qemu-nbd.c do "fd_size -=3D dev_offset" before "nbd_export_new(bs, dev=
_offset, fd_size, "

But the assert is fine because patch 3/19 fixed qemu-nbd.c to never pass
in dev_offset larger than size (it fails up front if dev_offset is out
of bounds, whether from the -o command line option or from what it read
from the partition header with the -P command line option).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XrCfHqzaIvJNoGbHGNpVLb5bM0qDlbGKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw9+1YACgkQp6FrSiUn
Q2qpXAf7BcnnqiufeBog1UoKYEg0Bg/2pMSgzKaiu0mwBMgaEyNACwZLQRveEg/o
TmeEihwTxDzWGQQp5vtfK0/mYBjZStHAwLnzJN1MPZ83OyuLrY6XwNCiYwT4Ehaz
3GrPzqlbmmEulaj+ZGbV7DpZ/p0Ppm66LYNSq123FxhdrCMeDnX0NVDT5Th72JEd
txhufi+8q/DaiS/MBHKnrIAr/Qwper4BvS+svqb5+cx9jCXM6fmYnER/erqaEplH
f+8U85cdA1BpEVTmuF8rFHL8cZDr4cJbvLtf+yFeRJl39vVyIBsb3KGvMqCpWs0h
6oeMgqyccJwjoLGHiWU7xn3h5RktBA==
=aRQY
-----END PGP SIGNATURE-----

--XrCfHqzaIvJNoGbHGNpVLb5bM0qDlbGKS--
