Received: from eggs.gnu.org ([2001:4830:134:3::10]:39227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMUwt-0007ha-KI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMUwq-0007qk-FC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:20:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:46528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMUwq-0007qD-7s
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:20:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMUwn-0002Fi-5u
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 08:20:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 127682E80D7
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 08:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2017 08:13:11 -0000
From: ChristianEhrhardt <1736655@bugs.launchpad.net>
Reply-To: Bug 1736655 <1736655@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151253983521.3178.4021889730911467554.malonedeb@gac.canonical.com>
Message-Id: <151254799186.10171.4022481552142627458.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1736655] Re: 2k3/xp guests w/virtio-net randomly
 DHCP fail on boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I wanted an XP guest testbed anyway for some time, so this was the perfect =
reason to create one.
# virtio drivers from [1] and otherwise a "normal" virt-manager setup of a =
winxp sp3 (32bit) guest

- Modified to use virtio for net
- Modified to have the virtio drivers as floppy
- Installed virtio drivers for network afer base install

So after that I assume I'm at the same stage you are.
- WinXP Guest
- Virtio Driver for network
- Host provides DHCP to a bridged network

I set that to a rebot loop and checked the internet connection through
the dhcp virtiop net after reboot. This worked through 10 reboots
without an issue, but then IIRC with vhost ioeventfd was on all the
time.

I realized the change identified by you should only make a differenc on non=
-vhost virtio-net.
But libvirt will make use of vhost automatically if available, so I set the=
 interface to use driver qemu explicitly.

Another 10 reboots without issue - the virtio version is of 7/19/2017 versi=
on 51.75.104.14100
There must be something more to your case, so please if you have more info =
how to trigger the case let us know.

I really think I have the same case you were describing as affected by the =
change you identified:
$ virsh qemu-monitor-command --hmp winxp 'info network'
net0: index=3D0,type=3Dnic,model=3Dvirtio-net-pci,macaddr=3D52:54:00:ce:ca:=
72
 \ hostnet0: index=3D0,type=3Dtap,fd=3D26
Here from qtree on the device [2] ioeventfd is on.

Could you try and run it with vhost and see if this changes behavior it
for you?

[1]: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stabl=
e-virtio/virtio-win_amd64.vfd
[2]: http://paste.ubuntu.com/26123654/

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1736655

Title:
  2k3/xp guests w/virtio-net randomly DHCP fail on boot

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Host:
  Debian GNU/Linux 9 with Linux 4.13.0-0.bpo.1-amd64
  QEMU 2.10.1

  Guest:
  Windows 2003 Standard SP2 (x64)
  Windows XP SP3 (i386)

  QEMU command line:
  http://cfp.vim-cn.com/cbdF3

  Description:
  After upgrading from QEMU 2.8 to 2.10.1, my Windows 2003 x64 and Windows =
XP guests with "virtio-net-pci" NIC would randomly fail to aquire DHCP addr=
ess on boot. When it fails, cycle disable/enable the connection in Control =
Panel could make it connect successfully. As an immediate workaround, I swi=
tched to the RTL8139 NIC which works fine. Further investigation showed tha=
t manually reverting commit '4a3f03ba8dbf53fce36d0c1dd5d0cc0f340fe5f3' on t=
op of 2.10.1 "fixed" the problem.

  Here are the bisect test results:
  git branch 97cd965: 17 boots, 5 failures  (Feb 18)
  git branch 77424a4: 27 boots, 0 failure   (Jan 09)
  git branch c25d97c: 7 boots, 2 failures   (Feb 01)
  git branch 4a3f03b: 25 boots, 8 failures  (Jan 19)
  git branch 39f099e: 60 boots, 0 failure   (Jan 18)
  2.10.1 with revert: 194 boots, 0 failure
  2.10.1 without revert: 30 boots, 4 failures

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1736655/+subscriptions
