Received: from eggs.gnu.org ([2001:4830:134:3::10]:51713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxhJO-0002U1-Re
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 18:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxhJN-00070n-Jm
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 18:29:42 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-4-eblake@redhat.com>
	<c8c520f0-7bd2-db54-bb07-3d1ee0cf87df@redhat.com>
	<87c590cd-e35e-81a7-c1ea-0efccdeed6ab@redhat.com>
	<b17bdc57-6203-cb15-c84d-2beda28f6b57@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e62e57d-407e-a9fb-5be7-1aeb5c8d26ec@redhat.com>
Date: Thu, 28 Sep 2017 17:29:22 -0500
MIME-Version: 1.0
In-Reply-To: <b17bdc57-6203-cb15-c84d-2beda28f6b57@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rnD5h6l1vUjA1wkDqqKbf71iEAlsQENrS"
Subject: Re: [Qemu-devel] [PATCH v4 03/23] block: Make
 bdrv_round_to_clusters() signature more useful
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rnD5h6l1vUjA1wkDqqKbf71iEAlsQENrS
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <8e62e57d-407e-a9fb-5be7-1aeb5c8d26ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/23] block: Make
 bdrv_round_to_clusters() signature more useful
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-4-eblake@redhat.com>
 <c8c520f0-7bd2-db54-bb07-3d1ee0cf87df@redhat.com>
 <87c590cd-e35e-81a7-c1ea-0efccdeed6ab@redhat.com>
 <b17bdc57-6203-cb15-c84d-2beda28f6b57@redhat.com>
In-Reply-To: <b17bdc57-6203-cb15-c84d-2beda28f6b57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 02:29 PM, John Snow wrote:
>=20
>=20
> On 09/26/2017 03:18 PM, Eric Blake wrote:
>> On 09/26/2017 01:51 PM, John Snow wrote:
>>>
>>>
>>> On 09/13/2017 12:03 PM, Eric Blake wrote:
>>>> In the process of converting sector-based interfaces to bytes,
>>>> I'm finding it easier to represent a byte count as a 64-bit
>>>> integer at the block layer (even if we are internally capped
>>>> by SIZE_MAX or even INT_MAX for individual transactions, it's
>>>> still nicer to not have to worry about truncation/overflow
>>>> issues on as many variables).  Update the signature of
>>>> bdrv_round_to_clusters() to uniformly use int64_t, matching
>>>> the signature already chosen for bdrv_is_allocated and the
>>>> fact that off_t is also a signed type, then adjust clients
>>>> according to the required fallout.
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>
>>
>>>> @@ -946,7 +946,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv=
(BdrvChild *child,
>>>>      struct iovec iov;
>>>>      QEMUIOVector bounce_qiov;
>>>>      int64_t cluster_offset;
>>>> -    unsigned int cluster_bytes;
>>>> +    int64_t cluster_bytes;
>>>>      size_t skip_bytes;
>>>>      int ret;
>>>>
>>>> @@ -967,6 +967,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv=
(BdrvChild *child,
>>>>      trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
>>>>                                     cluster_offset, cluster_bytes);
>>>>
>>>> +    assert(cluster_bytes < SIZE_MAX);
>>>
>>> later in this function, is there any real or imagined risk of
>>> cluster_bytes exceeding INT_MAX when it's passed to
>>> bdrv_co_do_pwrite_zeroes?
>>>
>>>>      iov.iov_len =3D cluster_bytes;
>>
>> cluster_bytes is the input 'unsigned int bytes' rounded out to cluster=

>=20
> Ah, yes, we're probably not going to exceed that, you're right.
>=20
>> boundaries, but where we know 'bytes <=3D BDRV_REQUEST_MAX_BYTES' (whi=
ch
>> is 2^31 - 511).  Still, I guess you are right that rounding to a clust=
er
>> size could produce a larger value of exactly 2^31 (bigger than INT_MAX=
,
>> but still fits in 32-bit unsigned int, so my assert was to make sure
>> that truncating 64 bits to size_t iov.iov_len still works on 32-bit
>> platforms).
>>
>> In theory, I don't think we ever attempt an unaligned operation near
>> 2^31 that would round up to INT_MAX overflow (if we can, that's a
>> pre-existing bug that should be fixed separately).
>>
>> Should I tighten the assertion to assert(cluster_bytes <=3D
>> BDRV_REQUEST_MAX_BYTES), then see if I can come up with a case where w=
e
>> can violate that?
>>
>=20
> *Only* if you think it's worth your time. You'd know better than me at
> this point if this is remotely possible or not. Just a simple width
> check that caught my eye.

I reproduced a test case - we have a pre-existing bug.  An update to
qemu-io coming up (I need to make it easy to turn on
BDRV_O_COPY_ON_READ); then a new iotests with my test case: create a
backing file with more than 2G of explicit 0, then open a brand new
wrapper qcow2 file and read 2G-512 bytes at offset 1024.  This will,
given default qcow2 cluster size of 64k, proceed to copy-on-write 2G+64k
of data; which fits fine in the pre-patch unsigned int or post-patch
int64_t, but becomes an unintended no-op in the bdrv_co_do_pwrite_zeroes.=


Took me the better part of a day to figure out how to provoke it in a
way appropriate for iotests, but I'm grateful you gave me the challenge.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rnD5h6l1vUjA1wkDqqKbf71iEAlsQENrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnNd8IACgkQp6FrSiUn
Q2pB2Qf/S8NeHcs7QtFSLPdbFczTItxTcDVhBkGKAPpVGq79U2uv5xjy5Fyq9bzA
ycvOWxx5EcsThsfE92ItNK5HamDe7M6YKf+GT98pfSkFCLMYCv/rGu8LNapRHYRR
EMWvtldkSGkGN9dgvtzubOYybNhwt7sfN+wbKM9DTYLjCUoHKgbA4LjpBK4AJUpw
rTw0EyqTeESGlaJBj97SQewWleseohiaS7KrneMXwIQlslgpiHLX2/Nub8CE3Lo1
Q2nOLDOYhrHbsH3smTAgsRg+gWMNoEFKyzddA6Gv/3lNdgJXORGJnE1BZc0V7s3g
X8AANxcdUPOMpO/dDYoctdBh7MhmmQ==
=lHtB
-----END PGP SIGNATURE-----

--rnD5h6l1vUjA1wkDqqKbf71iEAlsQENrS--
