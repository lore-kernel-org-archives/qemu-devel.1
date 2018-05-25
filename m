Received: from eggs.gnu.org ([2001:4830:134:3::10]:58749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fMB0R-0007eI-A5
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fMB0N-0000cI-Cu
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:35:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:64196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fMB0N-0000bv-3T
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:35:31 -0400
Date: Fri, 25 May 2018 19:35:49 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180525113549.GA8547@debian>
References: <20180525110441.7185-1-tiwei.bie@intel.com>
	<20180525110441.7185-4-tiwei.bie@intel.com>
	<ae867b0d-2f70-f3ab-6d32-914935b5dd23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae867b0d-2f70-f3ab-6d32-914935b5dd23@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vhost-user: support registering
 external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Fri, May 25, 2018 at 07:26:05PM +0800, Jason Wang wrote:
> On 2018年05月25日 19:04, Tiwei Bie wrote:
[...]
> > +static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
> > +                                                       VhostUserVringArea *area,
> > +                                                       int fd)
> > +{
> > +    int queue_idx = area->u64 & VHOST_USER_VRING_IDX_MASK;
> > +    size_t page_size = qemu_real_host_page_size;
> > +    struct vhost_user *u = dev->opaque;
> > +    VhostUserState *user = u->user;
> > +    VirtIODevice *vdev = dev->vdev;
> > +    VhostUserHostNotifier *n;
> > +    int ret = 0;
> > +    void *addr;
> > +    char *name;
> > +
> > +    if (!virtio_has_feature(dev->protocol_features,
> > +                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
> > +        vdev == NULL || queue_idx >= virtio_get_num_queues(vdev)) {
> > +        ret = -1;
> > +        goto out;
> > +    }
> > +
> > +    n = &user->notifier[queue_idx];
> > +
> > +    if (n->addr) {
> > +        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, false);
> > +        object_unparent(OBJECT(&n->mr));
> > +        munmap(n->addr, page_size);
> > +        n->addr = NULL;
> > +    }
> > +
> > +    if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
> > +        goto out;
> > +    }
> > +
> > +    /* Sanity check. */
> > +    if (area->size != page_size) {
> > +        ret = -1;
> > +        goto out;
> > +    }
> > +
> > +    addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> 
> It looks to me that PROT_WRITE is sufficient here?
> 
> Thanks
> 

I think it's safer to add PROT_READ. And there's
no harm to do that.

Best regards,
Tiwei Bie
