Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d46gd-0005Cm-GK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d46gY-0001v3-B1
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:15:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d46gY-0001ut-59
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:15:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d46gT-0006d7-W9
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 14:15:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5F4D42E80D1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 14:15:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Apr 2017 14:08:54 -0000
From: Daniel Berrange <1686980@bugs.launchpad.net>
Reply-To: Bug 1686980 <1686980@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170428101422.23122.24568.malonedeb@wampee.canonical.com>
Message-Id: <20170428140854.27002.394.malone@chaenomeles.canonical.com>
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

I added further instrumentation and got this profile of where the
remaining time goes

1000x drive_new 18.347secs
-> 1000x blockdev_init 18.328secs
   -> 1000x monitor_add_blk 4.515secs
      -> 1000x blk_by_name 1.545secs
      -> 1000x bdrv_find_node 2.968secs
   -> 1000x blk_new_open 13.786secs
      -> 1000x bdrv_open 13.783secs

These numbers are all increasing as we process more & more -drive args,
so there's some O(N) factor in blk_by_name, bdrv_find_node and bdrv_open

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
