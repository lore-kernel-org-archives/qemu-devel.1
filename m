Received: from eggs.gnu.org ([2001:4830:134:3::10]:52700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fk8co-00058s-UC
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fk8cl-0004w4-RT
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:54:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fk8cl-0004v3-Ku
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:54:11 -0400
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180730163123-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <57aca548-b6f3-eae3-3b2e-a25523294a7d@redhat.com>
Date: Mon, 30 Jul 2018 15:54:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180730163123-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On 30.07.2018 15:34, Michael S. Tsirkin wrote:
> On Tue, Jul 17, 2018 at 04:47:31PM -0600, Alex Williamson wrote:
>> Directly assigned vfio devices have never been compatible with
>> ballooning.  Zapping MADV_DONTNEED pages happens completely
>> independent of vfio page pinning and IOMMU mapping, leaving us with
>> inconsistent GPA to HPA mapping between vCPUs and assigned devices
>> when the balloon deflates.  Mediated devices can theoretically do
>> better, if we make the assumption that the mdev vendor driver is fully
>> synchronized to the actual working set of the guest driver.  In that
>> case the guest balloon driver should never be able to allocate an mdev
>> pinned page for balloon inflation.  Unfortunately, QEMU can't know the
>> workings of the vendor driver pinning, and doesn't actually know the
>> difference between mdev devices and directly assigned devices.  Until
>> we can sort out how the vfio IOMMU backend can tell us if ballooning
>> is safe, the best approach is to disabling ballooning any time a vfio
>> devices is attached.
>>
>> To do that, simply make the balloon inhibitor a counter rather than a
>> boolean, fixup a case where KVM can then simply use the inhibit
>> interface, and inhibit ballooning any time a vfio device is attached.
>> I'm expecting we'll expose some sort of flag similar to
>> KVM_CAP_SYNC_MMU from the vfio IOMMU for cases where we can resolve
>> this.  An addition we could consider here would be yet another device
>> option for vfio, such as x-disable-balloon-inhibit, in case there are
>> mdev devices that behave in a manner compatible with ballooning.
>>
>> Please let me know if this looks like a good idea.  Thanks,
>>
>> Alex
> 
> It's probably the only a reasonable thing to do for this release.
> 
> Long term however, why can't balloon notify vfio as pages are
> added and removed? VFIO could update its mappings then.

What if the guest is rebooted and pages are silently getting reused
without getting a deflation request first?

-- 

Thanks,

David / dhildenb
