Received: from eggs.gnu.org ([2001:4830:134:3::10]:39617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCoXW-0008Tv-D0
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCoXR-0002fy-UC
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:14:46 -0500
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
	<20171109042137.GA13786@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <67bb3458-80da-beda-eec1-c08168837832@redhat.com>
Date: Thu, 9 Nov 2017 16:14:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171109042137.GA13786@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XSgaRa9r00kkQJI5Ig1ONOtrpeS3w90C7"
Subject: Re: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all
 after non-shared storage migration)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XSgaRa9r00kkQJI5Ig1ONOtrpeS3w90C7
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <67bb3458-80da-beda-eec1-c08168837832@redhat.com>
Subject: Re: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all
 after non-shared storage migration)
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
 <20171109042137.GA13786@lemon>
In-Reply-To: <20171109042137.GA13786@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 05:21, Fam Zheng wrote:
> On Thu, 11/09 01:48, Max Reitz wrote:
>> Hi,
>>
>> More exciting news from the bdrv_drain() front!
>>
>> I've noticed in the past that iotest 194 sometimes hangs.  I usually r=
un
>> the tests on tmpfs, but I've just now verified that it happens on my S=
SD
>> just as well.
>>
>> So the reproducer is a plain:
>>
>> while ./check -raw 194; do; done
>=20
> I cannot produce it on my machine.

Hm, too bad.  I see it both on my work laptop (with Fedora) and my
desktop (with Arch)...

>> (No difference between raw or qcow2, though.)
>>
>> And then, after a couple of runs (or a couple ten), it will just hang.=

>> The reason is that the source VM lingers around and doesn't quit
>> voluntarily -- the test itself was successful, but it just can't exit.=

>>
>> If you force it to exit by killing the VM (e.g. through pkill -11 qemu=
),
>> this is the backtrace:
>>
>> #0  0x00007f7cfc297e06 in ppoll () at /lib64/libc.so.6
>> #1  0x0000563b846bcac9 in ppoll (__ss=3D0x0, __timeout=3D0x0,
>> __nfds=3D<optimized out>, __fds=3D<optimized out>) at
>> /usr/include/bits/poll2.h:77
>=20
> Looking at the 0 timeout it seems we are in the aio_poll(ctx, blocking=3D=
false);
> branches of BDRV_POLL_WHILE? Is it a busy loop? If so I wonder what is =
making
> progress and causing the return value to be true in aio_poll().
>=20
>> #2  0x0000563b846bcac9 in qemu_poll_ns (fds=3D<optimized out>,
>> nfds=3D<optimized out>, timeout=3D<optimized out>) at util/qemu-timer.=
c:322
>> #3  0x0000563b846be711 in aio_poll (ctx=3Dctx@entry=3D0x563b856e3e80,
>> blocking=3D<optimized out>) at util/aio-posix.c:629
>> #4  0x0000563b8463afa4 in bdrv_drain_recurse
>> (bs=3Dbs@entry=3D0x563b865568a0, begin=3Dbegin@entry=3Dtrue) at block/=
io.c:201
>> #5  0x0000563b8463baff in bdrv_drain_all_begin () at block/io.c:381
>> #6  0x0000563b8463bc99 in bdrv_drain_all () at block/io.c:411
>> #7  0x0000563b8459888b in block_migration_cleanup (opaque=3D<optimized=

>> out>) at migration/block.c:714
>> #8  0x0000563b845883be in qemu_savevm_state_cleanup () at
>> migration/savevm.c:1251
>> #9  0x0000563b845811fd in migration_thread (opaque=3D0x563b856f1da0) a=
t
>> migration/migration.c:2298
>> #10 0x00007f7cfc56f36d in start_thread () at /lib64/libpthread.so.0
>> #11 0x00007f7cfc2a3e1f in clone () at /lib64/libc.so.6
>>
>>
>> And when you make bdrv_drain_all_begin() print what we are trying to
>> drain, you can see that it's the format node (managed by the "raw"
>> driver in this case).
>=20
> So what is the value of bs->in_flight?

gdb:
> (gdb) print bs->in_flight=20
> $3 =3D 2307492233

"That's weird, why would it..."

> (gdb) print *bs
> $4 =3D {open_flags =3D -1202160144, read_only =3D 161, encrypted =3D 85=
, sg =3D false, probed =3D false, force_share =3D 96, implicit =3D 159, d=
rv =3D 0x0, opaque =3D 0x0, aio_context =3D 0x8989898989898989, aio_notif=
iers =3D {lh_first =3D 0x8989898989898989},=20
>   walking_aio_notifiers =3D 137, filename =3D '\211' <repeats 4096 time=
s>, backing_file =3D '\211' <repeats 4096 times>, backing_format =3D '\21=
1' <repeats 16 times>, full_open_options =3D 0x8989898989898989,=20
>   exact_filename =3D '\211' <repeats 4096 times>, backing =3D 0x8989898=
989898989, file =3D 0x8989898989898989, bl =3D {request_alignment =3D 230=
7492233, max_pdiscard =3D -1987475063, pdiscard_alignment =3D 2307492233,=
=20
>     max_pwrite_zeroes =3D -1987475063, pwrite_zeroes_alignment =3D 2307=
492233, opt_transfer =3D 2307492233, max_transfer =3D 2307492233, min_mem=
_alignment =3D 9910603678816504201, opt_mem_alignment =3D 991060367881650=
4201, max_iov =3D -1987475063},=20
>   supported_write_flags =3D 2307492233, supported_zero_flags =3D 230749=
2233, node_name =3D '\211' <repeats 32 times>, node_list =3D {tqe_next =3D=
 0x8989898989898989, tqe_prev =3D 0x8989898989898989}, bs_list =3D {tqe_n=
ext =3D 0x8989898989898989,=20
>     tqe_prev =3D 0x8989898989898989}, monitor_list =3D {tqe_next =3D 0x=
8989898989898989, tqe_prev =3D 0x8989898989898989}, refcnt =3D -198747506=
3, op_blockers =3D {{lh_first =3D 0x8989898989898989} <repeats 16 times>}=
, job =3D 0x8989898989898989,=20
>   inherits_from =3D 0x8989898989898989, children =3D {lh_first =3D 0x89=
89898989898989}, parents =3D {lh_first =3D 0x8989898989898989}, options =3D=
 0x8989898989898989, explicit_options =3D 0x8989898989898989, detect_zero=
es =3D 2307492233,=20
>   backing_blocker =3D 0x8989898989898989, total_sectors =3D -8536140394=
893047415, before_write_notifiers =3D {notifiers =3D {lh_first =3D 0x8989=
898989898989}}, write_threshold_offset =3D 9910603678816504201, write_thr=
eshold_notifier =3D {notify =3D=20
>     0x8989898989898989, node =3D {le_next =3D 0x8989898989898989, le_pr=
ev =3D 0x8989898989898989}}, dirty_bitmap_mutex =3D {lock =3D {__data =3D=
 {__lock =3D -1987475063, __count =3D 2307492233, __owner =3D -1987475063=
, __nusers =3D 2307492233,=20
>         __kind =3D -1987475063, __spins =3D -30327, __elision =3D -3032=
7, __list =3D {__prev =3D 0x8989898989898989, __next =3D 0x89898989898989=
89}}, __size =3D '\211' <repeats 40 times>, __align =3D -8536140394893047=
415}, initialized =3D 137},=20
>   dirty_bitmaps =3D {lh_first =3D 0x8989898989898989}, wr_highest_offse=
t =3D {value =3D 9910603678816504201}, copy_on_read =3D -1987475063, in_f=
light =3D 2307492233, serialising_in_flight =3D 2307492233, wakeup =3D 13=
7, io_plugged =3D 2307492233,=20
>   enable_write_cache =3D -1987475063, quiesce_counter =3D -1987475063, =
write_gen =3D 2307492233, reqs_lock =3D {locked =3D 2307492233, ctx =3D 0=
x8989898989898989, from_push =3D {slh_first =3D 0x8989898989898989}, to_p=
op =3D {
>       slh_first =3D 0x8989898989898989}, handoff =3D 2307492233, sequen=
ce =3D 2307492233, holder =3D 0x8989898989898989}, tracked_requests =3D {=
lh_first =3D 0x8989898989898989}, flush_queue =3D {entries =3D {sqh_first=
 =3D 0x8989898989898989,=20
>       sqh_last =3D 0x8989898989898989}}, active_flush_req =3D 160, flus=
hed_gen =3D 0}
"Oh."

*sigh*

OK, I'll look into it...

Max

>> So I thought, before I put more time into this, let's ask whether the
>> test author has any ideas. :-)
>=20
> Fam
>=20



--XSgaRa9r00kkQJI5Ig1ONOtrpeS3w90C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloEcM4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aq7cIAKea/xbUcUJwKW3Js35vlVHj5yZFlRtH
HvGDfRzVpAtyQKCAoexLDsAHSxqFro2fFqa0keCS3c7jVAKONMBLmbdTR0YoY7vi
9ZuGkWpgRHN6RyHT5Dx1EVcIdwNGjPtUukUrO6wr6RZXJKPpQZOOU/MdGNpsNADP
GkeMUUhGzCCcQLfwyF85bkItCizSrAcqmn2RofRj3UCzNZsRjKuoKC18WFTAJg1x
ibDU8v1AIEIzxk/uJ9ZRoHZMSe7ooak1ToM8TjosFpEi9a/NpWgjg2jlB9FMjTE3
IwNq/HpcGV6rAQQFpCoNfMfYkonOL2MaPdvcf54/r5qfeVccY7mde7g=
=gNaE
-----END PGP SIGNATURE-----

--XSgaRa9r00kkQJI5Ig1ONOtrpeS3w90C7--
