Received: from eggs.gnu.org ([2001:4830:134:3::10]:58278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fslnL-0007Mb-N3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fslnH-0001Jb-L1
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:20:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:45114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fslnH-0001Is-E4
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:20:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fslnG-0001js-6g
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 315AF2E851F
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Aug 2018 09:11:23 -0000
From: Marc Hartmayer <1788582@bugs.launchpad.net>
Reply-To: Bug 1788582 <1788582@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153501548405.31458.2315196104370535583.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788582] [NEW] Race condition during shutdown
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

I ran into a bug when I started several VMs in parallel using
libvirt. The VMs are using only a kernel and a initrd (which includes a
minimal OS). The guest OS itself does a 'poweroff -f' as soon as the
login prompt shows up. So the expectaction is that the VMs will start,
the shutdown will be initiated, and the QEMU processes will then
end. But instead some of the QEMU processes get stuck in ppoll().

A bisect showed that the first bad commit was
0f12264e7a41458179ad10276a7c33c72024861a ("block: Allow graph changes in
bdrv_drain_all_begin/end sections").

I've already tried the current master (13b7b188501d419a7d63c016e00065bcc693=
b7d4) =

since the problem might be related
to the commit a1405acddeb0af6625dd9c30e8277b08e0885bd3 ("aio: Do
aio_notify_accept only during blocking aio_poll"). But the bug is still
there. I=E2=80=99ve reproduced the bug on x86_64 and on s390x.

The backtrace of a hanging QEMU process:

(gdb) bt
#0  0x00007f5d0e251b36 in ppoll () from target:/lib64/libc.so.6
#1  0x0000560191052014 in qemu_poll_ns (fds=3D0x560193b23d60, nfds=3D5, tim=
eout=3D55774838936000) at /home/user/git/qemu/util/qemu-timer.c:334
#2  0x00005601910531fa in os_host_main_loop_wait (timeout=3D55774838936000)=
 at /home/user/git/qemu/util/main-loop.c:233
#3  0x0000560191053119 in main_loop_wait (nonblocking=3D0) at /home/user/gi=
t/qemu/util/main-loop.c:497
#4  0x0000560190baf454 in main_loop () at /home/user/git/qemu/vl.c:1866
#5  0x0000560190baa552 in main (argc=3D71, argv=3D0x7ffde10e41c8, envp=3D0x=
7ffde10e4408) at /home/user/git/qemu/vl.c:4644

The used domain definition is:

<domain type=3D'kvm'>
  <name>test</name>
  <memory unit=3D'KiB'>716800</memory>
  <vcpu placement=3D'static'>2</vcpu>
  <iothreads>8</iothreads>
  <os>
    <type arch=3D'x86_64' machine=3D'pc-i440fx-3.0'>hvm</type>
    <kernel>/var/lib/libvirt/images/vmlinuz-4.14.13-200.fc26.x86_64</kernel>
    <initrd>/var/lib/libvirt/images/test-image-qemux86_64+modules-4.14.13-2=
00.fc26.x86_64.cpio.gz</initrd>
    <cmdline>console=3Dhvc0 STARTUP=3Dshutdown.sh</cmdline>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
  </features>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>preserve</on_crash>
  <devices>
    <emulator>/usr/local/qemu/master/bin/qemu-system-x86_64</emulator>
    <controller type=3D'usb' index=3D'0' model=3D'piix3-uhci'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
    <controller type=3D'virtio-serial' index=3D'0'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0'/>
    </controller>
    <console type=3D'pty'>
      <target type=3D'virtio' port=3D'0'/>
    </console>
    <input type=3D'mouse' bus=3D'ps2'/>
    <input type=3D'keyboard' bus=3D'ps2'/>
    <memballoon model=3D'none'/>
  </devices>
</domain>

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788582

Title:
  Race condition during shutdown

Status in QEMU:
  New

Bug description:
  I ran into a bug when I started several VMs in parallel using
  libvirt. The VMs are using only a kernel and a initrd (which includes a
  minimal OS). The guest OS itself does a 'poweroff -f' as soon as the
  login prompt shows up. So the expectaction is that the VMs will start,
  the shutdown will be initiated, and the QEMU processes will then
  end. But instead some of the QEMU processes get stuck in ppoll().

  A bisect showed that the first bad commit was
  0f12264e7a41458179ad10276a7c33c72024861a ("block: Allow graph changes in
  bdrv_drain_all_begin/end sections").

  I've already tried the current master (13b7b188501d419a7d63c016e00065bcc6=
93b7d4) =

  since the problem might be related
  to the commit a1405acddeb0af6625dd9c30e8277b08e0885bd3 ("aio: Do
  aio_notify_accept only during blocking aio_poll"). But the bug is still
  there. I=E2=80=99ve reproduced the bug on x86_64 and on s390x.

  The backtrace of a hanging QEMU process:

  (gdb) bt
  #0  0x00007f5d0e251b36 in ppoll () from target:/lib64/libc.so.6
  #1  0x0000560191052014 in qemu_poll_ns (fds=3D0x560193b23d60, nfds=3D5, t=
imeout=3D55774838936000) at /home/user/git/qemu/util/qemu-timer.c:334
  #2  0x00005601910531fa in os_host_main_loop_wait (timeout=3D5577483893600=
0) at /home/user/git/qemu/util/main-loop.c:233
  #3  0x0000560191053119 in main_loop_wait (nonblocking=3D0) at /home/user/=
git/qemu/util/main-loop.c:497
  #4  0x0000560190baf454 in main_loop () at /home/user/git/qemu/vl.c:1866
  #5  0x0000560190baa552 in main (argc=3D71, argv=3D0x7ffde10e41c8, envp=3D=
0x7ffde10e4408) at /home/user/git/qemu/vl.c:4644

  The used domain definition is:

  <domain type=3D'kvm'>
    <name>test</name>
    <memory unit=3D'KiB'>716800</memory>
    <vcpu placement=3D'static'>2</vcpu>
    <iothreads>8</iothreads>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-3.0'>hvm</type>
      <kernel>/var/lib/libvirt/images/vmlinuz-4.14.13-200.fc26.x86_64</kern=
el>
      <initrd>/var/lib/libvirt/images/test-image-qemux86_64+modules-4.14.13=
-200.fc26.x86_64.cpio.gz</initrd>
      <cmdline>console=3Dhvc0 STARTUP=3Dshutdown.sh</cmdline>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
    </features>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>preserve</on_crash>
    <devices>
      <emulator>/usr/local/qemu/master/bin/qemu-system-x86_64</emulator>
      <controller type=3D'usb' index=3D'0' model=3D'piix3-uhci'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <controller type=3D'virtio-serial' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </controller>
      <console type=3D'pty'>
        <target type=3D'virtio' port=3D'0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <input type=3D'keyboard' bus=3D'ps2'/>
      <memballoon model=3D'none'/>
    </devices>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788582/+subscriptions
