Received: from eggs.gnu.org ([2001:4830:134:3::10]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb4vE-0002dO-Qd
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb4vA-0000KC-1N
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:31:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cb4v9-0000Jw-Og
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:30:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cb4v8-0005eE-CB
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 12:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 59BEF2E80C9
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 12:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 12:24:49 -0000
From: Thomas Huth <1660946@bugs.launchpad.net>
Reply-To: Bug 1660946 <1660946@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170201114649.1137.53576.malonedeb@wampee.canonical.com>
Message-Id: <20170207122449.29689.24187.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1660946] Re: [nested] virt-install falls to SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sounds like your problem only occurs on older versions of Ubuntu, so
moving this to the QEMU-Ubuntu bug tracker.

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660946

Title:
  [nested] virt-install falls to SLOF

Status in qemu package in Ubuntu:
  New

Bug description:
  =

  [nested] virt-install falls to SLOF: after starting installer (ISO/CDROM)=
, it crashes w/ a kernel panic due to an HTM (Hardware Transactional Memory=
) exception.

  Scenario:
  Host=3DUbuntu 16.04 Xenial (Ubuntu KVM ppc64el POWER8E 8247-22L)
  Guest=3DUbuntu 16.04 Xenial (Ubuntu Xenial Cloud Image QCOW2)
  Nested=3DUbuntu 16.04 Xenial (Ubuntu Xenial Server ISO *or* NetInstall mi=
ni.iso)

  Inside Guest (1st level), run virt-install as shown below to reproduce
  the bug.

  Facts:
   * ISO images (from both Server or netinstall mini.iso) fail to boot on x=
enial/yakkety
   * Cloud image (xenial/yakkety/zesty) on nested virt boots fine, the logi=
n prompt is seen.
   * Reproducible with Xenial and Yakkety
   * NOT reproducible with Zesty (Installer menu starts just normally)
   * virtio-scsi, virtio-net and virtio-blk modules are seen in zesty. Only=
 virtio-scsi is seen on xenial/yakkety (-net and -blk are built-in modules?)
   * kvm-pr is loaded for all tested scenarios
   * This patch[1] rings a bell, however, it doesn't explain how cloud imag=
es boot just fine and don't hit the bug, since the kernel used in the cloud=
 images also enable HTM[2].

  [1] https://lists.ozlabs.org/pipermail/linuxppc-
  dev/2016-April/141292.html

  [2] grep TRANSA /boot/config-4.8.0-26-generic
  CONFIG_PPC_TRANSACTIONAL_MEM=3Dy

  =

  # cat virt-inst.sh
  virt-install --virt-type=3Dkvm --cpu=3Dhost --name=3Dnested-xenial --cont=
roller type=3Dscsi,model=3Dvirtio-scsi --graphics none --console pty,target=
_type=3Dserial --disk path=3D/home/nested-xenial.qcow2,size=3D20 --vcpus=3D=
4 --ram=3D4096 --os-type=3Dlinux --os-variant ubuntu16.04 --network bridge=
=3Dvirbr0,model=3Dvirtio --cdrom=3D$1

  =

  # ./virt-inst.sh ubuntu-16.04-server-ppc64el.iso
  WARNING  CDROM media does not print to the text console by default, so yo=
u likely will not see text install output. You might want to use --location=
. See the man page for examples of using --location with CDROM media

  Starting install...
  Creating domain...                                                       =
                                                                           =
         |    0 B  00:00:00
  Connected to domain nested-xenial
  Escape character is ^]
  Populating /vdevice methods
  Populating /vdevice/vty@30000000
  Populating /vdevice/nvram@71000000
  Populating /pci@800000020000000
                       00 2800 (D) : 1af4 1002    unknown-legacy-device*
                       00 2000 (D) : 1af4 1001    virtio [ block ]
                       00 1800 (D) : 106b 003f    serial bus [ usb-ohci ]
                       00 1000 (D) : 1af4 1004    virtio [ scsi ]
  Populating /pci@800000020000000/scsi@2
         SCSI: Looking for devices
            100000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
                       00 0800 (D) : 10ec 8139    network [ ethernet ]
  No NVRAM common partition, re-initializing...
  Scanning USB
    OHCI: initializing
  Using default console: /vdevice/vty@30000000

    Welcome to Open Firmware

    Copyright (c) 2004, 2011 IBM Corporation All rights reserved.
    This program and the accompanying materials are made available
    under the terms of the BSD License available at
    http://www.opensource.org/licenses/bsd-license.php

  =

  Trying to load:  from: /pci@800000020000000/scsi@2/disk@100000000000000 .=
..   Successfully loaded

                       GNU GRUB  version 2.02~beta2-36ubuntu3

   +-----------------------------------------------------------------------=
-----+
   |*Install                                                               =
     |
   | Rescue mode                                                           =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   |                                                                       =
     |
   +-----------------------------------------------------------------------=
-----+

        Use the ^ and v keys to select which entry is highlighted.
        Press enter to boot the selected OS, `e' to edit the commands
        before booting or `c' for a command-line.

  =

  OF stdout device is: /vdevice/vty@30000000
  Preparing to boot Linux version 4.4.0-21-generic (buildd@bos01-ppc64el-01=
7) (gcc version 5.3.1 20160413 (Ubuntu/IBM 5.3.1-14ubuntu2) ) #37-Ubuntu SM=
P Mon Apr 18 18:30:22 UTC 2016 (Ubuntu 4.4.0-21.37-generic 4.4.6)
  Detected machine type: 0000000000000101
  Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
  Calling ibm,client-architecture-support... done
  command line: BOOT_IMAGE=3D/install/vmlinux tasks=3Dstandard pkgsel/langu=
age-pack-patterns=3D pkgsel/install-language-support=3Dfalse --- quiet
  memory layout at init:
    memory_limit : 0000000000000000 (16 MB aligned)
    alloc_bottom : 0000000004640000
    alloc_top    : 0000000030000000
    alloc_top_hi : 0000000100000000
    rmo_top      : 0000000030000000
    ram_top      : 0000000100000000
  instantiating rtas at 0x000000002fff0000... done
  prom_hold_cpus: skipped
  copying OF device tree...
  Building dt strings...
  Building dt structure...
  Device tree strings 0x0000000004650000 -> 0x0000000004650a5b
  Device tree struct  0x0000000004660000 -> 0x0000000004670000
  Quiescing Open Firmware ...
  Booting Linux via __start() ...
   -> smp_release_cpus()
  spinning_secondaries =3D 3
   <- smp_release_cpus()
   <- setup_system()
  Linux ppc64le
  #37-Ubuntu SMP M[    2.155665] Facility 'TM' unavailable, exception at 0x=
3fff9f3d8644, MSR=3Db00000014280f033
  [    2.161582] Facility 'TM' unavailable, exception at 0x3fff8a488644, MS=
R=3Db00000014280f033
  [    2.168973] Facility 'TM' unavailable, exception at 0x3fffb2df8644, MS=
R=3Db00000014280f033
  [    2.174818] Facility 'TM' unavailable, exception at 0x3fff902f8644, MS=
R=3Db00000014280f033
  [    2.180887] Facility 'TM' unavailable, exception at 0x3fff84728644, MS=
R=3Db00000014280f033
  [    2.186023] Facility 'TM' unavailable, exception at 0x3fff8f1f8644, MS=
R=3Db00000014280f033
  [    2.193073] Facility 'TM' unavailable, exception at 0x3fffa8ecfe30, MS=
R=3Db00000014280f033
  [    2.193697] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000004
  [    2.193697]
  [    2.193751] CPU: 3 PID: 1 Comm: init Not tainted 4.4.0-21-generic #37-=
Ubuntu
  [    2.193788] Call Trace:
  [    2.193826] [c0000000fea83a50] [c000000000aedc1c] dump_stack+0xb0/0xf0=
 (unreliable)
  [    2.193868] [c0000000fea83a90] [c000000000ae9e50] panic+0x100/0x2c0
  [    2.193914] [c0000000fea83b20] [c0000000000bd474] do_exit+0xc24/0xc30
  [    2.193945] [c0000000fea83be0] [c0000000000bd564] do_group_exit+0x64/0=
x100
  [    2.193979] [c0000000fea83c20] [c0000000000ce9cc] get_signal+0x55c/0x7=
b0
  [    2.194012] [c0000000fea83d10] [c000000000017424] do_signal+0x54/0x2b0
  [    2.194043] [c0000000fea83e00] [c00000000001787c] do_notify_resume+0xb=
c/0xd0
  [    2.194072] [c0000000fea83e30] [c000000000009838] ret_from_except_lite=
+0x64/0x68

  Domain creation completed.
  Restarting guest.
  Connected to domain nested-xenial
  Escape character is ^]
  Populating /vdevice methods
  Populating /vdevice/vty@30000000
  Populating /vdevice/nvram@71000000
  Populating /pci@800000020000000
                       00 2800 (D) : 1af4 1002    unknown-legacy-device*
                       00 2000 (D) : 1af4 1001    virtio [ block ]
                       00 1800 (D) : 106b 003f    serial bus [ usb-ohci ]
                       00 1000 (D) : 1af4 1004    virtio [ scsi ]
  Populating /pci@800000020000000/scsi@2
         SCSI: Looking for devices
            100000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
                       00 0800 (D) : 10ec 8139    network [ ethernet ]
  No NVRAM common partition, re-initializing...
  Scanning USB
    OHCI: initializing
  Using default console: /vdevice/vty@30000000

    Welcome to Open Firmware

    Copyright (c) 2004, 2011 IBM Corporation All rights reserved.
    This program and the accompanying materials are made available
    under the terms of the BSD License available at
    http://www.opensource.org/licenses/bsd-license.php

  =

  Trying to load:  from: /pci@800000020000000/scsi@4 ...
  E3404: Not a bootable device!
  Trying to load:  from: HALT ...
  E3405: No such device

  E3407: Load failed

          ..`. ..     .......  ..           ......      .......
      ..`...`''.`'. .''``````..''.       .`''```''`.  `''``````
         .`` .:' ': `''.....  .''.       ''`     .''..''.......
           ``.':.';. ``````''`.''.      .''.      ''``''`````'`
           ``.':':`   .....`''.`'`...... `'`.....`''.`'`
          .`.`'``   .'`'`````.  ``''''''  ``''`'''`. `'`
    Type 'boot'  and press return  to  continue  booting  the system.
    Type 'reset-all'  and  press  return  to   reboot   the   system.

  =

  Ready!
  0 >

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1660946/+subscriptions
