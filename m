Received: from eggs.gnu.org ([2001:4830:134:3::10]:50692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCsYc-0003ZE-UA
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCsYb-0006Bd-5Z
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:32:10 -0500
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
	<20171109042137.GA13786@lemon>
	<67bb3458-80da-beda-eec1-c08168837832@redhat.com>
	<20171109152856.GA3661@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e4207841-1ae5-af2e-b7ef-14412202b75a@redhat.com>
Date: Thu, 9 Nov 2017 20:31:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171109152856.GA3661@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I3oSXjeACCa8XFtiXPRGb876snC0avQ1r"
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
--I3oSXjeACCa8XFtiXPRGb876snC0avQ1r
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <e4207841-1ae5-af2e-b7ef-14412202b75a@redhat.com>
Subject: Re: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all
 after non-shared storage migration)
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
 <20171109042137.GA13786@lemon>
 <67bb3458-80da-beda-eec1-c08168837832@redhat.com>
 <20171109152856.GA3661@lemon>
In-Reply-To: <20171109152856.GA3661@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 16:30, Fam Zheng wrote:
> On Thu, 11/09 16:14, Max Reitz wrote:
>> On 2017-11-09 05:21, Fam Zheng wrote:
>>> On Thu, 11/09 01:48, Max Reitz wrote:
>>>> Hi,
>>>>
>>>> More exciting news from the bdrv_drain() front!
>>>>
>>>> I've noticed in the past that iotest 194 sometimes hangs.  I usually=
 run
>>>> the tests on tmpfs, but I've just now verified that it happens on my=
 SSD
>>>> just as well.
>>>>
>>>> So the reproducer is a plain:
>>>>
>>>> while ./check -raw 194; do; done
>>>
>>> I cannot produce it on my machine.
>>
>> Hm, too bad.  I see it both on my work laptop (with Fedora) and my
>> desktop (with Arch)...
>>
>>>> (No difference between raw or qcow2, though.)
>>>>
>>>> And then, after a couple of runs (or a couple ten), it will just han=
g.
>>>> The reason is that the source VM lingers around and doesn't quit
>>>> voluntarily -- the test itself was successful, but it just can't exi=
t.
>>>>
>>>> If you force it to exit by killing the VM (e.g. through pkill -11 qe=
mu),
>>>> this is the backtrace:
>>>>
>>>> #0  0x00007f7cfc297e06 in ppoll () at /lib64/libc.so.6
>>>> #1  0x0000563b846bcac9 in ppoll (__ss=3D0x0, __timeout=3D0x0,
>>>> __nfds=3D<optimized out>, __fds=3D<optimized out>) at
>>>> /usr/include/bits/poll2.h:77
>>>
>>> Looking at the 0 timeout it seems we are in the aio_poll(ctx, blockin=
g=3Dfalse);
>>> branches of BDRV_POLL_WHILE? Is it a busy loop? If so I wonder what i=
s making
>>> progress and causing the return value to be true in aio_poll().
>>>
>>>> #2  0x0000563b846bcac9 in qemu_poll_ns (fds=3D<optimized out>,
>>>> nfds=3D<optimized out>, timeout=3D<optimized out>) at util/qemu-time=
r.c:322
>>>> #3  0x0000563b846be711 in aio_poll (ctx=3Dctx@entry=3D0x563b856e3e80=
,
>>>> blocking=3D<optimized out>) at util/aio-posix.c:629
>>>> #4  0x0000563b8463afa4 in bdrv_drain_recurse
>>>> (bs=3Dbs@entry=3D0x563b865568a0, begin=3Dbegin@entry=3Dtrue) at bloc=
k/io.c:201
>>>> #5  0x0000563b8463baff in bdrv_drain_all_begin () at block/io.c:381
>>>> #6  0x0000563b8463bc99 in bdrv_drain_all () at block/io.c:411
>>>> #7  0x0000563b8459888b in block_migration_cleanup (opaque=3D<optimiz=
ed
>>>> out>) at migration/block.c:714
>>>> #8  0x0000563b845883be in qemu_savevm_state_cleanup () at
>>>> migration/savevm.c:1251
>>>> #9  0x0000563b845811fd in migration_thread (opaque=3D0x563b856f1da0)=
 at
>>>> migration/migration.c:2298
>>>> #10 0x00007f7cfc56f36d in start_thread () at /lib64/libpthread.so.0
>>>> #11 0x00007f7cfc2a3e1f in clone () at /lib64/libc.so.6
>>>>
>>>>
>>>> And when you make bdrv_drain_all_begin() print what we are trying to=

>>>> drain, you can see that it's the format node (managed by the "raw"
>>>> driver in this case).
>>>
>>> So what is the value of bs->in_flight?
>>
>> gdb:
>>> (gdb) print bs->in_flight=20
>>> $3 =3D 2307492233
>>
>> "That's weird, why would it..."
>>
>>> (gdb) print *bs
>>> $4 =3D {open_flags =3D -1202160144, read_only =3D 161, encrypted =3D =
85, sg =3D false, probed =3D false, force_share =3D 96, implicit =3D 159,=
 drv =3D 0x0, opaque =3D 0x0, aio_context =3D 0x8989898989898989, aio_not=
ifiers =3D {lh_first =3D 0x8989898989898989},=20
>>>   walking_aio_notifiers =3D 137, filename =3D '\211' <repeats 4096 ti=
mes>, backing_file =3D '\211' <repeats 4096 times>, backing_format =3D '\=
211' <repeats 16 times>, full_open_options =3D 0x8989898989898989,=20
>>>   exact_filename =3D '\211' <repeats 4096 times>, backing =3D 0x89898=
98989898989, file =3D 0x8989898989898989, bl =3D {request_alignment =3D 2=
307492233, max_pdiscard =3D -1987475063, pdiscard_alignment =3D 230749223=
3,=20
>>>     max_pwrite_zeroes =3D -1987475063, pwrite_zeroes_alignment =3D 23=
07492233, opt_transfer =3D 2307492233, max_transfer =3D 2307492233, min_m=
em_alignment =3D 9910603678816504201, opt_mem_alignment =3D 9910603678816=
504201, max_iov =3D -1987475063},=20
>>>   supported_write_flags =3D 2307492233, supported_zero_flags =3D 2307=
492233, node_name =3D '\211' <repeats 32 times>, node_list =3D {tqe_next =
=3D 0x8989898989898989, tqe_prev =3D 0x8989898989898989}, bs_list =3D {tq=
e_next =3D 0x8989898989898989,=20
>>>     tqe_prev =3D 0x8989898989898989}, monitor_list =3D {tqe_next =3D =
0x8989898989898989, tqe_prev =3D 0x8989898989898989}, refcnt =3D -1987475=
063, op_blockers =3D {{lh_first =3D 0x8989898989898989} <repeats 16 times=
>}, job =3D 0x8989898989898989,=20
>>>   inherits_from =3D 0x8989898989898989, children =3D {lh_first =3D 0x=
8989898989898989}, parents =3D {lh_first =3D 0x8989898989898989}, options=
 =3D 0x8989898989898989, explicit_options =3D 0x8989898989898989, detect_=
zeroes =3D 2307492233,=20
>>>   backing_blocker =3D 0x8989898989898989, total_sectors =3D -85361403=
94893047415, before_write_notifiers =3D {notifiers =3D {lh_first =3D 0x89=
89898989898989}}, write_threshold_offset =3D 9910603678816504201, write_t=
hreshold_notifier =3D {notify =3D=20
>>>     0x8989898989898989, node =3D {le_next =3D 0x8989898989898989, le_=
prev =3D 0x8989898989898989}}, dirty_bitmap_mutex =3D {lock =3D {__data =3D=
 {__lock =3D -1987475063, __count =3D 2307492233, __owner =3D -1987475063=
, __nusers =3D 2307492233,=20
>>>         __kind =3D -1987475063, __spins =3D -30327, __elision =3D -30=
327, __list =3D {__prev =3D 0x8989898989898989, __next =3D 0x898989898989=
8989}}, __size =3D '\211' <repeats 40 times>, __align =3D -85361403948930=
47415}, initialized =3D 137},=20
>>>   dirty_bitmaps =3D {lh_first =3D 0x8989898989898989}, wr_highest_off=
set =3D {value =3D 9910603678816504201}, copy_on_read =3D -1987475063, in=
_flight =3D 2307492233, serialising_in_flight =3D 2307492233, wakeup =3D =
137, io_plugged =3D 2307492233,=20
>>>   enable_write_cache =3D -1987475063, quiesce_counter =3D -1987475063=
, write_gen =3D 2307492233, reqs_lock =3D {locked =3D 2307492233, ctx =3D=
 0x8989898989898989, from_push =3D {slh_first =3D 0x8989898989898989}, to=
_pop =3D {
>>>       slh_first =3D 0x8989898989898989}, handoff =3D 2307492233, sequ=
ence =3D 2307492233, holder =3D 0x8989898989898989}, tracked_requests =3D=
 {lh_first =3D 0x8989898989898989}, flush_queue =3D {entries =3D {sqh_fir=
st =3D 0x8989898989898989,=20
>>>       sqh_last =3D 0x8989898989898989}}, active_flush_req =3D 160, fl=
ushed_gen =3D 0}
>> "Oh."
>>
>> *sigh*
>>
>> OK, I'll look into it...
>=20
> OK, I'll let you.. Just one more thing: could it relate to the use-afte=
r-free
> bug reported on block_job_defer_to_main_loop()?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01144.html

Thanks for the heads-up; I think it's a different issue, though.

What appears to be happening is that the mirror job completes and then
drains its BDS.  While that is happening, a bdrv_drain_all() comes in
from block_migration_cleanup().

That now tries to drain the mirror node.  However, that node cannot be
drained until the job is truly gone now, so that is what's happening:
mirror_exit() is called, it cleans up, destroys the mirror node, and
returns.

Now bdrv_drain_all() can go on, specifically the BDRV_POLL_WHILE() on
the mirror node.  However, oops, that node is gone now...  So that's
where the issue seems to be. :-/

Maybe all that we need to do is wrap the bdrv_drain_recurse() call in
bdrv_drain_all_begin() in a bdrv_ref()/bdrv_unref() pair?  Having run
194 for a couple of minutes, that seems to indeed work -- until it dies
because of an invalid BB pointer in bdrv_next().  I guess that is
because bdrv_next() does not guard against deleted BDSs.

Copying all BDS into an own list (in both bdrv_drain_all_begin() and
bdrv_drain_all_end()), with a strong reference to every single one, and
then draining them really seems to work, though.  (Survived 9000
iterations, that seems good enough for something that usually fails
after, like, 5.)

Max


--I3oSXjeACCa8XFtiXPRGb876snC0avQ1r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloErSoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARTgIAKA14xWonj4ji7TNK5vVLiqs7dJurw2W
aa5CBrWo/8pgIb5/HySgf7EavckBbzCCgc80FI7ZiF8dg8QpdfCT+xS7wH1ViHWU
mWurGIVomZ7ItF+KWlUb+240L8InJnyuIrpLEp1thEMU4mqSxRcc3X6ePF6yI12l
sV44TdVRk/Dop5j5gFJqjYeug6loGM+AdBMayUIhBR+jLw1GUxpivam/jarFWsLU
3Seo6kvrga+9S8S0Uvd7rnINomlFFobRpqoIFKyvfNEPo9qlA9aQeLWpxKPivynG
TdCPOT6eDDXdd5J1O1mmKY1nSrmlQcjLj4Eq91dn/TQWv3xqeXlApAY=
=08mD
-----END PGP SIGNATURE-----

--I3oSXjeACCa8XFtiXPRGb876snC0avQ1r--
