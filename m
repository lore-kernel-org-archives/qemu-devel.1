Received: from eggs.gnu.org ([2001:4830:134:3::10]:43137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldevulder@suse.de>) id 1fO0hz-0006WS-1A
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldevulder@suse.de>) id 1fO0hs-0008Ci-8I
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:00:07 -0400
From: Loic Devulder <ldevulder@suse.de>
Message-ID: <adf387ea-ddf9-b0cb-a281-2c66d8408f4d@suse.de>
Date: Wed, 30 May 2018 14:59:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] KVM internal error with kvm-pr on ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

Hi guys!

I tried to start a Linux CD (I tried openSUSE Leap 42.3) to install my pp=
c64le VM with kvm-pr (yes
kvm-pr!) on a Power8 host and I have some issues...

My host system is an openSUSE Tumbleweed 20180525 with qemu 2.11 and kern=
el 4.16.11.

I tried different version of qemu without any success but I tried with op=
enSUSE Leap 42.3 as a host
(and qemu 2.11 and 2.12) with success. Kernel is 4.4 on Leap 42.3, and if=
 I update the kernel to a
more recent version I have the same issue! So it seems to be a kvm proble=
m, not qemu.

I also tried without KVM and it works (but it is of course very slow!).

I tried to understand why and it seems to be related to the virtio-vga. H=
ere the different tries I
made with openSUSE Tumbleweed 20180525 as host.

- With only virtio-vga and boot/messages on VGA console:
/usr/bin/qemu-system-ppc64 -m 1024 -cpu host -device virtio-scsi-pci,id=3D=
scsi0 -device
scsi-cd,drive=3Dcd0,bus=3Dscsi0.0 -drive
media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3D/opt/openSUSE-Leap-4=
2.3-NET-ppc64le-Build0130-Media.iso
-smp 1,threads=3D1 -enable-kvm -device nec-usb-xhci -device usb-tablet -d=
evice usb-kbd -serial
stdio:mon -device virtio-vga -nodefaults

Trying to load:  from: /pci@800000020000000/scsi@0/disk@100000000000000 .=
..   Successfully loaded
SUSE Linux
#1 SMP Fri Jun 3KVM internal error. Suberror: 61568
NIP c0000000005359f4   LR c0000000005356cc CTR 0000000000000032 XER 00000=
00000000000 CPU#0
MSR b000000000009033 HID0 0000000000000000  HF 8000000000000000 iidx 3 di=
dx 3
TB 00000000 00000000 DECR 00000000
GPR00 0000000000006400 c00000003e49f440 c000000000f3ba00 0000000000000190
GPR04 d0000800803ce800 0000000000000000 0000000000000000 0000000000000000
GPR08 0000000000000040 d0000800803ce800 0000000000000032 ffffffffffffffff
GPR12 c000000000535950 c00000000fa00000 c00000000000bf38 0000000000000000
GPR16 0000000000000064 0000000000000025 0000000000000064 c0000000012d5a98
GPR20 0000000000000000 0000000000000320 0000000000000000 0000000000000000
GPR24 0000000000000006 0000000000000008 0000000000000000 0000000000006400
GPR28 c000000000535950 c00000003e719800 0000000000000000 d0000800803ce800
CR 44022084  [ G  G  -  E  E  -  L  G  ]             RES ffffffffffffffff
FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR08 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPSCR 0000000000000000
 SRR0 c0000000005359f4  SRR1 b000000000009033    PVR 00000000004b0201 VRS=
AVE 0000000000000000
SPRG0 0000000000000000 SPRG1 c00000000fa00000  SPRG2 c00000000fa00000  SP=
RG3 0000000000000000
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SP=
RG7 0000000000000000
HSRR0 0000000000000000 HSRR1 0000000000000000
 CFAR 0000000000000000
 LPCR 0000000002000000
 SDR1 0000000000000000   DAR d0000800803ce800  DSISR 0000000042000000

I have the "Loading kernel..." to "Booting Linux via __start() ..." on th=
e VGA console and after the
crash on the serial console. "Suberror: 61568" is weird...

Same if I boot with "-vga std" or "-vga virtio" instead of "-device virti=
o-vga" (I know that "-vga
virtio" and "-device virtio-vga" are the same).

With the help of Alexander Graf (thanks!) I was able to have some debug i=
nformations:
qemu-system-ppc-9944  [006] .... 83419.417302: kvm_book3s_reenter: reentr=
y r=3D1 | pc=3D0xc000000000089930
 qemu-system-ppc-9944  [006] .... 83419.417304: kvm_exit: exit=3DPROGRAM =
| pc=3D0xc000000000009958 |
msr=3D0xb000000000001031 | dar=3D0x7fff67356200 | srr1=3D0x800000000004d0=
33 | last_inst=3D0x4c000024
 qemu-system-ppc-9944  [006] .... 83419.417305: kvm_ppc_instr: inst 12750=
68452 pc 0xc0000000005359f4
emulate 0
 qemu-system-ppc-9944  [006] .... 83419.417305: kvm_book3s_reenter: reent=
ry r=3D1 | pc=3D0xc0000000005359f4
 qemu-system-ppc-9944  [006] .... 83419.417307: kvm_exit: exit=3DDATA_SEG=
MENT | pc=3D0xc0000000005359f4
| msr=3D0xb000000000009033 | dar=3D0xd0000800803ce800 | srr1=3D0x80000000=
0000d033 | last_inst=3D0x4c000024
 qemu-system-ppc-9944  [006] .... 83419.417307: kvm_book3s_slb_found: 180=
00033deaf8008 -> 61c0f87e5e
 qemu-system-ppc-9944  [006] .... 83419.417308: kvm_book3s_slbmte: 61c0f8=
7e5e990, d000080088000003
 qemu-system-ppc-9944  [006] .... 83419.417308: kvm_book3s_reenter: reent=
ry r=3D0 | pc=3D0xc0000000005359f4
 qemu-system-ppc-9944  [006] .... 83419.417310: kvm_exit: exit=3DDATA_STO=
RAGE | pc=3D0xc0000000005359f4
| msr=3D0xb000000000009033 | dar=3D0xd0000800803ce800 | srr1=3D0x80000000=
0000d033 | last_inst=3D0xf8c90000
 qemu-system-ppc-9944  [006] .... 83419.417315: kvm_book3s_slb_found: 180=
00033deaf8008 -> 61c0f87e5e
 qemu-system-ppc-9944  [006] .... 83419.417317: kvm_book3s_reenter: reent=
ry r=3D2 | pc=3D0xc0000000005359f4
 qemu-system-ppc-9944  [006] .... 83419.417319: kvm_userspace_exit: reaso=
n KVM_EXIT_INTERNAL_ERROR (17)
qemu-system-ppc-9941  [004] .... 83419.447328: kvm_book3s_mmu_flush: Flus=
h 5473 pPTEs: 200080000000
- 200081000000
           gdbus-9946  [004] .... 83465.282674: kvm_book3s_mmu_flush: Flu=
sh 5473 PTEs: 0 - 0
           gdbus-9946  [004] .... 83465.282684: kvm_book3s_mmu_invalidate=
: Flush: hva=3D61c1b7cf37f7f0
pfn=3D7677e ea=3Dc00000002f7f0000 vp=3Dea1b217002f7f0 ra=3D2f7f0000 [6]

- With only virtio-vga and boot/messages on hvterm console (I removed the=
 USB part to force the
console output):
/usr/bin/qemu-system-ppc64 -serial mon:stdio -m 1024 -cpu host -device vi=
rtio-scsi-pci,id=3Dscsi0
-device scsi-cd,drive=3Dcd0,bus=3Dscsi0.0 -drive
media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3D/opt/openSUSE-Leap-4=
2.3-NET-ppc64le-Build0130-Media.iso
-smp 1,threads=3D1 -enable-kvm -device virtio-vga -nodefaults

Loading kernel ...
Loading initial ramdisk ...
OF stdout device is: /vdevice/vty@71000000
Preparing to boot Linux version 4.4.74-1-default (geeko@buildhost) (gcc v=
ersion 4.8.5 (SUSE Linux) )
#1 SMP Fri Jun 30 19:11:19 UTC 2017 (f0a86d9)
Detected machine type: 0000000000000101
Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
Calling ibm,client-architecture-support... done
command line: BOOT_IMAGE=3D/boot/ppc64le/linux
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000006380000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000040000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000040000000
found display   : /pci@800000020000000/vga@1, opening... done
instantiating rtas at 0x000000002fff0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000006390000 -> 0x0000000006390abe
Device tree struct  0x00000000063a0000 -> 0x00000000063b0000
Quiescing Open Firmware ...
Booting Linux via __start() ...
Loading kernel ...
Loading initial ramdisk ...
OF stdout device is: /vdevice/vty@71000000
Preparing to boot Linux version 4.4.74-1-default (geeko@buildhost) (gcc v=
ersion 4.8.5 (SUSE Linux) )
#1 SMP Fri Jun 30 19:11:19 UTC 2017 (f0a86d9)
Detected machine type: 0000000000000101
Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
Calling ibm,client-architecture-support... done
command line: BOOT_IMAGE=3D/boot/ppc64le/linux
[...]
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
Using unsupported 800x600 vga at 200080800000, depth=3D32, pitch=3D3200
KVM internal error. Suberror: 88
NIP c0000000005359f4   LR c0000000005356cc CTR 0000000000000032 XER 00000=
00000000000 CPU#0
MSR b000000000009033 HID0 0000000000000000  HF 8000000000000000 iidx 3 di=
dx 3
TB 00000000 00000000 DECR 00000000
GPR00 0000000000006400 c00000003e49f440 c000000000f3ba00 0000000000000190
GPR04 d0000800801ce800 0000000000000000 0000000000000000 0000000000000000
GPR08 0000000000000040 d0000800801ce800 0000000000000032 ffffffffffffffff
GPR12 c000000000535950 c00000000fa00000 c00000000000bf38 0000000000000000
GPR16 0000000000000064 0000000000000025 0000000000000064 c0000000012d5a98
GPR20 0000000000000000 0000000000000320 0000000000000000 0000000000000000
GPR24 0000000000000006 0000000000000008 0000000000000000 0000000000006400
GPR28 c000000000535950 c00000003e719800 0000000000000000 d0000800801ce800
CR 44022084  [ G  G  -  E  E  -  L  G  ]             RES ffffffffffffffff
FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR08 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPSCR 0000000000000000
 SRR0 c0000000005359f4  SRR1 b000000000009033    PVR 00000000004b0201 VRS=
AVE 0000000000000000
SPRG0 0000000000000000 SPRG1 c00000000fa00000  SPRG2 c00000000fa00000  SP=
RG3 0000000000000000
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SP=
RG7 0000000000000000
HSRR0 0000000000000000 HSRR1 0000000000000000
 CFAR 0000000000000000
 LPCR 0000000002000000
 SDR1 0000000000000000   DAR d0000800801ce800  DSISR 0000000042000000

It's a little bit better, I think "Suberror: 88" is more comprehensible (=
at least I hope!).

Same if I boot with "-vga std" or "-vga virtio" instead of "-device virti=
o-vga".

Some debug informations:
qemu-system-ppc-10016 [004] .... 83794.482587: kvm_book3s_reenter: reentr=
y r=3D1 | pc=3D0xc000000000089930
 qemu-system-ppc-10016 [004] .... 83794.482588: kvm_exit: exit=3DPROGRAM =
| pc=3D0xc000000000009958 |
msr=3D0xb000000000001031 | dar=3D0x7fff3e357200 | srr1=3D0x800000000004d0=
33 | last_inst=3D0x4c000024
 qemu-system-ppc-10016 [004] .... 83794.482589: kvm_ppc_instr: inst 12750=
68452 pc 0xc0000000005359f4
emulate 0
 qemu-system-ppc-10016 [004] .... 83794.482590: kvm_book3s_reenter: reent=
ry r=3D1 | pc=3D0xc0000000005359f4
 qemu-system-ppc-10016 [004] .... 83794.482591: kvm_exit: exit=3DDATA_SEG=
MENT | pc=3D0xc0000000005359f4
| msr=3D0xb000000000009033 | dar=3D0xd0000800801ce800 | srr1=3D0x80000000=
0000d033 | last_inst=3D0x4c000024
 qemu-system-ppc-10016 [004] .... 83794.482592: kvm_book3s_slb_found: 180=
00033deaf8008 -> 61c1b7cf37
 qemu-system-ppc-10016 [004] .... 83794.482592: kvm_book3s_slbmte: 61c1b7=
cf37990, d000080088000003
 qemu-system-ppc-10016 [004] .... 83794.482592: kvm_book3s_reenter: reent=
ry r=3D0 | pc=3D0xc0000000005359f4
 qemu-system-ppc-10016 [004] .... 83794.482594: kvm_exit: exit=3DDATA_STO=
RAGE | pc=3D0xc0000000005359f4
| msr=3D0xb000000000009033 | dar=3D0xd0000800801ce800 | srr1=3D0x80000000=
0000d033 | last_inst=3D0xf8c90000
 qemu-system-ppc-10016 [004] .... 83794.482599: kvm_book3s_slb_found: 180=
00033deaf8008 -> 61c1b7cf37
 qemu-system-ppc-10016 [004] .... 83794.482602: kvm_book3s_reenter: reent=
ry r=3D2 | pc=3D0xc0000000005359f4
 qemu-system-ppc-10016 [004] .... 83794.482602: kvm_userspace_exit: reaso=
n KVM_EXIT_INTERNAL_ERROR (17)
 qemu-system-ppc-10013 [005] .... 83794.495264: kvm_book3s_mmu_flush: Flu=
sh 5468 pPTEs: 200080000000
- 200081000000
 qemu-system-ppc-10013 [001] .... 83800.464923: kvm_book3s_mmu_flush: Flu=
sh 5468 PTEs: 0 - 0
 qemu-system-ppc-10013 [001] .... 83800.464933: kvm_book3s_mmu_invalidate=
: Flush: hva=3D61c0392d85f7f0
pfn=3D75b7e ea=3Dc00000002f7f0000 vp=3Dea1b217002f7f0 ra=3D2f7f0000 [6]
 qemu-system-ppc-10013 [001] .... 83800.464938: kvm_book3s_mmu_invalidate=
: Flush: hva=3D61c0392d85f7e0
pfn=3D75b7d ea=3Dc00000002f7e0000 vp=3Dea1b217002f7e0 ra=3D2f7e0000 [6]

- With only virtio-gpu and boot/messages on hvterm/VGA console:
/usr/bin/qemu-system-ppc64 -serial mon:stdio -m 1024 -cpu host -device vi=
rtio-scsi-pci,id=3Dscsi0
-device scsi-cd,drive=3Dcd0,bus=3Dscsi0.0 -drive
media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3D/opt/openSUSE-Leap-4=
2.3-NET-ppc64le-Build0130-Media.iso
-smp 1,threads=3D1 -enable-kvm -device virtio-gpu -nodefaults

No problem, the kernel boot with default console on hvterm and some messa=
ges on VGA console. And the
kernel boot also if I set the console to VGA (console=3Dtty on Linux).

- With only virtio-gpu-pci and boot/messages on hvterm:
/usr/bin/qemu-system-ppc64 -serial mon:stdio -m 1024 -cpu host -device vi=
rtio-scsi-pci,id=3Dscsi0
-device scsi-cd,drive=3Dcd0,bus=3Dscsi0.0 -drive
media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3D/opt/openSUSE-Leap-4=
2.3-NET-ppc64le-Build0130-Media.iso
-smp 1,threads=3D1 -enable-kvm -device virtio-gpu-pci -nodefaults

Same as above. It seems like if virtio-gpu and virtio-gpu-pci are the sam=
e.

QT_X11_NO_MITSHM=3D1 /usr/bin/qemu-system-ppc64 -serial mon:stdio -m 1024=
 -cpu host -device
virtio-scsi-pci,id=3Dscsi0 -device scsi-cd,drive=3Dcd0,bus=3Dscsi0.0 -dri=
ve
media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3D/opt/openSUSE-Leap-4=
2.3-NET-ppc64le-Build0130-Media.iso
-smp 1,threads=3D1 -enable-kvm -device nec-usb-xhci -device usb-tablet -d=
evice usb-kbd -device
virtio-vga -device virtio-gpu-pci -nodefaults

So, is anybody already saw this? May I did something wrong? How we can de=
bug this? (And sorry for
this long email, I try to add all the needed information!).

--=20
Loic Devulder - Senior QA Engineer
Container & Storage Solutions Quality Assurance team (qa-css)
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nuernberg, Germany
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton HRB=
, 21284 (AG Nuernberg)
