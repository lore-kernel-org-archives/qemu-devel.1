Received: from eggs.gnu.org ([2001:4830:134:3::10]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkAun-0006BD-M0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkAuk-00072z-R8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:20:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fkAuk-00072e-Hw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:20:54 -0400
Date: Mon, 30 Jul 2018 10:20:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180730102029.122765d2@t450s.home>
In-Reply-To: <20180730121704-mutt-send-email-mst@kernel.org>
References: <20180723045956.27521-1-tiwei.bie@intel.com>
	<20180723045956.27521-4-tiwei.bie@intel.com>
	<20180726144539.740acf4d@t450s.home>
	<20180727015805.GA11247@debian>
	<20180727140300.022d9872@t450s.home>
	<20180730081003.GA10680@debian>
	<20180730121704-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/3] vhost-user: support programming VFIO
 group in master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, jasowang@redhat.com, qemu-devel@nongnu.org

On Mon, 30 Jul 2018 12:30:58 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 30, 2018 at 04:10:04PM +0800, Tiwei Bie wrote:
> > On Fri, Jul 27, 2018 at 02:03:00PM -0600, Alex Williamson wrote:  
> > > On Fri, 27 Jul 2018 09:58:05 +0800
> > > Tiwei Bie <tiwei.bie@intel.com> wrote:
> > >   
> > > > On Thu, Jul 26, 2018 at 02:45:39PM -0600, Alex Williamson wrote:  
> > > > > On Mon, 23 Jul 2018 12:59:56 +0800
> > > > > Tiwei Bie <tiwei.bie@intel.com> wrote:
> > > > >     
> > > > [...]  
> > > > > >  
> > > > > > +static int vhost_user_slave_handle_vfio_group(struct vhost_dev *dev,
> > > > > > +                                              int *fd)
> > > > > > +{
> > > > > > +    struct vhost_user *u = dev->opaque;
> > > > > > +    VhostUserState *user = u->user;
> > > > > > +    VirtIODevice *vdev = dev->vdev;
> > > > > > +    int groupfd = fd[0];
> > > > > > +    VFIOGroup *group;
> > > > > > +
> > > > > > +    if (!virtio_has_feature(dev->protocol_features,
> > > > > > +                            VHOST_USER_PROTOCOL_F_VFIO_GROUP) ||
> > > > > > +        vdev == NULL) {
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (user->vfio_group) {
> > > > > > +        vfio_put_group(user->vfio_group);
> > > > > > +        user->vfio_group = NULL;
> > > > > > +    }
> > > > > > +    
> > > > 
> > > > There should be a below check here (I missed it in this
> > > > patch, sorry..):
> > > > 
> > > >     if (groupfd < 0) {
> > > >         return 0;
> > > >     }
> > > >   
> > > > > > +    group = vfio_get_group_from_fd(groupfd, vdev->dma_as, NULL);
> > > > > > +    if (group == NULL) {
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (group->fd != groupfd) {
> > > > > > +        close(groupfd);
> > > > > > +    }
> > > > > > +
> > > > > > +    user->vfio_group = group;
> > > > > > +    fd[0] = -1;
> > > > > > +
> > > > > > +    return 0;
> > > > > > +}    
> > > > > 
> > > > > This all looks very sketchy, we're reaching into vfio internal state
> > > > > and arbitrarily releasing data structures, reusing existing ones, and
> > > > > maybe creating new ones.  We know that a vfio group only allows a
> > > > > single open, right?    
> > > > 
> > > > Yeah, exactly!
> > > > 
> > > > When the vhost-user backend process has opened a VFIO group fd,
> > > > QEMU won't be able to open this group file via open() any more.
> > > > So vhost-user backend process will share the VFIO group fd to
> > > > QEMU via the UNIX socket. And that's why we're introducing a
> > > > new API:
> > > > 
> > > > 	vfio_get_group_from_fd(groupfd, ...);
> > > > 
> > > > for vfio/common.c to get (setup) a VFIOGroup structure. (Because
> > > > in this case, vfio/common.c can't open this group file via open(),
> > > > and what we have is a VFIO group fd shared by another process via
> > > > UNIX socket). And ...
> > > >   
> > > > > So if you have a groupfd, vfio will never have
> > > > > that same group opened already.    
> > > > 
> > > > ... if the same vhost-user backend process shares the same VFIO
> > > > group fd more than one times via different vhost-user slave channels
> > > > to different vhost-user frontends in the same QEMU process, the
> > > > same VFIOGroup could exist already.
> > > > 
> > > > This case could happen when e.g. there are two vhost accelerator
> > > > devices in the same VFIO group, and they are managed by the same
> > > > vhost-user backend process, and used to accelerate two different
> > > > virtio devices in QEMU. In this case, the same VFIO group fd could
> > > > be sent twice.
> > > > 
> > > > If we need to support this case, more changes in vfio/common.c
> > > > will be needed, e.g. 1) add a refcnt in VFIOGroup to support
> > > > getting and putting a VFIOGroup structure multiple times,
> > > > 2) add a lock to make vfio_get_group*() and vfio_put_group()
> > > > thread-safe.  
> > > 
> > > This is the sort of case where it seems like we're just grabbing
> > > internal interfaces and using them from other modules.  VFIOGroups have
> > > a device_list and currently handles multiple puts by testing whether
> > > that device list is empty (ie. we already have a refcnt effectively).
> > > Now we have a group user that has no devices, which is not something
> > > that it seems like we've designed or audited the code for handling.
> > > IOW, while the header file lives in a common location, it's not really
> > > intended to be an API within QEMU and it makes me a bit uncomfortable
> > > to use it as such.
> > >   
> > > > > Is that the goal?  It's not obvious in
> > > > > the code.  I don't really understand what vhost goes on to do with this
> > > > > group,    
> > > > 
> > > > The goal is that, we have a VFIO group opened by an external
> > > > vhost-user backend process, this process will manage the VFIO
> > > > device, but want QEMU to manage the VFIO group, including:
> > > > 
> > > > 1 - program the DMA mappings for this VFIO group based on
> > > >     the front-end device's dma_as in QEMU.
> > > > 
> > > > 2 - add this VFIO group to KVM (KVM_DEV_VFIO_GROUP_ADD).
> > > > 
> > > > Vhost-user in QEMU as the vhost-user frontend just wants
> > > > hw/vfio to do above things after receiving a VFIO group fd
> > > > from the vhost-user backend process.
> > > > 
> > > > Vhost-user will just ask hw/vfio to get (setup) a VFIOGroup
> > > > by calling vfio_get_group_from_fd() or put this VFIOGroup by
> > > > calling vfio_put_group() when it's not needed anymore, and
> > > > won't do anything else.
> > > > 
> > > > Vhost-user will only deal with the VFIOGroups allocated by
> > > > itself, and won't influence any other VFIOGroups used by the
> > > > VFIO passthru devices (-device vfio-pci). Because the same
> > > > VFIO group file can only be opened by one process via open().  
> > > 
> > > But there's nothing here that guarantees the reverse.  vhost cannot
> > > open the group of an existing vfio-pci device, but vfio-pci can re-use
> > > the group that vhost has already opened.  This is again where it seems
> > > like we're trying to cherry pick from an internal API and leaving some
> > > loose ends dangling.
> > >   
> > > > > but I'm pretty sure the existing state machine in vfio isn't
> > > > > designed for it.  Thanks,    
> > > > 
> > > > Yeah, more changes (e.g. refcnt, ..) in hw/vfio are needed to
> > > > make it work robustly. Hmm.. Is above idea (e.g. how vhost-user
> > > > is going to use VFIOGroup and how we are going to extend hw/vfio)
> > > > acceptable to you? Thanks!  
> > > 
> > > I certainly would not want to duplicate managing the group, container,
> > > and MemoryListener, but I think we need a more formal interface with at
> > > least some notion of reference counting beyond the device list or
> > > explicit knowledge of an external user.  
> > 
> > Got it! I'll try to address this. Thanks!
> >   
> > > I'm also curious if it really
> > > makes sense that the vhost backend is opening the group rather than
> > > letting QEMU do it.  It seems that vhost wants to deal with the device
> > > and we can never have symmetry in the scenario above, where a group
> > > might contain multiple devices and order matters because of where the
> > > group is opened.  If we still had a notion of a VFIODevice for an
> > > external user, then the device_list refcnt would just work.  Thanks,  
> > 
> > Vhost-user backend will but QEMU won't open the VFIO
> > fds, because QEMU just has a vhost-user UNIX socket
> > path that it should connect to or listen on. So QEMU
> > doesn't know which group and device it should open.
> > The vhost accelerator devices are probed and managed
> > in the vhost-user backend process. And the vhost-user
> > backend process will bind the vhost-user instances
> > and vhost accelerator devices based on some sort of
> > user's input.
> > 
> > Best regards,
> > Tiwei Bie  
> 
> Is the reason it's done like this because the
> backend is sharing the device with multiple QEMUs?

Each QEMU instance that gets passed a vfio group would attempt to add
it to a vfio container (ie. IOMMU domain), so this mechanism cannot
support multiple QEMU instances attached to the same group.  Beyond
that, the address space of each device would need to be unique within
the instance as we only have a single IOVA space for the group.  Thanks,

Alex
