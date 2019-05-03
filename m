Received: from eggs.gnu.org ([209.51.188.92]:42974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYs0-0001gl-6m
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYrz-0006W0-4k
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:09:00 -0400
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
	<66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
	<35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <52acdba2-a13a-5323-a804-9cc6b680f2fb@redhat.com>
Date: Fri, 3 May 2019 16:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZppAl84phsH03XPiN6meRlOuYLnzJPjyN"
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZppAl84phsH03XPiN6meRlOuYLnzJPjyN
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com"
 <berto@igalia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>
Message-ID: <52acdba2-a13a-5323-a804-9cc6b680f2fb@redhat.com>
Subject: Re: [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve locking
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-8-vsementsov@virtuozzo.com>
 <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
 <66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
 <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
In-Reply-To: <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.04.19 11:44, Vladimir Sementsov-Ogievskiy wrote:
> 30.04.2019 11:38, Vladimir Sementsov-Ogievskiy wrote:
>> 29.04.2019 19:37, Max Reitz wrote:
>>> On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
>>>> Background: decryption will be done in threads, to take benefit of i=
t,
>>>> we should move it out of the lock first.
>>>
>>> ...which is safe after your commit c972fa123c73501b4, I presume.
>>>
>>> (At first glance, the patched looked a bit weird to me because it
>>> doesn't give a reason why dropping the lock around
>>> qcrypto_block_decrypt() would be OK.)
>>>
>>>> But let's go further: it turns out, that for locking around switch
>>>> cases we have only two variants: when we just do memset(0) not
>>>> releasing the lock (it is useless) and when we actually can handle t=
he
>>>> whole case out of the lock. So, refactor the whole thing to reduce
>>>> locked code region and make it clean.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>> ---
>>>> =C2=A0 block/qcow2.c | 46 ++++++++++++++++++++++--------------------=
----
>>>> =C2=A0 1 file changed, 22 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index 46e8e39da5..fcf92a7eb6 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -1983,6 +1983,7 @@ static coroutine_fn int qcow2_co_preadv(BlockD=
riverState *bs, uint64_t offset,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2=
_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
>>>
>>> Isn't this the only function in the loop that actually needs the lock=
?
>>> Wouldn't it make more sense to just take it around this call?
>>>
>>
>> Hmm, looks correct, I'll resend.
>>
>>
>=20
> Or not, actually, we may have several qcow2_get_data_offset calls under=
 one lock,
> if clusters are different kinds of ZERO. So, I think better to keep it =
as is for now.

Hm, but how is this relevant?  For one thing, if that was a problem if
some other party concurrently changes the image, then that would be a
problem in general.  Keeping the lock would hide it for different kinds
of read-as-zero clusters, but it would still appear if data clusters and
other clusters are interleaved, wouldn=E2=80=99t it?

Also, this is a coroutine.  As long as nothing yields, nothing gets
concurrent access.  I don=E2=80=99t see anything outside of
qcow2_get_cluster_offset() that could yield as long as we only see
read-as-zero clusters.

Max


--ZppAl84phsH03XPiN6meRlOuYLnzJPjyN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzMS3EACgkQ9AfbAGHV
z0BCGAgAgkgtEKuwKn2/BRPFl9bw8gk3AKwlVquIcDKq8vvzQFpPydbsSqloFEhA
Ysm/Oxq7kUx+nyT5okf0kG2riJ2muKS3YVMsgmeKcSRrfi9iEgfztfYF3qIwrIiz
veA9rji6xIWYTdBSIprKQ8QJuRmCE28ahUfzFVpTBFed8F1iSgnbyI06VbHjnBxo
3QaRgRzw43ktIaEAXYGzB6PbOxXOEz1zeI6QnJSjcUgBZ8AFj3/mbqF4bNv4M1dd
vglUAF8a8KepBRj/sum3kqaA64BIHmCzEj778pQK471PB+Hq2XxKW5dROK6rcYzt
D5jkjjc+2Vn4uE8PGRoCFY5f/yV47A==
=uQu1
-----END PGP SIGNATURE-----

--ZppAl84phsH03XPiN6meRlOuYLnzJPjyN--
