Received: from eggs.gnu.org ([2001:4830:134:3::10]:52186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTGk2-0008BW-78
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTGjz-0000rG-3W
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cTGjy-0000qt-TT
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:07 -0500
References: <20170112114612.14520-1-stefanha@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <47c3dbde-9ac2-31e1-4c06-a99d382a2160@redhat.com>
Date: Tue, 17 Jan 2017 00:31:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170112114612.14520-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio: revert
 virtio_queue_set_notification() nesting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Doug Goldstein <cardoe@cardoe.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/12/17 12:46, Stefan Hajnoczi wrote:
> The virtio_queue_set_notification() nesting introduced for AioContext polling
> raised an assertion with virtio-net (even in non-polling mode).  Converting
> virtio-net and virtio-crypto to use virtio_queue_set_notification() in a
> nesting fashion would be invasive and isn't worth it.
> 
> Patch 1 contains the revert to resolve the bug that Doug noticed.
> 
> Patch 2 is a less efficient but safe alternative.
> 
> Stefan Hajnoczi (2):
>   Revert "virtio: turn vq->notification into a nested counter"
>   virtio: disable notifications again after poll succeeded
> 
>  hw/virtio/virtio.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 

I confirm that with current master
(2ccede18bd24fce5db83fef3674563a1f256717b), my TCG aarch64 guest,
running ArmVirtQemu UEFI firmware, crashes with the following assertion
failure:

qemu-system-aarch64: .../hw/virtio/virtio.c:215:
virtio_queue_set_notification: Assertion `vq->notification_disabled > 0'
failed.

This guest does not use iPXE's UEFI SNP driver for virtio-net, instead
it uses OVMF's own, built-in VirtioNetDxe driver.

With both patches applied, everything works fine. The assertion failure
is gone, and I could ping a public host from the UEFI shell command line.

Tested-by: Laszlo Ersek <lersek@redhat.com>

I'm unsure if my use case covers polling mode, so it might be prudent to
add the tag to patch #1 only. I set the breakpoint that you gave Doug
(using "virsh start --paused" + attaching GDB to the running QEMU
process, before the firmware got any chance to execute), and the
breakpoint (virtio_queue_host_notifier_aio_poll_begin) didn't fire
during the test.

Thanks!
Laszlo
