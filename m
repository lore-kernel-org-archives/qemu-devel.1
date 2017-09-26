Received: from eggs.gnu.org ([2001:4830:134:3::10]:59026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwvNv-0006tc-7F
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwvNu-00087L-2x
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:19:11 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-4-eblake@redhat.com>
	<c8c520f0-7bd2-db54-bb07-3d1ee0cf87df@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <87c590cd-e35e-81a7-c1ea-0efccdeed6ab@redhat.com>
Date: Tue, 26 Sep 2017 14:18:54 -0500
MIME-Version: 1.0
In-Reply-To: <c8c520f0-7bd2-db54-bb07-3d1ee0cf87df@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AM8C7SvK5J9fMGdDORGqxjQiXcchKNAQO"
Subject: Re: [Qemu-devel] [PATCH v4 03/23] block: Make
 bdrv_round_to_clusters() signature more useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AM8C7SvK5J9fMGdDORGqxjQiXcchKNAQO
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <87c590cd-e35e-81a7-c1ea-0efccdeed6ab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/23] block: Make
 bdrv_round_to_clusters() signature more useful
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-4-eblake@redhat.com>
 <c8c520f0-7bd2-db54-bb07-3d1ee0cf87df@redhat.com>
In-Reply-To: <c8c520f0-7bd2-db54-bb07-3d1ee0cf87df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 01:51 PM, John Snow wrote:
>=20
>=20
> On 09/13/2017 12:03 PM, Eric Blake wrote:
>> In the process of converting sector-based interfaces to bytes,
>> I'm finding it easier to represent a byte count as a 64-bit
>> integer at the block layer (even if we are internally capped
>> by SIZE_MAX or even INT_MAX for individual transactions, it's
>> still nicer to not have to worry about truncation/overflow
>> issues on as many variables).  Update the signature of
>> bdrv_round_to_clusters() to uniformly use int64_t, matching
>> the signature already chosen for bdrv_is_allocated and the
>> fact that off_t is also a signed type, then adjust clients
>> according to the required fallout.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>

>> @@ -946,7 +946,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(B=
drvChild *child,
>>      struct iovec iov;
>>      QEMUIOVector bounce_qiov;
>>      int64_t cluster_offset;
>> -    unsigned int cluster_bytes;
>> +    int64_t cluster_bytes;
>>      size_t skip_bytes;
>>      int ret;
>>
>> @@ -967,6 +967,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(B=
drvChild *child,
>>      trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
>>                                     cluster_offset, cluster_bytes);
>>
>> +    assert(cluster_bytes < SIZE_MAX);
>=20
> later in this function, is there any real or imagined risk of
> cluster_bytes exceeding INT_MAX when it's passed to
> bdrv_co_do_pwrite_zeroes?
>=20
>>      iov.iov_len =3D cluster_bytes;

cluster_bytes is the input 'unsigned int bytes' rounded out to cluster
boundaries, but where we know 'bytes <=3D BDRV_REQUEST_MAX_BYTES' (which
is 2^31 - 511).  Still, I guess you are right that rounding to a cluster
size could produce a larger value of exactly 2^31 (bigger than INT_MAX,
but still fits in 32-bit unsigned int, so my assert was to make sure
that truncating 64 bits to size_t iov.iov_len still works on 32-bit
platforms).

In theory, I don't think we ever attempt an unaligned operation near
2^31 that would round up to INT_MAX overflow (if we can, that's a
pre-existing bug that should be fixed separately).

Should I tighten the assertion to assert(cluster_bytes <=3D
BDRV_REQUEST_MAX_BYTES), then see if I can come up with a case where we
can violate that?

> Everything else looks obviously correct to me.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AM8C7SvK5J9fMGdDORGqxjQiXcchKNAQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKqB4ACgkQp6FrSiUn
Q2qTMQf+NUIC5PNVGZqYpSWlZiVjkOwvul2T1P3fIahzGi//X01VhT24QOIUYAEO
TTLWFhDpO48hGjVQZhCKL3Tp1MqxvtyCZ2+VcKwDeWxBeBk6XinRnqpbSy+8gQFD
9yrQ0kKZ7OMrgGsNOFIgfyWKjDAgMkPJAP+9s2grLsws43+GMTDa2Qw9i7guqMDN
b+KBxDCHwsh0DjDuiTc6z1AM7sT/vR2MaTNu941O77naVvqGNuEdgalJlPu8gy1V
m743yaHcN+3iLH9ZgMVZJerdAFu90+rE1n/94KsUUWDTJR/6hsKZSx9uF8LTpHhP
siSXgcplemyaj9dmSkJuCAtYs0QxPg==
=6BUA
-----END PGP SIGNATURE-----

--AM8C7SvK5J9fMGdDORGqxjQiXcchKNAQO--
