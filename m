Received: from eggs.gnu.org ([2001:4830:134:3::10]:58252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6E7f-0002fX-PR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6E7e-0005Mh-UQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:36:35 -0400
References: <20170504102339.31971-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22096620-8f3b-88b2-3e6d-e40869b567c2@redhat.com>
Date: Thu, 4 May 2017 12:36:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170504102339.31971-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] aio: add missing aio_notify() to
 aio_enable_external()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>



On 04/05/2017 12:23, Stefan Hajnoczi wrote:
> The main loop uses aio_disable_external()/aio_enable_external() to
> temporarily disable processing of external AioContext clients like
> device emulation.
> 
> This allows monitor commands to quiesce I/O and prevent the guest from
> submitting new requests while a monitor command is in progress.
> 
> The aio_enable_external() API is currently broken when an IOThread is in
> aio_poll() waiting for fd activity when the main loop re-enables
> external clients.  Incrementing ctx->external_disable_cnt does not wake
> the IOThread from ppoll(2) so fd processing remains suspended and leads
> to unresponsive emulated devices.
> 
> This patch adds an aio_notify() call to aio_enable_external() so the
> IOThread is kicked out of ppoll(2) and will re-arm the file descriptors.
> 
> The bug can be reproduced as follows:
> 
>   $ qemu -M accel=kvm -m 1024 \
>          -object iothread,id=iothread0 \
>          -device virtio-scsi-pci,iothread=iothread0,id=virtio-scsi-pci0 \
>          -drive if=none,id=drive0,aio=native,cache=none,format=raw,file=test.img \
>          -device scsi-hd,id=scsi-hd0,drive=drive0 \
>          -qmp tcp::5555,server,nowait
> 
>   $ scripts/qmp/qmp-shell localhost:5555
>   (qemu) blockdev-snapshot-sync device=drive0 snapshot-file=sn1.qcow2
>          mode=absolute-paths format=qcow2
> 
> After blockdev-snapshot-sync completes the SCSI disk will be
> unresponsive.  This leads to request timeouts inside the guest.

I agree this is the minimal fix and is the right thing to do.  The
bdrv_drained_begin/end device callbacks would also make it possible to
remove disable/enable external altogether, but that's more invasive.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org

> Reported-by: Qianqian Zhu <qizhu@redhat.com>
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 406e323..5294b04 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -456,6 +456,7 @@ static inline void aio_enable_external(AioContext *ctx)
>  {
>      assert(ctx->external_disable_cnt > 0);
>      atomic_dec(&ctx->external_disable_cnt);
> +    aio_notify(ctx);
>  }
>  
>  /**
> 
