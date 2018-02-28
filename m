Received: from eggs.gnu.org ([2001:4830:134:3::10]:58498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er2Un-0007g4-SJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er2Uj-0004ww-3c
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:14:13 -0500
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-6-mreitz@redhat.com>
	<20180227074413.GB21035@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2c81d46d-434d-d9bb-86b4-9a644bf0284a@redhat.com>
Date: Wed, 28 Feb 2018 15:13:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180227074413.GB21035@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8JYtbp0yXJR2Po7cYQcR0zoQUvIMlB5cJ"
Subject: Re: [Qemu-devel] [PATCH v2 05/16] block/mirror: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8JYtbp0yXJR2Po7cYQcR0zoQUvIMlB5cJ
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <2c81d46d-434d-d9bb-86b4-9a644bf0284a@redhat.com>
Subject: Re: [PATCH v2 05/16] block/mirror: Convert to coroutines
References: <20180122220806.22154-1-mreitz@redhat.com>
 <20180122220806.22154-6-mreitz@redhat.com>
 <20180227074413.GB21035@lemon.usersys.redhat.com>
In-Reply-To: <20180227074413.GB21035@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-27 08:44, Fam Zheng wrote:
> On Mon, 01/22 23:07, Max Reitz wrote:
>> @@ -101,7 +105,7 @@ static BlockErrorAction mirror_error_action(Mirror=
BlockJob *s, bool read,
>>      }
>>  }
>> =20
>> -static void mirror_iteration_done(MirrorOp *op, int ret)
>> +static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)=

>>  {
>>      MirrorBlockJob *s =3D op->s;
>>      struct iovec *iov;
>=20
> I think we want s/qemu_coroutine_enter/aio_co_wake/ in mirror_iteration=
_done().
> As an AIO callback before, this didn't matter, but now we are in an ter=
minating
> coroutine, so it is pointless to defer the termination, or even risky i=
n that we
> are in a aio_context_acquire/release section, but have already decremen=
ted
> s->in_flight, which is fishy.

I guess I'll still do the replacement, regardless of whether the next
patch overwrites it again...

>> @@ -138,9 +142,8 @@ static void mirror_iteration_done(MirrorOp *op, in=
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
>> @@ -157,9 +160,8 @@ static void mirror_write_complete(void *opaque, in=
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
>> @@ -174,8 +176,11 @@ static void mirror_read_complete(void *opaque, in=
t ret)
>> =20
>>          mirror_iteration_done(op, ret);
>>      } else {
>> -        blk_aio_pwritev(s->target, op->offset, &op->qiov,
>> -                        0, mirror_write_complete, op);
>> +        int ret;
>=20
> s/ret/ret2/ or drop the definition?
> because ret is already the paramter of the function.

Oh, right, yes, will do.

>> +
>> +        ret =3D blk_co_pwritev(s->target, op->offset,
>> +                             op->qiov.size, &op->qiov, 0);
>> +        mirror_write_complete(op, ret);
>>      }
>>      aio_context_release(blk_get_aio_context(s->common.blk));
>>  }
>=20
> <snip>
>=20
>> +static void coroutine_fn mirror_co_discard(void *opaque)
>> +{
>> +    MirrorOp *op =3D opaque;
>> +    int ret;
>> +
>> +    op->s->in_flight++;
>> +    op->s->bytes_in_flight +=3D op->bytes;
>> +    *op->bytes_handled =3D op->bytes;
>> +
>> +    ret =3D blk_co_pdiscard(op->s->target, op->offset, op->bytes);
>> +    mirror_write_complete(op, ret);
>>  }
>> =20
>>  static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
>>                                 unsigned bytes, MirrorMethod mirror_me=
thod)
>=20
> Doesn't mirror_perform need coroutine_fn annotation too?

I don't think it needs one.  We could give it one, but as far as I've
understood (which may be wrong), all functions that need to be run from
a coroutine need the tag -- but functions that may be called from either
coroutines or just normal code don't need it.

(And I think this function should be fine either way, so I don't think
it needs a tag.)


Also, thanks for reviewing! :-)

Max


--8JYtbp0yXJR2Po7cYQcR0zoQUvIMlB5cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqWuSESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8ZQIAJlqA5EFtc02ctJuaYxEI59sUqaOpzvs
d4GaGY8t070Tx7FARmnpiSQA97GmA7X2KFQb5O58oi4jpcV+KTnWOhrhllk4xoye
aRiNaycE9WW5MMB080U7iWYkjJgELv7J6a8EO2JgLpDRfx9b3QgU5exN5jG9v0wv
06mO9MG+RjLMFV+8FNZdIqEzzX7T0qwUXlDLxZcuv0FurKYjL+dCQoRjoJkjU1PJ
rfzgQJHN4/yUFLe5cAQtSRdC8esKrEPXrTJnkfMKzgH65kG9jAcqEQvlT3uXYymh
KeC9fsKcwqOaYkOiQsmt8Y4C0u5+KxSq2NoU0i74/eUkUkFiT3CG0r4=
=M9H1
-----END PGP SIGNATURE-----

--8JYtbp0yXJR2Po7cYQcR0zoQUvIMlB5cJ--
