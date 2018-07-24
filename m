Received: from eggs.gnu.org ([2001:4830:134:3::10]:47309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fi6jc-00027o-WE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 19:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fi6jY-00065F-V5
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 19:28:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:53786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fi6jY-00064g-O1
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 19:28:48 -0400
Received: from chaenomeles.canonical.com ([91.189.89.119])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fi6jX-0006ay-CW
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 23:28:47 +0000
Received: from chaenomeles.canonical.com (localhost [IPv6:::1])
	by chaenomeles.canonical.com (Postfix) with ESMTPS id 48789681C09
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 23:28:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jul 2018 23:28:47 -0000
From: Launchpad Bug Tracker <1783422@bugs.launchpad.net>
Reply-To: Bug 1783422 <1783422@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153247232146.31708.16928869218429719038.malonedeb@chaenomeles.canonical.com>
Message-Id: <153247492703.32215.3342726685556574819.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1783422] [NEW] qemu_clock_get_ns does not take
 into account icount_time_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You have been subscribed to a public bug:

Hello,

If you check the qemu/util/qemu-timer.c you will find the following
function:

597: int64_t qemu_clock_get_ns(QEMUClockType type)
598: {
....
602:    switch (type) {
....
606:    case QEMU_CLOCK_VIRTUAL:
607:        if (use_icount) {
608:            return cpu_get_icount(); =



Now on line 606, in case we requested QEMU_CLOCK_VIRTUAL, and we are using =
icount, the value of cpu_get_icount(); will be returned.

However if I understand correctly, in order to convert icount to ns, you
must use take into account the icount shift -- as defined in the
documentation: "The virtual cpu will execute one instruction every 2^N
ns of virtual time.".

Therefor, the correct value to return would be
cpu_icount_to_ns(cpu_get_icount()), where cpu_icount_to_ns is defined in
cpus.c:

296: int64_t cpu_icount_to_ns(int64_t icount)
297: {
298:    return icount << icount_time_shift;
299: }

Best Regards,
Humberto "SilverOne" Carvalho

** Affects: qemu
     Importance: Undecided
         Status: Incomplete

-- =

qemu_clock_get_ns does not take into account icount_time_shift
https://bugs.launchpad.net/bugs/1783422
You received this bug notification because you are a member of qemu-devel-m=
l, which is subscribed to QEMU.
