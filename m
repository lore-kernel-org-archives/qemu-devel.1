Received: from eggs.gnu.org ([2001:4830:134:3::10]:56733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1djoq0-0007AL-SA
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1djopv-0004kD-VX
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:42:00 -0400
Date: Mon, 21 Aug 2017 18:39:48 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170821153948.agdtsvy3m5u4jfip@postretch>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-4-el13635@mail.ntua.gr>
	<w51ziatm05h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ud4cy4eqvmphs2g"
Content-Disposition: inline
In-Reply-To: <w51ziatm05h.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] block: require job-id when device
 is a node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--4ud4cy4eqvmphs2g
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 05:05:30PM +0200, Alberto Garcia wrote:
>On Wed 09 Aug 2017 04:02:53 PM CEST, Manos Pitsidianakis wrote:
>> @@ -622,20 +622,14 @@ void *block_job_create(const char *job_id, const B=
lockJobDriver *driver,
>>          return NULL;
>>      }
>>
>> -    if (job_id =3D=3D NULL && !(flags & BLOCK_JOB_INTERNAL)) {
>> -        job_id =3D bdrv_get_device_name(bs);
>> -        if (!*job_id) {
>> -            error_setg(errp, "An explicit job ID is required for this n=
ode");
>> -            return NULL;
>> -        }
>> -    }
>> -
>> -    if (job_id) {
>> -        if (flags & BLOCK_JOB_INTERNAL) {
>> +    if (flags & BLOCK_JOB_INTERNAL) {
>> +        if (job_id) {
>>              error_setg(errp, "Cannot specify job ID for internal block =
job");
>>              return NULL;
>>          }
>
>When BLOCK_JOB_INTERNAL is set, then job_id must be NULL...
>
>> -
>> +    } else {
>> +        /* Require job-id. */
>> +        assert(job_id);
>>          if (!id_wellformed(job_id)) {
>>              error_setg(errp, "Invalid job ID '%s'", job_id);
>>              return NULL;
>> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
>> index f13ad05c0d..ff906808a6 100644
>> --- a/include/block/blockjob_int.h
>> +++ b/include/block/blockjob_int.h
>> @@ -112,8 +112,7 @@ struct BlockJobDriver {
>>
>>  /**
>>   * block_job_create:
>> - * @job_id: The id of the newly-created job, or %NULL to have one
>> - * generated automatically.
>> + * @job_id: The id of the newly-created job, must be non %NULL.
>
>...but here you say that it must not be NULL.
>
>And since job_id can be NULL in some cases I think I'd replace the
>assert(job_id) that you added to block_job_create() with a normal
>pointer check + error_setg().
>
>> @@ -93,9 +93,6 @@ static void test_job_ids(void)
>>      blk[1] =3D create_blk("drive1");
>>      blk[2] =3D create_blk("drive2");
>>
>> -    /* No job ID provided and the block backend has no name */
>> -    job[0] =3D do_test_id(blk[0], NULL, false);
>> -
>
>If you decide to handle NULL ids by returning and error instead of
>asserting, we should keep a couple of tests for that scenario.
>
>Berto
>

Thanks, I will change that. What cases are you thinking of besides=20
internal jobs though? And should documentation of block_job_create=20
reflect that internal jobs have job_id =3D=3D NULL?

--4ud4cy4eqvmphs2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlma/sQACgkQc2J8L2kN
9xCGUw/8C8/A0aNQQTjf3h/eSX2aKxZGjmX9oHPGXeVvIPHGRnKnpA0Q8cFw4cvy
p4x4+Uzb/YMrjnUjiGBb7SguXLom8ZdDBlQUWw3U6mLpiOGM++VC4KHAW6/5gucV
x4vfMFrL/05LgAZY+mznVZP1bQKCnD46nvFEsTPqaSCLG1GT/G15cuPSiwsmELC4
o9LDmZx1EIcwGvTdrnhoic5E+8PaJV9FvOnmq/Z8V5viKc3mw2DEycge1UzMwH80
Qbh8bbihbbt9rk2nPLkP4ocB+lBNgzDm0jeSE/qMem612c9UG0nI17dh3bqI+Siv
Qx1JpDexBg+V329I0Jb1gvowZWpcw/vTyMVmBLDeqLtXMsrsoedQtuHmv+mxMSZz
Q8BFD6pjas2dNKtka24orVMjMWZNbiZX9/TsZekSrBcAB3fdJIZAq5ZdrSRi2T0u
uDhc6Av3BYc0imQhtIh2qNfUYmDH2aC6Mb19HXp2sVnI7FNA4d+vyTFyIpSK/UAx
mb4EotCnvqpzxKj1Pfup8foxcSwFTVcqnCXVJqy271PayJZaH53GhB4As+p4HSoD
FqWGTg+od5tL8O5mYEHUKPzc984nIi8ZJDSHcrA8E6EWQ/UJtHrQBlLYWDq5eIXa
dgwN/jjC19l//INIpyRV8NTASvdZJ/wubm6kar3Ixa+LL5o364E=
=7V81
-----END PGP SIGNATURE-----

--4ud4cy4eqvmphs2g--
