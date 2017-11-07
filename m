Received: from eggs.gnu.org ([2001:4830:134:3::10]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC92I-0006gF-L5
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC92E-0003ht-O1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:55:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:38664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC92E-0003hQ-Go
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:55:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC92C-0007HA-KT
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 904032E804B
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 18:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 18:42:58 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1080086 <1080086@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121117144135.13758.80176.malonedeb@wampee.canonical.com>
Message-Id: <151008017823.4447.13719410884183228823.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1080086] Re: MC146818 RTC breaks when SET bit in
 Register B is on.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We fixed this bug long ago in 2012, in commit 02c6ccc6dde90d (thanks for
your patch!) but forgot to close the bug...so I'm doing it now.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1080086

Title:
  MC146818 RTC breaks when SET bit in Register B is on.

Status in QEMU:
  Fix Released

Bug description:
  This bug occurs when the SET flag of Register B is enabled. When an RTC
  data register (i.e. any of the 10 bytes of time/calender data in CMOS) is=
 set,
  the data is (as expected) correctly stored in the cmos_data array. Howeve=
r,
  since the SET flag is enabled, the function rtc_set_time is not invoked.
  As a result, the field base_rtc in RTCState remains uninitialized. This a=
ppears to
  cause a problem on subsequent writes which can end up overwriting data.

  To see this, consider writing data to Register A after having written
  data to any of the RTC data registers; the following figure illustrates
  the call stack for the Register A write operation:

   +- cmos_io_port_write
   +-- check_update_timer
   +---- get_next_alarm
   +------ rtc_update_time

  In rtc_update_time, get_guest_rtc calculates the wrong time and
  overwrites the previously written RTC data register values.

  I have created a standalone test case which exposes this bug:

  https://github.com/ahorn/benchmarks/commit/fff1ca40694bbef6f7f9de323bb0be=
d63419ef99

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1080086/+subscriptions
