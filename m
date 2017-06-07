Received: from eggs.gnu.org ([2001:4830:134:3::10]:36838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIW43-00024A-Tb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIW43-00012x-4L
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:11:39 -0400
Date: Wed, 7 Jun 2017 16:11:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170607081129.GA4314@lemon.lan>
References: <20170524025235.32190-1-famz@redhat.com>
	<20170524025235.32190-12-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524025235.32190-12-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/16] virtio-scsi: Request
 BLK_PERM_AIO_CONTEXT_CHANGE for dataplane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, 05/24 10:52, Fam Zheng wrote:
> blk_set_aio_context is audited by perm API, so follow the protocol and
> request for permission first.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 46a3e3f..074e235 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -794,6 +794,10 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>              return;
>          }
>          virtio_scsi_acquire(s);
> +        if (!blk_request_perm(sd->conf.blk, BLK_PERM_AIO_CONTEXT_CHANGE, errp)) {

Inversed condition, should be s/!//.

Fam

> +            virtio_scsi_release(s);
> +            return;
> +        }
>          blk_set_aio_context(sd->conf.blk, s->ctx);
>          virtio_scsi_release(s);
>  
> -- 
> 2.9.4
> 
> 
