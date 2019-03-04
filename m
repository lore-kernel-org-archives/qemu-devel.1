Received: from eggs.gnu.org ([209.51.188.92]:41123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h0q65-0001m5-Tt
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h0q60-00064k-Ae
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:05:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h0q60-00063S-4U
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:05:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h0q5y-0005H1-Nf
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 16:05:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B09522E8031
	for <qemu-devel@nongnu.org>; Mon,  4 Mar 2019 16:05:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Mar 2019 15:58:41 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1817846 <1817846@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155125434202.29829.12830631606462823569.malonedeb@chaenomeles.canonical.com>
Message-Id: <155171512188.31424.3487556240295645656.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1817846] Re: Qemu 3.1 Aarch64 TLBI VAE1, x0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could you provide a test binary (and the QEMU command line to run it)
that demonstrates the bug, please?

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
