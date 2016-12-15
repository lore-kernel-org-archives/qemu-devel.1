Received: from eggs.gnu.org ([2001:4830:134:3::10]:60085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHUHC-0002Qa-OV
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHUH7-0003wX-NF
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:32:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43814
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHUH7-0003vn-H5
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:32:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBFBOjNT134130
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 06:32:36 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bt84gbms-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 06:32:36 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 15 Dec 2016 11:32:33 -0000
References: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
	<20161215105257.GD2509@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 12:32:31 +0100
MIME-Version: 1.0
In-Reply-To: <20161215105257.GD2509@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>



On 12/15/2016 11:52 AM, Dr. David Alan Gilbert wrote:
>> We got a bugreport with this log for a live migration target. 
>>
>> 2016-12-13T18:59:03.647309Z qemu-system-s390x: VQ 1 size 0x100 < last_avail_idx 0x2f76 - used_idx 0x762f
> Is this actually an endian problem - 2f76 vs 762f ?
> 
> Dave
> 

Thanks! It seems you are right:

static inline uint16_t vring_avail_idx(VirtQueue *vq)
{
    hwaddr pa;
    pa = vq->vring.avail + offsetof(VRingAvail, idx);
    vq->shadow_avail_idx = virtio_lduw_phys(vq->vdev, pa);

we should have an endiannes handling here before assigning shadow_avail_idx I guess

    return vq->shadow_avail_idx;
} 

I will meditate a bit more on this and probably create a patch to fix it.

What make me wonder is that according to the reports live migration usually
works (ca 1% fails)...

Can I credit you as reporter in case I end up making a fix?

Halil
