Received: from eggs.gnu.org ([209.51.188.92]:57066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyuIz-0005So-Bk
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyuIy-0007I0-8O
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:11:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:45372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gyuIu-00074h-T9
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:11:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gyuIj-0006LV-1T
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 08:10:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0280D2E80C7
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 08:10:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Feb 2019 07:59:01 -0000
From: RTOS Pharos <1817846@bugs.launchpad.net>
Reply-To: Bug 1817846 <1817846@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155125434202.29829.12830631606462823569.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1817846] [NEW] Qemu 3.1 Aarch64 TLBI VAE1, x0
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

Hello,

In my code I'm trying to remove some permissions to a 4KiB MMU
descriptor. After that I invalidate the MMU with

TLBI VAE1, x0

where x0 is the start of the address of the 4 KiB page.

In Qemu 2.12 this did not work, but I worked around it with:


    /* invalidate the address */
    TLBI VAE1, x0


    /*****************************************************************/
    /*****************************************************************/
    /* NOTE: THIS IS A TRICK FOR QEMU!!!!!!!!!!!!                          =
                                     */
    /* Apparently we have to change the TTBR0_EL1 when we change a descript=
or (especially to remove permissions) */
    /* Otherwise qemu (2.12) will continue with the same descriptor with pe=
rmissions!                          **/
   /*****************************************************************/
   /*****************************************************************/
     =

    /* do a trick (in qemu) */
    mrs     x1 , TTBR0_EL1

    ldr     x2 , =3DkernelTable0Table

    msr     TTBR0_EL1 , x2

    isb

    msr     TTBR0_EL1 , x1

    /* return from function */
    ret


That is, I just replaced the TTBR0_EL1 with a temporary value, and then res=
tored it. (guess qemu 2.12 just needed to reload the values again).

However, even this procedure is not working with qemu 3.1. (I just
tested again with qemu 2.12 and the code works fine, with qemu 3.1 it
does not).

Thanks,
Pharos team

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817846

Title:
  Qemu 3.1 Aarch64 TLBI VAE1, x0

Status in QEMU:
  New

Bug description:
  Hello,

  In my code I'm trying to remove some permissions to a 4KiB MMU
  descriptor. After that I invalidate the MMU with

  TLBI VAE1, x0

  where x0 is the start of the address of the 4 KiB page.

  In Qemu 2.12 this did not work, but I worked around it with:

  =

      /* invalidate the address */
      TLBI VAE1, x0

  =

      /*****************************************************************/
      /*****************************************************************/
      /* NOTE: THIS IS A TRICK FOR QEMU!!!!!!!!!!!!                        =
                                       */
      /* Apparently we have to change the TTBR0_EL1 when we change a descri=
ptor (especially to remove permissions) */
      /* Otherwise qemu (2.12) will continue with the same descriptor with =
permissions!                          **/
     /*****************************************************************/
     /*****************************************************************/
       =

      /* do a trick (in qemu) */
      mrs     x1 , TTBR0_EL1

      ldr     x2 , =3DkernelTable0Table

      msr     TTBR0_EL1 , x2

      isb

      msr     TTBR0_EL1 , x1

      /* return from function */
      ret

  =

  That is, I just replaced the TTBR0_EL1 with a temporary value, and then r=
estored it. (guess qemu 2.12 just needed to reload the values again).

  However, even this procedure is not working with qemu 3.1. (I just
  tested again with qemu 2.12 and the code works fine, with qemu 3.1 it
  does not).

  Thanks,
  Pharos team

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817846/+subscriptions
