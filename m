Received: from eggs.gnu.org ([209.51.188.92]:44776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEd5m-0005Nk-GQ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEd5l-0007Lr-Dw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:02:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hEd5l-0007L7-3D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:02:25 -0400
Date: Thu, 11 Apr 2019 19:02:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190411190215.2163572e.cohuck@redhat.com>
In-Reply-To: <20190411110157.14252-1-yuval.shaia@oracle.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com, linux-rdma@vger.kernel.org, jgg@mellanox.com

On Thu, 11 Apr 2019 14:01:54 +0300
Yuval Shaia <yuval.shaia@oracle.com> wrote:

> Data center backends use more and more RDMA or RoCE devices and more and
> more software runs in virtualized environment.
> There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> 
> Virtio is the optimal solution since is the de-facto para-virtualizaton
> technology and also because the Virtio specification
> allows Hardware Vendors to support Virtio protocol natively in order to
> achieve bare metal performance.
> 
> This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> Virtio Specification and a look forward on possible implementation
> techniques.
> 
> Open issues/Todo list:
> List is huge, this is only start point of the project.
> Anyway, here is one example of item in the list:
> - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
>   in order to support for example 32K QPs we will need 64K VirtQ. Not sure
>   that this is reasonable so one option is to have one for all and
>   multiplex the traffic on it. This is not good approach as by design it
>   introducing an optional starvation. Another approach would be multi
>   queues and round-robin (for example) between them.
> 
> Expectations from this posting:
> In general, any comment is welcome, starting from hey, drop this as it is a
> very bad idea, to yeah, go ahead, we really want it.
> Idea here is that since it is not a minor effort i first want to know if
> there is some sort interest in the community for such device.

My first reaction is: Sounds sensible, but it would be good to have a
spec for this :)

You'll need a spec if you want this to go forward anyway, so at least a
sketch would be good to answer questions such as how many virtqueues
you use for which purpose, what is actually put on the virtqueues,
whether there are negotiable features, and what the expectations for
the device and the driver are. It also makes it easier to understand
how this is supposed to work in practice.

If folks agree that this sounds useful, the next step would be to
reserve an id for the device type.

> 
> The scope of the implementation is limited to probing the device and doing
> some basic ibverbs commands. Data-path is not yet implemented. So with this
> one can expect only that driver is (partialy) loaded and basic queries and
> resource allocation is done.
> 
> One note regarding the patchset.
> I know it is not standard to collaps patches from several repos as i did
> here (qemu and linux) but decided to do it anyway so the whole picture can
> be seen.
> 
> patch 1: virtio-net: Move some virtio-net-pci decl to include/hw/virtio
> 	This is a prelimenary patch just as a hack so i will not need to
> 	impelement new netdev
> patch 2: hw/virtio-rdma: VirtIO rdma device
> 	The implementation of the device
> patch 3: RDMA/virtio-rdma: VirtIO rdma driver
> 	The device driver
> 
