Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5GfF-0006NA-9V
	for qemu-devel@nongnu.org; Mon, 01 May 2017 15:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5GfC-0005yr-1k
	for qemu-devel@nongnu.org; Mon, 01 May 2017 15:07:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57676
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d5GfB-0005yX-Q8
	for qemu-devel@nongnu.org; Mon, 01 May 2017 15:07:13 -0400
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
	<9d55b0bb-3d76-4b63-52d3-9f7df1003806@ilande.co.uk>
	<1492787538720.44490@epfl.ch>
	<c8006ea5-9a10-9edd-7bfd-04359bfbd235@ilande.co.uk>
	<1492904528362.73566@epfl.ch>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <77bc50a0-5f3a-4d6e-32af-9db38587cfb0@ilande.co.uk>
Date: Mon, 1 May 2017 20:06:45 +0100
MIME-Version: 1.0
In-Reply-To: <1492904528362.73566@epfl.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 23/04/17 00:42, Ajallooiean Hossein wrote:

Hi Ajallooiean,

> Hi Mark,
> 
> Thanks a lot for this. - it did work! 
> 
> So, now im wondering how did you install the iso on disk?
> 
> would you mind sharing your command line for the install please? and hacks if any

I simply went for something along the lines of:

./qemu-system-sparc64 -hda deb90.qcow2 -cdrom
debian-9.0-sparc64-NETINST-1.iso -boot d -nographic

i.e. no virtio devices and using the in-built device emulation. I do
have some alpha patches that add virtio support to OpenBIOS but they are
definitely not ready for production yet.

> i am now able to install and boot, but my boot hang after this line "[   22.559491] [TTM] Initializing pool allocator" - inside user space. - I did blacklist bochs_drm for installing as such "-append 'modprobe.blacklist=bochs_drm'".

Once I installed the image, I restarted QEMU as normal but this time
booting from the qcow2 image i.e.

./qemu-system-sparc64 -hda deb90.qcow2 -cdrom
debian-9.0-sparc64-NETINST-1.iso -nographic

Then at the SILO "boot: " prompt I typed:

Linux modprobe.blacklist=bochs_drm

That got me to a terminal login at which point I created the following
file as /etc/modprobe.d/bochs_drm.conf:

blacklist bochs_drm

I then did an update-initramfs rebooted as normal, since with the module
blacklisted there is no need to enter any custom parameters at the SILO
boot prompt and I can simply hit Enter.

> also, i have a couple of questions if you dont mind responding to them. - ill appreciate this a lot:
> 1- did you use virtio for your install? i.e. not using the "-cdrom" command and blacklisting the pata_cmd64x and also providing your own virtio device (/dev/vdb)?
>     - i used this link for hints on how to install with virtio http://tyom.blogspot.ch/2013/03/debiansparc64-wheezy-under-qemu-how-to.html

No, I just used the slower in-built CDROM emulation.

> 2- i see that you used ext3 for your OS install, isnt that slower than ext4? -again im referencing this: http://tyom.blogspot.ch/2013/03/virtio-performance-and-filesystems.html

>From memory the installer insisted that /boot needed to be an ext3
partition in order to work with SILO which is why I chose it.

> 3- also, im noticing that you didnt define root=/dev/sda or root=/dev/vda1 for when your running qemu. and when im running your image i have to do that, otherwise ill get to the initramfs only. is there a trick behind this?

No, it just seems to work for me with the inbuilt CDROM? However if you
switch to using my image with virtio then you'll have to tweak
/etc/fstab to use /dev/vda* rather than /dev/sda* devices and rebuild
the initramfs once again.

> 4- i dont see you defining a kernel and initrd? is there a reason for this? if i just use your cmd line, ill get this: also, are you extracting the kernel and initrd from the image or the iso?
> 
> OpenBIOS for Sparc64
> Configuration device id QEMU version 1 machine id 0
> kernel cmdline 
> CPUs: 1 x SUNW,UltraSPARC-IIi
> UUID: 00000000-0000-0000-0000-000000000000
> Welcome to OpenBIOS v1.1 built on Mar 15 2017 19:37
>   Type 'help' for detailed information
> Trying disk:a...
> Not a bootable ELF image
> Loading a.out image...
> Loaded 7680 bytes
> entry point is 0x4000
> SILO Version 1.4.14
> boot: 

Right - all you need to do here is hit Enter and boot will continue.
Since I'm not using virtio I'm letting SILO do the work here. Once
you've blacklisted bochs_drm and rebuilt the initramfs with everything
setup then you should be able to copy them from the resulting image and
boot them directly in QEMU using -kernel and -initrd.


ATB,

Mark.
