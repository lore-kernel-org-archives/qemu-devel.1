Received: from eggs.gnu.org ([209.51.188.92]:47616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUuF-0007OG-3n
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUsd-0000ac-Ss
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:41:17 -0400
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
	<20190430110918.GF5607@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
Date: Tue, 30 Apr 2019 10:41:02 -0500
MIME-Version: 1.0
In-Reply-To: <20190430110918.GF5607@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
 <20190423125706.26989-3-vsementsov@virtuozzo.com>
 <20190430092437.jbecehdkqa4zdavd@steredhat>
 <4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
 <20190430110918.GF5607@linux.fritz.box>
In-Reply-To: <20190430110918.GF5607@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 6:09 AM, Kevin Wolf wrote:
> Am 30.04.2019 um 12:03 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 30.04.2019 12:24, Stefano Garzarella wrote:
>>> On Tue, Apr 23, 2019 at 03:57:05PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
>>>> This fixes at least one overflow in qcow2_process_discards, which
>>>> passes 64bit region length to bdrv_pdiscard where bytes (or sectors =
in
>>>> the past) parameter is int since its introduction in 0b919fae.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>

>>>> -    if (!bs || !bs->drv) {
>>>> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
>>>
>>> Should we describe this change in the commit message?
>>
>> Honestly, don't want to resend the series for this.
>=20
> I haven't reviewed the patches yet, but if this remains the only thing
> to change, it can be updated while applying the series if we have a
> specific proposal for a new commit message.

How about:

This fixes at least one overflow in qcow2_process_discards, which was
inadvertently truncating a 64-bit region length to the bdrv_pdiscard
'int bytes' parameter (previously bdrv_discard's 'int sectors') since
its introduction in 0b919fae.

By inlining the remaining portions of bdrv_check_byte_request() that are
still independent from the code previously validating a 32-bit request,
we can drop the call to that function. A request larger than 31 bits (or
the driver's max discard limit, if specified) is still split into
smaller chunks by the block layer before reaching the driver.


At any rate, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIbI4ACgkQp6FrSiUn
Q2r6sQf/XXjTsk75VmfCuh6wISaLexIoCpqItTSPix5QnEOWUFtPpv8leJh/tGit
jgNDeiJBisePVvR1UK5MFP8nSy2Chrqe/IuvQfaRBpeLC7YLpEtS9YiHc5FuyIXa
ka2u9cTtPhd3e2/t+LUQlCU7qhawVHzBXXJFfCDTX40xCJC8OUAUqRArAG/8bwaw
cxADZs/pGmEf4KcxbcblYEs+3n7MwABk3hEuQrA/pwffnB/fueV+nkfffgoc60he
XhvKAYU/wVlAM7dJkvmL2C4fepxc0hond0u+rEyhqhrBZtVuwj/WKontgnPd58N8
J6Kx4vrTj96eF3W5egY1IG1Y39667A==
=MmpC
-----END PGP SIGNATURE-----

--JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV--
