Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cr5FX-0001xM-Ny
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cr5FS-0000C0-Mk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:06:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:49728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cr5FS-0000Bt-Av
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:06:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cr5FQ-0000GY-50
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 16:06:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 23FE62E80CE
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 16:06:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Mar 2017 15:51:04 -0000
From: Aaron Doyle <aaron_doyle_48@hotmail.com>
Reply-To: Bug 1675458 <1675458@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170323155104.30547.10490.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1675458] [NEW] attach-interface - unexpected
 action
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

Not sure where to report this, or if it is a bug. However, I feel like
the behaviour is not what would/should be expected.

---------------------------------------------------------------------------=
-------------------------------

Environment:
KVM Version:		root@hostname:~# virsh version
      			Compiled against library: libvirt 1.2.9
			Using library: libvirt 1.2.9
			Using API: QEMU 1.2.9
			Running hypervisor: QEMU 2.1.2
uname -a:		Linux hostname 3.16.0-4-amd64 #1 SMP Debian 3.16.39-1+deb8u2 (20=
17-03-07) x86_64 GNU/Linux
CPU:			Intel(R) Xeon(R) CPU E3-1240 V2 @ 3.40GHz
Host Debian Version:	8.7 (Jessie)
Guest Debian Version:	8.7 (Jessie)

---------------------------------------------------------------------------=
-------------------------------

Issue:
When adding an interface to a live VM, the position of interfaces within th=
e VM may change post reboot.
It appears a new interface takes up the first available =E2=80=9Cpci slot=
=E2=80=9D. If you have removed an interface in the past, this will be the o=
ne that is taken up.

---------------------------------------------------------------------------=
-------------------------------

Example:

If the VM Has the following interfaces layout:

eth0  HWaddr 00:00:00:00:00:00
eth1  HWaddr 11:11:11:11:11:11
eth2  HWaddr 22:22:22:22:22:22
eth3  HWaddr 33:33:33:33:33:33

Now I delete the interface with MAC address 11:11:11:11:11:11, you now
have this:

eth0  HWaddr 00:00:00:00:00:00
eth1  HWaddr 22:22:22:22:22:22
eth2  HWaddr 33:33:33:33:33:33

And then you add a new interface with MAC address 44:44:44:44:44:44,
using virsh:

virsh attach-interface --domain guest --type bridge --source br3 --mac
44:44:44:44:44:44 --model e1000 --target vmeth3 --live --persistent

It will now look like this:

eth0  HWaddr 00:00:00:00:00:00
eth1  HWaddr 22:22:22:22:22:22
eth2  HWaddr 33:33:33:33:33:33
eth3  HWaddr 44:44:44:44:44:44

However, after a reboot, it will look like this:

eth0  HWaddr 00:00:00:00:00:00
eth1  HWaddr 44:44:44:44:44:44
eth2  HWaddr 22:22:22:22:22:22
eth3  HWaddr 33:33:33:33:33:33 =


This can be a problem, as /etc/network/interfaces file, etc., will be
pointing to the wrong interfaces. I.E. originally eth1 was connected to
br1 (for example), after reboot eth1 is now connected to br3.

To resolve this issue, I need to edit the .xml file in the KVM machine,
and edit the following lines:

      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x0c'
function=3D'0x0'/>

Changing these into the order I want them to be loaded in, i.e. eth0,
eth1, eth2=E2=80=A6. (I know 4 are taken already and not usable by ethernet
interfaces.)

---------------------------------------------------------------------------=
-------------------------------


Thanks in advance.

Kind regards,

Aaron Doyle

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1675458

Title:
  attach-interface - unexpected action

Status in QEMU:
  New

Bug description:
  Hello,

  Not sure where to report this, or if it is a bug. However, I feel like
  the behaviour is not what would/should be expected.

  -------------------------------------------------------------------------=
---------------------------------

  Environment:
  KVM Version:		root@hostname:~# virsh version
        			Compiled against library: libvirt 1.2.9
  			Using library: libvirt 1.2.9
  			Using API: QEMU 1.2.9
  			Running hypervisor: QEMU 2.1.2
  uname -a:		Linux hostname 3.16.0-4-amd64 #1 SMP Debian 3.16.39-1+deb8u2 (=
2017-03-07) x86_64 GNU/Linux
  CPU:			Intel(R) Xeon(R) CPU E3-1240 V2 @ 3.40GHz
  Host Debian Version:	8.7 (Jessie)
  Guest Debian Version:	8.7 (Jessie)

  -------------------------------------------------------------------------=
---------------------------------

  Issue:
  When adding an interface to a live VM, the position of interfaces within =
the VM may change post reboot.
  It appears a new interface takes up the first available =E2=80=9Cpci slot=
=E2=80=9D. If you have removed an interface in the past, this will be the o=
ne that is taken up.

  -------------------------------------------------------------------------=
---------------------------------

  Example:

  If the VM Has the following interfaces layout:

  eth0  HWaddr 00:00:00:00:00:00
  eth1  HWaddr 11:11:11:11:11:11
  eth2  HWaddr 22:22:22:22:22:22
  eth3  HWaddr 33:33:33:33:33:33

  Now I delete the interface with MAC address 11:11:11:11:11:11, you now
  have this:

  eth0  HWaddr 00:00:00:00:00:00
  eth1  HWaddr 22:22:22:22:22:22
  eth2  HWaddr 33:33:33:33:33:33

  And then you add a new interface with MAC address 44:44:44:44:44:44,
  using virsh:

  virsh attach-interface --domain guest --type bridge --source br3 --mac
  44:44:44:44:44:44 --model e1000 --target vmeth3 --live --persistent

  It will now look like this:

  eth0  HWaddr 00:00:00:00:00:00
  eth1  HWaddr 22:22:22:22:22:22
  eth2  HWaddr 33:33:33:33:33:33
  eth3  HWaddr 44:44:44:44:44:44

  However, after a reboot, it will look like this:

  eth0  HWaddr 00:00:00:00:00:00
  eth1  HWaddr 44:44:44:44:44:44
  eth2  HWaddr 22:22:22:22:22:22
  eth3  HWaddr 33:33:33:33:33:33 =


  This can be a problem, as /etc/network/interfaces file, etc., will be
  pointing to the wrong interfaces. I.E. originally eth1 was connected
  to br1 (for example), after reboot eth1 is now connected to br3.

  To resolve this issue, I need to edit the .xml file in the KVM
  machine, and edit the following lines:

        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x0c'
  function=3D'0x0'/>

  Changing these into the order I want them to be loaded in, i.e. eth0,
  eth1, eth2=E2=80=A6. (I know 4 are taken already and not usable by ethern=
et
  interfaces.)

  -------------------------------------------------------------------------=
---------------------------------

  =

  Thanks in advance.

  Kind regards,

  Aaron Doyle

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1675458/+subscriptions
