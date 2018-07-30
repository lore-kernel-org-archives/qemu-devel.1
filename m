Received: from eggs.gnu.org ([2001:4830:134:3::10]:60663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fkCsV-0002Oc-Vl
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fkCsS-0001MB-01
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:26:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:43838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fkCsR-0001Lo-Qs
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:26:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fkCsO-0003Eh-8o
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 18:26:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3015A2E81E1
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 18:26:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jul 2018 18:12:41 -0000
From: RTOS Pharos <1777777@bugs.launchpad.net>
Reply-To: Bug 1777777 <1777777@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152947435461.1911.16896504402050089205.malonedeb@chaenomeles.canonical.com>
Message-Id: <153297436134.9953.2231795709028365399.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777777] Re: arm9 clock pending (SP804)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Let me explain a bit how to reproduce the problem. I'm developing a RTOS
with qemu (and boards,etc) -
https://sourceforge.net/projects/rtospharos/. The first version used
ARM926 with the versatilepb board and I used the qemu 2.5 version.

In my test (to check that the RTOS is working correctly) I produced a
loop that is always reading the current time ("pharosClockGet") and
checking that it is always increasing. This works perfectly on qemu 2.5.
When qemu 2.12 was released I updated to the new version to add support
for the raspberry pi 3.

Here is a piece of the test:


void aperiodicThread0_0()
{
    uint64_t microseconds;
    uint64_t previousMicroseconds =3D 0;
    uint32_t i;

    for(i =3D 0; i < NUMBER_REPETITIONS; i++)
    {
        microseconds =3D pharosClockGetSinceBoot();
        if(previousMicroseconds > microseconds) =

        {
            print("ERROR! Clock got lower\r\n");
            break;
        }
    }
}


I'll show you the "internals" of Pharos next (this is file clock.c):


uint64_t pharosIClockGetSinceBoot(void)
{
    /* microseconds since last clock tick*/
    uint32_t microseconds;

    /* number of clock ticks since boot */
    ClockTick clockTicks;

    /* >> interrupts are disabled when we get here << */

    /* read the number of microseconds on the counter */
    clockTicks =3D pharosVClockTicks;

    /* read the timer value */
    microseconds =3D pharosCpuClockReadCounter();

    /* if the clock interrupt is pending we might have read the microsecond=
s before or after the clock tick occurred (but not processed since interrup=
ts are disabled) */
    if(pharosCpuClockIsrIsPending() =3D=3D TRUE)
    {
        /* interrupt is pending, so read again the microseconds and subtrac=
t 2 clock ticks */
        microseconds =3D (2U * pharosIMicrosecondsPerClockTick()) - pharosC=
puClockReadCounter();
    }
    else
    {
        /* the timer counts backwards so we must subtract to get the number=
 of microseconds since last tick */
        microseconds =3D pharosIMicrosecondsPerClockTick() - microseconds;
    }

    /* calculate the result using the last us read */
    return (uint64_t) ((pharosIMicrosecondsPerClockTick() * clockTicks) + m=
icroseconds);
}


And the part that is hw dependent (for ARM926) - this is in file ClockSp804=
.h: =


INLINE bool armSp804TimerInterruptIsPending(const ptrArmSp804Timer c)
{
        /* get the first bit of the interrupt status (ignore other bits) to=
 check if the interrupt is pending */
        return (c->timerInterruptMaskStatus & 0x1U) =3D=3D 1U ? TRUE : FALS=
E;
}


I hope the code is easy enough to read.
Thank you

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777777

Title:
  arm9 clock pending (SP804)

Status in QEMU:
  New

Bug description:
  Hello all,

  I'm using the versatilepb board and the timer Interrupt Mask Status
  register (offset 0x14 of the SP804) does not seem to be working
  properly on the latest qemu-2.12. I tried on the 2.5 (i believe this
  is the mainstream version that comes with Linux) and it works
  perfectly.

  What happens is that the pending bit does not seem to be set in some
  scenarios. In my case, I see the timer value decreasing to 0 and then
  being reset to the reload value and neither does the interrupt is
  triggered nor the pending bit is set.

  I believe this is a matter of timing since in the "long" run the
  system eventually catches up (after a few microseconds).

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777777/+subscriptions
