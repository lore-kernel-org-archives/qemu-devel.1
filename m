Received: from eggs.gnu.org ([2001:4830:134:3::10]:50792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFmDv-000586-Lr
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFmDq-0003gZ-Me
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:55:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:44090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fFmDq-0003g2-Cy
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:54:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fFmDp-0002oj-9n
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 19:54:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4167D2E80C9
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 19:54:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 May 2018 19:40:56 -0000
From: Thomas Huth <1456804@bugs.launchpad.net>
Reply-To: Bug 1456804 <1456804@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150519211456.24162.83108.malonedeb@gac.canonical.com>
Message-Id: <152572205687.25770.3477379261167096575.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1456804] Re: kvm_irqchip_commit_routes: Assertion
 `ret == 0' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1456804

Title:
  kvm_irqchip_commit_routes: Assertion `ret =3D=3D 0' failed.

Status in QEMU:
  Incomplete

Bug description:
  During win8.1 boot on qemu.git
  eba05e922e8e7f307bc5d4104a78797e55124e97, kernel 4.1-rc4, I get the
  following assert:

  qemu-system-x86_64: /net/gimli/home/alwillia/Work/qemu.git/kvm-
  all.c:1033: kvm_irqchip_commit_routes: Assertion `ret =3D=3D 0' failed.

  Bisected to:

  commit 851c2a75a6e80c8aa5e713864d98cfb512e7229b
  Author: Jason Wang <jasowang@redhat.com>
  Date:   Thu Apr 23 14:21:47 2015 +0800

      virtio-pci: speedup MSI-X masking and unmasking
      =

      This patch tries to speed up the MSI-X masking and unmasking through
      the mapping between vector and queues. With this patch it will there's
      no need to go through all possible virtqueues, which may help to
      reduce the time spent when doing MSI-X masking/unmasking a single
      vector when more than hundreds or even thousands of virtqueues were
      supported.
      =

      Tested with 80 queue pairs virito-net-pci by changing the smp affinity
      in the background and doing netperf in the same time:
      =

      Before the patch:
      5711.70 Gbits/sec
      After the patch:
      6830.98 Gbits/sec
      =

      About 19.6% improvements in throughput.
      =

      Cc: Michael S. Tsirkin <mst@redhat.com>
      Signed-off-by: Jason Wang <jasowang@redhat.com>
      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

  Backtrace:

  Program received signal SIGABRT, Aborted.
  [Switching to Thread 0x7f32fffff700 (LWP 23059)]
  0x00007f33187438d7 in raise () from /lib64/libc.so.6
  (gdb) bt
  #0  0x00007f33187438d7 in raise () at /lib64/libc.so.6
  #1  0x00007f331874553a in abort () at /lib64/libc.so.6
  #2  0x00007f331873c47d in __assert_fail_base () at /lib64/libc.so.6
  #3  0x00007f331873c532 in  () at /lib64/libc.so.6
  #4  0x000055e0252fed5b in kvm_irqchip_commit_routes (s=3D0x55e027ce17e0)
      at /net/gimli/home/alwillia/Work/qemu.git/kvm-all.c:1033
  #5  0x000055e0252fef46 in kvm_update_routing_entry (s=3D0x55e027ce17e0, n=
ew_entry=3D0x7f32ffffe4a0) at /net/gimli/home/alwillia/Work/qemu.git/kvm-al=
l.c:1078
  #6  0x000055e0252ff78e in kvm_irqchip_update_msi_route (s=3D0x55e027ce17e=
0, virq=3D0, msg=3D...) at /net/gimli/home/alwillia/Work/qemu.git/kvm-all.c=
:1282
  #7  0x000055e0255899a0 in virtio_pci_vq_vector_unmask (proxy=3D0x55e02a0e=
e580, queue_no=3D2, vector=3D2, msg=3D...) at hw/virtio/virtio-pci.c:588
  #8  0x000055e025589b76 in virtio_pci_vector_unmask (dev=3D0x55e02a0ee580,=
 vector=3D2, msg=3D...) at hw/virtio/virtio-pci.c:641
  #9  0x000055e0255186f0 in msix_set_notifier_for_vector (dev=3D0x55e02a0ee=
580, vector=3D2) at hw/pci/msix.c:513
  #10 0x000055e0255187ee in msix_set_vector_notifiers (dev=3D0x55e02a0ee580=
, use_notifier=3D0x55e025589ad2 <virtio_pci_vector_unmask>, release_notifie=
r=3D0x55e025589c0c <virtio_pci_vector_mask>, poll_notifier=3D0x55e025589cb1=
 <virtio_pci_vector_poll>) at hw/pci/msix.c:540
  #11 0x000055e02558a1f0 in virtio_pci_set_guest_notifiers (d=3D0x55e02a0ee=
580, nvqs=3D2, assign=3Dtrue) at hw/virtio/virtio-pci.c:794
  #12 0x000055e02533c2bc in vhost_net_start (dev=3D0x55e02a0eef90, ncs=3D0x=
55e02a866ac0, total_queues=3D1)
      at /net/gimli/home/alwillia/Work/qemu.git/hw/net/vhost_net.c:318
  #13 0x000055e025336dce in virtio_net_vhost_status (n=3D0x55e02a0eef90, st=
atus=3D7 '\a') at /net/gimli/home/alwillia/Work/qemu.git/hw/net/virtio-net.=
c:146
  #14 0x000055e025336e78 in virtio_net_set_status (vdev=3D0x55e02a0eef90, s=
tatus=3D7 '\a') at /net/gimli/home/alwillia/Work/qemu.git/hw/net/virtio-net=
.c:165
  #15 0x000055e0253504c6 in virtio_set_status (vdev=3D0x55e02a0eef90, val=
=3D7 '\a')
      at /net/gimli/home/alwillia/Work/qemu.git/hw/virtio/virtio.c:551
  #16 0x000055e025588d6d in virtio_ioport_write (opaque=3D0x55e02a0ee580, a=
ddr=3D18, val=3D7) at hw/virtio/virtio-pci.c:259
  #17 0x000055e0255891d1 in virtio_pci_config_write (opaque=3D0x55e02a0ee58=
0, addr=3D18, val=3D7, size=3D1) at hw/virtio/virtio-pci.c:385
  #18 0x000055e025303155 in memory_region_write_accessor (mr=3D0x55e02a0eee=
00, addr=3D18, value=3D0x7f32ffffe908, size=3D1, shift=3D0, mask=3D255, att=
rs=3D...)
      at /net/gimli/home/alwillia/Work/qemu.git/memory.c:457
  #19 0x000055e025303308 in access_with_adjusted_size (addr=3D18, value=3D0=
x7f32ffffe908, size=3D1, access_size_min=3D1, access_size_max=3D4, access=
=3D
      0x55e0253030d0 <memory_region_write_accessor>, mr=3D0x55e02a0eee00, a=
ttrs=3D...) at /net/gimli/home/alwillia/Work/qemu.git/memory.c:516
  #20 0x000055e025305b15 in memory_region_dispatch_write (mr=3D0x55e02a0eee=
00, addr=3D18, data=3D7, size=3D1, attrs=3D...)
      at /net/gimli/home/alwillia/Work/qemu.git/memory.c:1166
  #21 0x000055e0252b68eb in address_space_rw (as=3D0x55e025b71a80 <address_=
space_io>, addr=3D49458, attrs=3D..., buf=3D0x7f3322f48000 "\a", len=3D1, i=
s_write=3Dtrue)
      at /net/gimli/home/alwillia/Work/qemu.git/exec.c:2363
  #22 0x000055e02530041e in kvm_handle_io (port=3D49458, attrs=3D..., data=
=3D0x7f3322f48000, direction=3D1, size=3D1, count=3D1)
      at /net/gimli/home/alwillia/Work/qemu.git/kvm-all.c:1679
  #23 0x000055e025300914 in kvm_cpu_exec (cpu=3D0x55e02a1383a0)
  ---Type <return> to continue, or q <return> to quit---
      at /net/gimli/home/alwillia/Work/qemu.git/kvm-all.c:1839
  #24 0x000055e0252e8062 in qemu_kvm_cpu_thread_fn (arg=3D0x55e02a1383a0)
      at /net/gimli/home/alwillia/Work/qemu.git/cpus.c:947
  #25 0x00007f3321b2352a in start_thread () at /lib64/libpthread.so.0
  #26 0x00007f331880f22d in clone () at /lib64/libc.so.6

  VM XML (-snapshot added only for bisect):

  <domain type=3D'kvm' id=3D'8' xmlns:qemu=3D'http://libvirt.org/schemas/do=
main/qemu/1.0'>
    <name>Steam</name>
    <uuid>79f39860-d659-426b-89e8-90cb46ee57c6</uuid>
    <memory unit=3D'KiB'>4194304</memory>
    <currentMemory unit=3D'KiB'>4194304</currentMemory>
    <memoryBacking>
      <hugepages/>
    </memoryBacking>
    <vcpu placement=3D'static'>4</vcpu>
    <cputune>
      <vcpupin vcpu=3D'0' cpuset=3D'0'/>
      <vcpupin vcpu=3D'1' cpuset=3D'1'/>
      <vcpupin vcpu=3D'2' cpuset=3D'2'/>
      <vcpupin vcpu=3D'3' cpuset=3D'3'/>
    </cputune>
    <resource>
      <partition>/machine</partition>
    </resource>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-2.3'>hvm</type>
      <loader readonly=3D'yes' type=3D'pflash'>/usr/share/edk2.git/ovmf-x64=
/OVMF_CODE-pure-efi.fd</loader>
      <nvram template=3D'/usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd=
'>/var/lib/libvirt/qemu/nvram/Steam_VARS.fd</nvram>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
      <kvm>
        <hidden state=3D'on'/>
      </kvm>
    </features>
    <cpu mode=3D'host-passthrough'>
      <topology sockets=3D'1' cores=3D'4' threads=3D'1'/>
    </cpu>
    <clock offset=3D'localtime'>
      <timer name=3D'rtc' tickpolicy=3D'catchup'/>
      <timer name=3D'pit' tickpolicy=3D'delay'/>
      <timer name=3D'hpet' present=3D'no'/>
    </clock>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/local/bin/qemu-system-x86_64</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2' cache=3D'none' io=3D'native'/>
        <source file=3D'/mnt/store/vm/Steam.qcow2'/>
        <backingStore type=3D'file' index=3D'1'>
          <format type=3D'raw'/>
          <source file=3D'/mnt/store/vm/Steam.img'/>
          <backingStore/>
        </backingStore>
        <target dev=3D'sda' bus=3D'scsi'/>
        <boot order=3D'2'/>
        <alias name=3D'scsi0-0-0-0'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
        <alias name=3D'scsi0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
        <alias name=3D'usb0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x7'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
        <alias name=3D'usb0'/>
        <master startport=3D'0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0' multifunction=3D'on'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
        <alias name=3D'usb0'/>
        <master startport=3D'2'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
        <alias name=3D'usb0'/>
        <master startport=3D'4'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'>
        <alias name=3D'pci.0'/>
      </controller>
      <interface type=3D'bridge'>
        <mac address=3D'52:54:00:60:ef:ac'/>
        <source bridge=3D'br0'/>
        <target dev=3D'vnet0'/>
        <model type=3D'virtio'/>
        <alias name=3D'net0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <driver name=3D'vfio'/>
        <source>
          <address domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' function=3D=
'0x0'/>
        </source>
        <alias name=3D'hostdev0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </hostdev>
      <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <driver name=3D'vfio'/>
        <source>
          <address domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' function=3D=
'0x1'/>
        </source>
        <alias name=3D'hostdev1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0'/>
      </hostdev>
      <memballoon model=3D'none'>
        <alias name=3D'balloon0'/>
      </memballoon>
    </devices>
    <qemu:commandline>
      <qemu:arg value=3D'-snapshot'/>
    </qemu:commandline>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1456804/+subscriptions
