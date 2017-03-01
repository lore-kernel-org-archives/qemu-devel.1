Received: from eggs.gnu.org ([2001:4830:134:3::10]:37031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjAJu-0004jP-J3
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjAJq-0005aK-Da
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:53:54 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cjAJq-0005Zq-6T
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:53:50 -0500
Received: by mail-wr0-x243.google.com with SMTP id l37so6844508wrc.3
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 11:53:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
	<331bf747-0c32-0f1a-eda0-40e6fa507494@redhat.com>
	<e78274bf-ed9b-3358-0a5d-271854247da1@linux.vnet.ibm.com>
	<b24ba9f9-11f4-d17f-1973-b94e82316518@redhat.com>
	<08ca0c91-4a6d-1750-ed79-a0f6e2ca7eaf@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee3d0300-27c2-8d1e-c29e-51d7165af0ec@redhat.com>
Date: Wed, 1 Mar 2017 20:53:46 +0100
MIME-Version: 1.0
In-Reply-To: <08ca0c91-4a6d-1750-ed79-a0f6e2ca7eaf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fallback from irqfd to
 non-irqfd notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 01/03/2017 17:08, Halil Pasic wrote:
> applied I do not see the problem any more. I will most likely
> turn this into a patch tomorrow. I would like to give it some more testing and
> thinking (see questions below) until tomorrow.
> 
> I should probably cc stable, or?

Yes, please do!

> 
> Q1. For this to work correctly, it seems to me, we need to be sure that
> virtio_blk_req_complete can not be happen between the newly added
> notify_guest_bh(s);
> and 
> vblk->dataplane_started = false; 
> becomes visible. How is this ensured?

blk_set_aio_context drains the block device, and the event notifiers are
not active anymore so draining the block device coincides with the last
call to virtio_blk_req_complete.

Please add a comment - it's a good observation.

> Q2. The virtio_blk_data_plane_stop should be from the thread/context
> associated with the main event loop, and with that
> vblk->dataplane_started = false too. But I think dataplane_started
> may end up being used form a different thread (e.g. req_complete).

1) virtio_queue_aio_set_host_notifier_handler stops the event notifiers

2) virtio_bus_set_host_notifier invokes them one last time before exiting

Note that this could call again virtio_queue_notify_vq and hence
virtio_device_start_ioeventfd, but dataplane won't be reactivated
because vblk->dataplane_started is still true.

> How does the sequencing work there and/or is it even important?

It is important and not really easy to get right---as shown by the bug
you found, in fact.

Thanks,

Paolo
