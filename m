Received: from eggs.gnu.org ([209.51.188.92]:58750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghyKL-0002aB-Sp
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghyKJ-0001cd-Sx
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:02:29 -0500
Date: Fri, 11 Jan 2019 16:02:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111150213.GK5010@dhcp-200-186.str.redhat.com>
References: <cover.1547132561.git.berto@igalia.com>
	<42c8dab1efbcd608a09a1d84468fc498b612bfa1.1547132561.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c8dab1efbcd608a09a1d84468fc498b612bfa1.1547132561.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] block: Acquire the AioContext in
 scsi_*_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 10.01.2019 um 16:03 hat Alberto Garcia geschrieben:
> This fixes the following crash:
> 
> { "execute": "blockdev-add",
>   "arguments": {"driver": "null-co", "node-name": "hd0"}}
> { "execute": "object-add",
>   "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> { "execute": "x-blockdev-set-iothread",
>   "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
> { "execute": "device_add",
>    "arguments": {"id": "scsi-pci0", "driver": "virtio-scsi-pci"}}
> { "execute": "device_add",
>   "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> qemu: qemu_mutex_unlock_impl: Operation not permitted
> Aborted
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

> @@ -2553,6 +2563,7 @@ static int get_device_type(SCSIDiskState *s)
>  static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>  {
>      SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
> +    AioContext *ctx;
>      int sg_version;
>      int rc;
>  
> @@ -2568,7 +2579,10 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>      }
>  
>      /* check we are using a driver managing SG_IO (version 3 and after) */
> +    ctx = blk_get_aio_context(s->qdev.conf.blk);
> +    aio_context_acquire(ctx);
>      rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
> +    aio_context_release(ctx);
>      if (rc < 0) {
>          error_setg_errno(errp, -rc, "cannot get SG_IO version number");
>          if (rc != -EPERM) {

This is probably not enough. get_device_type() and
scsi_generic_read_device_inquiry() below issue more ioctls (but we need
to be careful not to include the scsi_realize() call in the locked
section if you take the lock again there).

Kevin
