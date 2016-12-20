Received: from eggs.gnu.org ([2001:4830:134:3::10]:52033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cJIEA-0000Q5-De
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cJIE5-0003gU-CC
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:05:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cJIE5-0003fa-6r
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:04:57 -0500
Date: Tue, 20 Dec 2016 16:34:42 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20161214070156.23368-1-ppandit@redhat.com>
Message-ID: <alpine.LFD.2.20.1612201632530.28158@wniryva>
References: <20161214070156.23368-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Zhenhao Hong <zhenhaohong@gmail.com>, =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

+-- On Wed, 14 Dec 2016, P J P wrote --+
| From: Prasad J Pandit <pjp@fedoraproject.org>
| 
| Virtio GPU device while processing 'VIRTIO_GPU_CMD_GET_CAPSET'
| command, retrieves the maximum capabilities size to fill in the
| response object. It continues to fill in capabilities even if
| retrieved 'max_size' is zero(0), thus resulting in OOB access.
| Add check to avoid it.
| 
| Reported-by: Zhenhao Hong <zhenhaohong@gmail.com>
| Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| ---
|  hw/display/virtio-gpu-3d.c | 6 +++++-
|  1 file changed, 5 insertions(+), 1 deletion(-)
| 
| diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
| index 758d33a..6ceeba3 100644
| --- a/hw/display/virtio-gpu-3d.c
| +++ b/hw/display/virtio-gpu-3d.c
| @@ -370,8 +370,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
|  
|      virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
|                                 &max_size);
| +    if (!max_size) {
| +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
| +        return;
| +    }
| +
|      resp = g_malloc(sizeof(*resp) + max_size);
| -
|      resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
|      virgl_renderer_fill_caps(gc.capset_id,
|                               gc.capset_version,
| 

Ping..!
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
