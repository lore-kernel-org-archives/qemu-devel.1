Received: from eggs.gnu.org ([2001:4830:134:3::10]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8Ocu-00080s-7W
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 06:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8Ocp-0003Fz-9Y
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 06:46:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:34148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8Oco-0003Bm-Uq
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 06:45:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8Ocl-00021J-Rn
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 10:45:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D136F2E80CD
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 10:45:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 10:35:27 -0000
From: Bug Watch Updater <1192499@bugs.launchpad.net>
Reply-To: Bug 1192499 <1192499@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130619090511.29840.85811.malonedeb@wampee.canonical.com>
Message-Id: <150918692951.11953.13884242349964889852.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1192499] Re: virsh migration copy-storage-all
 fails with "Unable to read from monitor: Connection reset by peer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 15 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D979411.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2013-06-28T13:15:38+00:00 chandrashekar wrote:

Created attachment 766573
Source-migrate-logs

Description of problem:

virsh migration copy-storage-all fails with "Unable to read from
monitor: Connection reset by peer" and shut downs the guest on the
source host.

Kernel Version: 3.10.0-rc5+

Libvirt Version: 1.0.6

Qemu Version: 1.5.50

Steps to Reproduce:

1. Created the qemu-img create -f qcow2 vm.qcow2 11G on the destination hos=
t which is same as the source.
2. Started the guest on the source
3. Started the vncdisplay to monitor the guest
4. Initiated the migration "virsh migrate --live VM1 qemu+ssh://host-ip/sys=
tem tcp://host-ip --verbose --copy-storage-all"
5. It started the copying the storage from souce to destination (conitinous=
ly monitored it was growing)
6. Guest on the destination was paused and was running on the source
7. At some point the VM on the source got shutdown and migration failed wit=
h "Unable to read from monitor: Connection reset by peer"

Attached the libvirt debug logs.

The debug logs shows :

2013-06-19 08:43:12.253+0000: 4026: debug : virEventPollInterruptLocked:716=
 : Interrupting
2013-06-19 08:43:12.253+0000: 4026: debug : virEventPollAddTimeout:248 : EV=
ENT_POLL_ADD_TIMEOUT: timer=3D1 frequency=3D0 cb=3D0x7fe930baa960 opaque=3D=
(nil) ff=3D(nil)

Note: The virsh live migration works fine with nfs storage from source to d=
estination and vice versa.
With libvirt 1.0.5 and qemu 1.5 also we were facing the same issue, but wit=
h that even "Live migration with nfs also was not working".

Guest XML:
----------------

<domain type=3D'kvm'>
  <name>VM1</name>
  <uuid>47feb0e1-0c23-9be9-da12-2ead34864de2</uuid>
  <memory unit=3D'KiB'>4096000</memory>
  <currentMemory unit=3D'KiB'>2048000</currentMemory>
  <vcpu placement=3D'auto'>1</vcpu>
  <numatune>
    <memory mode=3D'strict' nodeset=3D'0'/>
  </numatune>
  <os>
    <type arch=3D'x86_64' machine=3D'pc-i440fx-1.5'>hvm</type>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <pae/>
  </features>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>restart</on_crash>
  <devices>
    <emulator>/usr/local/bin/qemu-system-x86_64</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2' cache=3D'none'/>
      <source file=3D'/home/images/VM1.qcow2'/>
      <target dev=3D'hda' bus=3D'ide'/>
      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=
=3D'0'/>
    </disk>
    <disk type=3D'block' device=3D'cdrom'>
      <driver name=3D'qemu' type=3D'raw'/>
      <target dev=3D'hdc' bus=3D'ide'/>
      <readonly/>
      <address type=3D'drive' controller=3D'0' bus=3D'1' target=3D'0' unit=
=3D'0'/>
    </disk>
    <controller type=3D'usb' index=3D'0'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'ide' index=3D'0'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:9d:cf:bb'/>
      <source network=3D'default'/>
      <model type=3D'rtl8139'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' fu=
nction=3D'0x0'/>
    </interface>
    <serial type=3D'pty'>
      <target port=3D'0'/>
    </serial>
    <console type=3D'pty'>
      <target type=3D'serial' port=3D'0'/>
    </console>
    <input type=3D'mouse' bus=3D'ps2'/>
    <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes' listen=3D'127.0.0.1=
'>
      <listen type=3D'address' address=3D'127.0.0.1'/>
    </graphics>
    <video>
      <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0'/>
    </video>
    <memballoon model=3D'virtio'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' fu=
nction=3D'0x0'/>
    </memballoon>
  </devices>
  <seclabel type=3D'none' model=3D'selinux'/>
</domain>

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/2

------------------------------------------------------------------------
On 2013-06-28T13:27:20+00:00 Michal wrote:

Can you provide the destination debug logs? Esp. content of
/var/log/libvirt/qemu/VM1.log as there's supposed to be the reason why
qemu died.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/3

------------------------------------------------------------------------
On 2013-06-28T13:59:18+00:00 chandrashekar wrote:

Created attachment 766578
Source Logs

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/4

------------------------------------------------------------------------
On 2013-06-28T13:59:51+00:00 chandrashekar wrote:

Created attachment 766579
Destination Logs

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/5

------------------------------------------------------------------------
On 2013-06-28T14:20:28+00:00 Michal wrote:

>From the VM1_dest.log:

...
Completed 97 %
Completed 98 %
Completed 99 %
qemu: warning: error while loading state section id 1
load of migration failed

So the qemu is unable to migrate itself. Therefore I think this is actually=
 a qemu bug.
On the other hand, I wonder why the guest on the source is shut down. There=
's no sign of that in the logs.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/6

------------------------------------------------------------------------
On 2013-07-01T10:02:08+00:00 chandrashekar wrote:

When the migration fails the guest gets shutdown on the source.

[root@9 images]# virsh list --all
 Id    Name                           State
----------------------------------------------------
 5     VM1                     running

[root@9 images]# virsh migrate --live rhel64-64 qemu+ssh:/IP/system tcp://I=
P --verbose --copy-storage-all
 =

Migration: [ 93 %]error: Unable to read from monitor: Connection reset by p=
eer


At the destination:

[root@9 images]# virsh list --all
 Id    Name                           State
----------------------------------------------------
 -     VM1                      shut off

[root@destination]# virsh list --all
 Id    Name                           State
----------------------------------------------------
 16    VM1                      paused

[root@destination]# virsh list --all
 Id    Name                           State
----------------------------------------------------

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/8

------------------------------------------------------------------------
On 2013-07-01T10:02:48+00:00 chandrashekar wrote:

Attached the SOS report of the Source and Destination machines.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/9

------------------------------------------------------------------------
On 2013-07-01T10:05:36+00:00 chandrashekar wrote:

Created attachment 767310
source sos

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/10

------------------------------------------------------------------------
On 2013-07-01T10:14:21+00:00 chandrashekar wrote:

Created attachment 767311
Destination sos

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/12

------------------------------------------------------------------------
On 2013-07-01T10:29:44+00:00 Michal wrote:

Unfortunately, the libvirtd.log is missing. I've written some guide as
well:

http://wiki.libvirt.org/page/DebugLogs

Please set the correct debug logs, reproduce and attach the new reports.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/15

------------------------------------------------------------------------
On 2013-07-01T11:34:34+00:00 chandrashekar wrote:

Attached libvirtd logs of both Source and Destination

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/16

------------------------------------------------------------------------
On 2013-07-01T11:36:13+00:00 chandrashekar wrote:

Created attachment 767340
source libvirtd log

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/17

------------------------------------------------------------------------
On 2013-07-01T11:38:53+00:00 chandrashekar wrote:

Created attachment 767342
Destination libvird logs

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/18

------------------------------------------------------------------------
On 2013-07-01T12:19:24+00:00 Michal wrote:

>From the *source* libvirtd log:

2013-07-01 11:30:29.582+0000: 3164: debug : virObjectRef:297 : OBJECT_REF: =
obj=3D0x7fe97000cb00
2013-07-01 11:30:29.582+0000: 3164: error : qemuMonitorIORead:511 : Unable =
to read from monitor: Connection reset by peer
2013-07-01 11:30:29.582+0000: 3164: debug : qemuMonitorIO:644 : Error on mo=
nitor Unable to read from monitor: Connection reset by peer
2013-07-01 11:30:29.582+0000: 3164: debug : virObjectUnref:260 : OBJECT_UNR=
EF: obj=3D0x7fe97000cb00
2013-07-01 11:30:29.582+0000: 3165: debug : qemuMonitorSend:905 : Send comm=
and resulted in error Unable to read from monitor: Connection reset by peer
2013-07-01 11:30:29.582+0000: 3164: debug : qemuMonitorIO:678 : Triggering =
error callback
2013-07-01 11:30:29.582+0000: 3164: debug : qemuProcessHandleMonitorError:3=
51 : Received error on 0x7fe9881337f0 'rhel64-64'

This means, qemu died unexpectedly. The qemu error message should be in
/var/log/libvirt/qemu/rhel64-64.log on the source.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/19

------------------------------------------------------------------------
On 2014-12-09T16:04:47+00:00 Michal wrote:

Since this is a qemu bug (probably fixed already) I'm closing this one.
If you disagree please reopen.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1192499/comments/32


** Changed in: libvirt (Fedora)
       Status: Unknown =3D> Won't Fix

** Changed in: libvirt (Fedora)
   Importance: Unknown =3D> High

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1192499

Title:
  virsh migration copy-storage-all  fails with "Unable to read from
  monitor: Connection reset by peer"

Status in QEMU:
  Won't Fix
Status in libvirt package in Ubuntu:
  Invalid
Status in libvirt package in Fedora:
  Won't Fix

Bug description:
  virsh migration copy-storage-all  fails with "Unable to read from
  monitor: Connection reset by peer" and shut downs the guest on the
  source host.

  Kernel Version:  3.10.0-rc5+

  Libvirt Version: 1.0.6

  Qemu Version: 1.5.50

  Steps to reproduce the issue:
  ----------------------------------------
  1. Created the qemu-img create -f qcow2 vm.qcow2 11G on the destination h=
ost which is same as the source.
  2. Started the guest on the source
  3. Started the vncdisplay to monitor the guest
  4. Initiated the migration "virsh migrate --live VM1 qemu+ssh://host-ip/s=
ystem tcp://host-ip --verbose --copy-storage-all"
  5. It started the copying the storage from souce to destination (conitino=
usly monitored it was growing)
  6. Guest on the destination was paused and was running on the source
  7. At some point the VM on the source got shutdown and migration failed w=
ith "Unable to read from monitor: Connection reset by peer"

  Attached the libvirt debug logs.

  The debug logs shows :

  2013-06-19 08:43:12.253+0000: 4026: debug : virEventPollInterruptLocked:7=
16 : Interrupting
  2013-06-19 08:43:12.253+0000: 4026: debug : virEventPollAddTimeout:248 : =
EVENT_POLL_ADD_TIMEOUT: timer=3D1 frequency=3D0 cb=3D0x7fe930baa960 opaque=
=3D(nil) ff=3D(nil)

  Note: The virsh live migration works fine with nfs storage from source to=
 destination and vice versa.
  With libvirt 1.0.5 and qemu 1.5 also we were facing the same issue, but w=
ith that even "Live migration with nfs also was not working".

  Guest XML:
  ----------------

  <domain type=3D'kvm'>
    <name>VM1</name>
    <uuid>47feb0e1-0c23-9be9-da12-2ead34864de2</uuid>
    <memory unit=3D'KiB'>4096000</memory>
    <currentMemory unit=3D'KiB'>2048000</currentMemory>
    <vcpu placement=3D'auto'>1</vcpu>
    <numatune>
      <memory mode=3D'strict' nodeset=3D'0'/>
    </numatune>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-1.5'>hvm</type>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
    </features>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/local/bin/qemu-system-x86_64</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2' cache=3D'none'/>
        <source file=3D'/home/images/VM1.qcow2'/>
        <target dev=3D'hda' bus=3D'ide'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <disk type=3D'block' device=3D'cdrom'>
        <driver name=3D'qemu' type=3D'raw'/>
        <target dev=3D'hdc' bus=3D'ide'/>
        <readonly/>
        <address type=3D'drive' controller=3D'0' bus=3D'1' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <controller type=3D'usb' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'ide' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <interface type=3D'network'>
        <mac address=3D'52:54:00:9d:cf:bb'/>
        <source network=3D'default'/>
        <model type=3D'rtl8139'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <serial type=3D'pty'>
        <target port=3D'0'/>
      </serial>
      <console type=3D'pty'>
        <target type=3D'serial' port=3D'0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes' listen=3D'127.0.0=
.1'>
        <listen type=3D'address' address=3D'127.0.0.1'/>
      </graphics>
      <video>
        <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
      </memballoon>
    </devices>
    <seclabel type=3D'none' model=3D'selinux'/>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1192499/+subscriptions
