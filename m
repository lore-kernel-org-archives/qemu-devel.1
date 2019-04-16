Received: from eggs.gnu.org ([209.51.188.92]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGQ8t-0003UH-QL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGQ8s-0008EA-Jr
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:37:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:45436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGQ8s-0008Cs-B5
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:37:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGQ8p-0003nW-Cm
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 15:36:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 571A12E80E4
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 15:36:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 15:16:11 -0000
From: Thomas Huth <1543163@bugs.launchpad.net>
Reply-To: Bug 1543163 <1543163@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160208150110.15874.66099.malonedeb@gac.canonical.com>
Message-Id: <155542777199.13712.64254462462121085.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1543163] Re: VMs unable to boot from network with
 e1000 since 2.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ok, thanks for checking. Closing now.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1543163

Title:
  VMs unable to boot from network with e1000 since 2.2

Status in QEMU:
  Fix Released

Bug description:
  With KVM/QEMU version 1.4, using e1000 NIC, virtual machines boot from
  network alright; they get an IP from DHCP server (machine A), then
  connect to Microsoft System Center (machine B) and proceed to boot
  into Windows PE, install images etc.

  However, with versions at least 2.2 and 2.5, using same NIC, virtual
  machines fail to boot from network; they still get an IP from A, but
  then fail "contacting B using gateway (0.0.0.0). Different NICs do not
  help except for i82551, which however causes problems further down the
  road (presumably because there is no driver for that card in PE (based
  on Windows 7/8/10)).

  Note that actual physical machines work.

  Wireshark reveals this:

  QEMU 1.4 + Intel e1000
  **********************
  1) client sends DHCP discover
  2) machine A answers, offers an IP, gateway and itself as next server
  3) machine B answers, offers no IP, but gateway and itself as next server
  4) client requests the IP
  5) machine A ACKs
  6) client sends unicast request for ??? to B
  7) B offers (unicast) a boot file (some .com)
  8) client sends another unicast request for ??? to B
  9) B again offers the boot file
  (then they chat a bit, B offers another file, client downloads some stuff=
 via TFTP etc.)

  =

  QEMU 2.2/2.5 + Intel e1000
  **************************
  1) client sends DHCP discover
  2) machine A answers, offers an IP, gateway and itself as next server
  3) machine B answers, offers no IP, but gateway and itself as next server
  4) client requests the IP
  5) machine A ACKs
  6) client sends _broadcast_ request for ??? to B
  7) B offers (likewise broadcast) a boot file
  8) client sends another request, this time unicast and claims "Client IP =
address =3D 0.0.0.0"
  (and it basically hangs)

  =

  So, since some time after 1.4, QEMUlated machines with otherwise trusty e=
1000 can no longer boot from network and it might be due to different behav=
iour.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1543163/+subscriptions
