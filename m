Received: from eggs.gnu.org ([2001:4830:134:3::10]:44215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cj4Dg-00065d-Ve
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cj4Dc-0002n5-W6
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:23:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50443
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cj4Dc-0002mo-PP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:23:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21DJdeA095530
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 08:23:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wxr81j9d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 08:22:59 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 13:22:57 -0000
References: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
	<331bf747-0c32-0f1a-eda0-40e6fa507494@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 14:22:55 +0100
MIME-Version: 1.0
In-Reply-To: <331bf747-0c32-0f1a-eda0-40e6fa507494@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <e78274bf-ed9b-3358-0a5d-271854247da1@linux.vnet.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 03/01/2017 01:57 PM, Paolo Bonzini wrote:
> 
> 
> On 01/03/2017 12:50, Halil Pasic wrote:
>> The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
>> 9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
>> changed how notifications are done for virtio-blk substantially. Due to a
>> race condition interrupts are lost when irqfd is torn down after
>> notify_guest_bh was scheduled but before it actually runs.
> 
> I don't think the non-irqfd notification mechanism is thread safe, and
> that would be a problem for this patch.

Sorry, haven't looked into that thoroughly (and speculated people with
more understanding will jump in).

> 
> What is the path that causes the irqfd to be torn down?  Only something

Here a trace:

135871@1488304024.512533:virtio_blk_req_complete req 0x2aa6b117e10 status 0
135871@1488304024.512541:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
135871@1488304024.522607:virtio_blk_req_complete req 0x2aa6b118980 status 0
135871@1488304024.522616:virtio_blk_req_complete req 0x2aa6b119260 status 0
135871@1488304024.522627:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
135871@1488304024.527386:virtio_blk_req_complete req 0x2aa6b118980 status 0
135871@1488304024.527431:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
135871@1488304024.528611:virtio_guest_notifier_read vdev 0x2aa6b0e61c8 vq 0x2aa6b4de880
135871@1488304024.528628:virtio_guest_notifier_read vdev 0x2aa6b0e61c8 vq 0x2aa6b4de8f8
135871@1488304024.528753:virtio_blk_data_plane_stop dataplane 0x2aa6b0e5540
                         ^== DATAPLANE STOP  
135871@1488304024.530709:virtio_blk_req_complete req 0x2aa6b117e10 status 0
135871@1488304024.530752:virtio_guest_notifier_read vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
                         ^== comes from k->set_guest_notifiers(qbus->parent, nvqs, false);
                             in virtio_blk_data_plane_stop and done immediately after
                             irqfd is cleaned up by the transport
135871@1488304024.530836:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
halil: error in event_notifier_set: Bad file descriptor
                         ^== here we have the problem

If you want a stacktrace that can be arranged to.

> like a reset should cause it (the only call in virtio-blk is from
> virtio_blk_data_plane_stop), and then the guest doesn't care anymore
> about interrupts.

I do not understand this with 'doesn't care anymore about interrupts'.
I was debugging a virtio-blk device being stuck waiting for a host
notification (interrupt) after migration.

> 
> That path also does a qemu_bh_delete, so the notify_guest_bh should not
> be invoked at all.
> 

That's only for destroy. I'm migrating.

Seems I tried to fix this is the wrong way. Was not too confident about it
in the first place. Suggestions welcome!

Cheers,
Halil
