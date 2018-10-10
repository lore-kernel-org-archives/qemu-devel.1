Received: from eggs.gnu.org ([2001:4830:134:3::10]:58380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gA7OI-0007l4-0Q
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 01:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gA7OE-0006qm-DP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 01:50:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:60672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gA7OE-0006qQ-6y
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 01:50:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gA7OD-0007Ih-GI
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 05:50:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7A3F52E8019
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 05:50:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Oct 2018 05:39:49 -0000
From: Artem Pisarenko <1797033@bugs.launchpad.net>
Reply-To: Bug 1797033 <1797033@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153914992284.15580.825215730676882564.malonedeb@gac.canonical.com>
Message-Id: <153914998993.12117.3640916446563132103.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1797033] Re: Running with -rtc clock=vm,
 base=<datetime> introduces arbitrary base shift at guest startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Why I didn't posted patch to qemu-devel ?
I have no idea how to patch it correctly, because it isn't clear how these =
things are expected to work when referenced across all qemu code and differ=
ent use cases. Should vl.c/qemu_get_timedate() just be fixed ? Does each ca=
ller expect same behavior from it? Or only selected hw/* RTC implementation=
s (such as hw/timer/mc146818rtc.c) have to be modified to use alternative f=
unction ? Or maybe it isn't specific to clock=3Dvm and should be considered=
 bad behavior in any case (i.e. time shouldn't advance before guest executi=
on being started)?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1797033

Title:
  Running with -rtc clock=3Dvm,base=3D<datetime> introduces arbitrary base
  shift at guest startup

Status in QEMU:
  New

Bug description:
  When specifying 'base' for RTC to start with, it has incorrect
  implementation in combination with clock=3Dvm.

  I inspected source code. This is because it uses host clock
  (qemu_time() function return value) as reference with
  'rtc_date_offset' operations across several places in code before
  guest execution starts, which has no relevance with clock=3Dvm.

  It works in vast majority of cases only thanks to combination of some
  luck and fast execution of qemu initialization phase relative to host
  real time (i.e. multiple calls of qemu_time() returns same value). But
  if qemu execution is being slow down by high CPU load on host or
  started just before value of second changes, it may accumulate at
  least 1 second (and in hard circumstances even 2+ seconds) of delay
  from specified base datetime before guest becomes ready to start.

  This behavior breaks determinism of guest execution in icount mode.
  (Even if guest doesn't cares about precise time, just one second shift
  may trigger such chain of changes which accumulates significant
  difference in guest state at the moment when guest OS finishes
  booting.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1797033/+subscriptions
