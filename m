Received: from eggs.gnu.org ([2001:4830:134:3::10]:35289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSona-0002Oi-7N
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 12:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSonX-0002TZ-2v
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 12:40:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:38641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cSonW-0002TI-T5
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 12:40:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cSonU-0006tc-Dx
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 17:40:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 631B52E80C0
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 17:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Jan 2017 17:33:36 -0000
From: Medicine Yeh <1656676@bugs.launchpad.net>
Reply-To: Bug 1656676 <1656676@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170115173336.27164.62843.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1656676=5D_=5BNEW=5D_nvram/fw=5Fcfg?=
 =?utf-8?b?LmMg4oCYcmVhZOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVk?=
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

Commit Number: b6af8ea60282df514f87d32e36afd1c9aeee28c8

The gcc version version 6.3.1 catches a new uninitialized variable in the m=
aster branch of QEMU on the Github. After looking through the function, it =
is really not properly assigned to a value in a certain path (the else cond=
ition of assigning read value in the code).
Here is the snippet of the condition assigning value:
    if (dma.control & FW_CFG_DMA_CTL_READ) {
        read =3D 1;
    } else if (dma.control & FW_CFG_DMA_CTL_SKIP) {
        read =3D 0;
    } else {
        dma.length =3D 0;
    }

Error (Warning) message is as following:
hw/nvram/fw_cfg.c: In function =E2=80=98fw_cfg_dma_transfer=E2=80=99:
hw/nvram/fw_cfg.c:372:16: error: =E2=80=98read=E2=80=99 may be used uniniti=
alized in this function [-Werror=3Dmaybe-uninitialized]

Solution:
You can fix this by either assign a proper initial value when defining it, =
or give a proper value in the else condition. =

Sorry that I don't have a patch for this. I'm not sure whether to assign 1 =
or 0 in the else condition.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656676

Title:
  nvram/fw_cfg.c =E2=80=98read=E2=80=99 may be used uninitialized

Status in QEMU:
  New

Bug description:
  Commit Number: b6af8ea60282df514f87d32e36afd1c9aeee28c8

  The gcc version version 6.3.1 catches a new uninitialized variable in the=
 master branch of QEMU on the Github. After looking through the function, i=
t is really not properly assigned to a value in a certain path (the else co=
ndition of assigning read value in the code).
  Here is the snippet of the condition assigning value:
      if (dma.control & FW_CFG_DMA_CTL_READ) {
          read =3D 1;
      } else if (dma.control & FW_CFG_DMA_CTL_SKIP) {
          read =3D 0;
      } else {
          dma.length =3D 0;
      }

  Error (Warning) message is as following:
  hw/nvram/fw_cfg.c: In function =E2=80=98fw_cfg_dma_transfer=E2=80=99:
  hw/nvram/fw_cfg.c:372:16: error: =E2=80=98read=E2=80=99 may be used unini=
tialized in this function [-Werror=3Dmaybe-uninitialized]

  Solution:
  You can fix this by either assign a proper initial value when defining it=
, or give a proper value in the else condition. =

  Sorry that I don't have a patch for this. I'm not sure whether to assign =
1 or 0 in the else condition.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1656676/+subscriptions
