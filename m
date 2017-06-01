Received: from eggs.gnu.org ([2001:4830:134:3::10]:54527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGRyj-0000uT-BX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGRye-0000Ns-TC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:25:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGRye-0000Na-Nd
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:25:32 -0400
Date: Thu, 1 Jun 2017 18:25:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170601182513-mutt-send-email-mst@kernel.org>
References: <1496328687-13121-1-git-send-email-indiffPig@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496328687-13121-1-git-send-email-indiffPig@126.com>
Subject: Re: [Qemu-devel] [PATCH] vhost_dev:qemu will quit when vhost_dev is
 null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: indiffPig@126.com
Cc: qemu-devel@nongnu.org, "yin.zuowei" <cxasm@qq.com>

On Thu, Jun 01, 2017 at 10:51:27AM -0400, indiffPig@126.com wrote:
> From: "yin.zuowei" <cxasm@qq.com>
> 
> Signed-off-by: yin.zuowei <cxasm@qq.com>
> 
> when ovdk socket is not ok, this vhost_dev is null ,then qemu will be quit.
> We think ovdk is just a network devices, should not cause an exit .


It is called like this:
    if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
        return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
    }

so how can it be NULL?


> ---
>  hw/virtio/vhost-user.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index dde094a..3a9fdf4 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -387,6 +387,9 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
>  static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>  {
>      int i;
> +    if (!dev) {
> +        return -1;
> +    }
>  
>      if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
>          return -1;
> -- 
> 1.8.3.1
> 
