Received: from eggs.gnu.org ([2001:4830:134:3::10]:57863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHYhg-00071j-AZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHYhc-0005Oc-Bp
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:16:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33956
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHYhc-0005OF-5G
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:16:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBFGFKxb105363
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 11:16:15 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bt851fcq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 11:16:15 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 15 Dec 2016 16:16:12 -0000
References: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
	<20161215105257.GD2509@work-vm>
	<b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
	<04b36158-a381-298f-1d81-d1bd18f3cec7@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 17:16:08 +0100
MIME-Version: 1.0
In-Reply-To: <04b36158-a381-298f-1d81-d1bd18f3cec7@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <1ca3b865-276d-8618-cd57-33593a82b7d7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] commit virtio: recalculate vq->inuse after
 migration might cause last_avail_idx vs. used_idx failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>



On 12/15/2016 02:37 PM, Paolo Bonzini wrote:
> 
> 
> On 15/12/2016 12:32, Halil Pasic wrote:
>> static inline uint16_t vring_avail_idx(VirtQueue *vq)
>> {
>>     hwaddr pa;
>>     pa = vq->vring.avail + offsetof(VRingAvail, idx);
>>     vq->shadow_avail_idx = virtio_lduw_phys(vq->vdev, pa);
>>
>> we should have an endiannes handling here before assigning shadow_avail_idx I guess
>>
>>     return vq->shadow_avail_idx;
>> } 
> 
> Endianness is already handled:
> 
> static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
> {
>     if (virtio_access_is_big_endian(vdev)) {
>         return lduw_be_phys(&address_space_memory, pa);
>     }
>     return lduw_le_phys(&address_space_memory, pa);
> }

Thanks Paolo, you are obviously right. Sorry for the noise.

> 
>> I will meditate a bit more on this and probably create a patch to fix it.
>>
>> What make me wonder is that according to the reports live migration usually
>> works (ca 1% fails)...


Seems I will have to get a dump and/or reproduce the problem myself
before I can tell what is going on there  -- the guru saved me some
meditation.

> 
> What is the backtrace of the vring_avail_idx call?  If your device is

As far as I can see from the code the guest features should be already
loaded from the migration stream.

Thanks again!

Halil

> virtio 1.0, and vdev->guest_features has not been initialized correctly,
> you might incorrectly treat LE virtio 1.0 data as BE virtio 0.9 data:
> 
>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>         return false;
>     }
>     return true;
> 
> Thanks,
> 
> Paolo
> 
