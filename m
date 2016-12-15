Received: from eggs.gnu.org ([2001:4830:134:3::10]:34402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHUN8-0004Ao-Tp
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHUN3-0008Bs-U0
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHUN3-0008Bk-OH
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:38:45 -0500
Date: Thu, 15 Dec 2016 11:38:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215113840.GF2509@work-vm>
References: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
	<20161215105257.GD2509@work-vm>
	<b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 12/15/2016 11:52 AM, Dr. David Alan Gilbert wrote:
> >> We got a bugreport with this log for a live migration target. 
> >>
> >> 2016-12-13T18:59:03.647309Z qemu-system-s390x: VQ 1 size 0x100 < last_avail_idx 0x2f76 - used_idx 0x762f
> > Is this actually an endian problem - 2f76 vs 762f ?
> > 
> > Dave
> > 
> 
> Thanks! It seems you are right:
> 
> static inline uint16_t vring_avail_idx(VirtQueue *vq)
> {
>     hwaddr pa;
>     pa = vq->vring.avail + offsetof(VRingAvail, idx);
>     vq->shadow_avail_idx = virtio_lduw_phys(vq->vdev, pa);
> 
> we should have an endiannes handling here before assigning shadow_avail_idx I guess
> 
>     return vq->shadow_avail_idx;
> } 
> 
> I will meditate a bit more on this and probably create a patch to fix it.
> 
> What make me wonder is that according to the reports live migration usually
> works (ca 1% fails)...

> Can I credit you as reporter in case I end up making a fix?

Sure if you want.

Dave

> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
