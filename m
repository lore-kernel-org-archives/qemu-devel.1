Received: from eggs.gnu.org ([2001:4830:134:3::10]:58642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkbDS-0000CX-0c
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkbDQ-0006WO-0L
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:21:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dkbDP-0006W9-NG
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:21:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dkbDN-00056z-MZ
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:21:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EC38D2E8194
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:21:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2017 19:10:27 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150351542776.11546.13573489267141135936.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with qemu
 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yeah seems to be slightly different than the former assert.

2017-08-23 18:41:54.556+0000: initiating migration
bdrv_inactivate_recurse: entry for drive-virtio-disk0
bdrv_inactivate_recurse: entry for #block133
bdrv_inactivate_recurse: entry for #block329
bdrv_inactivate_recurse: entry for #block202
bdrv_inactivate_recurse: exit end good for #block202
bdrv_inactivate_recurse: exit end good for #block329
bdrv_inactivate_recurse: entry for #block025
bdrv_inactivate_recurse: exit end good for #block025
bdrv_inactivate_recurse: exit end good for #block133
bdrv_inactivate_recurse: exit end good for drive-virtio-disk0
bdrv_inactivate_recurse: entry for #block799
bdrv_inactivate_recurse: entry for #block626
bdrv_inactivate_recurse: exit end good for #block626
bdrv_inactivate_recurse: exit end good for #block799
bdrv_inactivate_recurse: entry for drive-virtio-disk1
bdrv_inactivate_recurse: entry for #block570
bdrv_inactivate_recurse: entry for #block485
bdrv_inactivate_recurse: exit end good for #block485
bdrv_inactivate_recurse: exit end good for #block570
bdrv_inactivate_recurse: exit end good for drive-virtio-disk1
bdrv_inactivate_recurse: entry for #block1058
bdrv_inactivate_recurse: entry for #block920
bdrv_inactivate_recurse: exit end good for #block920
bdrv_inactivate_recurse: exit end good for #block1058
bdrv_inactivate_recurse: entry for drive-virtio-disk0
Unexpected error in bdrv_check_perm() at /build/qemu-0OVYHF/qemu-2.10~rc3+d=
fsg/block.c:1574:
2017-08-23T18:41:54.730131Z qemu-system-x86_64: Block node is read-only

Which is:
1553 /*                                                                    =
           =

1554  * Check whether permissions on this node can be changed in a way that=
           =

1555  * @cumulative_perms and @cumulative_shared_perms are the new cumulati=
ve         =

1556  * permissions of all its parents. This involves checking whether all =
necessary  =

1557  * permission changes to child nodes can be performed.                =
           =

1558  *                                                                    =
           =

1559  * A call to this function must always be followed by a call to bdrv_s=
et_perm()  =

1560  * or bdrv_abort_perm_update().                                       =
           =

1561  */                                                                   =
           =

1562 static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_p=
erms,      =

1563                            uint64_t cumulative_shared_perms,          =
           =

1564                            GSList *ignore_children, Error **errp)     =
           =

1565 {                                                                     =
           =

1566     BlockDriver *drv =3D bs->drv;                                     =
             =

1567     BdrvChild *c;                                                     =
           =

1568     int ret;                                                          =
           =

1569                                                                       =
           =

1570     /* Write permissions never work with read-only images */          =
           =

1571     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED=
)) &&      =

1572         !bdrv_is_writable(bs))                                        =
           =

1573     {                                                                 =
           =

1574         error_setg(errp, "Block node is read-only");                  =
           =

1575         return -EPERM;                                                =
           =

1576     } =


Adding in debug symbols to see in gdb which device that actually is showed =
me:
I don't know what you might need so the full struct:

(gdb) p *bs
$2 =3D {open_flags =3D 2050, read_only =3D false, encrypted =3D false, sg =
=3D false, probed =3D false, force_share =3D false, implicit =3D true, =

  drv =3D 0x1a67219800 <bdrv_mirror_top>, opaque =3D 0x0, aio_context =3D 0=
x1a684ae0d0, aio_notifiers =3D {lh_first =3D 0x1a6a4850e0}, =

  walking_aio_notifiers =3D false, filename =3D "/var/lib/uvtool/libvirt/im=
ages/kvmguest-artful-normal.qcow", '\000' <repeats 4037 times>, =

  backing_file =3D "/var/lib/uvtool/libvirt/images/kvmguest-artful-normal.q=
cow", '\000' <repeats 4037 times>, =

  backing_format =3D "qcow2\000\000\000\000\000\000\000\000\000\000", full_=
open_options =3D 0x0, =

  exact_filename =3D "/var/lib/uvtool/libvirt/images/kvmguest-artful-normal=
.qcow", '\000' <repeats 4037 times>, backing =3D 0x1a6971a4a0, =

  file =3D 0x0, bl =3D {request_alignment =3D 1, max_pdiscard =3D 0, pdisca=
rd_alignment =3D 0, max_pwrite_zeroes =3D 0, pwrite_zeroes_alignment =3D 0, =

    opt_transfer =3D 0, max_transfer =3D 0, min_mem_alignment =3D 512, opt_=
mem_alignment =3D 4096, max_iov =3D 1024}, supported_write_flags =3D 0, =

  supported_zero_flags =3D 0, node_name =3D "#block814", '\000' <repeats 22=
 times>, node_list =3D {tqe_next =3D 0x1a684b44d0, tqe_prev =3D 0x1a6b02e0c=
0}, =

  bs_list =3D {tqe_next =3D 0x1a6a010030, tqe_prev =3D 0x1a6ab6bc50}, monit=
or_list =3D {tqe_next =3D 0x0, tqe_prev =3D 0x0}, refcnt =3D 3, op_blockers=
 =3D {{
      lh_first =3D 0x1a69e18e80}, {lh_first =3D 0x1a69e18ea0}, {lh_first =
=3D 0x1a69e18ec0}, {lh_first =3D 0x1a69e18ee0}, {lh_first =3D 0x1a69e18f00}=
, {
      lh_first =3D 0x0}, {lh_first =3D 0x1a69e18f40}, {lh_first =3D 0x1a69e=
18f60}, {lh_first =3D 0x1a69e18f80}, {lh_first =3D 0x1a69e18fa0}, {
      lh_first =3D 0x1a6989be30}, {lh_first =3D 0x1a69e18fc0}, {lh_first =
=3D 0x1a69e18fe0}, {lh_first =3D 0x1a69352e90}, {lh_first =3D 0x1a69352eb0}=
, {
      lh_first =3D 0x1a69352ed0}}, job =3D 0x1a69e18bf0, inherits_from =3D =
0x0, children =3D {lh_first =3D 0x1a6971a4a0}, parents =3D {
    lh_first =3D 0x1a69e18e00}, options =3D 0x1a69b636a0, explicit_options =
=3D 0x1a69e16bb0, detect_zeroes =3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF, =

  backing_blocker =3D 0x1a686e2e00, total_sectors =3D 16777216, before_writ=
e_notifiers =3D {notifiers =3D {lh_first =3D 0x0}}, write_threshold_offset =
=3D 0, =

  write_threshold_notifier =3D {notify =3D 0x0, node =3D {le_next =3D 0x0, =
le_prev =3D 0x0}}, dirty_bitmap_mutex =3D {lock =3D {__data =3D {__lock =3D=
 0, =

        __count =3D 0, __owner =3D 0, __nusers =3D 0, __kind =3D 0, __spins=
 =3D 0, __elision =3D 0, __list =3D {__prev =3D 0x0, __next =3D 0x0}}, =

      __size =3D '\000' <repeats 39 times>, __align =3D 0}, initialized =3D=
 true}, dirty_bitmaps =3D {lh_first =3D 0x0}, wr_highest_offset =3D {
    value =3D 1190584320}, copy_on_read =3D 0, in_flight =3D 0, serialising=
_in_flight =3D 0, wakeup =3D false, io_plugged =3D 0, enable_write_cache =
=3D 0, =

  quiesce_counter =3D 0, write_gen =3D 2, reqs_lock =3D {locked =3D 0, ctx =
=3D 0x0, from_push =3D {slh_first =3D 0x0}, to_pop =3D {slh_first =3D 0x0}, =

    handoff =3D 0, sequence =3D 0, holder =3D 0x0}, tracked_requests =3D {l=
h_first =3D 0x0}, flush_queue =3D {entries =3D {sqh_first =3D 0x0, =

      sqh_last =3D 0x1a69b63680}}, active_flush_req =3D false, flushed_gen =
=3D 2}

And that effectively is my root disk:

At least the trivial flag in the struct is "read_only =3D false".
Also on a FS level it is rw:
-rw------- 1 root root 717160448 Aug 23 18:50 /var/lib/uvtool/libvirt/image=
s/kvmguest-artful-normal.qcow
(qemu is running privileged in this setup with UID 0, so no reason to mark =
that as read only IMHO)

So I checked the full context of the if that leads to the error:
  (cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))
       3  (in my case)  & (    0x2   |  0x4)
  ok that is a match

So it goes further to
  !bdrv_is_writable(bs)

Which effectively is:
  !bdrv_is_read_only(bs) && !(bs->open_flags & BDRV_O_INACTIVE);
       !bs->read_only       ! (2050        &    0x800)
         !false                     !(true)
         true                       false

So the problem is that BDRV_O_INACTIVE is set?
Sorry I don't see why that is so (maybe too late for today).
But I hope that helps in understanding the remaining case.

I checked against your coommit list and I didn't have the following yet.
cf26039a2b50f078b4ad90b88eea5bb28971c0d8 block: Update open_flags after ->i=
nactivate() callback
I took it now from the PULL 0/6 of Eric that appeared after my last test.
Building with that now to report once again.

If there is no build hickup that next test should just fit in before I fall=
 asleep.
Hoping for the best to report a tested by in time if possible.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711602

Title:
  --copy-storage-all failing with qemu 2.10

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Confirmed
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  We fixed an issue around disk locking already in regard to qemu-nbd
  [1], but there still seem to be issues.

  $ virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh=
://10.22.69.196/system
  error: internal error: qemu unexpectedly closed the monitor: 2017-08-18T1=
2:10:29.800397Z qemu-system-x86_64: -chardev pty,id=3Dcharserial0: char dev=
ice redirected to /dev/pts/0 (label charserial0)
  2017-08-18T12:10:48.545776Z qemu-system-x86_64: load of migration failed:=
 Input/output error

  Source libvirt log for the guest:
  2017-08-18 12:09:08.251+0000: initiating migration
  2017-08-18T12:09:08.809023Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer
  2017-08-18T12:09:08.809481Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer

  Target libvirt log for the guest:
  2017-08-18T12:09:08.730911Z qemu-system-x86_64: load of migration failed:=
 Input/output error
  2017-08-18 12:09:09.010+0000: shutting down, reason=3Dcrashed

  Given the timing it seems that the actual copy now works (it is busy ~10 =
seconds on my environment which would be the copy).
  Also we don't see the old errors we saw before, but afterwards on the act=
ual take-over it fails.

  Dmesg has no related denials as often apparmor is in the mix.

  Need to check libvirt logs of source [2] and target [3] in Detail.

  [1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02200.html
  [2]: http://paste.ubuntu.com/25339356/
  [3]: http://paste.ubuntu.com/25339358/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711602/+subscriptions
