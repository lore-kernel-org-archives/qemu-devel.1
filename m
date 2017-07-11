Received: from eggs.gnu.org ([2001:4830:134:3::10]:35163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUqpV-0004Bg-9W
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUqpP-00062D-8r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:47:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUqpP-00061v-2O
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:47:31 -0400
Date: Tue, 11 Jul 2017 10:47:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711104724.1c929a76@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499700760-4777-7-git-send-email-thuth@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-7-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/10] pc-bios/s390-ccw: Add code for
 virtio feature negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Mon, 10 Jul 2017 17:32:36 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The upcoming virtio-net driver needs to negotiate some features,
> so we need the possibility to do this in the core virtio code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/s390-ccw.h      |  2 ++
>  pc-bios/s390-ccw/virtio-blkdev.c |  3 ++-
>  pc-bios/s390-ccw/virtio.c        | 25 ++++++++++++++++++-------
>  pc-bios/s390-ccw/virtio.h        |  2 +-
>  4 files changed, 23 insertions(+), 9 deletions(-)
> 

> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 6cb77bc..ed4026f 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -266,9 +266,10 @@ uint64_t virtio_get_blocks(void)
>  void virtio_blk_setup_device(SubChannelId schid)
>  {
>      VDev *vdev = virtio_get_device();
> +    uint32_t guestfeats[2] = { 0, 0 };
>  
>      vdev->schid = schid;
> -    virtio_setup_ccw(vdev);
> +    virtio_setup_ccw(vdev, guestfeats);

I'd tack the feature bits onto the VDev instead. Even if you're not
doing anything fancy right now, it makes validating the feature bits
more straightforward.

>  
>      switch (vdev->senseid.cu_model) {
>      case VIRTIO_ID_BLOCK:
