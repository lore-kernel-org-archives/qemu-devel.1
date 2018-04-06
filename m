Received: from eggs.gnu.org ([2001:4830:134:3::10]:52401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4W50-0001eQ-Kf
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4W4v-00041D-Oi
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:27:18 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:48796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f4W4v-0003zf-Fg
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:27:13 -0400
Received: from player759.ha.ovh.net (unknown [10.109.108.113])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BE37019E777
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 20:27:11 +0200 (CEST)
Date: Fri, 6 Apr 2018 20:27:06 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180406202706.48304b60@bahia.lan>
In-Reply-To: <20180406185413.0af47db3.cohuck@redhat.com>
References: <152302765908.144052.14302567702608397806.stgit@bahia.lan>
	<20180406185413.0af47db3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] vfio-ccw: fix memory leak in
 vfio_ccw_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Fri, 6 Apr 2018 18:54:13 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 06 Apr 2018 17:14:19 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > The vfio_ccw_realize() function currently leaks vcdev->vdev.name if
> > the subchannel is already attached or if vfio_get_device() fails.
> > 
> > This happens because vcdev->vdev.name is expected to be freed in
> > vfio_put_device() which isn't called in this case.
> > 
> > Adding g_free(vcdev->vdev.name) on these two error paths would be
> > enough to fix the leak, but this is unfortunate since we would then
> > have three locations doing this. Also, this would be inconsistent
> > with the label based rollback scheme of this function.  
> 
> This is all a bit awkward :(
> 
> But I'd actually prefer adding the two g_free calls for now, as that
> would be a nice, small patch that my brain can still process at this
> point in the evening :)
> 
> Your patch would be a nice cleanup for 2.13, though.
> 
> Alternatively, I could be convinced to queue this if I get a R-b from
> someone :)
> 

I guess I should rather split the patch in two: a bug fix with the two
g_free calls for 2.12 and stable, and a cleanup patch for 2.13.

> > 
> > The root issue is that vcdev->vdev.name is set before vfio_get_device()
> > is called, which theoretically prevents to call vfio_put_device() to
> > do the freeing. Well actually, we could call it anyway  because
> > vfio_put_base_device() is a nop if the device isn't attached, but this
> > would be confusing.
> > 
> > This patch hence moves all the logic of attaching the device to a
> > separate vfio_ccw_get_device() function, which is the counterpart
> > of vfio_put_device(). While here, vfio_put_device() is renamed to
> > vfio_ccw_put_device() for consistency.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/vfio/ccw.c |   54 ++++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 36 insertions(+), 18 deletions(-)
> > 
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index 4e5855741a64..49ae986d288d 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -292,12 +292,44 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
> >      g_free(vcdev->io_region);
> >  }
> >  
> > -static void vfio_put_device(VFIOCCWDevice *vcdev)
> > +static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
> >  {
> >      g_free(vcdev->vdev.name);
> >      vfio_put_base_device(&vcdev->vdev);
> >  }
> >  
> > +static int vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
> > +                               Error **errp)
> > +{
> > +    char *name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
> > +                                 vcdev->cdev.hostid.ssid,
> > +                                 vcdev->cdev.hostid.devid);
> > +    VFIODevice *vbasedev;
> > +
> > +    QLIST_FOREACH(vbasedev, &group->device_list, next) {
> > +        if (strcmp(vbasedev->name, name) == 0) {
> > +            error_setg(errp, "vfio: subchannel %s has already been attached",
> > +                       name);
> > +            goto out_err;
> > +        }
> > +    }
> > +
> > +    if (vfio_get_device(group, vcdev->cdev.mdevid, &vcdev->vdev, errp)) {
> > +        goto out_err;
> > +    }
> > +
> > +    vcdev->vdev.ops = &vfio_ccw_ops;
> > +    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> > +    vcdev->vdev.name = name;
> > +    vcdev->vdev.dev = &vcdev->cdev.parent_obj.parent_obj;
> > +
> > +    return 0;
> > +
> > +out_err:
> > +    g_free(name);
> > +    return -1;
> > +}
> > +
> >  static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
> >  {
> >      char *tmp, group_path[PATH_MAX];
> > @@ -327,7 +359,6 @@ static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
> >  
> >  static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> >  {
> > -    VFIODevice *vbasedev;
> >      VFIOGroup *group;
> >      CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> >      S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> > @@ -348,20 +379,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> >          goto out_group_err;
> >      }
> >  
> > -    vcdev->vdev.ops = &vfio_ccw_ops;
> > -    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> > -    vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
> > -                                       cdev->hostid.ssid, cdev->hostid.devid);
> > -    vcdev->vdev.dev = dev;
> > -    QLIST_FOREACH(vbasedev, &group->device_list, next) {
> > -        if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
> > -            error_setg(&err, "vfio: subchannel %s has already been attached",
> > -                       vcdev->vdev.name);
> > -            goto out_device_err;
> > -        }
> > -    }
> > -
> > -    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, &err)) {
> > +    if (vfio_ccw_get_device(group, vcdev, &err)) {
> >          goto out_device_err;
> >      }
> >  
> > @@ -380,7 +398,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> >  out_notifier_err:
> >      vfio_ccw_put_region(vcdev);
> >  out_region_err:
> > -    vfio_put_device(vcdev);
> > +    vfio_ccw_put_device(vcdev);
> >  out_device_err:
> >      vfio_put_group(group);
> >  out_group_err:
> > @@ -401,7 +419,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
> >  
> >      vfio_ccw_unregister_io_notifier(vcdev);
> >      vfio_ccw_put_region(vcdev);
> > -    vfio_put_device(vcdev);
> > +    vfio_ccw_put_device(vcdev);
> >      vfio_put_group(group);
> >  
> >      if (cdc->unrealize) {
> >   
> 
