Received: from eggs.gnu.org ([2001:4830:134:3::10]:51984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnOYJ-0005mZ-V7
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnOYF-0002pC-P9
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:31:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:60848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fnOYF-0002oc-Hp
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fnOYC-0007iV-LX
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 13:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5F2E42E80D1
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 13:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Aug 2018 13:23:11 -0000
From: Bharata B Rao <1785972@bugs.launchpad.net>
Reply-To: Bug 1785972 <1785972@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153371136089.29473.12663307170219083138.malonedeb@chaenomeles.canonical.com>
Message-Id: <153373459147.3443.4550096621765346347.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785972] Re: v3.0.0-rc4: VM fails to start after
 vcpuhotunplug, managedsave sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The first commit that causes this issue is:

b94020268e0b6659499e250d25346baaa9888fed (spapr_cpu_core: migrate per-
CPU data)

Simpler way to reproduce:
1. Hotplug a CPU
2. Hot unplug it
3. Migrate the VM (will fail)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785972

Title:
  v3.0.0-rc4: VM fails to start after vcpuhotunplug, managedsave
  sequence

Status in QEMU:
  New

Bug description:
  VM fails to start after vcpu hot un-plug, managedsave sequence

  Host info:
  Kernel: 4.18.0-rc8-00002-g1236568ee3cb

  qemu: commit 6ad90805383e6d04b3ff49681b8519a48c9f4410 (HEAD -> master, ta=
g: v3.0.0-rc4)
  QEMU emulator version 2.12.94 (v3.0.0-rc4-dirty)

  libvirt: commit 087de2f5a3dffb27d2eeb0c50a86d5d6984e5a5e (HEAD -> master)
  libvirtd (libvirt) 4.6.0

  Guest Kernel: 4.18.0-rc8-00002-g1236568ee3cb

  =

  Steps to reproduce:
  1. Start a guest(VM) with 2 current , 4 max vcpus
  virsh start vm1
  Domain vm1 started

  2. Hotplug 2 vcpus
  virsh setvcpus vm1 4 --live

  3. Hot unplug 2 vcpus
  virsh setvcpus vm1 2 --live

  4. Managedsave the VM
  virsh managedsave vm1

  Domain vm1 state saved by libvirt

  5. Start the VM ---Fails to start
  virsh start vm1

  error: Failed to start domain avocado-vt-vm1
  error: internal error: qemu unexpectedly closed the monitor: 2018-08-08T0=
6:27:53.853818Z qemu: Unknown savevm section or instance 'spapr_cpu' 2
  2018-08-08T06:27:53.854949Z qemu: load of migration failed: Invalid argum=
ent


  Testcase:
  avocado run libvirt_vcpu_plug_unplug.positive_test.vcpu_set.live.vm_opera=
te.managedsave_with_unplug --vt-type libvirt --vt-extra-params emulator_pat=
h=3D/usr/share/avocado-plugins-vt/bin/qemu create_vm_libvirt=3Dyes kill_vm_=
libvirt=3Dyes env_cleanup=3Dyes smp=3D8 backup_image_before_testing=3Dno li=
bvirt_controller=3Dvirtio-scsi scsi_hba=3Dvirtio-scsi-pci drive_format=3Dsc=
si-hd use_os_variant=3Dno restore_image_after_testing=3Dno vga=3Dnone displ=
ay=3Dnographic kernel=3D/home/kvmci/linux/vmlinux kernel_args=3D'root=3D/de=
v/sda2 rw console=3Dtty0 console=3DttyS0,115200 init=3D/sbin/init  initcall=
_debug' take_regular_screendumps=3Dno --vt-guest-os JeOS.27.ppc64le
  JOB ID     : 1f869477ad87e7d7e7e7777f631ae08965f41a74
  JOB LOG    : /root/avocado/job-results/job-2018-08-08T02.42-1f86947/job.l=
og
   (1/1) type_specific.io-github-autotest-libvirt.libvirt_vcpu_plug_unplug.=
positive_test.vcpu_set.live.vm_operate.managedsave_with_unplug: ERROR (91.5=
8 s)
  RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 95.89 s

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785972/+subscriptions
