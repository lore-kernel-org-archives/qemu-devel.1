Received: from eggs.gnu.org ([2001:4830:134:3::10]:50474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF0ab-0003j6-9Y
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 11:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF0aa-0003Hy-7J
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 11:31:01 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
	<97df2225-908c-e817-8364-2454f1451768@redhat.com>
	<1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <efa75e61-f1f7-478f-b5b5-ab39491761e2@redhat.com>
Date: Wed, 15 Nov 2017 17:30:44 +0100
MIME-Version: 1.0
In-Reply-To: <1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="peoGXChqhLOxwx3hreaCN4bv7qsiPp3cd"
Subject: Re: [Qemu-devel] [PATCH 2/5] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--peoGXChqhLOxwx3hreaCN4bv7qsiPp3cd
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <efa75e61-f1f7-478f-b5b5-ab39491761e2@redhat.com>
Subject: Re: [PATCH 2/5] qcow2: multiple clusters write compressed
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
 <97df2225-908c-e817-8364-2454f1451768@redhat.com>
 <1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
In-Reply-To: <1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 17:28, Anton Nefedov wrote:
> On 15/11/2017 6:11 PM, Max Reitz wrote:
>> On 2017-11-14 11:16, Anton Nefedov wrote:
>>> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>>
>>> At the moment, qcow2_co_pwritev_compressed can process the requests s=
ize
>>> less than or equal to one cluster. This patch added possibility to wr=
ite
>>> compressed data in the QCOW2 more than one cluster. The implementatio=
n
>>> is simple, we just split large requests into separate clusters and wr=
ite
>>> using existing functionality. For unaligned requests we use a workaro=
und
>>> and do write data without compression.
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> ---
>>> =C2=A0 block/qcow2.c | 77
>>> +++++++++++++++++++++++++++++++++++++++++++----------------
>>> =C2=A0 1 file changed, 56 insertions(+), 21 deletions(-)
>>
>> On one hand, it might be better to do this centrally somewhere in
>> block/io.c.=C2=A0 On the other, that would require more work because i=
t would
>> probably mean having to introduce another field in BlockLimits, and it=

>> wouldn't do much -- because qcow (v1) is, well, qcow v1...=C2=A0 And v=
mdk
>> seems to completely not care about this single cluster limitation.=C2=A0=
 So
>> for now we probably wouldn't even gain anything by doing this in
>> block/io.c.
>>
>> So long story short, it's OK to do this locally in qcow2, yes.
>>
>=20
> [..]
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_iovec_reset(&hd_qiov=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chunk_size =3D MIN(bytes,=
 s->cluster_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_iovec_concat(&hd_qio=
v, qiov, curr_off, chunk_size);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_co_pwritev_=
cluster_compressed(bs, offset +
>>> curr_off,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 chunk_size,
>>> &hd_qiov);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOTSUP) =
{
>>
>> Why this?=C2=A0 I mean, I can see the appeal, but then we should proba=
bly
>> actually return -ENOTSUP somewhere (e.g. for unaligned clusters and th=
e
>> like) -- and we should not abort if offset_into_cluster(s, cluster) is=

>> true, but we should write the header uncompressed and compress the mai=
n
>> bulk.
>>
>> Max
>>
>=20
> Right, sorry, missed this part when porting the patch.
>=20
> I think this needs to be removed (and the commit message fixed
> accordingly).
> Returning an error, rather than silently falling back to uncompressed
> seems preferable to me. "Compressing writers" (backup, img convert and
> now stream) are aware that they have to cluster-align, and if they fail=

> to do so that means there is an error somewhere.

OK for me.

> If it won't return an error anymore, then the unaligned tail shouldn't
> either. So we can end up 'letting' the callers send small unaligned
> requests which will never get compressed.

Either way is fine.  It just looks to me like vmdk falls back to
uncompressed writes, so it's not like it would be completely new behavior=
=2E..

(But I won't judge whether what vmdk does is a good idea.)

Max


--peoGXChqhLOxwx3hreaCN4bv7qsiPp3cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMa7QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgCcH/jdxUsAiR59dkOxpfQ3gEdDHaOA3aooA
Qq8NAid7c8UXEX4DksYLU4u2EGY/k2/p4kJv/jTd7UxQYViit17dscdJs2iGAEOC
V8M362DT0YfM6rcFqxwIFm84MzXGtvDCxQ3uoYlJLzEirAphrQG00Gx5ZZGtzxgF
LOkofRrlywvXJsBQpfasBvHjb9DJQ67WdKvzZcNGn5t6HyIjZ0n/cu+8q8o/yiQs
rnYK7SUBpC+uDMu6G1affbGnxqKlMUPTW4ocMHonVMLpbaZe524ecILyvWzEr0ZO
luHljH4KEv2lTR6T81o4fwS0bHY8YLMBHtO9qcuH8U5coYoMxszimE0=
=zuJC
-----END PGP SIGNATURE-----

--peoGXChqhLOxwx3hreaCN4bv7qsiPp3cd--
