Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1chMB5-0006RY-05
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1chMAz-0003R1-Ss
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:09:18 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:45508 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1chMAz-0003OT-Jm
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:09:13 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <20170224150250.GB4429@noname.redhat.com>
Date: Fri, 24 Feb 2017 21:09:07 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2191139-E787-44D2-A15E-2A1DDC6BDA0D@kamp.de>
References: <1487680191-13096-1-git-send-email-pl@kamp.de>
	<20170224150250.GB4429@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@gmail.com, Christian Theune <ct@flyingcircus.io>, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com


> Am 24.02.2017 um 16:02 schrieb Kevin Wolf <kwolf@redhat.com>:
>=20
> Am 21.02.2017 um 13:29 hat Peter Lieven geschrieben:
>> the convert process is currently completely implemented with sync =
operations.
>> That means it reads one buffer and then writes it. No parallelism and =
each sync
>> request takes as long as it takes until it is completed.
>>=20
>> This can be a big performance hit when the convert process reads and =
writes
>> to devices which do not benefit from kernel readahead or pagecache.
>> In our environment we heavily have the following two use cases when =
using
>> qemu-img convert.
>>=20
>> a) reading from NFS and writing to iSCSI for deploying templates
>> b) reading from iSCSI and writing to NFS for backups
>>=20
>> In both processes we use libiscsi and libnfs so we have no kernel =
cache.
>>=20
>> This patch changes the convert process to work with parallel running =
coroutines
>> which can significantly improve performance for network storage =
devices:
>>=20
>> qemu-img (master)
>> nfs -> iscsi 22.8 secs
>> nfs -> ram   11.7 secs
>> ram -> iscsi 12.3 secs
>>=20
>> qemu-img-async (8 coroutines, in-order write disabled)
>> nfs -> iscsi 11.0 secs
>> nfs -> ram   10.4 secs
>> ram -> iscsi  9.0 secs
>>=20
>> This patches introduces 2 new cmdline parameters. The -m parameter to =
specify
>> the number of coroutines running in parallel (defaults to 8). And the =
-W paremeter to
>> allow qemu-img to write to the target out of order rather than =
sequential. This improves
>> performance as the writes do not have to wait for each other to =
complete.
>>=20
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>=20
>> @@ -1563,9 +1581,13 @@ static int convert_read(ImgConvertState *s, =
int64_t sector_num, int nb_sectors,
>>         blk =3D s->src[s->src_cur];
>>         bs_sectors =3D s->src_sectors[s->src_cur];
>>=20
>>         n =3D MIN(nb_sectors, bs_sectors - (sector_num - =
s->src_cur_offset));
>=20
> convert_co_read() uses global state here (s->src, s->src_cur,
> s->src_cur_offset) while not running under a lock. Are you sure that
> this is correct when some coroutines are operating on the first source
> image, but others are already working on the second one?

You are right that could cause problems. I have to change that to use =
local variables.

>=20
> The same variables are used in convert_iteration_sectors(), but I =
think
> there it's okay because we're just starting a new request and are
> holding s->lock.
>=20
>> @@ -1651,12 +1685,122 @@ static int convert_write(ImgConvertState *s, =
int64_t sector_num, int nb_sectors,
>>     return 0;
>> }
>>=20
>> -static int convert_do_copy(ImgConvertState *s)
>> +static void coroutine_fn convert_co_do_copy(void *opaque)
>> {
>> +    ImgConvertState *s =3D opaque;
>>     uint8_t *buf =3D NULL;
>> -    int64_t sector_num, allocated_done;
>> -    int ret;
>> -    int n;
>> +    int ret, i;
>> +    int index =3D -1;
>> +
>> +    for (i =3D 0; i < s->num_coroutines; i++) {
>> +        if (s->co[i] =3D=3D qemu_coroutine_self()) {
>> +            index =3D i;
>> +            break;
>> +        }
>> +    }
>> +    assert(index >=3D 0);
>> +
>> +    s->running_coroutines++;
>> +    buf =3D blk_blockalign(s->target, s->buf_sectors * =
BDRV_SECTOR_SIZE);
>> +
>> +    while (1) {
>> +        int n;
>> +        int64_t sector_num;
>> +        enum ImgConvertBlockStatus status;
>> +
>> +        qemu_co_mutex_lock(&s->lock);
>> +        if (s->ret !=3D -EINPROGRESS || s->sector_num >=3D =
s->total_sectors) {
>> +            qemu_co_mutex_unlock(&s->lock);
>> +            goto out;
>> +        }
>> +        n =3D convert_iteration_sectors(s, s->sector_num);
>> +        if (n < 0) {
>> +            qemu_co_mutex_unlock(&s->lock);
>> +            s->ret =3D n;
>> +            goto out;
>> +        }
>> +        /* safe current sector and allocation status to local =
variables */
>=20
> s/safe/save/
>=20
>> +        sector_num =3D s->sector_num;
>> +        status =3D s->status;
>> +        if (!s->min_sparse && s->status =3D=3D BLK_ZERO) {
>> +            n =3D MIN(n, s->buf_sectors);
>> +        }
>> +        /* increment global sector counter so that other coroutines =
can
>> +         * already continue reading beyond this request */
>> +        s->sector_num +=3D n;
>> +        qemu_co_mutex_unlock(&s->lock);
>=20
> Here we unlock, so after this point we can only access globally valid
> values from s, but not request-specific ones like s->status or
> s->sector_num...
>=20
>> +        if (status =3D=3D BLK_DATA || (!s->min_sparse && s->status =
=3D=3D BLK_ZERO)) {
>=20
> ...but s->status is used here...
>=20
>> +            s->allocated_done +=3D n;
>> +            qemu_progress_print(100.0 * s->allocated_done /
>> +                                        s->allocated_sectors, 0);
>> +        }
>> +
>> +        if (status =3D=3D BLK_DATA) {
>> +            ret =3D convert_co_read(s, sector_num, n, buf);
>> +            if (ret < 0) {
>> +                error_report("error while reading sector %" PRId64
>> +                             ": %s", sector_num, strerror(-ret));
>> +                s->ret =3D ret;
>> +                goto out;
>> +            }
>> +        } else if (!s->min_sparse && s->status =3D=3D BLK_ZERO) {
>=20
> ...and here.

Right, but thats easy to fix.

>=20
>> +            status =3D BLK_DATA;
>> +            memset(buf, 0x00, n * BDRV_SECTOR_SIZE);
>> +        }
>> +
>> +        if (s->wr_in_order) {
>> +            /* keep writes in order */
>> +            while (s->wr_offs !=3D sector_num) {
>> +                if (s->ret !=3D -EINPROGRESS) {
>> +                    goto out;
>> +                }
>> +                s->wait_sector_num[index] =3D sector_num;
>> +                qemu_coroutine_yield();
>> +            }
>> +            s->wait_sector_num[index] =3D -1;
>> +        }
>> +
>> +        ret =3D convert_co_write(s, sector_num, n, buf, status);
>> +        if (ret < 0) {
>> +            error_report("error while writing sector %" PRId64
>> +                         ": %s", sector_num, strerror(-ret));
>> +            s->ret =3D ret;
>> +            goto out;
>> +        }
>> +
>> +        if (s->wr_in_order) {
>> +            /* reenter the coroutine that might have waited
>> +             * for this write to complete */
>> +            s->wr_offs =3D sector_num + n;
>> +            for (i =3D 0; i < s->num_coroutines; i++) {
>> +                if (s->co[i] && s->wait_sector_num[i] =3D=3D =
s->wr_offs) {
>> +                    /*
>> +                     * A -> B -> A cannot occur because A has
>> +                     * s->wait_sector_num[i] =3D=3D -1 during A -> =
B. Therefore
>> +                     * B will never enter A during this time window.
>> +                     */
>> +                    qemu_coroutine_enter(s->co[i]);
>> +                    break;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +out:
>> +    qemu_vfree(buf);
>> +    s->co[index] =3D NULL;
>> +    s->running_coroutines--;
>> +    if (!s->running_coroutines && s->ret =3D=3D -EINPROGRESS) {
>> +        /* the convert job finished successfully */
>> +        s->ret =3D 0;
>> +    }
>> +}
>> diff --git a/qemu-img.texi b/qemu-img.texi
>> index 174aae3..6715ff3 100644
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -137,6 +137,12 @@ Parameters to convert subcommand:
>>=20
>> @item -n
>> Skip the creation of the target volume
>> +@item -m
>> +Number of parallel coroutines for the convert process
>> +@item -W
>> +Allow to write out of order to the destination. This is option =
improves performance,
>> +but is only recommened for preallocated devices like host devices or =
other
>> +raw block devices.
>> @end table
>>=20
>> Parameters to dd subcommand:
>> @@ -296,7 +302,7 @@ Error on reading data
>>=20
>> @end table
>>=20
>> -@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T =
@var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s =
@var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S =
@var{sparse_size}] @var{filename} [@var{filename2} [...]] =
@var{output_filename}
>> +@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T =
@var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s =
@var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-m =
@var{num_coroutines}] [-W] {[-S @var{sparse_size}] @var{filename} =
[@var{filename2} [...]] @var{output_filename}
>=20
> The extra { before -S causes 'make qemu-doc.html' to fail (as reported
> by patchew).

Will fix!

Thank you,
Peter
