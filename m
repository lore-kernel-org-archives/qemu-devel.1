Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJGB-0002G3-IJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJGA-0000lq-Ka
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:06:55 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-4-git-send-email-anton.nefedov@virtuozzo.com>
	<ac354ca7-a569-42f4-1aab-0274b269b50b@redhat.com>
	<48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
	<b3fdc845-173f-7d92-c157-4e83eb920af6@redhat.com>
	<16ae4c8c-4296-1583-8a65-055f1b2c02a9@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <864689e6-e335-e246-db25-26deb95bec3b@redhat.com>
Date: Thu, 1 Feb 2018 19:06:41 +0100
MIME-Version: 1.0
In-Reply-To: <16ae4c8c-4296-1583-8a65-055f1b2c02a9@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rBmq2NVmN0SouTrjMVUIs0MRjOmDHX6Ce"
Subject: Re: [Qemu-devel] [PATCH v7 3/9] block: introduce BDRV_REQ_ALLOCATE
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rBmq2NVmN0SouTrjMVUIs0MRjOmDHX6Ce
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <864689e6-e335-e246-db25-26deb95bec3b@redhat.com>
Subject: Re: [PATCH v7 3/9] block: introduce BDRV_REQ_ALLOCATE flag
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-4-git-send-email-anton.nefedov@virtuozzo.com>
 <ac354ca7-a569-42f4-1aab-0274b269b50b@redhat.com>
 <48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
 <b3fdc845-173f-7d92-c157-4e83eb920af6@redhat.com>
 <16ae4c8c-4296-1583-8a65-055f1b2c02a9@virtuozzo.com>
In-Reply-To: <16ae4c8c-4296-1583-8a65-055f1b2c02a9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-01 14:34, Anton Nefedov wrote:
> On 31/1/2018 8:31 PM, Max Reitz wrote:
>> On 2018-01-30 13:34, Anton Nefedov wrote:
>>> Offtop: does REQ_ZERO_WRITE override REQ_WRITE_COMPRESSED in this
>>> function? at least with !REQ_MAY_UNMAP it looks wrong
>>
>> Looks like zero detection will indeed override compression.=C2=A0 I th=
ink
>> that was intended, but I don't even have an opinion either way.
>>
>> Of course, it wouldn't be so nice if you tried to compress something a=
nd
>> then, because the zero write failed, you actually write uncompressed
>> zeroes...=C2=A0 But since zero detection is an optional feature, it mi=
ght be
>> your own fault if you enable it when you want compression anyway, and =
if
>> you write to some format/protocol combination that doesn't allow zero
>> writes.
>>
>> Max
>>
>=20
> Is it detection only? I guess in case the caller sets
> (REQ_ZERO_WRITE | REQ_COMPRESSED) it also fires here.

True, but that's the caller's "fault".  One of those things has to take
precedence.

And I've just noticed that when bdrv_co_do_pwrite_zeroes() falls back to
a bounce buffer, it passes the original flags (without
BDRV_REQ_ZERO_WRITE) to bdrv_driver_pwritev(), so compression will take
effect then.  So the only result is that we first try a zero write, and
if that fails, we do a compressed write.  That sounds reasonable to me.

(I mean, we could do it the other way around, but I firstly I don't
think it matters much and secondly it's probably better this way because
I'd suspect zero writes to be more efficient than compressing the bounce
buffer; at least that's how it is for qcow2.)

Max

> Looks like noone does that though, but for example backup might;
> it supports compression, and it also does a zero detection itself and
> calls write_zeroes() when it can.
> It sets REQ_MAY_UNMAP which should indeed override a compression, but
> unmap might be not supported.
>=20
> /Anton



--rBmq2NVmN0SouTrjMVUIs0MRjOmDHX6Ce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzVzESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdjQH/AzONwE2It50oS6xFW0Rs0jaz9OTPuJg
/PU3CwiKcIJrAezs647jVjsDKDcene4gOkHPxTADcj4I2RU1TKwAyVT5AH2akcFT
JwbBuGh3ipkJGlmNWX2QvcI3hVdk86oVEbFh9f6Xd4HD49sMyA/SCqkyTxI3nxZu
xAAaVRMseColKPyWQBavAaqKw0dJqZYZlECoCriYyJlb9kIxi/Y2vbHPvDz1ATce
QZWuxZznD3LTYQT9B9PySO5AKE65/Oj0m+zMRFWeuoEhtn6qrJk91H3Jpn4+71OO
/tKJrT2ho/7oXJl/ZnMrubpH8SH5llnEYnUu5fg1VKPqOth8wml3MpE=
=zZqH
-----END PGP SIGNATURE-----

--rBmq2NVmN0SouTrjMVUIs0MRjOmDHX6Ce--
