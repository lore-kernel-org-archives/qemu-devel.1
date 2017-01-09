Received: from eggs.gnu.org ([2001:4830:134:3::10]:54206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQZh7-0004PR-48
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQZh3-0008AN-Pn
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQZh3-0008A7-Jc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:08:57 -0500
Date: Mon, 9 Jan 2017 13:08:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170109130852.GE2541@work-vm>
References: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
Subject: Re: [Qemu-devel] assert hit on master with q35 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, Doug Goldstein <cardoe@cardoe.com>
Cc: qemu-devel@nongnu.org

copying in Stefan since it's his commit.

* Doug Goldstein (cardoe@cardoe.com) wrote:
> I'm currently hitting an assert on master. I've bisected the change down
> to aff8fd18f1786fc5af259a9bc0077727222f51ca but obviously that's a false
> positive because that adds the assert for the condition. So obviously
> the issue was introduced prior to this. As another data point the issue
> only occurs with q35 machines and will only happen with pc-q35-2.7 and
> pc-q35-2.8 (and obviously the aliased q35). If I use pc-q35-2.6 it does
> not hit.
> 
> The message is: qemu-system-x86_64:
> /home/doug/work/qemu/hw/virtio/virtio.c:214:
> virtio_queue_set_notification: Assertion `vq->notification_disabled > 0'
> failed.
> 
> But that clearly just shows its the assert that was added in that
> commit. To create the machine I use the following command line:
> 
> ./work/qemu/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -M pc-q35-2.8
> -device intel-iommu -cpu host -m 2048 -smp 2 -drive
> if=pflash,format=raw,file=/tmp/tmp.Sno2BP3saP -global
> isa-debugcon.iobase=0x402 -debugcon file:/tmp/tmp.KCrwM98Mus -monitor
> stdio -chardev socket,host=127.0.0.1,port=4455,id=S0,server,nowait
> -device isa-serial,chardev=S0 -device piix3-usb-uhci -device usb-tablet
> -netdev id=net0,type=tap -device virtio-net-pci,netdev=net0 -boot
> order=n -device qxl-vga -gdb tcp::1234
> 
> It happens almost right away. Let me know how I can help track this down
> further.
> 
> Thanks.
> -- 
> Doug Goldstein
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
