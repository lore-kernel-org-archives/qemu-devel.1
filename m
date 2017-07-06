Received: from eggs.gnu.org ([2001:4830:134:3::10]:55970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT9a7-00017P-Ri
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT9a6-0003xj-5x
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:24:43 -0400
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-20-eblake@redhat.com>
	<20170706160203.GM5975@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8bc92879-aa6d-5528-cd42-d99f2c88324c@redhat.com>
Date: Thu, 6 Jul 2017 11:24:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170706160203.GM5975@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jUCkGO91HR5gbFhMXx4FXue1Lx9CjkgP4"
Subject: Re: [Qemu-devel] [PATCH v4 19/21] block: Make bdrv_is_allocated()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jUCkGO91HR5gbFhMXx4FXue1Lx9CjkgP4
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <8bc92879-aa6d-5528-cd42-d99f2c88324c@redhat.com>
Subject: Re: [PATCH v4 19/21] block: Make bdrv_is_allocated() byte-based
References: <20170705210842.960-1-eblake@redhat.com>
 <20170705210842.960-20-eblake@redhat.com>
 <20170706160203.GM5975@noname.redhat.com>
In-Reply-To: <20170706160203.GM5975@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2017 11:02 AM, Kevin Wolf wrote:
> Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  In the common case, allocation is unlikely to ever use
>> values that are not naturally sector-aligned, but it is possible
>> that byte-based values will let us be more precise about allocation
>> at the end of an unaligned file that can do byte-based access.
>>
>> Changing the signature of the function to use int64_t *pnum ensures
>> that the compiler enforces that all callers are updated.  For now,
>> the io.c layer still assert()s that all callers are sector-aligned
>> on input and that *pnum is sector-aligned on return to the caller,
>> but that can be relaxed when a later patch implements byte-based
>> block status.  Therefore, this code adds usages like
>> DIV_ROUND_UP(,BDRV_SECTOR_SIZE) to callers that still want aligned
>> values, where the call might reasonbly give non-aligned results
>> in the future; on the other hand, no rounding is needed for callers
>> that should just continue to work with byte alignment.
>>
>> For the most part this patch is just the addition of scaling at the
>> callers followed by inverse scaling at bdrv_is_allocated().  But
>> some code, particularly bdrv_commit(), gets a lot simpler because it
>> no longer has to mess with sectors; also, it is now possible to pass
>> NULL if the caller does not care how much of the image is allocated
>> beyond the initial offset.
>>
>> For ease of review, bdrv_is_allocated_above() will be tackled
>> separately.
>>

>> @@ -1036,14 +1036,15 @@ static int coroutine_fn bdrv_aligned_preadv(Bd=
rvChild *child,

>>
>> -        if (!ret || pnum !=3D nb_sectors) {
>> +        if (!ret || pnum !=3D nb_sectors << BDRV_SECTOR_BITS) {
>>              ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qi=
ov);
>>              goto out;
>>          }
>=20
> This code would become a lot simpler if you just removed the local
> variables start_sector/end_sector and used the byte offsets instead tha=
t
> are available in this function. (And even simpler once sector alignment=

> isn't required any more for bdrv_is_allocated(). Should we leave a
> comment here so we won't forget the conversion?)

Hmm - that cleanup is not (yet) done in my bdrv_get_block_status series
(where I finally drop the need for sector alignment in
bdrv_is_allocated).  Yes, I can add a temporary comment here (that aids
with the understanding of intermediate states), as well as a new
followup patch that actually does the cleanup.

>> -int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t sect=
or_num,
>> -                                   int nb_sectors, int *pnum)
>> +int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offs=
et,
>> +                                   int64_t bytes, int64_t *pnum)
>>  {
>>      BlockDriverState *file;
>> -    int64_t ret =3D bdrv_get_block_status(bs, sector_num, nb_sectors,=
 pnum,
>> -                                        &file);
>> +    int64_t sector_num =3D offset >> BDRV_SECTOR_BITS;
>> +    int nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
>> +    int64_t ret;
>> +    int psectors;
>> +
>> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
>> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) &&
>> +           bytes < INT_MAX * BDRV_SECTOR_SIZE);
>=20
> I think we can actually assert bytes <=3D INT_MAX. Both ways to write t=
he
> assertion are only true because of BDRV_REQUEST_MAX_SECTORS, which
> ensures that the byte counts fit in an int.

That's a tighter assertion, but if it passes, I'm fine using it.

>=20
> Some of the places that call bdrv_is_allocated() actually depend on thi=
s
> because your patches tend to use nb_sectors << BDRV_SECTOR_BITS (which
> truncates) rather than nb_sectors * BDRV_SECTOR_BYTES (which is always =
a
> 64 bit calculation).

Actually, for this series of cleanups, I tried really hard to use *
_BYTES everywhere that I widen sectors to bytes, and limit myself to >>
_BITS for going from bytes back to sectors (after also checking if I
needed DIV_ROUND_UP instead of straight division).  If you spot places
where I'm still doing a 32-bit << _BITS, please call it out (as I do
remember that I caused bugs that way back when I converted pdiscard to
byte-based, back near commit d2cb36af).


>> +++ b/block/stream.c
>> @@ -137,6 +137,7 @@ static void coroutine_fn stream_run(void *opaque)
>>
>>      for ( ; offset < s->common.len; offset +=3D n * BDRV_SECTOR_SIZE)=
 {
>>          bool copy;
>> +        int64_t count =3D 0;
>>
>>          /* Note that even when no rate limit is applied we need to yi=
eld
>>           * with no pending I/O here so that bdrv_drain_all() returns.=

>> @@ -148,8 +149,8 @@ static void coroutine_fn stream_run(void *opaque)
>>
>>          copy =3D false;
>>
>> -        ret =3D bdrv_is_allocated(bs, offset / BDRV_SECTOR_SIZE,
>> -                                STREAM_BUFFER_SIZE / BDRV_SECTOR_SIZE=
, &n);
>> +        ret =3D bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &co=
unt);
>> +        n =3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>>          if (ret =3D=3D 1) {
>>              /* Allocated in the top, no need to copy.  */
>>          } else if (ret >=3D 0) {
>=20
> I'm not sure if I agree with rounding up here. If ret =3D=3D 0, it coul=
d
> mean that we skip some data that is actually allocated. So I'd like an
> assertion better.
>=20
> The last patch of the series gets rid of this by switching the whole
> function to bytes, so not that important.

A temporary assertion is fine (and you're right that the assertion goes
away once the function uses bytes everywhere).

Sounds like we're racking up enough cleanups that I'll spin a v5, but
also sounds like we're real close to getting this in.

>> @@ -274,9 +275,9 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMi=
gDevState *bmds)
>>          /* Skip unallocated sectors; intentionally treats failure as
>>           * an allocated sector */
>>          while (cur_sector < total_sectors &&
>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sector=
s)) {
>> -            cur_sector +=3D nr_sectors;
>> +               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTO=
R_SIZE,
>> +                                  MAX_IS_ALLOCATED_SEARCH, &count)) {=

>> +            cur_sector +=3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>>          }
>>          aio_context_release(blk_get_aio_context(bb));
>>          qemu_mutex_unlock_iothread();
>=20
> This one stays and it has the same problem. I think you need to round
> down if you don't want to accidentally skip migrating allocated data.

I haven't (yet) tackled trying to rewrite this one to do byte-base
iteration, but that may help.  I'm also worried (in general) that if
something truncates down a sub-sector result in code that is still
sector-based, then we could get stuck in an inf-loop of querying the
same sector offset over and over again instead of making progress.

But for this particular code, I see what you are saying - we are trying
to optimize the migration by skipping unallocated sectors, but if there
is nothing to skip, we still make migration progress as long as I
remember to break from the loop if I ever get a sub-sector answer (thus
migrating the whole sector, including the [unlikely] initial unallocated
portion).  Okay, I'll fix it for v5.

>=20
>> diff --git a/qemu-img.c b/qemu-img.c
>> index d5a1560..5271b41 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3229,6 +3229,7 @@ static int img_rebase(int argc, char **argv)
>>          int64_t new_backing_num_sectors =3D 0;
>>          uint64_t sector;
>>          int n;
>> +        int64_t count;
>>          float local_progress =3D 0;
>>
>>          buf_old =3D blk_blockalign(blk, IO_BUF_SIZE);
>> @@ -3276,12 +3277,14 @@ static int img_rebase(int argc, char **argv)
>>              }
>>
>>              /* If the cluster is allocated, we don't need to take act=
ion */
>> -            ret =3D bdrv_is_allocated(bs, sector, n, &n);
>> +            ret =3D bdrv_is_allocated(bs, sector << BDRV_SECTOR_BITS,=

>> +                                    n << BDRV_SECTOR_BITS, &count);
>>              if (ret < 0) {
>>                  error_report("error while reading image metadata: %s"=
,
>>                               strerror(-ret));
>>                  goto out;
>>              }
>> +            n =3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>>              if (ret) {
>>                  continue;
>>              }
>=20
> Same thing. Sectors that are half allocated and half free must be
> considered completely allocated if the caller can't do byte alignment.
> Just rounding up without looking at ret isn't correct.
>=20
>> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
>> index b0ea327..e529b8f 100644
>> --- a/qemu-io-cmds.c
>> +++ b/qemu-io-cmds.c
>> @@ -1894,15 +1889,14 @@ static int map_f(BlockBackend *blk, int argc, =
char **argv)
>>          }
>>
>>          retstr =3D ret ? "    allocated" : "not allocated";
>> -        cvtstr(num << BDRV_SECTOR_BITS, s1, sizeof(s1));
>> -        cvtstr(offset << BDRV_SECTOR_BITS, s2, sizeof(s2));
>> +        cvtstr(num, s1, sizeof(s1));
>> +        cvtstr(offset, s2, sizeof(s2));
>>          printf("%s (0x%" PRIx64 ") bytes %s at offset %s (0x%" PRIx64=
 ")\n",
>> -               s1, num << BDRV_SECTOR_BITS, retstr,
>> -               s2, offset << BDRV_SECTOR_BITS);
>> +               s1, num, retstr, s2, offset);
>>
>>          offset +=3D num;
>> -        nb_sectors -=3D num;
>> -    } while (offset < total_sectors);
>> +        bytes -=3D num;
>> +    };
>=20
> This semicolon isn't needed.

Indeed. I converted do/while to plain while, but not quite correctly ;)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jUCkGO91HR5gbFhMXx4FXue1Lx9CjkgP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXmQ7AAoJEKeha0olJ0NqPsAH/iK3LlFZhxFG+p1MnYZpfAYb
+IZCe31XaGCoY8AX8qSNcFADL3vLWuK4mWX3Bm/Ca8vdojAHPr/VBxYWCYQs9+ev
UHqcUhoS4VOKA9mrNBejh8oFkEZGsC5mPt3GKUjawrbpKNkgj99HV6qjUEzTAm4Y
s5lN+f9cVDEa9tyzDpiHbUjDxCznMmnDf44boFdHZKv58hILoi92yjIaq2xK648X
hrFVmiCvqZisPrpw5qRoQ5Lpp7zV7MuJDX5NWZfBaodMWOM1ZJ+iu0yKqfVHp2Bb
wodUbF+9PCJoLuR90PzBwIXjTAuetahE+BaYhkEixpTEWDRRhjG9Err2ZFLpJJM=
=sKVP
-----END PGP SIGNATURE-----

--jUCkGO91HR5gbFhMXx4FXue1Lx9CjkgP4--
