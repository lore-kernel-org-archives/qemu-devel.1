Received: from eggs.gnu.org ([2001:4830:134:3::10]:37887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRmy-0004Hs-Aj
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRmx-0005bW-6o
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:59:04 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-5-jsnow@redhat.com>
	<8290bf09-1525-a09b-5582-f20a70022025@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7009f691-12fb-d688-9edb-7196ee398386@redhat.com>
Date: Wed, 22 Aug 2018 13:58:51 +0200
MIME-Version: 1.0
In-Reply-To: <8290bf09-1525-a09b-5582-f20a70022025@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="30vgJe4BrdFrX4TCuE3fFItThbcu5ypIp"
Subject: Re: [Qemu-devel] [PATCH 4/7] block/commit: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30vgJe4BrdFrX4TCuE3fFItThbcu5ypIp
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com
Message-ID: <7009f691-12fb-d688-9edb-7196ee398386@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/7] block/commit: utilize job_exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-5-jsnow@redhat.com>
 <8290bf09-1525-a09b-5582-f20a70022025@redhat.com>
In-Reply-To: <8290bf09-1525-a09b-5582-f20a70022025@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:18, John Snow wrote:
>=20
>=20
> On 08/17/2018 03:04 PM, John Snow wrote:
>> Change the manual deferment to commit_complete into the implicit
>> callback to job_exit, renaming commit_complete to commit_exit.
>>
>> This conversion does change the timing of when job_completed is
>> called to after the bdrv_replace_node and bdrv_unref calls, which
>> could have implications for bjob->blk which will now be put down
>> after this cleanup.
>>
>> Kevin highlights that we did not take any permissions for that backend=

>> at job creation time, so it is safe to reorder these operations.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/commit.c | 20 ++++----------------
>>  1 file changed, 4 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index 4a17bb73ec..93c3b6a39e 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -68,19 +68,13 @@ static int coroutine_fn commit_populate(BlockBacke=
nd *bs, BlockBackend *base,
>>      return 0;
>>  }
>> =20
>> -typedef struct {
>> -    int ret;
>> -} CommitCompleteData;
>> -
>> -static void commit_complete(Job *job, void *opaque)
>> +static void commit_exit(Job *job)
>>  {
>>      CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.jo=
b);
>>      BlockJob *bjob =3D &s->common;
>> -    CommitCompleteData *data =3D opaque;
>>      BlockDriverState *top =3D blk_bs(s->top);
>>      BlockDriverState *base =3D blk_bs(s->base);
>>      BlockDriverState *commit_top_bs =3D s->commit_top_bs;
>> -    int ret =3D data->ret;
>>      bool remove_commit_top_bs =3D false;
>> =20
>>      /* Make sure commit_top_bs and top stay around until bdrv_replace=
_node() */
>> @@ -93,8 +87,8 @@ static void commit_complete(Job *job, void *opaque)
>> =20
>>      if (!job_is_cancelled(job) && ret =3D=3D 0) {
>=20
> forgot to actually squash the change in here that replaces `ret` with
> `job->ret`.

A better interface would be one function that is called when .run() was
successful, and one that is called when it was not.  (They can still
resolve into a single function in the job that is just called with a
boolean that's either true or false, but accessing *job to find out
whether .run() was successful or not seems kind of convoluted to me.)

Max


--30vgJe4BrdFrX4TCuE3fFItThbcu5ypIp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9T/sACgkQ9AfbAGHV
z0Bp5Af/Uth9XZ4xzNN+pE5wHHtJaXzkWLvK/iWQmqvtaQvY6q/gy4/SYfv9nTGn
3ogryaN2jeB/CH5hWwzRA+AGUi59WxW0RjHVEfh9YrM29EiPbl0Dwq4yW3Gj0+a8
1lcAjMZ/k6Aa8FEsbsimt693nAHHi6dGlydgGWtqJtalVRN8MTbw5k5+o40I81pS
0ci95FcOJ+H5qetzqgM9iN1gkm8fM5JmxrcZhU77xI6+TS4mQRDGd49SQdPAzuY4
hHN1uDZSAzJ7FwjB1g0Q8cdVpPUccUJC+sBxIVSFldJ5helWcOS3ydUWr2fshIUw
nZ3rfqw6hhMaJj2gna20mGy+CM3h+w==
=KEK0
-----END PGP SIGNATURE-----

--30vgJe4BrdFrX4TCuE3fFItThbcu5ypIp--
