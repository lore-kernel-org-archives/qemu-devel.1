Received: from eggs.gnu.org ([2001:4830:134:3::10]:42799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjT51-0007Nv-PH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjT4y-0000hu-K9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:55:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58939
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cjT4y-0000hh-DM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:55:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v22Floxj054730
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 10:55:43 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xpbs0bq6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 10:55:43 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 2 Mar 2017 15:55:40 -0000
References: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
	<20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
	<b12c69aa-67ee-ffbc-cd89-716c24889167@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 2 Mar 2017 16:55:37 +0100
MIME-Version: 1.0
In-Reply-To: <b12c69aa-67ee-ffbc-cd89-716c24889167@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <9a67d492-5bda-4b2a-0732-4034176d0d28@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org



On 03/02/2017 04:32 PM, Paolo Bonzini wrote:
> 
> 
> On 02/03/2017 15:49, Cornelia Huck wrote:
>> On Thu,  2 Mar 2017 14:04:22 +0100
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
>>> index 5556f0e..13dd14d 100644
>>> --- a/hw/block/dataplane/virtio-blk.c
>>> +++ b/hw/block/dataplane/virtio-blk.c
>>> @@ -258,9 +258,16 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
>>>          virtio_queue_aio_set_host_notifier_handler(vq, s->ctx, NULL);
>>>      }
>>>
>>> -    /* Drain and switch bs back to the QEMU main loop */
>>> +    /* Drain and switch bs back to the QEMU main loop. After drain, the
>>> +     * device will not submit (nor comple) any requests until dataplane
>>
>> s/comple/complete/
>>

Will fix.

>>> +     * starts again.
>>> +     */
>>>      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());

I'm wondering if synchronization is needed for batch_notify_vqs. I think
the set_bit can be from the iothread, but the notify_guest_bh below is main
event loop. Is it OK like this (could we miss bits set in other thread)?
Does blk_set_aio_context include a barrier?

>>>
>>> +    /* Notify guest before the guest notifiers get cleaned up */
>>> +    qemu_bh_cancel(s->bh);
>>> +    notify_guest_bh(s);
>>> +
>>
>> Hm... does virtio-scsi dataplane need a similar treatment? Or am I
>> missing something?
> 
> No, the BH optimization is specific to virtio-blk.  Thanks for the patch
> Halil!
> 

You are welcome ;)!

Regards,
Halil
