Received: from eggs.gnu.org ([2001:4830:134:3::10]:44766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYWNs-0002Aj-S1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYWNn-0006mA-W6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:57028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fYWNn-0006kG-Pt
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:50:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fYWNl-0002VP-No
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:50:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 73ADD2E81A4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:50:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Jun 2018 12:35:05 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1779120@bugs.launchpad.net>
Reply-To: Bug 1779120 <1779120@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153018930547.7042.8204279860342554943.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779120] [NEW] disk missing in the guest
 contingently when hotplug several virtio scsi disks consecutively
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

Hi, I found a bug that disk missing (not all disks missing ) in the
guest contingently when hotplug several virtio scsi disks consecutively.
After rebooting the guest,the missing disks appear again.

The guest is centos7.3 running on a centos7.3 host and the scsi
controllers are configed with iothread.  The scsi controller xml is
below:

=C2=A0=C2=A0=C2=A0=C2=A0<controller type=3D'scsi' index=3D'0' model=3D'virt=
io-scsi'>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<driver iothread=3D'26'/>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<alias name=3D'scsi0'/>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<address type=3D'pci' domain=3D'0x0000'=
 bus=3D'0x00' slot=3D'0x07' function=3D'0x0'/>
=C2=A0=C2=A0=C2=A0=C2=A0</controller>

If the scsi controllers are configed without iothread,  disks are all
can be seen in the guest when hotplug several virtio scsi disks
consecutively.

I think the biggest difference between them is that scsi controllers
with iothread call virtio_notify_irqfd to notify guest and scsi
controllers without iothread call virtio_notify instead.  What make it
difference? Will interrupts are lost when call virtio_notify_irqfd  due
to  race condition for some unknow reasons? Maybe guys more familiar
with scsi dataplane can help. Thanks for your reply!

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Hi, I found a bug that disk missing (not all disks missing ) in the
  guest contingently when hotplug several virtio scsi disks consecutively.
  After rebooting the guest,the missing disks appear again.
  =

  The guest is centos7.3 running on a centos7.3 host and the scsi
  controllers are configed with iothread.  The scsi controller xml is
  below:
  =

-     <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
-       <driver iothread=3D'26'/>
-       <alias name=3D'scsi0'/>
-       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' =
function=3D'0x0'/>
-     </controller>
+ =C2=A0=C2=A0=C2=A0=C2=A0<controller type=3D'scsi' index=3D'0' model=3D'vi=
rtio-scsi'>
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<driver iothread=3D'26'/>
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<alias name=3D'scsi0'/>
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<address type=3D'pci' domain=3D'0x000=
0' bus=3D'0x00' slot=3D'0x07' function=3D'0x0'/>
+ =C2=A0=C2=A0=C2=A0=C2=A0</controller>
  =

- =

- If the scsi controllers are configed without iothread,  disks are all can=
 be seen in the guest when hotplug several virtio scsi disks consecutively.
+ If the scsi controllers are configed without iothread,  disks are all
+ can be seen in the guest when hotplug several virtio scsi disks
+ consecutively.
  =

  I think the biggest difference between them is that scsi controllers
  with iothread call virtio_notify_irqfd to notify guest and scsi
- controllers without
- =

- iothread call virtio_notify instead.  What make it difference? Will
- interrupts are lost when call virtio_notify_irqfd  due to  race
- condition for some unknow reasons? Maybe guys more familiar with scsi
- dataplane can help. Thanks for your reply!
+ controllers without iothread call virtio_notify instead.  What make it
+ difference? Will interrupts are lost when call virtio_notify_irqfd  due
+ to  race condition for some unknow reasons? Maybe guys more familiar
+ with scsi dataplane can help. Thanks for your reply!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779120

Title:
  disk missing in the guest contingently when hotplug several virtio
  scsi disks consecutively

Status in QEMU:
  New

Bug description:
  Hi, I found a bug that disk missing (not all disks missing ) in the
  guest contingently when hotplug several virtio scsi disks
  consecutively.  After rebooting the guest,the missing disks appear
  again.

  The guest is centos7.3 running on a centos7.3 host and the scsi
  controllers are configed with iothread.  The scsi controller xml is
  below:

  =C2=A0=C2=A0=C2=A0=C2=A0<controller type=3D'scsi' index=3D'0' model=3D'vi=
rtio-scsi'>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<driver iothread=3D'26'/>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<alias name=3D'scsi0'/>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<address type=3D'pci' domain=3D'0x000=
0' bus=3D'0x00' slot=3D'0x07' function=3D'0x0'/>
  =C2=A0=C2=A0=C2=A0=C2=A0</controller>

  If the scsi controllers are configed without iothread,  disks are all
  can be seen in the guest when hotplug several virtio scsi disks
  consecutively.

  I think the biggest difference between them is that scsi controllers
  with iothread call virtio_notify_irqfd to notify guest and scsi
  controllers without iothread call virtio_notify instead.  What make it
  difference? Will interrupts are lost when call virtio_notify_irqfd
  due to  race condition for some unknow reasons? Maybe guys more
  familiar with scsi dataplane can help. Thanks for your reply!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779120/+subscriptions
