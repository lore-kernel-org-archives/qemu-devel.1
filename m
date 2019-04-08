Received: from eggs.gnu.org ([209.51.188.92]:54545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDVKK-0006FN-91
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDVKJ-0006j5-9h
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:32:48 -0400
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-3-eblake@redhat.com>
	<ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
	<d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
	<d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d14359d2-6178-eb32-c01a-b9d8e876e4ee@redhat.com>
Date: Mon, 8 Apr 2019 09:32:38 -0500
MIME-Version: 1.0
In-Reply-To: <d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv"
Subject: Re: [Qemu-devel] [PATCH 2/7] nbd/server: Trace server noncompliance
 on unaligned requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <d14359d2-6178-eb32-c01a-b9d8e876e4ee@redhat.com>
Subject: Re: [PATCH 2/7] nbd/server: Trace server noncompliance on unaligned
 requests
References: <20190403030526.12258-1-eblake@redhat.com>
 <20190403030526.12258-3-eblake@redhat.com>
 <ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
 <d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
 <d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
In-Reply-To: <d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 7:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> 05.04.2019 23:04, Eric Blake wrote:
>> On 4/5/19 9:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 03.04.2019 6:05, Eric Blake wrote:
>>>> We've recently added traces for clients to flag server non-complianc=
e;
>>>> let's do the same for servers to flag client non-compliance. Accordi=
ng
>>
>> Thus, s/Trace server/Trace client/ in the subject line.
>>

>>> Patch seems correct anyway, so if you are in a hurry, it's OK as is:
>>>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>
>> Here's what I'll squash in; I think it is obvious enough to still keep=

>> your R-b, if I send the pull request before you reply back.
>>

>> @@ -2136,7 +2136,10 @@ static int nbd_co_receive_request(NBDRequestDat=
a
>> *req, NBDRequest *request,
>>            * The block layer gracefully handles unaligned requests, bu=
t
>>            * it's still worth tracing client non-compliance
>>            */
>> -
>> trace_nbd_co_receive_align_compliance(nbd_cmd_lookup(request->type));
>> +        trace_nbd_co_receive_align_compliance(nbd_cmd_lookup(request-=
>type,
>> +                                                             request-=
>from,
>> +                                                             request-=
>len,
>> +
>> client->check_align));
>=20
> something strange here with brackets.

Yeah, I grabbed the diff before compile-testing, but fixed it before
pushing to my branch.


>> +++ w/nbd/trace-events
>> @@ -71,5 +71,5 @@ nbd_co_send_extents(uint64_t handle, unsigned int
>> extents, uint32_t id, uint64_t
>>   nbd_co_send_structured_error(uint64_t handle, int err, const char
>> *errname, const char *msg) "Send structured error reply: handle =3D %"=

>> PRIu64 ", error =3D %d (%s), msg =3D '%s'"
>>   nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type,
>> const char *name) "Decoding type: handle =3D %" PRIu64 ", type =3D %" =
PRIu16
>> " (%s)"
>>   nbd_co_receive_request_payload_received(uint64_t handle, uint32_t le=
n)
>> "Payload received: handle =3D %" PRIu64 ", len =3D %" PRIu32
>> -nbd_co_receive_align_compliance(const char *op) "client sent
>> non-compliant unaligned %s request"
>> +nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32=
_t
>> len, uint32_t align) "client sent non-compliant unaligned %s request:
>> from=3D0x%" PRIx64 ", len=3D0x%x, align=3D0x%x"
>=20
> %x or % PRIx32 - doesn't matter?

Will use PRIx32 for consistency.

>=20
>>   nbd_trip(void) "Reading request"
>>
>>
>>
>=20
> OK for me, thanks.

Thanks for a second look. Pull request will be out later today.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyrW4YACgkQp6FrSiUn
Q2rQfgf9G2Lz69PZGegesKt0WSdT1CDn9ZdrNT3X9IzjYYa0YSpI0CVAFoL/ZvQT
SmuHAPoNYgwj0+Iz9q1+cewcHmRVd0JZNerTHsaDiGCLLVYCpNCALJux2biTTB5c
syVxAQn6ZJfmYMybaDTh8YQo0cjtCGPVhdGEf03gbFA0mYQ1u7zgO7v6Ldo1rTrH
/JePakq1LzXTzm0BBDShOFBc37hJJDPZtQDDWePMNatR2PeF+aMoywbvECiSYFRX
XacsZTlt/8hTHLtU3aDUNGz//KygFl1UJOdHs3x7Y0NijrD0t7D3hnuS6Xm40HQu
DdWvltAWB6eek2NLseK6HzdQYUoCpA==
=iLCK
-----END PGP SIGNATURE-----

--d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv--
