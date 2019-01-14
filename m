Received: from eggs.gnu.org ([209.51.188.92]:42536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjBYy-0003Rh-5Z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjBYx-00040a-Gv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:22:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjBYx-0003k0-AG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:22:35 -0500
Date: Mon, 14 Jan 2019 18:22:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114182210-mutt-send-email-mst@kernel.org>
References: <20181215120353.82786-1-liq3ea@163.com>
	<20181215120353.82786-3-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215120353.82786-3-liq3ea@163.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] vhost-user: fix ioeventfd_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org

On Sat, Dec 15, 2018 at 04:03:52AM -0800, Li Qiang wrote:
> Currently, the vhost-user-test assumes the eventfd is available.
> However it's not true because the accel is qtest. So the
> 'vhost_set_vring_file' will not add fds to the msg and the server
> side of vhost-user-test will be broken. The bug is in 'ioeventfd_enabled'.
> We should make this function return true if not using kvm accel.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2: change the fix in 'ioeventfd_enabled' per Paolo's review
> 
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index e09bed0e4a..564a31d12c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -207,7 +207,7 @@ struct vhost_user {
>  
>  static bool ioeventfd_enabled(void)
>  {
> -    return kvm_enabled() && kvm_eventfds_enabled();
> +    return !kvm_enabled() || kvm_eventfds_enabled();
>  }
>  
>  static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
> -- 
> 2.17.1
> 
> 
