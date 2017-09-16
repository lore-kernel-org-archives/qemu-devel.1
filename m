Received: from eggs.gnu.org ([2001:4830:134:3::10]:39646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtDcI-0003oV-Fl
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 09:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtDcH-0006Mm-Dk
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 09:58:42 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-16-mreitz@redhat.com>
	<20170914155738.GE7370@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
Date: Sat, 16 Sep 2017 15:58:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170914155738.GE7370@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FvXdb8bLvUKh8nObPwr0qtcxgdBpqAhpN"
Subject: Re: [Qemu-devel] [PATCH 15/18] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FvXdb8bLvUKh8nObPwr0qtcxgdBpqAhpN
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
Subject: Re: [PATCH 15/18] block/mirror: Add active mirroring
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-16-mreitz@redhat.com>
 <20170914155738.GE7370@stefanha-x1.localdomain>
In-Reply-To: <20170914155738.GE7370@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-14 17:57, Stefan Hajnoczi wrote:
> On Wed, Sep 13, 2017 at 08:19:07PM +0200, Max Reitz wrote:
>> This patch implements active synchronous mirroring.  In active mode, t=
he
>> passive mechanism will still be in place and is used to copy all
>> initially dirty clusters off the source disk; but every write request
>> will write data both to the source and the target disk, so the source
>> cannot be dirtied faster than data is mirrored to the target.  Also,
>> once the block job has converged (BLOCK_JOB_READY sent), source and
>> target are guaranteed to stay in sync (unless an error occurs).
>>
>> Optionally, dirty data can be copied to the target disk on read
>> operations, too.
>>
>> Active mode is completely optional and currently disabled at runtime. =
 A
>> later patch will add a way for users to enable it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-core.json |  23 +++++++
>>  block/mirror.c       | 187 ++++++++++++++++++++++++++++++++++++++++++=
+++++++--
>>  2 files changed, 205 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index bb11815608..e072cfa67c 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -938,6 +938,29 @@
>>    'data': ['top', 'full', 'none', 'incremental'] }
>> =20
>>  ##
>> +# @MirrorCopyMode:
>> +#
>> +# An enumeration whose values tell the mirror block job when to
>> +# trigger writes to the target.
>> +#
>> +# @passive: copy data in background only.
>> +#
>> +# @active-write: when data is written to the source, write it
>> +#                (synchronously) to the target as well.  In addition,=

>> +#                data is copied in background just like in @passive
>> +#                mode.
>> +#
>> +# @active-read-write: write data to the target (synchronously) both
>> +#                     when it is read from and written to the source.=

>> +#                     In addition, data is copied in background just
>> +#                     like in @passive mode.
>=20
> I'm not sure the terms "active"/"passive" are helpful.  "Active commit"=

> means committing the top-most BDS while the guest is accessing it.  The=

> "passive" mirror block still works on the top-most BDS while the guest
> is accessing it.
>=20
> Calling it "asynchronous" and "synchronous" is clearer to me.  It's als=
o
> the terminology used in disk replication (e.g. DRBD).

I'd be OK with that, too, but I think I remember that in the past at
least Kevin made a clear distinction between active/passive and
sync/async when it comes to mirroring.

> Ideally the user wouldn't have to worry about async vs sync because QEM=
U
> would switch modes as appropriate in order to converge.  That way
> libvirt also doesn't have to worry about this.

So here you mean async/sync in the way I meant it, i.e., whether the
mirror operations themselves are async/sync?

Maybe we could call the the passive mode "background" and the active
mode "synchronous" (or maybe even "foreground")?  Because sync then
means three things:
(1) The block job sync mode
(2) Synchronous write operations to the target
(3) Active mirroring mode

(1) is relatively easy to distinguish because it's just "the job sync
mode".  If we call the passive mode "background" we can distinguish (2)
and (3) at least based on their antonyms: "sync (as in sync/async)" vs.
"sync (as in sync/background)".

>>  static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
>>      uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
>>  {
>> -    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>> +    MirrorOp *op =3D NULL;
>> +    MirrorBDSOpaque *s =3D bs->opaque;
>> +    int ret =3D 0;
>> +    bool copy_to_target;
>> +
>> +    copy_to_target =3D s->job->ret >=3D 0 &&
>> +                     s->job->copy_mode =3D=3D MIRROR_COPY_MODE_ACTIVE=
_READ_WRITE;
>> +
>> +    if (copy_to_target) {
>> +        op =3D active_write_prepare(s->job, offset, bytes);
>> +    }
>> +
>> +    ret =3D bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>> +    if (ret < 0) {
>> +        goto out;
>> +    }
>> +
>> +    if (copy_to_target) {
>> +        do_sync_target_write(s->job, offset, bytes, qiov, 0);
>> +    }
>=20
> This mode is dangerous.  See bdrv_co_do_copy_on_readv():
>=20
>   /* Perform I/O through a temporary buffer so that users who scribble =
over
>    * their read buffer while the operation is in progress do not end up=

>    * modifying the image file.  This is critical for zero-copy guest I/=
O
>    * where anything might happen inside guest memory.
>    */
>   void *bounce_buffer;

Ooh, yes, right.  I'll just drop it for now, then.

Max


--FvXdb8bLvUKh8nObPwr0qtcxgdBpqAhpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9LekSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+N8H/RBVy1pwNi4rsC5RzTotS+Bt6XC64rcT
RzoeIm08APVclyHiua4BkSY743Ie84z0vfx8rEyLwKFzNWfuDArk8wuP3hQyQjfM
Cwxg1HIeKoBBDuWTxwyjjCIqjAlVSUrJuAbaC8G4bo5iE6p2wv48SwIxbQiMmMia
HjeMGUCKmzxpLeqV9BiBzr7U4yszsulSy9lookhQ+FJCPjPuFEuKX8S16yn72cvX
vC5vpQiIJfs1voB3pZzNYvO5j62zlCv4q+68ATElqQpMbxjG43GsAubOq7LI1PTq
6W103bWEzak1eXjKAFjBVXiJMUltj9FTBacQqnEa0Yo3K/+2c45Q8xE=
=haif
-----END PGP SIGNATURE-----

--FvXdb8bLvUKh8nObPwr0qtcxgdBpqAhpN--
