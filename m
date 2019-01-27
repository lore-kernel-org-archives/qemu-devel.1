Received: from eggs.gnu.org ([209.51.188.92]:40777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnc50-0001CY-Ot
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 23:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnc4z-0004wL-TB
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 23:29:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:46590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gnc4z-0004vx-NK
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 23:29:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gnc4y-0002YC-0R
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 04:29:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DFFD42E80C7
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 04:29:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Jan 2019 04:17:34 -0000
From: Launchpad Bug Tracker <1525123@bugs.launchpad.net>
Reply-To: Bug 1525123 <1525123@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151211084346.25665.93589.malonedeb@gac.canonical.com>
Message-Id: <154856265432.21534.1946367695365825954.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1525123] Re: USB assert failure on hcd-uhci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1525123

Title:
  USB assert failure on hcd-uhci.c

Status in QEMU:
  Expired

Bug description:
  When inserting the attached kernel moudle in the guest OS, QEMU quits
  with therse assert failure:

  [insert kernel module in guest root shell]
  root@qemu:~# insmod mymod.ko
  root@qemu:~#
  Connection closed by foreign host.

  [host message]
  qemu-system-x86_64: hw/usb/core.c:718: usb_ep_get: Assertion `pid =3D=3D =
0x69 || pid =3D=3D 0xe1' failed.
  Aborted

  The direct cause of this bug is due to misimplementation of UHCI.
  According to Intel's UHCI design guide, packet identification in transfer=
 descriptor must be one of these three values : IN (69h), OUT (E1h), and SE=
TUP (2Dh). Any other value in this field must cause the HALT of only HOST C=
ONTROLLER.

  However, due to misimplementation in uhci_handle_td, instead of host
  controller being halted, QEMU itself dies with assertion failure. The
  assertion code is in usb_ep_get():718, which is called during
  uhci_handle_td().

  Another issue resides in uhci_handle_td(). This function must check
  that transfer descriptor's pid is one of IN, OUT, SETUP before calling
  usb_ep_get() or other functions. If it does so, usb_ep_get() only
  needs to check if pid is not SETUP.

  This kind of assert failure can be misused by malwares to avoid being
  analyzed by terminating only in the virtual environments and still
  execute the malicious code in real machines.

  =

  [How to run exploit code]
  Prepare linux kernel's source header, then type these lines in root shell.
  # make
  # insmod mymod.ko

  It needs uhci-hcd.h from linux kernel source.
  I attached linux 3.18.24's uhci-hcd.h for tempory measure; You should get=
 proper version of uhci-hcd.h.
  In the following envrionment, this exploit worked, exiting whole QEMU, no=
t only USB.

  QEMU was running on these environment :
  [CPU model] Intel(R) Core(TM) i5-4590 CPU @ 3.30GHz
  [qemu version] QEMU 2.5.0-rc3 (compiled from source, gcc 4.8.4)
  [host info] Ubuntu 14.04.3, x86_64, 3.19.0-32-generic
  [guest info] Ubuntu 14.04.3, x86_64, 3.19.0-28-generic
  [QEMU argument]
  x86_64-softmmu/qemu-system-x86_64 -hda /media/hdd/img/ubuntu1404.qcow2 \
  =C2=A0-m 512 \
  =C2=A0--usbdevice disk:format=3Dqcow2:../usb.img \
  =C2=A0--enable-kvm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1525123/+subscriptions
