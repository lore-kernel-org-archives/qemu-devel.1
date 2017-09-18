Received: from eggs.gnu.org ([2001:4830:134:3::10]:54413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtz6o-0007Wm-D5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtz6m-0007Bz-Ho
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:41:22 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-6-mreitz@redhat.com>
	<20170918060222.GE15551@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c1ccf6e5-4729-6e33-0dca-e91d8ce3c379@redhat.com>
Date: Mon, 18 Sep 2017 18:41:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170918060222.GE15551@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eC0k6e0JeWRTWWHwG7dBuCTuDIpETvWHe"
Subject: Re: [Qemu-devel] [PATCH 05/18] block/mirror: Convert to coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eC0k6e0JeWRTWWHwG7dBuCTuDIpETvWHe
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <c1ccf6e5-4729-6e33-0dca-e91d8ce3c379@redhat.com>
Subject: Re: [PATCH 05/18] block/mirror: Convert to coroutines
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-6-mreitz@redhat.com> <20170918060222.GE15551@lemon.lan>
In-Reply-To: <20170918060222.GE15551@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 08:02, Fam Zheng wrote:
> On Wed, 09/13 20:18, Max Reitz wrote:
>> In order to talk to the source BDS (and maybe in the future to the
>> target BDS as well) directly, we need to convert our existing AIO
>> requests into coroutine I/O requests.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/mirror.c | 134 +++++++++++++++++++++++++++++++++---------------=
---------
>>  1 file changed, 78 insertions(+), 56 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 4664b0516f..2b3297aa61 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -80,6 +80,9 @@ typedef struct MirrorOp {
>>      QEMUIOVector qiov;
>>      int64_t offset;
>>      uint64_t bytes;
>> +
>> +    /* Set by mirror_co_read() before yielding for the first time */
>> +    uint64_t bytes_copied;
>>  } MirrorOp;
>> =20
>>  typedef enum MirrorMethod {
>> @@ -101,7 +104,7 @@ static BlockErrorAction mirror_error_action(Mirror=
BlockJob *s, bool read,
>>      }
>>  }
>> =20
>> -static void mirror_iteration_done(MirrorOp *op, int ret)
>> +static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)=

>>  {
>>      MirrorBlockJob *s =3D op->s;
>>      struct iovec *iov;
>> @@ -138,9 +141,8 @@ static void mirror_iteration_done(MirrorOp *op, in=
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
>> @@ -158,9 +160,8 @@ static void mirror_write_complete(void *opaque, in=
t ret)
>>      aio_context_release(blk_get_aio_context(s->common.blk));
>>  }
>> =20
>> -static void mirror_read_complete(void *opaque, int ret)
>> +static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
>>  {
>> -    MirrorOp *op =3D opaque;
>>      MirrorBlockJob *s =3D op->s;
>> =20
>>      aio_context_acquire(blk_get_aio_context(s->common.blk));
>> @@ -176,8 +177,11 @@ static void mirror_read_complete(void *opaque, in=
t ret)
>> =20
>>          mirror_iteration_done(op, ret);
>>      } else {
>> -        blk_aio_pwritev(s->target, op->offset, &op->qiov,
>> -                        0, mirror_write_complete, op);
>> +        int ret;
>> +
>> +        ret =3D blk_co_pwritev(s->target, op->offset,
>> +                             op->qiov.size, &op->qiov, 0);
>> +        mirror_write_complete(op, ret);
>>      }
>>      aio_context_release(blk_get_aio_context(s->common.blk));
>>  }
>> @@ -242,53 +246,49 @@ static inline void mirror_wait_for_io(MirrorBloc=
kJob *s)
>>   *          (new_end - offset) if tail is rounded up or down due to
>>   *          alignment or buffer limit.
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
>> +    op->bytes_copied =3D op->bytes;
>> =20
>>      if (s->cow_bitmap) {
>> -        ret +=3D mirror_cow_align(s, &offset, &bytes);
>> +        op->bytes_copied +=3D mirror_cow_align(s, &op->offset, &op->b=
ytes);
>>      }
>> -    assert(bytes <=3D s->buf_size);
>> +    /* Cannot exceed BDRV_REQUEST_MAX_BYTES + INT_MAX */
>> +    assert(op->bytes_copied <=3D UINT_MAX);
>> +    assert(op->bytes <=3D s->buf_size);
>>      /* The offset is granularity-aligned because:
>>       * 1) Caller passes in aligned values;
>>       * 2) mirror_cow_align is used only when target cluster is larger=
=2E */
>> -    assert(QEMU_IS_ALIGNED(offset, s->granularity));
>> +    assert(QEMU_IS_ALIGNED(op->offset, s->granularity));
>>      /* The range is sector-aligned, since bdrv_getlength() rounds up.=
 */
>> -    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>> -    nb_chunks =3D DIV_ROUND_UP(bytes, s->granularity);
>> +    assert(QEMU_IS_ALIGNED(op->bytes, BDRV_SECTOR_SIZE));
>> +    nb_chunks =3D DIV_ROUND_UP(op->bytes, s->granularity);
>> =20
>>      while (s->buf_free_count < nb_chunks) {
>> -        trace_mirror_yield_in_flight(s, offset, s->in_flight);
>> +        trace_mirror_yield_in_flight(s, op->offset, s->in_flight);
>>          mirror_wait_for_io(s);
>>      }
>> =20
>> -    /* Allocate a MirrorOp that is used as an AIO callback.  */
>> -    op =3D g_new(MirrorOp, 1);
>> -    op->s =3D s;
>> -    op->offset =3D offset;
>> -    op->bytes =3D bytes;
>> -
>>      /* Now make a QEMUIOVector taking enough granularity-sized chunks=

>>       * from s->buf_free.
>>       */
>>      qemu_iovec_init(&op->qiov, nb_chunks);
>>      while (nb_chunks-- > 0) {
>>          MirrorBuffer *buf =3D QSIMPLEQ_FIRST(&s->buf_free);
>> -        size_t remaining =3D bytes - op->qiov.size;
>> +        size_t remaining =3D op->bytes - op->qiov.size;
>> =20
>>          QSIMPLEQ_REMOVE_HEAD(&s->buf_free, next);
>>          s->buf_free_count--;
>> @@ -297,53 +297,75 @@ static uint64_t mirror_do_read(MirrorBlockJob *s=
, int64_t offset,
>> =20
>>      /* Copy the dirty cluster.  */
>>      s->in_flight++;
>> -    s->bytes_in_flight +=3D bytes;
>> -    trace_mirror_one_iteration(s, offset, bytes);
>> +    s->bytes_in_flight +=3D op->bytes;
>> +    trace_mirror_one_iteration(s, op->offset, op->bytes);
>> =20
>> -    blk_aio_preadv(source, offset, &op->qiov, 0, mirror_read_complete=
, op);
>> -    return ret;
>> +    ret =3D blk_co_preadv(source, op->offset, op->bytes, &op->qiov, 0=
);
>> +    mirror_read_complete(op, ret);
>>  }
>> =20
>> -static void mirror_do_zero_or_discard(MirrorBlockJob *s,
>> -                                      int64_t offset,
>> -                                      uint64_t bytes,
>> -                                      bool is_discard)
>> +static void coroutine_fn mirror_co_zero(void *opaque)
>>  {
>> -    MirrorOp *op;
>> +    MirrorOp *op =3D opaque;
>> +    int ret;
>> =20
>> -    /* Allocate a MirrorOp that is used as an AIO callback. The qiov =
is zeroed
>> -     * so the freeing in mirror_iteration_done is nop. */
>> -    op =3D g_new0(MirrorOp, 1);
>> -    op->s =3D s;
>> -    op->offset =3D offset;
>> -    op->bytes =3D bytes;
>> +    op->s->in_flight++;
>> +    op->s->bytes_in_flight +=3D op->bytes;
>> =20
>> -    s->in_flight++;
>> -    s->bytes_in_flight +=3D bytes;
>> -    if (is_discard) {
>> -        blk_aio_pdiscard(s->target, offset,
>> -                         op->bytes, mirror_write_complete, op);
>> -    } else {
>> -        blk_aio_pwrite_zeroes(s->target, offset,
>> -                              op->bytes, s->unmap ? BDRV_REQ_MAY_UNMA=
P : 0,
>> -                              mirror_write_complete, op);
>> -    }
>> +    ret =3D blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes=
,
>> +                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0)=
;
>> +    mirror_write_complete(op, ret);
>> +}
>> +
>> +static void coroutine_fn mirror_co_discard(void *opaque)
>> +{
>> +    MirrorOp *op =3D opaque;
>> +    int ret;
>> +
>> +    op->s->in_flight++;
>> +    op->s->bytes_in_flight +=3D op->bytes;
>> +
>> +    ret =3D blk_co_pdiscard(op->s->target, op->offset, op->bytes);
>> +    mirror_write_complete(op, ret);
>>  }
>> =20
>>  static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
>>                                 unsigned bytes, MirrorMethod mirror_me=
thod)
>>  {
>> +    MirrorOp *op;
>> +    Coroutine *co;
>> +    unsigned ret =3D bytes;
>> +
>> +    op =3D g_new(MirrorOp, 1);
>> +    *op =3D (MirrorOp){
>> +        .s      =3D s,
>> +        .offset =3D offset,
>> +        .bytes  =3D bytes,
>> +    };
>> +
>>      switch (mirror_method) {
>>      case MIRROR_METHOD_COPY:
>> -        return mirror_do_read(s, offset, bytes);
>> +        co =3D qemu_coroutine_create(mirror_co_read, op);
>> +        break;
>>      case MIRROR_METHOD_ZERO:
>> +        co =3D qemu_coroutine_create(mirror_co_zero, op);
>> +        break;
>>      case MIRROR_METHOD_DISCARD:
>> -        mirror_do_zero_or_discard(s, offset, bytes,
>> -                                  mirror_method =3D=3D MIRROR_METHOD_=
DISCARD);
>> -        return bytes;
>> +        co =3D qemu_coroutine_create(mirror_co_discard, op);
>> +        break;
>>      default:
>>          abort();
>>      }
>> +
>> +    qemu_coroutine_enter(co);
>> +
>> +    if (mirror_method =3D=3D MIRROR_METHOD_COPY) {
>> +        /* Same assertion as in mirror_co_read() */
>> +        assert(op->bytes_copied <=3D UINT_MAX);
>> +        ret =3D op->bytes_copied;
>> +    }
>=20
> This special casing is a bit ugly. Can you just make mirror_co_zero and=

> mirror_co_discard set op->bytes_copied too? (and perhaps rename to
> op->bytes_handled) If so the comment in MirrorOp needs an update too.

Sure.

> And is it better to initialize it to -1 before entering coroutine, then=
 assert
> it is !=3D -1 afterwards?

Sounds good, will do.

Max


--eC0k6e0JeWRTWWHwG7dBuCTuDIpETvWHe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm/9x0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AioUH/1QJ+1rccKvq6gbWXVETo3GciH81hcLm
nADE5Jsiug46qKfkFr2KzvGAcN/QLIXUmbZT2U/g1j1h/4do4+4ow9F7gtFtQ4LB
Js768l0i4bDUg12bPXFooJJkzgj6y1MuTR3qvfOzp6R+bJJU74roel9xHeejmdad
qwr7vYqvcCDjUQYhy2cC5dlhB2k/RJFoqu2lmBNrJxWwwuq0m9NuAYsbrV6cSsgQ
POPGRZuUAJccSNcjM8nckYg7Ak9h+8OTN+34Rg7I5ltgaAPcSIV8xArltWC8n5EN
292UMj9oK6HbcjWN4an7KDHGsax2f01HxOzCzfIypZjm0iGlQQjsiU4=
=Gmxk
-----END PGP SIGNATURE-----

--eC0k6e0JeWRTWWHwG7dBuCTuDIpETvWHe--
