Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRJJj-0005mK-IJ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRJJg-0002VA-Qm
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:56:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRJJg-0002UH-K9
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:56:24 -0500
Date: Tue, 19 Dec 2017 16:56:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219161754-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171219113505.GA8499@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219113505.GA8499@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com

>  * Please handle short reads/writes and EAGAIN with the UNIX domain socket.  Do
>    not use read/write_all() functions because they hang QEMU until I/O
>    completes.

I'm not sure I agree with this one. vhost-user uses this extensively
right now. It might be a worth-while goal to drop this limitation
but I don't see why we should start with vhost-pci.

And in particular, VCPU can't make progress unless a slave is present.

>  * What happens when the vhost-user master disconnects while we're running?
> 
>  * How does the guest know when the QEMU vhost-user slave has finished
>    initializing everything?  It seems like a guest driver could access the
>    device before things are initialized.
> 
>  * How can the vhost-user slave inside the guest participate in feature
>    negotiation?  It must be able to participate, otherwise slaves cannot
>    disable features that QEMU supports but they don't want to support.
> 
>    It's not feasible to pass in host_features as a QEMU parameter because
>    that would require libvirt, OpenStack, cloud providers, etc to add
>    support so users can manually set the bits for their slave
>    implementation.
>
>  * How can the the guest limit the number of virtqueues?

I think it is feasible to pass in host features, # of vqs etc.  Assuming
compatibility with existing guests, I don't think you can do anything
else really if you assume that vhost guest might boot after the
virtio guest.

So either you give up on compatibility, or you allow the vhost
guest to block the virtio guest.

I think compatibility is more important.

We can later think about ways to add non-blocking behaviour
as a feature.

> 
>  * Please include tests.  See tests/virtio-net-test.c and
>    tests/vhost-user-test.c for examples.

Unit tests are nice but an actual way to test without
running a full blown dpdk stack would be nicer.
Something along the lines of a port of vhost user bridge
to the guest.

-- 
MST
