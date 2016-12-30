Received: from eggs.gnu.org ([2001:4830:134:3::10]:46533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cN1lt-0001B6-Fv
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cN1lp-0001mM-9z
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:19:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:35838
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cN1lp-0001lo-3N
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:19:13 -0500
References: <bd0ad06c-1dce-03c9-73b0-d8d6e4ca333b@roeck-us.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4b04ec32-b647-5047-7830-269cfc217550@ilande.co.uk>
Date: Fri, 30 Dec 2016 18:18:56 +0000
MIME-Version: 1.0
In-Reply-To: <bd0ad06c-1dce-03c9-73b0-d8d6e4ca333b@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Problems with qemu "modern" virtio on sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, "qemu-devel@nongnu.org >> QEMU Developers" <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 25/11/16 18:11, Guenter Roeck wrote:

> Hi,
> 
> I am using virtio on sparc64 for my Linux kernel runtime tests.
> 
> Starting with qemu v2.7, I noticed that the kernel either gets stuck or
> crashes.
> After adding some debug information to the kernel, I found that the
> problem happens
> in vp_reset().
> 
> Interestingly, when running v4.9-rc6 without modification, the kernel
> crashes on me.
> If I add pr_info just before and after the vp_iowrite8() in
> virtio_pci_modern.c:vp_reset(),
> the kernel gets stuck in the vp_iowrite8().
> 
> Here is the relevant part of the crash:
> 
> [    3.151167] Unable to handle kernel NULL pointer dereference
> [    3.151809] tsk->{mm,active_mm}->context = 0000000000000000
> [    3.152430] tsk->{mm,active_mm}->pgd = fffff80000402000
> [    3.153032]               \|/ ____ \|/
> [    3.153032]               "@'/ .. \`@"
> [    3.153032]               /_| \__/ |_\
> [    3.153032]                  \__U_/
> [    3.154042] swapper(1): Oops [#1]
> [    3.154773] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc5+ #4
> [    3.155375] task: fffff8001f0af620 task.stack: fffff8001f0b0000
> [    3.155958] TSTATE: 0000009980001606 TPC: 00000000006edf44 TNPC:
> 00000000006edf48 Y: 00000000    Not tainted
> [    3.156901] TPC: <vp_reset+0x4/0x40>
> 
> None of the pointers used in vp_reset() is NULL. As mentioned above,
> adding a pr_info
> just before vp_iowrite8() makes the crash disappear and the kernel is
> stuck instead.
> Here is how it looks like:
> 
> [    3.104243] Hi there
> [   26.912509] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
> [swapper:1]
> [   26.913102] Modules linked in:
> [   26.914061] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc5+ #5
> [   26.914633] task: fffff8001f0af620 task.stack: fffff8001f0b0000
> [   26.915156] TSTATE: 0000004480001605 TPC: 00000000006edf50 TNPC:
> 00000000006edf54 Y: 00000412    Not tainted
> [   26.915954] TPC: <vp_reset+0x10/0x60>
> 
> Another pr_info() after vp_iowrite8() is never printed, suggesting that
> the code never
> gets to that point.
> 
> The kernel configuration is sparc64_defconfig with the following
> configuration
> options enabled.
> 
> CONFIG_DEVTMPFS=y
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_SCSI_VIRTIO=y
> 
> Command line is
> 
> qemu-system-sparc64 -M sun4u -cpu "TI UltraSparc IIi" -m 512 \
>     -drive file=simple-root-filesystem-sparc.ext3,if=virtio,format=raw \
>     -kernel arch/sparc/boot/image -no-reboot \
>     -append "root=/dev/vda init=/sbin/init.sh console=ttyS0" \
>     -nographic -monitor none
> 
> Does anyone have an idea what might be wrong ?
> 
> Thanks,
> Guenter

Hi Guenter,

Have you been able to investigate this issue any further? Does the 2.8
release solve the issue for you?


ATB,

Mark.
