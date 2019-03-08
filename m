Received: from eggs.gnu.org ([209.51.188.92]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2Mqy-0006s5-5C
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2Mqx-0006LA-DK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:16:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h2Mqx-0006Kk-5T
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:16:27 -0500
Date: Fri, 8 Mar 2019 14:16:23 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190308141623.566cfda4@x1.home>
In-Reply-To: <cd99a2cc-a7e8-ef80-69b3-2082d28a3352@oracle.com>
References: <20190222054939.19739-1-kraxel@redhat.com>
	<20190222054939.19739-4-kraxel@redhat.com>
	<cd99a2cc-a7e8-ef80-69b3-2082d28a3352@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] vfio/display: delay link up event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org

On Fri, 22 Feb 2019 11:19:11 +0000
Liam Merwick <liam.merwick@oracle.com> wrote:

> On 22/02/2019 05:49, Gerd Hoffmann wrote:
> > Kick the display link up event with a 0.1 sec delay,
> > so the guest has a chance to notice the link down first.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>  
> 
> Depending on your thoughts on the suggestion in patch 1 regarding a 
> comment at the 'err' label - another candidate in 
> vfio_display_edid_link_up().

This would also get the following fixup rolled in.  Thanks,

Alex

 hw/vfio/display.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index e8f312dc3308..a3d9c8f5beac 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -44,7 +44,9 @@ static void vfio_display_edid_link_up(void *opaque)
     int fd = vdev->vbasedev.fd;
 
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
-    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
+    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
+        goto err;
+    }
     trace_vfio_display_edid_link_up();
     return;
 
