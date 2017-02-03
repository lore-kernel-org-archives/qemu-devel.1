Received: from eggs.gnu.org ([2001:4830:134:3::10]:55276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZkyG-0001EW-Dj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZkyD-0000M0-61
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:00:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cZkyC-0000Lp-N7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:00:37 -0500
References: <c327fa49-67c4-5e01-29f8-cbe9c883e157@grammatech.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5dcfdc9f-c12d-1b21-8c32-227436e0d627@redhat.com>
Date: Fri, 3 Feb 2017 22:00:33 +0100
MIME-Version: 1.0
In-Reply-To: <c327fa49-67c4-5e01-29f8-cbe9c883e157@grammatech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU + OVMF, bootable linux image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Dickens <jdickens@grammatech.com>, qemu-devel@nongnu.org

On 02/03/17 19:20, Jason Dickens wrote:
> I am trying to create a raw Linux image that is bootable by QEMU using
> the OVMF firmware image.
> 
> Basically, I have used a standard Ubuntu ISO  and a empty raw image.
> Executing qemu-system-x86_64 with the ISO as CD and the other image as a
> hardrive I have been able to install Ubuntu on the image, no problem.
> 
> However, when trying to boot the created image I simply get the UEFI shell?
> 
> I've noticed the following:
> 
> 1. The ISO image which boots with OVMF in UEFI just fine has the
> following format (from fdisk):
> 
> Disk ubuntu-14.04.3-desktop-amd64.iso: 1006 MiB, 1054867456 bytes,
> 2060288 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x6a6216fc
> 
> Device                           Boot   Start     End Sectors Size Id Type
> ubuntu-14.04.3-desktop-amd64.iso1  *        0 2060287 2060288 1006M  0
> Empty
> ubuntu-14.04.3-desktop-amd64.iso2     2038760 2043303 4544 2.2M ef EFI
> (FAT-12/16/32)
> 
> 2. The image created by the linux install has the following(from fdisk):
> 
> Disk ovmf_test_image: 10 GiB, 10737418240 bytes, 20971520 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> Disk identifier: 36240C48-C008-4619-BE31-26D271000490
> 
> Device              Start      End  Sectors  Size Type
> ovmf_test_image1     2048  1050623  1048576  512M EFI System
> ovmf_test_image2  1050624 12584959 11534336  5.5G Linux filesystem
> ovmf_test_image3 12584960 20969471  8384512    4G Linux swap
> 
> 
> Can someone help me understand the format requirements to boot using
> OVMF in UEFI mode? Clearly these two images are dramatically different.
> However, I would expect #2 to be the more modern method and more likely
> to work? As for QEMU command I use literally the same command switching
> only between the file names to get the different results it looks
> something like this:
> 
> qemu-system-x86_64 -drive file=ovmf_test_image,format=raw -m 4G
> --bios.bin -net none

"something like this" is quite likely where the bug is.

I downloaded "ubuntu-14.04.3-desktop-amd64.iso". I also have Gerd's
build of OVMF installed. The RPM is called "edk2.git-ovmf-x64", and the
repository is at <http://www.kraxel.org/repos/> (see the instructions
there). Before running the test, I upgraded the package to
"20170126.b2442.gf1d91f3".

The following script works flawlessly for me. You can use the same
script both for installation and then to boot the installed guest.

------------------------
ISO=ubuntu-14.04.3-desktop-amd64.iso
IMG=ubuntu-14.04.3-desktop-amd64.img
VARS=ubuntu-14.04.3-desktop-amd64.vars
DBG=ubuntu-14.04.3-desktop-amd64.dbg
CODE=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd
TMPL=/usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd

if ! [ -e "$VARS" ]; then
  cp $TMPL "$VARS"
fi

if ! [ -e "$IMG" ]; then
  qemu-img create -f raw "$IMG" 20G
fi

qemu-system-x86_64 \
  \
  -machine accel=kvm \
  -m 4096 \
  \
  -drive if=pflash,readonly,format=raw,file=$CODE \
  -drive if=pflash,format=raw,file="$VARS" \
  \
  -drive id=disk,if=none,format=raw,file=$IMG \
  -drive id=cdrom,if=none,readonly,format=raw,file=$ISO \
  \
  -device virtio-scsi-pci,id=scsi0 \
  -device scsi-hd,bus=scsi0.0,drive=disk,bootindex=0 \
  -device scsi-cd,bus=scsi0.0,drive=cdrom,bootindex=1 \
  \
  -chardev file,id=debug,path="$DBG" \
  -device isa-debugcon,iobase=0x402,chardev=debug
------------------------

If you wish, after installation (and powering off the guest), you can
simply drop the two lines from the script that contain the word "cdrom";
the guest will remain bootable just the same.

In general, I strongly suggest using libvirt. The QEMU command line is
too complex if you don't know exactly what you are doing.

(I'm not being arrogant: the vast majority of the QEMU command line
options freak me out, so I insist on using libvirt even for my own
development purposes.)

HTH,
Laszlo
