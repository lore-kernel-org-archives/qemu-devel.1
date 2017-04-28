Received: from eggs.gnu.org ([2001:4830:134:3::10]:47928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d43LO-0003lK-ES
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d43LK-0001vP-Hu
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:41:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:44760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d43LK-0001v2-BN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:41:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d43LG-0007w0-VV
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 10:41:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3CDC52E80D9
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 10:41:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Apr 2017 10:30:21 -0000
From: Daniel Berrange <1686980@bugs.launchpad.net>
Reply-To: Bug 1686980 <1686980@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170428101422.23122.24568.malonedeb@wampee.canonical.com>
Message-Id: <20170428103021.22977.71225.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1686980] Re: qemu is very slow when adding 16,
 384 virtio-scsi drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The first place where it ages an insane amount of time is simply
processing -drive options. The stack trace I see is this

(gdb) bt
#0  0x00005583b596719a in drive_get (type=3Dtype@entry=3DIF_NONE, bus=3Dbus=
@entry=3D0, unit=3Dunit@entry=3D2313) at blockdev.c:223
#1  0x00005583b59679bd in drive_new (all_opts=3D0x5583b890e080, block_defau=
lt_type=3D<optimized out>) at blockdev.c:996
#2  0x00005583b5971641 in drive_init_func (opaque=3D<optimized out>, opts=
=3D<optimized out>, errp=3D<optimized out>)
    at vl.c:1154
#3  0x00005583b5c1149a in qemu_opts_foreach (list=3D<optimized out>, func=
=3D0x5583b5971630 <drive_init_func>, opaque=3D0x5583b9980030, errp=3D0x0) a=
t util/qemu-option.c:1114
#4  0x00005583b5830d30 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at vl.c:4499


We're iterating over every -drive option. Now because we're using if=3Dnone=
, and thus unit=3D=3D0, line 996 of blockdev.c looks calling drive_get() un=
til we find a matching drive, in order to identify the unit number. So we h=
ave a loop over every drive, calling drive_new which loops over every drive=
 calling drive_get which loops over every drive. So about O(N*N*N)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686980

Title:
  qemu is very slow when adding 16,384 virtio-scsi drives

Status in QEMU:
  New

Bug description:
  qemu runs very slowly when adding many virtio-scsi drives.  I have
  attached a small reproducer shell script which demonstrates this.

  Using perf shows the following stack trace taking all the time:

      72.42%    71.15%  qemu-system-x86  qemu-system-x86_64       [.] drive=
_get
              |          =

               --72.32%--drive_get
                         |          =

                          --1.24%--__irqentry_text_start
                                    |          =

                                     --1.22%--smp_apic_timer_interrupt
                                               |          =

                                                --1.00%--local_apic_timer_i=
nterrupt
                                                          |          =

                                                           --1.00%--hrtimer=
_interrupt
                                                                     |     =
     =

                                                                      --0.8=
3%--__hrtimer_run_queues
                                                                           =
     |          =

                                                                           =
      --0.64%--tick_sched_timer

      21.70%    21.34%  qemu-system-x86  qemu-system-x86_64       [.] blk_l=
egacy_dinfo
              |
              ---blk_legacy_dinfo

       3.65%     3.59%  qemu-system-x86  qemu-system-x86_64       [.] blk_n=
ext
              |
              ---blk_next

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686980/+subscriptions
