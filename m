Received: from eggs.gnu.org ([2001:4830:134:3::10]:46847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cj4Lu-0001HV-LB
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cj4Lq-0005YD-Lv
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:31:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49438
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cj4Lq-0005Wx-FM
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:31:30 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21DTBlF020877
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 08:31:27 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28wxrahxk2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 08:31:27 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 13:31:19 -0000
References: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
	<20170301145306-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 14:31:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170301145306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <d118429d-f9e5-1c44-2223-6ce7bf97575a@linux.vnet.ibm.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 03/01/2017 01:54 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 01, 2017 at 12:50:04PM +0100, Halil Pasic wrote:
>> The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
>> 9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
>> changed how notifications are done for virtio-blk substantially. Due to a
>> race condition interrupts are lost when irqfd is torn down after
>> notify_guest_bh was scheduled but before it actually runs.  Furthermore
>> virtio_notify_irqfd ignores the value returned by event_notifier_set
>> which correctly indicates that notification has failed due to bad file
>> descriptor.
>>
>> Let's fix this by making virtio_notify_irqfd fall back to the non-irqfd
>> notification mechanism if event_notifier_set fails.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> This is probably not the only way to fix this: suggestions welcome. I
>> did not use a fixes tag because I'm not sure yet where exactly things got
>> broken. Maybe guys more familiar with dataplane an coroutines can help
>> (Paolo, Stefan).
>> ---
>>  hw/virtio/virtio.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 23483c7..8e1c1e9 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -1581,7 +1581,9 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
>>       * to an atomic operation.
>>       */
>>      virtio_set_isr(vq->vdev, 0x1);
>> -    event_notifier_set(&vq->guest_notifier);
>> +    if (event_notifier_set(&vq->guest_notifier)) {
>> +        virtio_notify_vector(vdev, vq->vector);
>> +    }
> 
> Does this fail because the underlying fd got closed?

Yes. Its data_plane_stop()->virtio_ccw_set_guest_notifier->event_notifier_cleanup().
The function event_notifier_cleanup() does not set fds to -1 :(.
Seems to me, it would be safer to do so. Should I make a patch?

> Then there's a problem: trying to write to a closed
> fd might corrupt an unrelated fd.
> If you want to use this way we need to set fds to -1 when we close.

Sorry, did not check for that. OTOH Paolo says my approach is
fundamentally flawed because virtio_notify_vector is not thread
safe. I suggest we continue the discussion there.

Regards,
Halil

> 
>>  }
>>  
>>  static void virtio_irq(VirtQueue *vq)
>> -- 
>> 2.8.4
> 
