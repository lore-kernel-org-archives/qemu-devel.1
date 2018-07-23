Received: from eggs.gnu.org ([2001:4830:134:3::10]:59256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhZZg-00053C-7z
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhZZb-00006t-Aq
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:04:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:17975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fhZZa-0008UT-W2
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:04:19 -0400
Date: Mon, 23 Jul 2018 20:04:00 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180723120400.GA17843@debian>
References: <20180723045956.27521-1-tiwei.bie@intel.com>
	<20180723045956.27521-4-tiwei.bie@intel.com>
	<20180723121919-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723121919-mutt-send-email-mst@kernel.org>
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

On Mon, Jul 23, 2018 at 12:20:12PM +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 23, 2018 at 12:59:56PM +0800, Tiwei Bie wrote:
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
> 
> Seems to create a window where mappings are invalid
> even if the same fd is re-sent. Is that OK?

Yeah, there will be a window that mappings are invalid
when the same fd is re-sent. Based on the proposal [1]
of this patch, it should be OK.

[1] http://lists.gnu.org/archive/html/qemu-devel/2018-07/msg04335.html
"""
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
"""

Best regards,
Tiwei Bie

> 
> > +    }
[...]
