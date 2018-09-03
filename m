Received: from eggs.gnu.org ([2001:4830:134:3::10]:32807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwkjH-0000cA-Sq
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwkjB-0000ZM-Ps
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:01:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:53798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fwkjB-0000YQ-Bk
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:00:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fwkj9-00083v-MX
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 09:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F7D42E80D3
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 09:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Sep 2018 08:46:11 -0000
From: Artem Pisarenko <1790460@bugs.launchpad.net>
Reply-To: Bug 1790460 <1790460@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153596437135.32162.9985112313849579617.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1790460] [NEW] -icount,
 sleep=off mode is broken (target slows down or hangs)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

QEMU running with options "-icount,sleep=3Doff -rtc clock=3Dvm" doesn't exe=
cute emulation at maximum possible speed.
Target virtual clock may run faster or slower than realtime clock by N time=
s, where N value depends on various unrelated conditions (i.e. random from =
the user point of view). The worst case is when target hangs (hopefully, ea=
rly in booting stage).
Example scenarios I've described here: http://lists.nongnu.org/archive/html=
/qemu-discuss/2018-08/msg00102.html

QEMU process just sleeps most of the time (polling, waiting some
condition, etc.). I've tried to debug issue and came to 99% conclusion
that there are racing somewhere in qemu internals.

The feature is broken since v2.6.0 release.
Bad commit is 281b2201e4e18d5b9a26e1e8d81b62b5581a13be by Pavel Dovgalyuk, =
03/10/2016 05:56 PM:

  icount: remove obsolete warp call
  =

  qemu_clock_warp call in qemu_tcg_wait_io_event function is not needed
  anymore, because it is called in every iteration of main_loop_wait.
  =

  Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

  Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
  Message-Id: <20160310115603.4812.67559.stgit@PASHA-ISP>
  Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I've reverted commit to all major releases and latest git master branch.
Issue was fixed for all of them. My adaptation is trivial: just
restoring removed function call before "qemu_cond_wait(...)" line.

I'm sure following bugs are just particular cases of the issue:
#1774677, #1653063 .

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790460

Title:
  -icount,sleep=3Doff mode is broken (target slows down or hangs)

Status in QEMU:
  New

Bug description:
  QEMU running with options "-icount,sleep=3Doff -rtc clock=3Dvm" doesn't e=
xecute emulation at maximum possible speed.
  Target virtual clock may run faster or slower than realtime clock by N ti=
mes, where N value depends on various unrelated conditions (i.e. random fro=
m the user point of view). The worst case is when target hangs (hopefully, =
early in booting stage).
  Example scenarios I've described here: http://lists.nongnu.org/archive/ht=
ml/qemu-discuss/2018-08/msg00102.html

  QEMU process just sleeps most of the time (polling, waiting some
  condition, etc.). I've tried to debug issue and came to 99% conclusion
  that there are racing somewhere in qemu internals.

  The feature is broken since v2.6.0 release.
  Bad commit is 281b2201e4e18d5b9a26e1e8d81b62b5581a13be by Pavel Dovgalyuk=
, 03/10/2016 05:56 PM:

    icount: remove obsolete warp call
    =

    qemu_clock_warp call in qemu_tcg_wait_io_event function is not needed
    anymore, because it is called in every iteration of main_loop_wait.
    =

    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

    Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
    Message-Id: <20160310115603.4812.67559.stgit@PASHA-ISP>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  I've reverted commit to all major releases and latest git master
  branch. Issue was fixed for all of them. My adaptation is trivial:
  just restoring removed function call before "qemu_cond_wait(...)"
  line.

  I'm sure following bugs are just particular cases of the issue:
  #1774677, #1653063 .

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790460/+subscriptions
