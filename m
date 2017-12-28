Received: from eggs.gnu.org ([2001:4830:134:3::10]:54365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUWNT-0005xq-4J
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUWNP-0004kN-5W
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:29:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUWNO-0004iO-TA
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:29:31 -0500
Date: Thu, 28 Dec 2017 12:29:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171228122916.667bcb4e@igors-macbook-pro.local>
In-Reply-To: <20171222231342-mutt-send-email-mst@kernel.org>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-3-git-send-email-jianjay.zhou@huawei.com>
	<20171222194855.6d1139f1@igors-macbook-pro.local>
	<20171222231342-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vhost: double check used memslots
 number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, gary.liuzhe@huawei.com, dgilbert@redhat.com, arei.gonglei@huawei.com, Jay Zhou <jianjay.zhou@huawei.com>

On Fri, 22 Dec 2017 23:15:09 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Dec 22, 2017 at 07:48:55PM +0100, Igor Mammedov wrote:
> > On Fri, 15 Dec 2017 16:45:55 +0800
> > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > 
> > > If the VM already has N(N>8) available memory slots for vhost user,
> > > the VM will be crashed in vhost_user_set_mem_table if we try to
> > > hotplug the first vhost user NIC.
> > > This patch checks if memslots number exceeded or not after updating
> > > vhost_user_used_memslots.
> > Can't understand commit message, pls rephrase (what is being fixed, and how it's fixed)
> > also include reproducing steps for crash and maybe describe call flow/backtrace
> > that triggers crash.
> > 
> > PS:
> > I wasn't able to reproduce crash
> > 
> > > 
> > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > ---
> > >  hw/virtio/vhost.c | 27 +++++++++++++++++++++++----
> > >  1 file changed, 23 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 59a32e9..e45f5e2 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -1234,6 +1234,18 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
> > >      event_notifier_cleanup(&vq->masked_notifier);
> > >  }
> > >  
> > > +static bool vhost_dev_used_memslots_is_exceeded(struct vhost_dev *hdev)
> > > +{
> > > +    if (hdev->vhost_ops->vhost_get_used_memslots() >
> > > +        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> > > +        error_report("vhost backend memory slots limit is less"
> > > +                " than current number of present memory slots");
> > > +        return true;
> > > +    }
> > > +
> > > +    return false;
> > > +}
> > > +
> > >  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> > >                     VhostBackendType backend_type, uint32_t busyloop_timeout)
> > >  {
> > > @@ -1252,10 +1264,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> > >          goto fail;
> > >      }
> > >  
> > > -    if (hdev->vhost_ops->vhost_get_used_memslots() >
> > > -        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> > > -        error_report("vhost backend memory slots limit is less"
> > > -                " than current number of present memory slots");
> > > +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
> > why do you keep this check?
> > it seems always be false
> > 
> > 
> > 
> > >          r = -1;
> > >          goto fail;
> > >      }
> > > @@ -1341,6 +1350,16 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> > >      hdev->memory_changed = false;
> > >      memory_listener_register(&hdev->memory_listener, &address_space_memory);
> > >      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
> > > +
> > > +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
> > > +        r = -1;
> > > +        if (busyloop_timeout) {
> > > +            goto fail_busyloop;
> > > +        } else {
> > > +            goto fail;
> > > +        }
> > > +    }
> > seem to be right thing to do, since after registering listener for the first time
> > used_memslots will be updated to actual value.
> > 
> > 
> > I did some testing and without this hunk/patch
> > 
> > on 'device_add  virtio-net-pci,netdev=net0' qemu prints:
> > 
> > qemu-system-x86_64: vhost_set_mem_table failed: Argument list too long (7)
> > qemu-system-x86_64: unable to start vhost net: 7: falling back on userspace virtio
> > 
> > and network is operational in guest, but with this patch
> > 
> > "netdev_add ...,vhost-on" prints:
> > 
> > vhost backend memory slots limit is less than current number of present memory slots
> > vhost-net requested but could not be initialized
> > 
> > and following "device_add  virtio-net-pci,netdev=net0" prints:
> > 
> > TUNSETOFFLOAD ioctl() failed: Bad file descriptor
> > TUNSETOFFLOAD ioctl() failed: Bad file descriptor
> > 
> > adapter is still hot-plugged but guest networking is broken (can't get IP address via DHCP)
> > 
> > so patch seems introduces a regression or something broken elsewhere and this exposes issue,
> > not sure what qemu reaction should be in this case
> >  i.e. when netdev_add fails 
> >     1: should we fail followed up device_add or 
> >     2: make it fall back to userspace virtio
> > 
> > I'd go for #2,
> > Michael what's your take on it?
> 
> OK but there's a vhost force flag, if that is set we definitely should
> fail device_add.
> 
> Also, hotplug can follow device_add, should be handled similarly.
I was testing with vhost-kernel (as it doesn't need extra environment to setup)
and it's able to fallback to virtio transport.

However in case of vhost-user, is there even an option to fallback to?
Perhaps our only choice here is to fail backend creation cleanly,
so no one would be able to add a frontend refering to non existing backend.


PS:
even if we have to fail on error for vhost-user, this patch shouldn't
change current vhost-kernel behavior (fallback should still work)

> 
> > > +
> > >      return 0;
> > >  
> > >  fail_busyloop:
> 
