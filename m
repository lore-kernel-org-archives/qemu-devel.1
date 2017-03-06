Received: from eggs.gnu.org ([2001:4830:134:3::10]:56203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckp59-0006N2-EP
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckp58-0000Nk-Ka
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:37:31 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckp58-0000M8-DH
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:37:30 -0500
Received: by mail-wr0-x230.google.com with SMTP id g10so112038973wrg.2
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 01:37:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJy91CaOxWeGAnpSU8ETpbaWQCdp6W6heYTcr5qtKQjE9qQh5g@mail.gmail.com>
References: <CAJy91CaOxWeGAnpSU8ETpbaWQCdp6W6heYTcr5qtKQjE9qQh5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 09:37:07 +0000
Message-ID: <CAFEAcA8w3JXfqv6Td9rz3d9f1FMjA6QtpzkW0MgD+XcqH8ajyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] versatilepb cannot load roofs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 March 2017 at 07:57, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> Dear QEMU developers,
>
> I have a problem when running qemu to build a system with versatilepb,
> linux zImage and rootfs. the qemu cmdl is as follows.
>
> ../qemu/build/arm-softmmu/qemu-system-arm.exe -M versatilepb -kernel zImage
> -dtb versatile-pb.dtb -initrd ramfs.gz -nographic -append "console=ttyAMA0
> root=/dev/ram0"
>
> However, the running result is the same as the case without the initrd
> file, which is "Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(1,0)".
>
> The kernel is configured with versatile_defconfig, ramfs.gz is created by
> busybox 1.25.1. I am using QEMU 2.8.50 and Linux 4.7. I've also tried with
> Linux 2.6.35 and 3.2.8, and still versatilepb gives this kernel panic.

> No filesystem could mount root, tried:  ext2 cramfs minix romfs
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(1,0)


This is a guest configuration error, not a QEMU bug. The kernel
message means "I found the root device, but I did not recognize
its contents as one of the above filesystem types". Probably
the thing you are trying to use as an initrd is something
like a compressed cpio archive, not an actual filesystem that
you can pass to root=. You need to either fix what you're using
to create the initrd or you need to fix the kernel command line
so you don't try to use it as a root device. (Usually an initrd
isn't the root= device, unless you've constructed it specially
for that purpose.)

thanks
-- PMM
