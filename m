Received: from eggs.gnu.org ([209.51.188.92]:40070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glX1z-0007sB-Ry
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glX1z-0001Xi-5G
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:42:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glX1y-0001XI-Vg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:42:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so22725684wrt.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:42:14 -0800 (PST)
References: <20190118183603.24757-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <07b9dbc7-e48d-adf7-d9cc-dc64de89e9d0@redhat.com>
Date: Mon, 21 Jan 2019 11:42:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190118183603.24757-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org

On 1/18/19 7:36 PM, Peter Maydell wrote:
> In virtio_balloon_get_config() we initialize a struct virtio_balloon_config
> which we then copy to guest memory. However, the local variable is not
> zero initialized. This works OK at the moment because we initialize
> all the fields in it; however an upcoming kernel header change will
> add some new fields. If we don't zero out the whole struct then we
> will start leaking a small amount of the contents of QEMU's stack
> to the guest as soon as we update linux-headers/ to a set of headers
> that includes the new fields.

Is it worth Cc'ing qemu-stable@?

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> It looks like none of the other virtio devices have this bug.
> Tested with "make check" only.
> As the commit message notes, must go in before our next headers update.
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
> 
