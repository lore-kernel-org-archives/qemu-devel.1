Received: from eggs.gnu.org ([2001:4830:134:3::10]:48149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cphYP-0005wW-Dj
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 16:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cphYH-0001cx-WA
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 16:35:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:39703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cphYH-0001cQ-Nd
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 16:35:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cphYG-0005cJ-60
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 20:35:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 206C02E80C7
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 20:35:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Mar 2017 20:25:58 -0000
From: 3vIL_VIrUs <hansp.schulz@gmail.com>
Reply-To: Bug 1674117 <1674117@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170319163002.19988.72829.malonedeb@soybean.canonical.com>
Message-Id: <20170319202559.22101.51201.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1674117] Re: Qemu VM start kills Pulseaudio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Tags removed: pulseaudio
** Tags added: pulse-audio

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1674117

Title:
  Qemu VM start kills Pulseaudio

Status in QEMU:
  New

Bug description:
  When I start a VM (start command below) in Qemu version >2.5, it kills Pu=
lseaudio (paired with a huge lagspike) in ~4/5 cases. Using version 2.5 bui=
ld from GIT, it works fine. This also happens when building from the curren=
t GIT master (ebedf0f).
  Host:
    Freshly installed Antergos Arch Linux 4.10.3-1-ARCH
    Intel I7-5930K
    ASUS X99 Deluxe II latest UEFI
    GTX 770

  Guest:
    Windows 10 x64
    AMD RX480 via VFIO

  This also happened on my last install (Ubuntu GNOME 16.10).

  Start command:
    QEMU_AUDIO_DRV=3Dpa \
    QEMU_PA_SAMPLES=3D4096 \
    qemu-system-x86_64 \
      -serial none \
      -parallel none \
      -nodefconfig \
      -nodefaults \
      -name win10 \
      -enable-kvm \
      -cpu host,check,kvm=3Doff \
      -smp 12,sockets=3D1,cores=3D6,threads=3D2 \
      -m 16G \
      -mem-prealloc \
      -device nec-usb-xhci,id=3Dxhci \
      -device usb-host,vendorid=3D0x05ac,productid=3D0x0205,bus=3Dxhci.0 \
      -net nic,vlan=3D0,model=3Dvirtio \
      -net bridge,vlan=3D0,br=3Dbridge0 \
      -object iothread,id=3Diothread0 \
      -device virtio-blk-pci,iothread=3Diothread0,drive=3Ddrive0 \
      -drive file=3D"$DISK",format=3Draw,if=3Dnone,cache=3Dnone,aio=3Dnativ=
e,id=3Ddrive0 \
      -boot order=3Dc,menu=3Don \
      -rtc base=3Dutc \
      -nographic \
      -k de \
      -monitor stdio \
      -soundhw hda \
      -device vfio-pci,host=3D02:00.0,addr=3D09.0,multifunction=3Don,x-vga=
=3Don \
      -device vfio-pci,host=3D02:00.1,addr=3D09.1 \
      -device vfio-pci,host=3D04:00.0,addr=3D07.0,multifunction=3Don,id=3Du=
sbcontroller

  When it kills Pulseaudio, I see these errors in the Qemu console:
    pulseaudio: set_sink_input_volume() failed
    pulseaudio: Reason: Bad state
    pulseaudio: set_sink_input_mute() failed
    pulseaudio: Reason: Bad state
    pulseaudio: set_source_output_volume() failed
    ... many more of these ...

  The journal shows that PulseAudio is killed:
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Main =
process exited, code=3Dkilled, status=3D9/KILL
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Unit =
entered failed state.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Faile=
d with result 'signal'.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Servi=
ce hold-off time over, scheduling restart.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: Stopped Sound Service.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: Starting Sound Service...

  I've also captured a PulseAudio debug log when this happens, but it
  does not contain anything interesting (no warnings or errors), which
  makes sense in case of SIGKILL.

  In DMESG I get some errors too, but they seem to be just symptoms (but Im=
 just guessing...); 00:14.0 is the USB controller my DAC is connected to:
    [ 4372.389051] usb 3-9.4: current rate 4500480 is different from the ru=
ntime rate 44100
    [ 4372.509163] usb 3-9.4: current rate 4500480 is different from the ru=
ntime rate 44100
    [ 4372.559104] usb 3-9.4: current rate 4500480 is different from the ru=
ntime rate 44100
    [ 4373.652557] xhci_hcd 0000:00:14.0: ERROR unknown event type 37
    [ 4373.712382] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 1 comp_code 36
    [ 4373.715714] xhci_hcd 0000:00:14.0: Looking for event-dma 0000000745d=
a7f00 trb-start 0000000745da7f10 trb-end 0000000745da7f10 seg-start 0000000=
745da7000 seg-end 0000000745da7ff0
    [ 4373.719055] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 1 comp_code 1
    [ 4373.722381] xhci_hcd 0000:00:14.0: Looking for event-dma 0000000745d=
a7f00 trb-start 0000000745da7f10 trb-end 0000000745da7f10 seg-start 0000000=
745da7000 seg-end 0000000745da7ff0
    [ 4373.725753] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 4 comp_code 13
    [ 4373.725759] xhci_hcd 0000:00:14.0: Looking for event-dma 000000073c5=
a51a0 trb-start 000000073c5a51b0 trb-end 000000073c5a51b0 seg-start 0000000=
73c5a5000 seg-end 000000073c5a5ff0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1674117/+subscriptions
