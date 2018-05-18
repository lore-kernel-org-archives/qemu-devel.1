Received: from eggs.gnu.org ([2001:4830:134:3::10]:53234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJcf4-0001NO-0K
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJcf2-0003TV-Or
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:30:58 -0400
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
Date: Fri, 18 May 2018 12:30:44 +0200
MIME-Version: 1.0
In-Reply-To: <1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Subject: Re: [Qemu-devel] [PPC64] P5020DS: Booting from img possible
 (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 18 May 2018 at 11:24PM, Thomas Huth wrote:
> On 18.05.2018 11:06, Christian Zigotzky wrote:
>> It works on my AmigaOne X5000 (P5020 board with 2x e5500 cores).
>>
>> Screenshots: https://plus.google.com/115515624056477014971
> Interesting ... but you still use your own kernel, and not the stock
> Ubuntu kernel, right? That would explain how this can work...
>
> Anyway, having a quick look at the sources, it seems to me that the
> ppce500 / mpc8544ds machines in QEMU do not support any mass storage
> controllor by default, so you got to specify the interface type.
>
> For example:
>
>   -drive if=virtio,file=...
>
> or:
>
>   -device virtio-scsi -drive if=none,id=c1,file=... \
>   -device scsi-cd,drive=c1
>
> Same for the graphics card, there does not seem to be support for a
> default here, so try to specify it like this:
>
>   -device VGA
>
> or:
>
>   -device virtio-vga
>
>   HTH,
>    Thomas
>
Hello Thomas,

Thanks for your reply.

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel 
/home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17 
-machine dt_compatible=fsl,,P5020DS -drive 
if=virtio,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img 
-append "root=/dev/sda3"

Output:

[    0.880961] VFS: Cannot open root device "sda3" or 
unknown-block(0,0): error -6
[    0.881150] Please append a correct "root=" boot option; here are the 
available partitions:
[    0.881446] 0100          131072 ram0
[    0.881478]  (driver?)
[    0.881709] 0101          131072 ram1
[    0.881715]  (driver?)
[    0.881875] 0102          131072 ram2
[    0.881879]  (driver?)
[    0.882033] 0103          131072 ram3
[    0.882037]  (driver?)
[    0.882189] 0104          131072 ram4
[    0.882193]  (driver?)
[    0.882347] 0105          131072 ram5
[    0.882350]  (driver?)
[    0.882503] 0106          131072 ram6
[    0.882507]  (driver?)
[    0.882700] 0107          131072 ram7
[    0.882705]  (driver?)
[    0.882862] 0108          131072 ram8
[    0.882866]  (driver?)
[    0.883018] 0109          131072 ram9
[    0.883021]  (driver?)
[    0.883174] 010a          131072 ram10
[    0.883178]  (driver?)
[    0.883330] 010b          131072 ram11
[    0.883333]  (driver?)
[    0.883487] 010c          131072 ram12
[    0.883490]  (driver?)
[    0.883694] 010d          131072 ram13
[    0.883699]  (driver?)
[    0.883858] 010e          131072 ram14
[    0.883863]  (driver?)
[    0.884020] 010f          131072 ram15
[    0.884024]  (driver?)
[    0.884265] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(0,0)
[    0.884883] Rebooting in 180 seconds..

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel 
/home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17 
-machine dt_compatible=fsl,,P5020DS -device virtio-scsi -drive 
if=none,id=c1,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img 
-device scsi-cd,drive=c1 -append "root=/dev/sda3"

Unfortunately without any success. (same errors like before)

Boot with U-Boot:

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -bios 
/home/christian/Downloads/u-boot -machine dt_compatible=fsl,,P5020DS 
-device virtio-scsi -drive 
if=none,id=c1,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img 
-device scsi-cd,drive=c1

Output:

U-Boot 2017.09-00322-g1f6049e (Sep 25 2017 - 20:50:48 +0200)

CPU:   Unknown, Version: 0.0, (0x00000000)
Core:  e5500, Version: 2.0, (0x80240020)
Clock Configuration:
        CPU0:400  MHz,
        CCB:400  MHz,
        DDR:200  MHz (400 MT/s data rate), LBC: unknown (LCRR[CLKDIV] = 
0x00)
L1:    D-cache 32 KiB enabled
        I-cache 32 KiB enabled
DRAM:  2 GiB
L2:    disabled
Using default environment


PCI: base address e0008000
   00:01.0     - 1af4:1000 - Network controller
   00:02.0     - 1af4:1004 - Mass storage controller
PCI1: Bus 00 - 00

In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.
Hit any key to stop autoboot:  0
=>

Any other hints?

Thanks,
Christian
