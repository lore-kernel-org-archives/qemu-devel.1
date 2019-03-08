Received: from eggs.gnu.org ([209.51.188.92]:53794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2MpW-0005nY-2l
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2MpU-0005OH-KF
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:14:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h2MpU-0005NY-9R
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:14:56 -0500
Date: Fri, 8 Mar 2019 14:14:51 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190308141451.55976c7e@x1.home>
In-Reply-To: <e49ae948-5856-e9e2-7c87-76810a44da91@oracle.com>
References: <20190222054939.19739-1-kraxel@redhat.com>
	<20190222054939.19739-2-kraxel@redhat.com>
	<e49ae948-5856-e9e2-7c87-76810a44da91@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] vfio/display: add edid support.
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

On Fri, 22 Feb 2019 11:09:06 +0000
Liam Merwick <liam.merwick@oracle.com> wrote:

> On 22/02/2019 05:49, Gerd Hoffmann wrote:
> > This patch adds EDID support to the vfio display (aka vgpu) code.
> > When supported by the mdev driver qemu will generate a EDID blob
> > and pass it on using the new vfio edid region.  The EDID blob will
> > be updated on UI changes (i.e. window resize), so the guest can
> > adapt.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   include/hw/vfio/vfio-common.h |   3 +
> >   hw/vfio/display.c             | 127 ++++++++++++++++++++++++++++++++++++++++++
> >   hw/vfio/trace-events          |   7 +++
> >   3 files changed, 137 insertions(+)
> > 
> > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > index 7624c9f511c4..5f7f709b95f1 100644
> > --- a/include/hw/vfio/vfio-common.h
> > +++ b/include/hw/vfio/vfio-common.h
> > @@ -148,6 +148,9 @@ typedef struct VFIODMABuf {
> >   typedef struct VFIODisplay {
> >       QemuConsole *con;
> >       RAMFBState *ramfb;
> > +    struct vfio_region_info *edid_info;
> > +    struct vfio_region_gfx_edid *edid_regs;
> > +    uint8_t *edid_blob;
> >       struct {
> >           VFIORegion buffer;
> >           DisplaySurface *surface;
> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > index dead30e626cb..f59fcc487128 100644
> > --- a/hw/vfio/display.c
> > +++ b/hw/vfio/display.c
> > @@ -15,15 +15,139 @@
> >   #include <sys/ioctl.h>
> >   
> >   #include "sysemu/sysemu.h"
> > +#include "hw/display/edid.h"
> >   #include "ui/console.h"
> >   #include "qapi/error.h"
> >   #include "pci.h"
> > +#include "trace.h"
> >   
> >   #ifndef DRM_PLANE_TYPE_PRIMARY
> >   # define DRM_PLANE_TYPE_PRIMARY 1
> >   # define DRM_PLANE_TYPE_CURSOR  2
> >   #endif
> >   
> > +#define pread_field(_fd, _reg, _ptr, _fld)                              \
> > +    if (sizeof(_ptr->_fld) !=                                           \
> > +        pread(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                   \
> > +              _reg->offset + offsetof(typeof(*_ptr), _fld)))            \
> > +        goto err;
> > +#define pwrite_field(_fd, _reg, _ptr, _fld)                             \
> > +    if (sizeof(_ptr->_fld) !=                                           \
> > +        pwrite(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                  \
> > +               _reg->offset + offsetof(typeof(*_ptr), _fld)))           \
> > +        goto err;
> > +
> > +
> > +static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
> > +                                     int prefx, int prefy)
> > +{
> > +    VFIODisplay *dpy = vdev->dpy;
> > +    int fd = vdev->vbasedev.fd;
> > +    qemu_edid_info edid = {
> > +        .maxx  = dpy->edid_regs->max_xres,
> > +        .maxy  = dpy->edid_regs->max_yres,
> > +        .prefx = prefx,
> > +        .prefy = prefy,
> > +    };
> > +
> > +    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
> > +    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
> > +    trace_vfio_display_edid_link_down();
> > +
> > +    if (!enabled) {
> > +        return;
> > +    }
> > +
> > +    if (edid.maxx && edid.prefx > edid.maxx) {
> > +        edid.prefx = edid.maxx;
> > +    }
> > +    if (edid.maxy && edid.prefy > edid.maxy) {
> > +        edid.prefy = edid.maxy;
> > +    }
> > +    qemu_edid_generate(dpy->edid_blob,
> > +                       dpy->edid_regs->edid_max_size,
> > +                       &edid);
> > +    trace_vfio_display_edid_update(edid.prefx, edid.prefy);
> > +
> > +    dpy->edid_regs->edid_size = qemu_edid_size(dpy->edid_blob);
> > +    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, edid_size);
> > +    if (pwrite(fd, dpy->edid_blob, dpy->edid_regs->edid_size,
> > +               dpy->edid_info->offset + dpy->edid_regs->edid_offset)
> > +        != dpy->edid_regs->edid_size) {
> > +        goto err;
> > +    }
> > +
> > +    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
> > +    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
> > +    trace_vfio_display_edid_link_up();
> > +    return;
> > +
> > +err:
> > +    trace_vfio_display_edid_write_error();
> > +    return;
> > +}
> > +
> > +static int vfio_display_edid_ui_info(void *opaque, uint32_t idx,
> > +                                     QemuUIInfo *info)
> > +{
> > +    VFIOPCIDevice *vdev = opaque;
> > +    VFIODisplay *dpy = vdev->dpy;
> > +
> > +    if (!dpy->edid_regs) {
> > +        return 0;
> > +    }
> > +
> > +    if (info->width && info->height) {
> > +        vfio_display_edid_update(vdev, true, info->width, info->height);
> > +    } else {
> > +        vfio_display_edid_update(vdev, false, 0, 0);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void vfio_display_edid_init(VFIOPCIDevice *vdev)
> > +{
> > +    VFIODisplay *dpy = vdev->dpy;
> > +    int fd = vdev->vbasedev.fd;
> > +    int ret;
> > +
> > +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> > +                                   VFIO_REGION_TYPE_GFX,
> > +                                   VFIO_REGION_SUBTYPE_GFX_EDID,
> > +                                   &dpy->edid_info);
> > +    if (ret) {
> > +        return;
> > +    }
> > +
> > +    trace_vfio_display_edid_available();
> > +    dpy->edid_regs = g_new0(struct vfio_region_gfx_edid, 1);
> > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_offset);
> > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_max_size);
> > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, max_xres);
> > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, max_yres);
> > +    dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
> > +
> > +    vfio_display_edid_update(vdev, true, 0, 0);
> > +    return;
> > +
> > +err:  
> 
> 
> Might it be worth a comment that the p{read|write}_field macros use this 
> label since it's not immediately obvious when reading the code there's a 
> use for this (compiler would have flagged it admittedly). Same comment 
> for vfio_display_edid_update() to a lesser extent.

Hi Gerd,

Liam and I both found some difficulty with the cleverness of the
macros, so for the sake of better maintainability, I'd like to propose
rolling in the following patch, including Liam's trace format fix.  It's
not as compact as your version, but I think it's equivalent, it's easier
to follow, and doesn't covertly introduce a non-curly braced block ;)
If you agree, I'll roll this into your v3. Thanks,

Alex

 hw/vfio/display.c    |   44 +++++++++++++++++++++++++++++---------------
 hw/vfio/trace-events |    2 +-
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index f59fcc487128..276fba090d8b 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -27,15 +27,14 @@
 #endif
 
 #define pread_field(_fd, _reg, _ptr, _fld)                              \
-    if (sizeof(_ptr->_fld) !=                                           \
-        pread(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                   \
-              _reg->offset + offsetof(typeof(*_ptr), _fld)))            \
-        goto err;
+    (sizeof(_ptr->_fld) !=                                              \
+     pread(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                      \
+           _reg->offset + offsetof(typeof(*_ptr), _fld)))
+
 #define pwrite_field(_fd, _reg, _ptr, _fld)                             \
-    if (sizeof(_ptr->_fld) !=                                           \
-        pwrite(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                  \
-               _reg->offset + offsetof(typeof(*_ptr), _fld)))           \
-        goto err;
+    (sizeof(_ptr->_fld) !=                                              \
+     pwrite(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                     \
+            _reg->offset + offsetof(typeof(*_ptr), _fld)))
 
 
 static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
@@ -51,7 +50,9 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
     };
 
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
-    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
+    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
+        goto err;
+    }
     trace_vfio_display_edid_link_down();
 
     if (!enabled) {
@@ -70,7 +71,9 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
     trace_vfio_display_edid_update(edid.prefx, edid.prefy);
 
     dpy->edid_regs->edid_size = qemu_edid_size(dpy->edid_blob);
-    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, edid_size);
+    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, edid_size)) {
+        goto err;
+    }
     if (pwrite(fd, dpy->edid_blob, dpy->edid_regs->edid_size,
                dpy->edid_info->offset + dpy->edid_regs->edid_offset)
         != dpy->edid_regs->edid_size) {
@@ -78,7 +81,9 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
     }
 
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
-    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
+    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
+        goto err;
+    }
     trace_vfio_display_edid_link_up();
     return;
 
@@ -122,10 +127,19 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
 
     trace_vfio_display_edid_available();
     dpy->edid_regs = g_new0(struct vfio_region_gfx_edid, 1);
-    pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_offset);
-    pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_max_size);
-    pread_field(fd, dpy->edid_info, dpy->edid_regs, max_xres);
-    pread_field(fd, dpy->edid_info, dpy->edid_regs, max_yres);
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_offset)) {
+        goto err;
+    }
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_max_size)) {
+        goto err;
+    }
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, max_xres)) {
+        goto err;
+    }
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, max_yres)) {
+        goto err;
+    }
+
     dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
 
     vfio_display_edid_update(vdev, true, 0, 0);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 0882f7b59644..decbde495ac2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -137,5 +137,5 @@ vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn
 vfio_display_edid_available(void) ""
 vfio_display_edid_link_up(void) ""
 vfio_display_edid_link_down(void) ""
-vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%dx%d"
+vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
 vfio_display_edid_write_error(void) ""
