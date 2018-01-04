Received: from eggs.gnu.org ([2001:4830:134:3::10]:37473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eX8lq-0002Td-4g
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eX8lc-0004Bt-1o
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:53:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eX8lb-0004BD-Ro
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:53:19 -0500
Date: Thu, 4 Jan 2018 18:53:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180104184236-mutt-send-email-mst@kernel.org>
References: <20171219162151.GA10889@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219162151.GA10889@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mukawa@igel.co.jp, marcandre.lureau@redhat.com, Wei Wang <wei.w.wang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n.nikolaev@virtualopensystems.com

On Tue, Dec 19, 2017 at 04:21:51PM +0000, Stefan Hajnoczi wrote:
> Hi,
> Vhost-user implementations assume the slave is already running before
> the master starts.  The slave is required during virtio device
> initialization (e.g. feature bit negotiation) and so it is simplest to
> assume that the master is already available and will respond immediately
> to the VHOST_USER_GET_FEATURES message.
> 
> I have thought about how to let master and slave start in any order.
> Some approaches involve changes to the VIRTIO specification so that
> guest drivers can wait until the vhost-user connection is established.
> 
> We can avoid spec changes using PCI hotplug:
> 
> 1. Introduce a new vhost-user object that manages a connection:
> 
>    -chardev ...
>    -object vhost-user,id=vhost-user0,chardev=chr0
> 
>    Note this object is *not* a NetClient.  It's a resource for managing
>    a vhost-user connection and can be used with any device type (net,
>    scsi, blk, etc).
> 
>    This object tries to establish a connection.  When a connection is
>    established it sends vhost-user protocol messages to fetch
>    information needed for virtio device initialization (like the number
>    of virtqueues supported, features bits, etc).  This information is
>    stashed so that vhost_*() calls later on do not require synchronous
>    communication with the vhost-user slave.

I'm not sure how important or feasible this last part is.

> 2. When the vhost-user connection is established the object emits a QMP
>    event so management software can hotplug the virtio device:
> 
>    VHOST_USER_CONNECTED source=vhost-user0
> 
> 3. The management software hotplugs the virtio device:
> 
>    (qmp) netdev_add vhost-user,id=netdev0,vhost-user=vhost-user0
>    (qmp) device_add virtio-net-pci,netdev=netdev0
> 
> Advantages of this approach:
> 
>  * Does not require spec changes.
>  * Can be implemented without vhost-user.c qemu_chr_fe_read/write_all()
>    calls that hang QEMU until the slave sends data.
>  * Allows slave to set the number of queues, feature bits, etc via the
>    vhost-user socket.  It is not necessary to manually specify feature
>    bitmasks and other slave-specific information on the QEMU
>    command-line.
> 
> I haven't thought through disconnection but I imagine the vhost-user
> object would emit a VHOST_USER_DISCONNECTED event so the management
> software can hot unplug the device.
> 
> Thoughts?
> 
> Stefan

This sounds like an interesting set of ideas to me.
Something to keep in mind for the future.

Thanks!

-- 
MST
