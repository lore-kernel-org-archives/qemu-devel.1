Received: from eggs.gnu.org ([2001:4830:134:3::10]:51048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d43e4-0008QH-Or
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d43e3-0008Lq-Sw
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:01:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:52162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d43e3-0008LY-MX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:01:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d43e1-0003aw-1L
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 11:01:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C6112E80C7
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 11:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Apr 2017 10:53:08 -0000
From: Daniel Berrange <1686980@bugs.launchpad.net>
Reply-To: Bug 1686980 <1686980@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170428101422.23122.24568.malonedeb@wampee.canonical.com>
Message-Id: <20170428105308.27035.15890.malone@chaenomeles.canonical.com>
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

I instrumented drive_new to time how long 1000 creations took with
current code:

1000 drive_new() in 0 secs
1000 drive_new() in 2 secs
1000 drive_new() in 18 secs
1000 drive_new() in 61 secs

As a quick hack you can just disable the drive_get() calls when if=3Dnone.
They're mostly just used to fill in default unit_id, but that's not
really required for if=3Dnone. That said, if no id=3D parameter is set, then
the code does expect unit_id to be valid, so not sure how to fully fix
that.

Anyway, with this hack applied it is much faster, but there is still
some kind of N*N complexity going on, because drive_new() gets slower &
slower as each drive is created - just not nearly as badly as before.

1000 drive_new() in 0 secs
1000 drive_new() in 0 secs
1000 drive_new() in 0 secs
1000 drive_new() in 1 secs
1000 drive_new() in 1 secs
1000 drive_new() in 1 secs
1000 drive_new() in 2 secs
1000 drive_new() in 2 secs
1000 drive_new() in 2 secs
1000 drive_new() in 4 secs
1000 drive_new() in 4 secs
1000 drive_new() in 6 secs
1000 drive_new() in 8 secs
1000 drive_new() in 8 secs


** Patch added: "Hack to avoid drive_new() when if=3Dnone"
   https://bugs.launchpad.net/qemu/+bug/1686980/+attachment/4869119/+files/=
skip-drive-get-if-none.patch

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
