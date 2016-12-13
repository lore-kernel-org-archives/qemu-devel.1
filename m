Received: from eggs.gnu.org ([2001:4830:134:3::10]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cGkgr-0000pP-0T
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cGkgn-0005dk-5d
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:52:09 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:37245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1cGkgm-0005bx-TY
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:52:05 -0500
Date: Tue, 13 Dec 2016 05:52:01 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <995759159.4566665.1481626321833.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161213071439.32322-1-ppandit@redhat.com>
References: <20161213071439.32322-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>


> 
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Virtio GPU device while processing 'VIRTIO_GPU_CMD_GET_CAPSET'
> command, retrieves the maximum capabilities size to fill in the
> response object. It continues to fill in capabilities even if
> retrieved 'max_size' is zero(0), thus resulting in OOB access.
> Add check to avoid it.
> 
> Reported-by: Zhenhao Hong <zhenhaohong@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/virtio-gpu-3d.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 758d33a..fbfb39f 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -371,11 +371,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>      virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
>                                 &max_size);
>      resp = g_malloc(sizeof(*resp) + max_size);
> -
> -    resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
> -    virgl_renderer_fill_caps(gc.capset_id,
> -                             gc.capset_version,
> -                             (void *)resp->capset_data);
> +    if (max_size) {
> +        resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
> +        virgl_renderer_fill_caps(gc.capset_id,
> +                                 gc.capset_version,
> +                                 (void *)resp->capset_data);
> +    }
>      virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + max_size);

Just one point here for 'max_size=0', do we don't require to set resp->hdr.type?
If yes,  other patch on list by 'Li Qiang' can also help to avoid sending garbage value.

>      g_free(resp);
>  }
> --
> 2.9.3
> 
> 
> 
