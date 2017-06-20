Received: from eggs.gnu.org ([2001:4830:134:3::10]:54522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNMLa-00055R-7D
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNMLX-0000xC-1s
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:49:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNMLW-0000wc-So
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:49:42 -0400
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
Date: Tue, 20 Jun 2017 18:49:33 +0200
MIME-Version: 1.0
In-Reply-To: <1497977049.20270.100.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rik van Riel <riel@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>

On 20.06.2017 18:44, Rik van Riel wrote:
> On Mon, 2017-06-12 at 07:10 -0700, Dave Hansen wrote:
> 
>> The hypervisor is going to throw away the contents of these pages,
>> right?  As soon as the spinlock is released, someone can allocate a
>> page, and put good data in it.  What keeps the hypervisor from
>> throwing
>> away good data?
> 
> That looks like it may be the wrong API, then?
> 
> We already have hooks called arch_free_page and
> arch_alloc_page in the VM, which are called when
> pages are freed, and allocated, respectively.
> 
> Nitesh Lal (on the CC list) is working on a way
> to efficiently batch recently freed pages for
> free page hinting to the hypervisor.
> 
> If that is done efficiently enough (eg. with
> MADV_FREE on the hypervisor side for lazy freeing,
> and lazy later re-use of the pages), do we still
> need the harder to use batch interface from this
> patch?
> 
David's opinion incoming:

No, I think proper free page hinting would be the optimum solution, if
done right. This would avoid the batch interface and even turn
virtio-balloon in some sense useless.

-- 

Thanks,

David
