Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dulgR-0006YF-NK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dulgM-0003eM-Uf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:33:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dulgM-0003dF-OD
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:33:18 -0400
Date: Wed, 20 Sep 2017 16:33:13 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <387632394.19220996.1505939593128.JavaMail.zimbra@redhat.com>
In-Reply-To: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
References: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio/vhost: reset dev->log after syncing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> vhost_log_put() is called to decomission the dirty log between qemu and
> a vhost device when stopping the device. Such a call can happen from
> migration_completion().
> 
> Present code sets dev->log_size to zero too early in vhost_log_put(),
> causing the sync check to always return false. As a consequence, the
> last pass on the dirty bitmap never happens at the end of migration.
> 
> If a vhost device was busy (writing to guest memory) until the last
> moments before vhost_virtqueue_stop(), this error will result in guest
> memory corruption (at least) following migrations.
> 
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  hw/virtio/vhost.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 5fd69f0..ddc42f0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -375,8 +375,6 @@ static void vhost_log_put(struct vhost_dev *dev, bool
> sync)
>      if (!log) {
>          return;
>      }
> -    dev->log = NULL;
> -    dev->log_size = 0;
>  


Good catch. This reminds me of another patch, but I can't find it.

What if we replace dev->log_size with log->size below? 

(and I don't see a clear reason why dev->log_size would be different from "log ? log->size : 0", am I missing something?)

>      --log->refcnt;
>      if (log->refcnt == 0) {
> @@ -396,6 +394,9 @@ static void vhost_log_put(struct vhost_dev *dev, bool
> sync)
>  
>          g_free(log);
>      }
> +
> +    dev->log = NULL;
> +    dev->log_size = 0;

>  }
>  
>  static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
> --
> 1.7.1
> 
> 
