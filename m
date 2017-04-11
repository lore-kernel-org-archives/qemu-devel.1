Received: from eggs.gnu.org ([2001:4830:134:3::10]:39043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxxmn-0000Qi-2E
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxxml-0004oe-Q9
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:32:53 -0400
Date: Tue, 11 Apr 2017 16:32:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411153234.GA5940@stefanha-x1.localdomain>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
	<20170407113450.GO13602@stefanha-x1.localdomain>
	<CAOGPPbcf6bPXmVGFcw3niNznPx1BHsA=uR2G0sN=AV6xhWXMrA@mail.gmail.com>
	<20170410135203.GA20631@stefanha-x1.localdomain>
	<CAOGPPbeMnM8z5DFaXFAEOswy94z1OYsRXVRe7LLg8S7RHS46QA@mail.gmail.com>
	<CAOGPPbfZjX0zsZZqhc0v6u2KNo8oDU9RvqTL-rW9W0Oid4ovMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <CAOGPPbfZjX0zsZZqhc0v6u2KNo8oDU9RvqTL-rW9W0Oid4ovMQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] migration/block:limit the
 time used for block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, Lidong Chen <lidongchen@tencent.com>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 09:06:37PM +0800, 858585 jemmy wrote:
> On Tue, Apr 11, 2017 at 8:19 PM, 858585 jemmy <jemmy858585@gmail.com> wro=
te:
> > On Mon, Apr 10, 2017 at 9:52 PM, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> >> On Sat, Apr 08, 2017 at 09:17:58PM +0800, 858585 jemmy wrote:
> >>> On Fri, Apr 7, 2017 at 7:34 PM, Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> >>> > On Fri, Apr 07, 2017 at 09:30:33AM +0800, 858585 jemmy wrote:
> >>> >> On Thu, Apr 6, 2017 at 10:02 PM, Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >>> >> > On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com =
wrote:
> >>> >> >
> >>> >> > A proper solution is to refactor the synchronous code to make it
> >>> >> > asynchronous.  This might require invoking the system call from a
> >>> >> > thread pool worker.
> >>> >> >
> >>> >>
> >>> >> yes, i agree with you, but this is a big change.
> >>> >> I will try to find how to optimize this code, maybe need a long ti=
me.
> >>> >>
> >>> >> this patch is not a perfect solution, but can alleviate the proble=
m.
> >>> >
> >>> > Let's try to understand the problem fully first.
> >>> >
> >>>
> >>> when migrate the vm with high speed, i find vnc response slowly somet=
ime.
> >>> not only vnc response slowly, virsh console aslo response slowly some=
time.
> >>> and the guest os block io performance is also reduce.
> >>>
> >>> the bug can be reproduce by this command:
> >>> virsh migrate-setspeed 165cf436-312f-47e7-90f2-f8aa63f34893 900
> >>> virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
> >>> --copy-storage-inc qemu+ssh://10.59.163.38/system
> >>>
> >>> and --copy-storage-all have no problem.
> >>> virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
> >>> --copy-storage-all qemu+ssh://10.59.163.38/system
> >>>
> >>> compare the difference between --copy-storage-inc and
> >>> --copy-storage-all. i find out the reason is
> >>> mig_save_device_bulk invoke bdrv_is_allocated, but bdrv_is_allocated
> >>> is synchronous and maybe wait
> >>> for a long time.
> >>>
> >>> i write this code to measure the time used by  brdrv_is_allocated()
> >>>
> >>>  279     static int max_time =3D 0;
> >>>  280     int tmp;
> >>>
> >>>  288             clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
> >>>  289             ret =3D bdrv_is_allocated(blk_bs(bb), cur_sector,
> >>>  290                                     MAX_IS_ALLOCATED_SEARCH, &nr=
_sectors);
> >>>  291             clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
> >>>  292
> >>>  293
> >>>  294             tmp =3D  (ts2.tv_sec - ts1.tv_sec)*1000000000L
> >>>  295                            + (ts2.tv_nsec - ts1.tv_nsec);
> >>>  296             if (tmp > max_time) {
> >>>  297                max_time=3Dtmp;
> >>>  298                fprintf(stderr, "max_time is %d\n", max_time);
> >>>  299             }
> >>>
> >>> the test result is below:
> >>>
> >>>  max_time is 37014
> >>>  max_time is 1075534
> >>>  max_time is 17180913
> >>>  max_time is 28586762
> >>>  max_time is 49563584
> >>>  max_time is 103085447
> >>>  max_time is 110836833
> >>>  max_time is 120331438
> >>>
> >>> bdrv_is_allocated is called after qemu_mutex_lock_iothread.
> >>> and the main thread is also call qemu_mutex_lock_iothread.
> >>> so cause the main thread maybe wait for a long time.
> >>>
> >>>    if (bmds->shared_base) {
> >>>         qemu_mutex_lock_iothread();
> >>>         aio_context_acquire(blk_get_aio_context(bb));
> >>>         /* Skip unallocated sectors; intentionally treats failure as
> >>>          * an allocated sector */
> >>>         while (cur_sector < total_sectors &&
> >>>                !bdrv_is_allocated(blk_bs(bb), cur_sector,
> >>>                                   MAX_IS_ALLOCATED_SEARCH, &nr_sector=
s)) {
> >>>             cur_sector +=3D nr_sectors;
> >>>         }
> >>>         aio_context_release(blk_get_aio_context(bb));
> >>>         qemu_mutex_unlock_iothread();
> >>>     }
> >>>
> >>> #0  0x00007f107322f264 in __lll_lock_wait () from /lib64/libpthread.s=
o.0
> >>> #1  0x00007f107322a508 in _L_lock_854 () from /lib64/libpthread.so.0
> >>> #2  0x00007f107322a3d7 in pthread_mutex_lock () from /lib64/libpthrea=
d.so.0
> >>> #3  0x0000000000949ecb in qemu_mutex_lock (mutex=3D0xfc51a0) at
> >>> util/qemu-thread-posix.c:60
> >>> #4  0x0000000000459e58 in qemu_mutex_lock_iothread () at /root/qemu/c=
pus.c:1516
> >>> #5  0x0000000000945322 in os_host_main_loop_wait (timeout=3D28911939)=
 at
> >>> util/main-loop.c:258
> >>> #6  0x00000000009453f2 in main_loop_wait (nonblocking=3D0) at util/ma=
in-loop.c:517
> >>> #7  0x00000000005c76b4 in main_loop () at vl.c:1898
> >>> #8  0x00000000005ceb77 in main (argc=3D49, argv=3D0x7fff921182b8,
> >>> envp=3D0x7fff92118448) at vl.c:4709
> >>
> >> The following patch moves bdrv_is_allocated() into bb's AioContext.  It
> >> will execute without blocking other I/O activity.
> >>
> >> Compile-tested only.
> > i will try this patch.
>=20
> Hi Stefan:
> It work for virtio. i will test ide later.
> Do you have any suggestion about the test case?

1. When testing virtio-blk it's interesting to try both -object
   iothread,id=3Diothread0 -device virtio-blk-pci,iothread=3Diothread0,...
   and without iothread.  The code paths are different so there may be
   bugs that only occur with iothread or without iothread.

2. The guest should be submitting I/O requests to increase the chance of
   race conditions.  You could run "dd if=3D/dev/vda of=3D/dev/null
   iflag=3Ddirect bs=3D4k &" 8 times inside the guest to generate I/O.

Thanks,
Stefan

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7PcRAAoJEJykq7OBq3PIUgQH/0Eh38rSPrbEPXui6q6qRflB
kntY94jkLzMrXY4VBqZYUc53DvHzzfpRoOCnhDaPVu3YkbM6B8bjPGHwpq+RiemE
eDTxJHGWU4c9DCLP7oOxF/CC6UHqxwezNq0FZYkxikLBR90h/YkTHQvSP/aojw8u
OKPpKG/0AyFnqXawiWILmo+bERZUrwuDgtWtEpdrDkCMjThH1i5sTLFiKb2KIyx/
kCUGzueCE/lwUKOgPbE97HuC9ddAiLN1fAnfv4jxsehYS9MuvMBia1gyYEs6sZOd
MwYiP3YwxECAWozRnV2sEm1sKtTgM1Wls2friAr6wdH4c/JEiwZKzyHfSnAFjJM=
=N6AQ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
