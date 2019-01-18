Received: from eggs.gnu.org ([209.51.188.92]:52930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkZZL-0007bL-8d
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkZZJ-000217-4h
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:12:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gkZZH-0001xx-AD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:12:39 -0500
Date: Fri, 18 Jan 2019 14:12:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190118141143-mutt-send-email-mst@kernel.org>
References: <20190118183603.24757-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118183603.24757-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] hw/virtio/virtio-balloon: zero-initialize
 the virtio_balloon_config struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jan 18, 2019 at 06:36:03PM +0000, Peter Maydell wrote:
> In virtio_balloon_get_config() we initialize a struct virtio_balloon_config
> which we then copy to guest memory. However, the local variable is not
> zero initialized. This works OK at the moment because we initialize
> all the fields in it; however an upcoming kernel header change will
> add some new fields. If we don't zero out the whole struct then we
> will start leaking a small amount of the contents of QEMU's stack
> to the guest as soon as we update linux-headers/ to a set of headers
> that includes the new fields.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> It looks like none of the other virtio devices have this bug.
> Tested with "make check" only.
> As the commit message notes, must go in before our next headers update.

Want me to merge it? Or you can pick it up directly if you like
to make sure that happens.

> ---
>  hw/virtio/virtio-balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 1728e4f83af..a12677d4d5b 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -311,7 +311,7 @@ out:
>  static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  {
>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> -    struct virtio_balloon_config config;
> +    struct virtio_balloon_config config = {};
>  
>      config.num_pages = cpu_to_le32(dev->num_pages);
>      config.actual = cpu_to_le32(dev->actual);
> -- 
> 2.20.1
