Received: from eggs.gnu.org ([2001:4830:134:3::10]:46318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er3Jj-0003KE-Bn
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er3Ji-0005BX-C9
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:06:51 -0500
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-15-mreitz@redhat.com>
	<20180227093430.GE25412@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <67817fcf-7014-8b38-714a-803fe41a7016@redhat.com>
Date: Wed, 28 Feb 2018 16:06:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180227093430.GE25412@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SfQAXU0nqSyzImZMPHkfboCQjWQBsl2UH"
Subject: Re: [Qemu-devel] [PATCH v2 14/16] block/mirror: Add active mirroring
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
--SfQAXU0nqSyzImZMPHkfboCQjWQBsl2UH
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <67817fcf-7014-8b38-714a-803fe41a7016@redhat.com>
Subject: Re: [PATCH v2 14/16] block/mirror: Add active mirroring
References: <20180122220806.22154-1-mreitz@redhat.com>
 <20180122220806.22154-15-mreitz@redhat.com>
 <20180227093430.GE25412@lemon.usersys.redhat.com>
In-Reply-To: <20180227093430.GE25412@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-27 10:34, Fam Zheng wrote:
> On Mon, 01/22 23:08, Max Reitz wrote:
>> @@ -1151,7 +1285,48 @@ static int coroutine_fn bdrv_mirror_top_preadv(=
BlockDriverState *bs,
>>  static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,=

>>      uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
>>  {
>> -    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
>> +    MirrorOp *op =3D NULL;
>> +    MirrorBDSOpaque *s =3D bs->opaque;
>> +    QEMUIOVector bounce_qiov;
>> +    void *bounce_buf;
>> +    int ret =3D 0;
>> +    bool copy_to_target;
>> +
>> +    copy_to_target =3D s->job->ret >=3D 0 &&
>> +                     s->job->copy_mode =3D=3D MIRROR_COPY_MODE_WRITE_=
BLOCKING;
>> +
>> +    if (copy_to_target) {
>> +        /* The guest might concurrently modify the data to write; but=

>> +         * the data on source and destination must match, so we have
>> +         * to use a bounce buffer if we are going to write to the
>> +         * target now. */
>> +        bounce_buf =3D qemu_blockalign(bs, bytes);
>> +        iov_to_buf_full(qiov->iov, qiov->niov, 0, bounce_buf, bytes);=

>=20
> Quorum doesn't use a bounce buffer, so I think we can get away without =
it too: a
> guest concurrently modifying the buffer isn't a concern in practice.
>=20
>> +
>> +        qemu_iovec_init(&bounce_qiov, 1);
>> +        qemu_iovec_add(&bounce_qiov, bounce_buf, bytes);
>> +        qiov =3D &bounce_qiov;
>> +
>> +        op =3D active_write_prepare(s->job, offset, bytes);
>> +    }
>> +
>> +    ret =3D bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);=

>> +    if (ret < 0) {
>> +        goto out;
>> +    }
>> +
>> +    if (copy_to_target) {
>> +        do_sync_target_write(s->job, offset, bytes, qiov, flags);
>> +    }
>> +
>> +out:
>> +    if (copy_to_target) {
>> +        active_write_settle(op);
>> +
>> +        qemu_iovec_destroy(&bounce_qiov);
>> +        qemu_vfree(bounce_buf);
>> +    }
>> +    return ret;
>>  }
>> =20
>>  static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
>=20
> Don't you need to update bdrv_mirror_top_pdiscard and bdrv_mirror_top_p=
writev
> too?

Now that you mention it...

Max


--SfQAXU0nqSyzImZMPHkfboCQjWQBsl2UH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqWxYASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYUMH/1YVR5YBNcYJWfDsThMa9G7rI2k5xDnR
oAMyuVrjjYA6EjkFeUe+21ql/QENok3bA0SrGPr82ZGmAHLl1GaepRlUjkEywdO5
Ic+tRxh2kWuaS1cKwaSB8ol8GHLwn3Xv9+K3THyTZdNFdf/lRJw2eaBYp5MP25NS
EeoBYK6PZJC9c7INEwMkKML4W4OZMj26vB1cRt6r6+eMbtlRrauSDjj+8JmcJDH6
2XEjPO5wjXdY1ZDSGEqUMHXEXLY5d12ZQhIkJzsSHaGBM0Nva/KNfcZ0FL2NhxXv
A3khCyx3KRZ0SWJSSQSly8Myy2F5wS3WZjchNqJbdYyXzVg2QfNsetE=
=d3lW
-----END PGP SIGNATURE-----

--SfQAXU0nqSyzImZMPHkfboCQjWQBsl2UH--
