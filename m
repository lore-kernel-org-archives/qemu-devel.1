Received: from eggs.gnu.org ([209.51.188.92]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gx8LJ-00083X-QI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gx8LH-00008e-AI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:46:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:40376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gx8LG-0008LZ-Ks
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:46:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gx8Ky-0002ie-HX
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 10:45:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 818A42E80C9
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 10:45:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Feb 2019 10:29:04 -0000
From: Thomas Huth <1550743@bugs.launchpad.net>
Reply-To: Bug 1550743 <1550743@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160227160544.1630.72757.malonedeb@soybean.canonical.com>
Message-Id: <155083134464.11803.7619105868985987655.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1550743] Re: connect low speed host devices to
 qemu ehci does not work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Are you sure that EHCI handles low-speed devices in that case? I thought th=
at XHCI is capable of handling low-speed devices instead...
Anyway, QEMU certainly only emulates the EHCI in a traditional way, so if y=
ou want to use low-speed devices here, you also have to specify an UHCI con=
troller for them. I.e. as far as I can see, this is not a bug in QEMU, but =
just a configuration issue.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1550743

Title:
  connect low speed host devices to qemu ehci does not work

Status in QEMU:
  Invalid

Bug description:
  $ qemu-system-i386 -hda my_x86.img -device ich9-usb-ehci1,id=3Dehci -devi=
ce usb-host,vendorid=3D0x045e,productid=3D0x071d -serial stdio
  qemu-system-i386: Warning: speed mismatch trying to attach usb device "Mi=
crosoft? 2.4GHz Transceiver V" (=03 speed) to bus "ehci.0", port "1" (high =
speed)
  qemu-system-i386: Warning: speed mismatch trying to attach usb device "Mi=
crosoft? 2.4GHz Transceiver V" (=03 speed) to bus "ehci.0", port "1" (high =
speed)
  qemu-system-i386: Warning: speed mismatch trying to attach usb device "Mi=
crosoft? 2.4GHz Transceiver V" (=03 speed) to bus "ehci.0", port "1" (high =
speed)

  Which is obviously wrong. The ehci specification states:

  Low-speed device, release ownership of port <=3D Table 2-16.

  Table 2-6:

  Number of Companion Controller (N_CC). This field indicates the number of
  companion controllers associated with this USB 2.0 host controller.
  A zero in this field indicates there are no companion host controllers. P=
ort-ownership
  hand-off is not supported. Only high-speed devices are supported on the h=
ost controller
  root ports.
  A value larger than zero in this field indicates there are companion USB =
1.1 host
  controller(s). Port-ownership hand-offs are supported. High, Full- and Lo=
w-speed
  devices are supported on the host controller root ports.

  Which is not longer true, as for example skylake and baytrail offers a
  dual usb stack of ehci and xhci. In that case, EHCI handles the low
  speed device as well.

  brgds,
  Bert

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1550743/+subscriptions
