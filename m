Received: from eggs.gnu.org ([2001:4830:134:3::10]:41972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1cEeEp-0000A3-MN
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1cEeEm-0006BP-Iw
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:34:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:59256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dave.hansen@intel.com>)
	id 1cEeEm-00069w-7I
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:34:28 -0500
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f7b47cc4-ee94-bacb-5a17-d049b402263e@intel.com>
Date: Wed, 7 Dec 2016 07:34:23 -0800
MIME-Version: 1.0
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Li, Liang Z" <liang.z.li@intel.com>, David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>

On 12/07/2016 05:35 AM, Li, Liang Z wrote:
>> Am 30.11.2016 um 09:43 schrieb Liang Li:
>> IOW in real examples, do we have really large consecutive areas or are all
>> pages just completely distributed over our memory?
> 
> The buddy system of Linux kernel memory management shows there should
> be quite a lot of consecutive pages as long as there are a portion of
> free memory in the guest.
...
> If all pages just completely distributed over our memory, it means
> the memory fragmentation is very serious, the kernel has the
> mechanism to avoid this happened.

While it is correct that the kernel has anti-fragmentation mechanisms, I
don't think it invalidates the question as to whether a bitmap would be
too sparse to be effective.

> In the other hand, the inflating should not happen at this time because the guest is almost
> 'out of memory'.

I don't think this is correct.  Most systems try to run with relatively
little free memory all the time, using the bulk of it as page cache.  We
have no reason to expect that ballooning will only occur when there is
lots of actual free memory and that it will not occur when that same
memory is in use as page cache.

In these patches, you're effectively still sending pfns.  You're just
sending one pfn per high-order page which is giving a really nice
speedup.  IMNHO, you're avoiding doing a real bitmap because creating a
bitmap means either have a really big bitmap, or you would have to do
some sorting (or multiple passes) of the free lists before populating a
smaller bitmap.

Like David, I would still like to see some data on whether the choice
between bitmaps and pfn lists is ever clearly in favor of bitmaps.  You
haven't convinced me, at least, that the data isn't even worth collecting.
