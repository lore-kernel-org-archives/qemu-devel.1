Received: from eggs.gnu.org ([2001:4830:134:3::10]:35990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dNfBI-0004i6-5j
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dNfBD-0007OF-84
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:56:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dNfBC-0007Nj-UD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:56:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5LCsRlc132204
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:56:16 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b7qckpbpf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:56:16 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 21 Jun 2017 06:56:15 -0600
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 21 Jun 2017 14:56:03 +0200
MIME-Version: 1.0
In-Reply-To: <7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <c5f8cf53-c30b-a7ec-a8e8-9a2c120bdff6@de.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Rik van Riel <riel@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>

On 06/20/2017 06:49 PM, David Hildenbrand wrote:
> On 20.06.2017 18:44, Rik van Riel wrote:
>> On Mon, 2017-06-12 at 07:10 -0700, Dave Hansen wrote:
>>
>>> The hypervisor is going to throw away the contents of these pages,
>>> right?  As soon as the spinlock is released, someone can allocate a
>>> page, and put good data in it.  What keeps the hypervisor from
>>> throwing
>>> away good data?
>>
>> That looks like it may be the wrong API, then?
>>
>> We already have hooks called arch_free_page and
>> arch_alloc_page in the VM, which are called when
>> pages are freed, and allocated, respectively.
>>
>> Nitesh Lal (on the CC list) is working on a way
>> to efficiently batch recently freed pages for
>> free page hinting to the hypervisor.
>>
>> If that is done efficiently enough (eg. with
>> MADV_FREE on the hypervisor side for lazy freeing,
>> and lazy later re-use of the pages), do we still
>> need the harder to use batch interface from this
>> patch?
>>
> David's opinion incoming:
> 
> No, I think proper free page hinting would be the optimum solution, if
> done right. This would avoid the batch interface and even turn
> virtio-balloon in some sense useless.
> 
Two reasons why I disagree:
- virtio-balloon is often used as memory hotplug. (e.g. libvirts current/max memory
uses virtio ballon)
- free page hinting will not allow to shrink the page cache of guests (like a ballooner does)
