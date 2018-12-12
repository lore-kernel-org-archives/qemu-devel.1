Received: from eggs.gnu.org ([2001:4830:134:3::10]:36391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0rL-0006Po-Sr
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0rI-00059r-E6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:58540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gX0rD-0004yy-OM
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gX0r6-0007XN-S0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:31:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 79A8E2E818A
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:30:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Dec 2018 09:19:31 -0000
From: Thomas Huth <1797033@bugs.launchpad.net>
Reply-To: Bug 1797033 <1797033@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153914992284.15580.825215730676882564.malonedeb@gac.canonical.com>
Message-Id: <154460637128.1185.12960525216607937606.malone@chaenomeles.canonical.com>
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

Fix has been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Deb6a52099160f1a6e66d7e

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1797033

Title:
  Running with -rtc clock=3Dvm,base=3D<datetime> introduces arbitrary base
  shift at guest startup

Status in QEMU:
  Fix Released

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
