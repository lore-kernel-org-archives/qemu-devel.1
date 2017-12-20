Received: from eggs.gnu.org ([2001:4830:134:3::10]:47156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRY8k-0007ya-4q
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRY8f-0006iM-6K
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:46:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRY8e-0006hb-VR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 01:46:01 -0500
Date: Wed, 20 Dec 2017 14:45:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171220064548.GB3735@lemon>
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n.nikolaev@virtualopensystems.com, Wei Wang <wei.w.wang@intel.com>, mukawa@igel.co.jp, marcandre.lureau@redhat.com

On Tue, 12/19 16:21, Stefan Hajnoczi wrote:
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
> 
> 2. When the vhost-user connection is established the object emits a QMP
>    event so management software can hotplug the virtio device:
> 
>    VHOST_USER_CONNECTED source=vhost-user0
> 
> 3. The management software hotplugs the virtio device:
> 
>    (qmp) netdev_add vhost-user,id=netdev0,vhost-user=vhost-user0
>    (qmp) device_add virtio-net-pci,netdev=netdev0

Why cannot the management software start the slave then hot plug chardev +
netdev + virtio-net-pci? That way we don't need the vhost-user connected event.

Fam
