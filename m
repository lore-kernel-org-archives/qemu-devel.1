Received: from eggs.gnu.org ([2001:4830:134:3::10]:38337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHWEk-0000rc-3U
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHWEe-0006St-Gd
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:38:18 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cHWEe-0006Se-9u
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:38:12 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so9828425wjc.2
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 05:38:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
	<20161215105257.GD2509@work-vm>
	<b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04b36158-a381-298f-1d81-d1bd18f3cec7@redhat.com>
Date: Thu, 15 Dec 2016 14:37:08 +0100
MIME-Version: 1.0
In-Reply-To: <b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>



On 15/12/2016 12:32, Halil Pasic wrote:
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

Endianness is already handled:

static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
{
    if (virtio_access_is_big_endian(vdev)) {
        return lduw_be_phys(&address_space_memory, pa);
    }
    return lduw_le_phys(&address_space_memory, pa);
}

> I will meditate a bit more on this and probably create a patch to fix it.
> 
> What make me wonder is that according to the reports live migration usually
> works (ca 1% fails)...

What is the backtrace of the vring_avail_idx call?  If your device is
virtio 1.0, and vdev->guest_features has not been initialized correctly,
you might incorrectly treat LE virtio 1.0 data as BE virtio 0.9 data:

    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
        return false;
    }
    return true;

Thanks,

Paolo
