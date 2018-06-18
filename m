Received: from eggs.gnu.org ([2001:4830:134:3::10]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fUuka-0006Z3-Qh
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fUukZ-0006hy-EM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:03:20 -0400
References: <20180613181823.13618-1-mreitz@redhat.com>
	<20180613181823.13618-3-mreitz@redhat.com>
	<20180614152239.GJ8564@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <34de4de1-87c6-4944-8161-d28580968017@redhat.com>
Date: Mon, 18 Jun 2018 16:03:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180614152239.GJ8564@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ULfnT7uewdI4Nzqh93RpqERJu0wLmyfrm"
Subject: Re: [Qemu-devel] [PATCH v5 02/14] block/mirror: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ULfnT7uewdI4Nzqh93RpqERJu0wLmyfrm
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow
 <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jeff Cody <jcody@redhat.com>
Message-ID: <34de4de1-87c6-4944-8161-d28580968017@redhat.com>
Subject: Re: [PATCH v5 02/14] block/mirror: Convert to coroutines
References: <20180613181823.13618-1-mreitz@redhat.com>
 <20180613181823.13618-3-mreitz@redhat.com>
 <20180614152239.GJ8564@localhost.localdomain>
In-Reply-To: <20180614152239.GJ8564@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-14 17:22, Kevin Wolf wrote:
> Am 13.06.2018 um 20:18 hat Max Reitz geschrieben:
>> In order to talk to the source BDS (and maybe in the future to the
>> target BDS as well) directly, we need to convert our existing AIO
>> requests into coroutine I/O requests.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>  block/mirror.c | 152 +++++++++++++++++++++++++++++-------------------=
-
>>  1 file changed, 90 insertions(+), 62 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index f5e240611b..47122482ff 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -78,6 +78,10 @@ typedef struct MirrorOp {
>>      QEMUIOVector qiov;
>>      int64_t offset;
>>      uint64_t bytes;
>> +
>> +    /* The pointee is set by mirror_co_read(), mirror_co_zero(), and
>> +     * mirror_co_discard() before yielding for the first time */
>> +    int64_t *bytes_handled;
>=20
> Should we at least document that this becomes invalid after the
> MirrorOp coroutine has yielded for the first time because it points to =
a
> stack variable of the caller which returns then?

Can do.

>>  } MirrorOp;
>> =20
>>  typedef enum MirrorMethod {
>> @@ -99,7 +103,7 @@ static BlockErrorAction mirror_error_action(MirrorB=
lockJob *s, bool read,
>>      }
>>  }
>> =20
>> -static void mirror_iteration_done(MirrorOp *op, int ret)
>> +static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)=

>>  {
>>      MirrorBlockJob *s =3D op->s;
>>      struct iovec *iov;
>> @@ -136,9 +140,8 @@ static void mirror_iteration_done(MirrorOp *op, in=
t ret)
>>      }
>>  }
>> =20
>> -static void mirror_write_complete(void *opaque, int ret)
>> +static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)=

>>  {
>> -    MirrorOp *op =3D opaque;
>>      MirrorBlockJob *s =3D op->s;
>> =20
>>      aio_context_acquire(blk_get_aio_context(s->common.blk));
>> @@ -155,9 +158,8 @@ static void mirror_write_complete(void *opaque, in=
t ret)
>>      aio_context_release(blk_get_aio_context(s->common.blk));
>>  }
>=20
> One of the effects of this conversion is that we hold the AioContext
> lock for s->common.blk recursively multiple times. I don't think
> anything calls drain in such sections (which would hang), so it's
> probably okay, but it could turn out to be a trap in the long run.

Sounds like something I'll be cleaning up in the planned followup.

https://git.xanclic.moe/XanClic/qemu/commit/0d2f888b9f96634b9665

>> -static void mirror_read_complete(void *opaque, int ret)
>> +static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
>>  {
>> -    MirrorOp *op =3D opaque;
>>      MirrorBlockJob *s =3D op->s;
>> =20
>>      aio_context_acquire(blk_get_aio_context(s->common.blk));
>> @@ -172,8 +174,9 @@ static void mirror_read_complete(void *opaque, int=
 ret)
>> =20
>>          mirror_iteration_done(op, ret);
>>      } else {
>> -        blk_aio_pwritev(s->target, op->offset, &op->qiov,
>> -                        0, mirror_write_complete, op);
>> +        ret =3D blk_co_pwritev(s->target, op->offset,
>> +                             op->qiov.size, &op->qiov, 0);
>> +        mirror_write_complete(op, ret);
>>      }
>>      aio_context_release(blk_get_aio_context(s->common.blk));
>>  }
>> @@ -230,60 +233,57 @@ static inline void mirror_wait_for_io(MirrorBloc=
kJob *s)
>>      s->waiting_for_io =3D false;
>>  }
>> =20
>> -/* Submit async read while handling COW.
>> - * Returns: The number of bytes copied after and including offset,
>> - *          excluding any bytes copied prior to offset due to alignme=
nt.
>> - *          This will be @bytes if no alignment is necessary, or
>> - *          (new_end - offset) if tail is rounded up or down due to
>> - *          alignment or buffer limit.
>> +/* Perform a mirror copy operation.
>> + *
>> + * *op->bytes_handled is set to the number of bytes copied after and
>> + * including offset, excluding any bytes copied prior to offset due
>> + * to alignment.  This will be op->bytes if no alignment is necessary=
,
>> + * or (new_end - op->offset) if the tail is rounded up or down due to=

>> + * alignment or buffer limit.
>>   */
>> -static uint64_t mirror_do_read(MirrorBlockJob *s, int64_t offset,
>> -                               uint64_t bytes)
>> +static void coroutine_fn mirror_co_read(void *opaque)
>>  {
>> +    MirrorOp *op =3D opaque;
>> +    MirrorBlockJob *s =3D op->s;
>>      BlockBackend *source =3D s->common.blk;
>>      int nb_chunks;
>>      uint64_t ret;
>> -    MirrorOp *op;
>>      uint64_t max_bytes;
>> =20
>>      max_bytes =3D s->granularity * s->max_iov;
>> =20
>>      /* We can only handle as much as buf_size at a time. */
>> -    bytes =3D MIN(s->buf_size, MIN(max_bytes, bytes));
>> -    assert(bytes);
>> -    assert(bytes < BDRV_REQUEST_MAX_BYTES);
>> -    ret =3D bytes;
>> +    op->bytes =3D MIN(s->buf_size, MIN(max_bytes, op->bytes));
>> +    assert(op->bytes);
>> +    assert(op->bytes < BDRV_REQUEST_MAX_BYTES);
>> +    *op->bytes_handled =3D op->bytes;
>> =20
>>      if (s->cow_bitmap) {
>> -        ret +=3D mirror_cow_align(s, &offset, &bytes);
>> +        *op->bytes_handled +=3D mirror_cow_align(s, &op->offset, &op-=
>bytes);
>>      }
>=20
> Actually, if we factor out this block, call it from mirror_perform() an=
d
> only assert the conditions here, we could get completely rid of that
> peculiar op->bytes_handled.

That is definitely something I'll clean up in the followup:

https://git.xanclic.moe/XanClic/qemu/commit/6cbe927e08dd1ec26a4c

I'd rather leave it in this series and worry about it later.  I
gradually phased out more and more nice-to-have things from this series
so it could get in at some point, and that apparently was one of those
things.

Max


--ULfnT7uewdI4Nzqh93RpqERJu0wLmyfrm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsnu5oACgkQ9AfbAGHV
z0AH6Af/fjgHewgvMDdjOKi9g8o4ru76ixiWwMUo9Z53gsep/xSbZq/SEnBkbe12
7BT+MSf6mksfsYeGxK+kvDO5MZfAx1GMW1NLB035U7Nipi9SQE+BrBFD3rtZdRG9
BZvL4umDDUG+XG7569B3KJSf8NpjqkSu1WgqOh6Vt4UW0gUB3ENF03kOjBtjGRfr
VCxXQC0y6AYaiulkHho1zYdSYBCp1qI/31FM67axugFtmHXc64y6AUd13/jdY8tR
jjqIcalGs8PvyXOCZAx27lap64us+Nf5fgvbvHzkNPy1MX3F2uftcd/kCNgSFto7
pCZc0AjVzAPeKe1AgBHHfUIfnaM2Iw==
=v8h1
-----END PGP SIGNATURE-----

--ULfnT7uewdI4Nzqh93RpqERJu0wLmyfrm--
