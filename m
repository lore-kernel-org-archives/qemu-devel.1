Received: from eggs.gnu.org ([2001:4830:134:3::10]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhZV4-0003qH-8O
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhZV1-0004nP-6p
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:59:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:17777)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fhZV0-0004fd-SR
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:59:35 -0400
Date: Mon, 23 Jul 2018 19:59:16 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180723115916.GA17365@debian>
References: <20180723045956.27521-1-tiwei.bie@intel.com>
	<20180723045956.27521-4-tiwei.bie@intel.com>
	<20180723121505-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723121505-mutt-send-email-mst@kernel.org>
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
Cc: alex.williamson@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org

On Mon, Jul 23, 2018 at 12:19:04PM +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 23, 2018 at 12:59:56PM +0800, Tiwei Bie wrote:
[...]
> > @@ -815,6 +816,21 @@ Slave message types
> >        This request should be sent only when VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
> >        protocol feature has been successfully negotiated.
> >  
> > + * VHOST_USER_SLAVE_VFIO_GROUP_MSG
> > +
> > +      Id: 4
> > +      Equivalent ioctl: N/A
> > +      Slave payload: N/A
> > +      Master payload: N/A
> > +
> > +      When VHOST_USER_PROTOCOL_F_VFIO_GROUP is negotiated, vhost-user slave
> > +      could send this request to share its VFIO group fd via ancillary data
> > +      to master. After receiving this request from slave, master will close
> > +      the existing VFIO group if any and do the DMA programming based on the
> > +      virtio device's DMA address space for the new group if the request is
> > +      sent with a file descriptor.
> > +
> 
> Should it also clear out any mappings that were set on the old fd
> before closing it?

Yes, more exactly it will do below things:

1. Delete VFIO group from KVM device fd;
2. Unset the container fd for this group fd;
3. Close this VFIO group fd;

Should I include above details in this doc?

> 
> Also should we limit when can this message be received?
> If not you need to re-program mappings again whenever
> we get a new fd.

To keep things simple, this proposal requires the slave
to assume the mappings are invalid before receiving the
REPLY from master when the slave sends this message to
master, and master will destroy the existing VFIO group
if any and do the setup for the (new) VFIO group if the
message carries a fd.

So if a VFIO group fd has been sent and the device has
been started, before sending a VFIO group fd (could be
the same fd that has been sent), the slave should stop
the device first and shouldn't assume the mappings are
valid before receiving the REPLY.

> 
> > +
[...]
> >  
> > +static int vhost_user_slave_handle_vfio_group(struct vhost_dev *dev,
> > +                                              int *fd)
> > +{
> > +    struct vhost_user *u = dev->opaque;
> > +    VhostUserState *user = u->user;
> > +    VirtIODevice *vdev = dev->vdev;
> > +    int groupfd = fd[0];
> > +    VFIOGroup *group;
> > +
> > +    if (!virtio_has_feature(dev->protocol_features,
> > +                            VHOST_USER_PROTOCOL_F_VFIO_GROUP) ||
> > +        vdev == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    if (user->vfio_group) {
> > +        vfio_put_group(user->vfio_group);
> > +        user->vfio_group = NULL;
> > +    }
> > +
> > +    group = vfio_get_group_from_fd(groupfd, vdev->dma_as, NULL);
> > +    if (group == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    if (group->fd != groupfd) {
> > +        close(groupfd);
> > +    }
> > +
> > +    user->vfio_group = group;
> > +    fd[0] = -1;
> > +
> > +    return 0;
> > +}
> > +
> 
> What will cause propagating groups to this vfio fd?

Do you mean when a VFIOGroup will be created for this
VFIO group fd?

A VFIOGroup will be created if there is no existing
VFIOGroup that references to the same group id.

Best regards,
Tiwei Bie

> 
> 
[...]
