Received: from eggs.gnu.org ([2001:4830:134:3::10]:58966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fReoE-0000lP-JG
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fReoD-0005DL-9M
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:25:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608200558.386-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b30f13d-cd17-7375-47b4-317ed350a052@amsat.org>
Date: Sat, 9 Jun 2018 11:25:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180608200558.386-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 00/13] hw/m68k: add Apple Machintosh Quadra
 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

Hi Laurent,

On 06/08/2018 05:05 PM, Laurent Vivier wrote:
> if you want to test the machine, I'm sorry, it doesn't boot
> a MacROM, but you can boot a linux kernel from the command line.
> 
> You can install your own disk using debian-installer, with:
> 
>     ...
>     -M q800 \
>     -serial none -serial mon:stdio \
>     -m 1000M -drive file=m68k.qcow2,format=qcow2 \
>     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>     -append "console=ttyS0 vga=off" \
>     -kernel vmlinux-4.15.0-2-m68k \
>     -initrd initrd.gz \
>     -drive file=debian-9.0-m68k-NETINST-1.iso \
>     -drive file=m68k.qcow2,format=qcow2 \
>     -nographic
> 
> If you use a graphic adapter instead of "-nographic", you can use "-g" to set the
> size of the display (I use "-g 1600x800x24").
> 
> You can get the ISO from:
> 
> https://cdimage.debian.org/mirror/cdimage/ports/9.0/m68k/iso-cd/debian-9.0-m68k-NETINST-1.iso
> 
> and extract the kernel and initrd.gz:
> 
> guestfish --add debian-9.0-m68k-NETINST-1.iso --ro \
>           --mount /dev/sda:/ <<_EOF_
> copy-out /install/cdrom/initrd.gz .
> copy-out /install/kernels/vmlinux-4.15.0-2-m68k .
> _EOF_

Running with -d in_asm,int I get:

----------------
IN: nf_get_id
0x0000d432:  movel %a3,%d0
0x0000d434:  addil #0,%d0
0x0000d43a:  movel %d0,%sp@-
0x0000d43c:  jsr 0xd404

----------------
IN:
0x0000d404:  071400

INT      1: Unassigned(0xf4) pc=0000d404 sp=00393e60 sr=2700
INT      2: Access Fault(0x8) pc=00000000 sp=00393e58 sr=2700
            ssw:  00000506 ea:   00000000 sfc:  5    dfc: 5

----------------
IN:
0x0000280c:  clrl %sp@-
0x0000280e:  pea 0xffffffffffffffff
0x00002812:  movel %d0,%sp@-
0x00002814:  moveml %d1-%d5/%a0-%a2,%sp@-
0x00002818:  movel %sp,%d0
0x0000281a:  andil #-8192,%d0
0x00002820:  moveal %d0,%a2
0x00002822:  moveal %a2@,%a2
0x00002824:  movel %sp,%sp@-
0x00002826:  bsrl 0x557c

----------------
IN: buserr_c
0x0000557c:  subql #4,%sp
0x0000557e:  moveml %d2-%d7/%a3-%fp,%sp@-
0x00005582:  moveal %sp@(48),%a3
0x00005586:  btst #5,%a3@(44)
0x0000558c:  bnes 0x5592

...

----------------
IN: panic
0x0002c956:  moveal 0x39503c,%a0
0x0002c95c:  moveq #101,%d1
0x0002c95e:  subql #1,%d1
0x0002c960:  bnes 0x2c9c6

objdump -S gives:

0000d404 <nf_get_id_phys>:
    d404:       7300            mvsb %d0,%d1
    d406:       4e75            rts

Instruction which exists in the disas code, but doesn't seem
tcg-implemented:

disas/m68k.c:3654:{"mvsb", 2,   one(0070400),   one(0170700), "*bDd",
mcfisa_b },

> 
> The mirror to use is: http://ftp.ports.debian.org/debian-ports/
> when it fails, continue without boot loader.
> 
> In the same way, you can extract the kernel and the initramfs from the qcow2
> image to use it with "-kernel" and "-initrd":
> 
> guestfish --add m68k.qcow2 --mount /dev/sda2:/ <<_EOF_
> copy-out /boot/vmlinux-4.15.0-2-m68k .
> copy-out /boot/initrd.img-4.15.0-2-m68k .
> _EOF_
> 
> and boot with:
> 
>    ...
>    -append "root=/dev/sda2 rw console=ttyS0 console=tty \
>    -kernel vmlinux-4.15.0-2-m68k \
>    -initrd initrd.img-4.15.0-2-m68k
