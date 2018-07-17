Received: from eggs.gnu.org ([2001:4830:134:3::10]:46064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffM3M-0004cS-Fw
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffM3J-0001xE-CH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:13:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ffM3J-0001x0-6q
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:13:49 -0400
Date: Tue, 17 Jul 2018 11:13:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180717111340.4c0a936a.cohuck@redhat.com>
In-Reply-To: <20180716173743.133393-4-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
	<20180716173743.133393-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 3/4] virtio-scsi/migration: Allow
 load_request to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

On Mon, 16 Jul 2018 18:37:42 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Rather than asserting, check values and return NULL
> on failure.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 6301af76ad..3441bfe6d7 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -204,7 +204,11 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
>      uint32_t n;
>  
>      qemu_get_be32s(f, &n);
> -    assert(n < vs->conf.num_queues);
> +    if (n >= vs->conf.num_queues) {
> +        error_report("%s: Bad queue number (%d vs %d)",
> +                     __func__, n, vs->conf.num_queues);

Hm... "(%d, num_queues %d)" might be a bit clearer?

> +        return NULL;
> +    }
>      req = qemu_get_virtqueue_element(vdev, f,
>                                       sizeof(VirtIOSCSIReq) + vs->cdb_size);
>      if (!req) {

Still,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
