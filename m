Received: from eggs.gnu.org ([2001:4830:134:3::10]:57670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxcBn-00027X-O4
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxcBh-0003Hz-Ga
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:01:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxcBh-0003HF-7f
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:01:25 -0400
Date: Thu, 28 Sep 2017 18:01:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170928170114.GF2130@work-vm>
References: <9AA25E8890139848BAC96ED2495626F439A2EA23@DGGEML501-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9AA25E8890139848BAC96ED2495626F439A2EA23@DGGEML501-MBX.china.huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ping RE: question: I found a qemu crash about
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "wangjie (P)" <wangjie88@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, mreitz@redhat.com, quintela@redhat.com, "pbonzini@redhat.com" <pbonzini@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, "eblake@redhat.com" <eblake@redhat.com>, "berrange@redhat.com kchamart@redhat.com" <kchamart@redhat.com>, "famz@redhat.com" <famz@redhat.com>

* wangjie (P) (wangjie88@huawei.com) wrote:
> Ping=EF=BC=9F
>=20
> From: wangjie (P)
> Sent: Tuesday, September 26, 2017 9:10 PM
> To: qemu-devel@nongnu.org; kwolf@redhat.com; pbonzini@redhat.com
> Cc: wangjie (P) <wangjie88@huawei.com>; fuweiwei (C) <fuweiwei2@huawei.=
com>; eblake@redhat.com; kchamart@redhat.com; dgilbert@redhat.com; famz@r=
edhat.com; Wubin (H) <wu.wubin@huawei.com>
> Subject: question: I found a qemu crash about migration
>=20
> Hi,
>=20
> When I use qemuMigrationRun to migrate both memory and storage with som=
e IO press in VM, and configured iothreads. We triggered a error reports:=
  (I use the current qemu master branch)
> " bdrv_co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed",
>=20
> I reviewed the code, and gdb the coredump file, I think one case can tr=
igger the error reports
>=20
> Case:
>=20
> Migration_thread()
>       Migration_completion() ----------> last iteration of memory migra=
tion
>             Vm_stop_force_state()--------------> Stop the VM, and call =
bdrv_drain_all, but I gdb the core file, and found the cnt of dirty bitma=
p of driver-mirror is not 0, and in_flight mirror IO is 16,
>                   Bdrv_inactivate_all()----------------> inactivate ima=
ges and set the INACTIVE label.
>       -> bdrv_co_do_pwritev()-------------->then the mirror IO handled =
after will trigger the Assertion `!(bs->open_flags & 0x0800)' and qemu cr=
ashed
>=20
>=20
>=20
>=20
> As we can see from above,  Migration_completion call Bdrv_inactivate_al=
l to inactivate images, but the mirror_run is not done (still has dirty c=
lusters), the mirror_run IO issued later will triggered error reports: " =
bdrv_co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed",
>=20
> It seems that memory migration and storage mirror is done independently=
 and the sequence of the two progresses are quite random.
>=20
> How can I solve this problem, should we not set  INACTIVE label for dri=
ve-mirror BlockDriverState?

Hi,
  This is a 'fun' bug;  I had a good chat to kwolf about it earlier.
A proper fix really needs to be done together with libvirt so that we
can sequence:
   a) The stopping of the CPU on the source
   b) The termination of the mirroring block job
   c) The inactivation of the block devices on the source
       (bdrv_inactivate_all)
   d) The activation of the block devices on the destination
       (bdrv_invalidate_cache_all)
   e) The start of the CPU on the destination

It looks like you're hitting a race between b/c;  we've had races
between c/d in the past and moved the bdrv_inactivate_all.

During the discussion we ended up with two proposed solutions;
both of them require one extra command and one extra migration
capability.

The block way
-------------
   1) Add a new migration capability pause-at-complete
   2) Add a new migration state almost-complete
   3) After saving devices, if pause-at-complete is set,
      transition to almost-complete
   4) Add a new command (migration-continue) that=20
      causes the migration to inactivate the devices (c)
      and send the final EOF to the destination.

You set pause-at-complete, wait until migrate hits almost-complete;
cleanup the mirror job, and then do migration-continue.  When it
completes do 'cont' on the destination.

The migration way
-----------------
   1) Stop doing (d) when the destination is started with -S
      since it happens anyway when 'cont' is issued
   2) Add a new migration capability ext-manage-storage
   3) When 'ext-manage-storage' is set, we don't bother doing (c)
   4) Add a new command 'block-inactivate' on the source

You set ext-manage-storage, do the migrate and when it's finished
clean up the block job, block-inactivate on the source, and
then cont on the destination.
 =20

My worry about the 'block way' is that the point at which we
do the pause seems pretty interesting;  it probably is best
done after the final device save but before the inactivate,
but could be done before it.  But it probably becomes API
and something might become dependent on where we did it.

I think Kevin's worry about the 'migration way' is that
it's a bit of a block-specific fudge; which is probably right.


I've not really thought what happens when you have a mix of shared and
non-shared storage.

Could we do any hack that isn't libvirt-visible for existing versions?
I guess maybe hack drive-mirror so it interlocks with the migration
code somehow to hold off on that inactivate?

This code is visible probalby from 2.9.ish with the new locking code;
but really that b/c race has been there for ever - there's maybe
always the chance that the last few blocks of mirroring might have
happened too late ?

Thoughts?
What are the libvirt view on the preferred solution.

Dave


> Qemu Crash bt:
> (gdb) bt
> #0  0x00007f6b6e2a71d7 in raise () from /usr/lib64/libc.so.6
> #1  0x00007f6b6e2a88c8 in abort () from /usr/lib64/libc.so.6
> #2  0x00007f6b6e2a0146 in __assert_fail_base () from /usr/lib64/libc.so=
.6
> #3  0x00007f6b6e2a01f2 in __assert_fail () from /usr/lib64/libc.so.6
> #4  0x00000000007b9211 in bdrv_co_pwritev (child=3D<optimized out>, off=
set=3Doffset@entry=3D7034896384, bytes=3Dbytes@entry=3D65536,
>     qiov=3Dqiov@entry=3D0x7f69cc09b068, flags=3D0) at block/io.c:1536
> #5  0x00000000007a6f02 in blk_co_pwritev (blk=3D0x2f92750, offset=3D703=
4896384, bytes=3D65536, qiov=3D0x7f69cc09b068,
>     flags=3D<optimized out>) at block/block_backend.c:851
> #6  0x00000000007a6fc1 in blk_aio_write_entry (opaque=3D0x301dad0) at b=
lock/block_backend.c:1043
> #7  0x0000000000835e2a in coroutine_trampoline (i0=3D<optimized out>, i=
1=3D<optimized out>) at util/coroutine_ucontext.c:79
> #8  0x00007f6b6e2b8cf0 in ?? () from /usr/lib64/libc.so.6
> #9  0x00007f6a1bcfc780 in ?? ()
> #10 0x0000000000000000 in ?? ()
>=20
> And I see the mirror_run is not done,  gdb info as following:
> [cid:image001.png@01D3386F.DBC9FF10]
>=20
>=20
> Src VM qemu log:
>=20
> [cid:image002.png@01D3386F.DBC9FF10]
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
