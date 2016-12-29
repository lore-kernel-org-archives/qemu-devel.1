Received: from eggs.gnu.org ([2001:4830:134:3::10]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cMc9K-0003IX-0d
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 09:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cMc9H-0007zE-13
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 09:57:46 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:45976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cMc9G-0007zA-Ou
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 09:57:42 -0500
Date: Thu, 29 Dec 2016 09:57:25 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1767808401.7524716.1483023445359.JavaMail.zimbra@redhat.com>
In-Reply-To: <1483003721-65360-1-git-send-email-liq3ea@gmail.com>
References: <1483003721-65360-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix memory leak in resource
 attach backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: kraxel@redhat.com, marcandre lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, liqiang6-s@360.cn

Hi

----- Original Message -----
> In the resource attach backing function, everytime it will
> allocate 'res->iov' thus can leading a memory leak. This
> patch avoid this.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/display/virtio-gpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f32e1a..045f296 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -705,6 +705,11 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>          return;
>      }
>  
> +    if (res->iov) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +        return;
> +    }
> +

I think I would rather return an error in the library for this case.

>      ret = virtio_gpu_create_mapping_iov(&ab, cmd, &res->addrs, &res->iov);
>      if (ret != 0) {
>          cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> --
> 1.8.3.1
> 
> 
