Received: from eggs.gnu.org ([2001:4830:134:3::10]:58715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0mT1-0005D9-0P
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0mSx-0007WN-Qf
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:08:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:62440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f0mSx-0007UD-E1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:08:35 -0400
Date: Tue, 27 Mar 2018 19:06:53 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180327110652.ehxg3vv5x4cv56lm@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180319071537.28649-7-tiwei.bie@intel.com>
	<20180322171740-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322171740-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] vhost-user: add VFIO based
 accelerators support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Mar 22, 2018 at 06:19:44PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:37PM +0800, Tiwei Bie wrote:
[...]
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > index cb3a7595aa..264a58a800 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -132,6 +132,15 @@ Depending on the request type, payload can be:
[...]
> 
> but readers of this
> document do not know what MemoryRegion is.
> 
> 
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK:
> >  -------------------------------
> >  The original vhost-user specification only demands replies for certain

All above comments about the doc are very helpful,
I'll improve the doc accordingly! Thanks a lot!

> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index b228994ffd..07fc63c6e8 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
[...]
> >  
> > +static int vhost_user_handle_vring_vfio_group(struct vhost_dev *dev,
> > +                                              uint64_t u64,
> 
> That's not a good variable name.
> 
> > +                                              int groupfd)
> > +{
[...]
> > +
> > +    vfio->group[queue_idx] = group;
> > +
> > +out:
> > +    kvm_irqchip_commit_routes(kvm_state);
> 
> The fact we poke at kvm_eventfds_enabled is already kind of ugly.
> It would be better to just process eventfds in QEMU when we do not
> and make it transparent to the backend.
> 
> I don't think vhost should touch more kvm state directly like that.
> 

I'll think about whether there's a better way to do this.

> 
> 
> > +    qemu_mutex_unlock(&vfio->lock);
> > +
> > +    if (ret != 0 && groupfd != -1) {
> > +        close(groupfd);
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +#define NOTIFY_PAGE_SIZE 0x1000
> 
> why is this correct for all systems?

Will fix this.

> 
> > +
> > +static int vhost_user_handle_vring_notify_area(struct vhost_dev *dev,
> > +                                               VhostUserVringArea *area,
> > +                                               int fd)
> > +{
[...]
> > +    if (area->size < NOTIFY_PAGE_SIZE) {
> > +        ret = -1;
> > +        goto out;
> > +    }
> 
> So that's the only use of size. Why have it at all then?
> 
> > +
> > +    addr = mmap(NULL, NOTIFY_PAGE_SIZE, PROT_READ | PROT_WRITE,
> > +                MAP_SHARED, fd, area->offset);
> 
> Can't we use memory_region_init_ram_from_fd?

Because we need to map the file with a specified offset.

> 
> Also, must validate the message before doing things like that.

Not pretty sure I have got your point. Do you mean we
also need to validate e.g. area->offset?

> 
> 
> > +    if (addr == MAP_FAILED) {
> > +        error_report("Can't map notify region.");
> > +        ret = -1;
> > +        goto out;
> > +    }
> > +
> > +    name = g_strdup_printf("vhost-user/vfio@%p mmaps[%d]", vfio, queue_idx);
> > +    memory_region_init_ram_device_ptr(&notify->mr, OBJECT(vdev), name,
> > +                                      NOTIFY_PAGE_SIZE, addr);
> 
> This will register RAM for migration which probably isn't what you want.

It's definitely not what I want. But I don't know how
to avoid it. Could you please provide more details about
how to avoid this? Thanks a lot!

> 
> > +    g_free(name);
> > +
> > +    if (virtio_device_notify_region_map(vdev, queue_idx, &notify->mr)) {
> > +        ret = -1;
> > +        goto out;
> > +    }
> > +
> > +    notify->addr = addr;
> > +    notify->mapped = true;
> > +
> > +out:
> > +    if (ret < 0 && addr != NULL) {
> > +        munmap(addr, NOTIFY_PAGE_SIZE);
> 
> Does this actually do the right thing?
> Don't we need to finalize the mr we created?

ret < 0 means this function failed. So we will
unmap the memory if the memory has been mapped.
I just noticed a bug, addr may also be MAP_FAILED.
Will fix this!

> 
> 
> > +    }
> > +    if (fd != -1) {
> > +        close(fd);
> > +    }
> 
> Who will close it if there's no error?
> Looks like this leaks fds on success.

fd != -1 means we have received a fd. The logic of
above code is to close the fd before returning from
this function (for both of error case and success
case). Because for success case, we also don't need
to keep the fd after we mmap it.

I will try to make above code more readable.

> 
> > +    qemu_mutex_unlock(&vfio->lock);
> > +    return ret;
> > +}
> > +
> >  static void slave_read(void *opaque)
> >  {
> >      struct vhost_dev *dev = opaque;
> > @@ -734,6 +901,12 @@ static void slave_read(void *opaque)
> >      case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG :
> >          ret = vhost_user_slave_handle_config_change(dev);
> >          break;
> > +    case VHOST_USER_SLAVE_VRING_VFIO_GROUP_MSG:
> > +        ret = vhost_user_handle_vring_vfio_group(dev, payload.u64, fd);
> > +        break;
> > +    case VHOST_USER_SLAVE_VRING_NOTIFY_AREA_MSG:
> > +        ret = vhost_user_handle_vring_notify_area(dev, &payload.area, fd);
> > +        break;
> >      default:
> >          error_report("Received unexpected msg type.");
> >          if (fd != -1) {
> > @@ -844,6 +1017,10 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
> >      u->slave_fd = -1;
> >      dev->opaque = u;
> >  
> > +    if (dev->vq_index == 0) {
> > +        qemu_mutex_init(&u->shared->vfio.lock);
> > +    }
> > +
> >      err = vhost_user_get_features(dev, &features);
> >      if (err < 0) {
> >          return err;
> 
> That seems inelegant.
> Now that we have a shared vhost user state, I'd expect a
> clean way to initialize it.

I'll fix this.

Best regards,
Tiwei Bie
