Received: from eggs.gnu.org ([2001:4830:134:3::10]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cGlcB-0007JX-An
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cGlc7-0001oG-0q
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:51:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cGlc6-0001o2-R2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:51:18 -0500
Date: Tue, 13 Dec 2016 17:20:51 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <1481627861.27088.116.camel@redhat.com>
Message-ID: <alpine.LFD.2.20.1612131703450.6298@wniryva>
References: <20161213071439.32322-1-ppandit@redhat.com>
	<1481627861.27088.116.camel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>

   Hello Gerd,

+-- On Tue, 13 Dec 2016, Gerd Hoffmann wrote --+
| On Di, 2016-12-13 at 12:44 +0530, P J P wrote:
| > From: Prasad J Pandit <pjp@fedoraproject.org>
| > 
| > Virtio GPU device while processing 'VIRTIO_GPU_CMD_GET_CAPSET'
| > command, retrieves the maximum capabilities size to fill in the
| > response object. It continues to fill in capabilities even if
| > retrieved 'max_size' is zero(0), thus resulting in OOB access.
| > Add check to avoid it.
| 
| Hmm?  Did you see this happing in practice?

  Yes, there is a reproducer from Zhenhao.
 
| > diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
| > index 758d33a..fbfb39f 100644
| > --- a/hw/display/virtio-gpu-3d.c
| > +++ b/hw/display/virtio-gpu-3d.c
| > @@ -371,11 +371,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
| >      virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
| >                                 &max_size);
| 
| This is not the guest returning the size, it is the host renderer
| library saying how much space it needs ...

  The library funcion checks 'capset_id' supplied via the 'cmd' object, as 
'gc' is initialised from a given command 'cmd'. It sets 'max_size=0' if 
capset_id != VREND_CAP_SET.

VIRTIO_GPU_FILL_CMD(gc)
virgl_renderer_get_cap_set(gc.capset_id
 -> vrend_renderer_get_cap_set
  -> https://cgit.freedesktop.org/~airlied/virglrenderer/tree/src/vrend_renderer.c#n6280
   if (cap_set != VREND_CAP_SET) {
      *max_ver = 0;
      *max_size = 0;
      return;
   }

| > -    virgl_renderer_fill_caps(gc.capset_id,
| > -                             gc.capset_version,
| > -                             (void *)resp->capset_data);
| 
| ... and here the renderer fills the qemu-allocated space with the actual
| data.
| 
| Can't see anything wrong here.

  IIUC,  when max_size=0, g_malloc allocates memory for the 'resp' object, 
with sizeof(capset_data)=0. But 'virgl_renderer_fill_caps' would try to fill 
in upto sizeof(union virgl_caps).

  -> https://cgit.freedesktop.org/~airlied/virglrenderer/tree/src/vrend_renderer.c#n5940


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
