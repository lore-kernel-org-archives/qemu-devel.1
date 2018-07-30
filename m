Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fk9vo-000122-HN
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fk9vl-0004ld-5b
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:17:56 -0400
References: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
	<1bf75ad8-dc90-b94e-0ead-53fdbc72dd4f@redhat.com>
	<b894e494-1dfc-8953-79e9-fde3f9560c77@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9bdf3ea6-d0f4-d637-3e34-eb43a9821434@redhat.com>
Date: Mon, 30 Jul 2018 17:17:49 +0200
MIME-Version: 1.0
In-Reply-To: <b894e494-1dfc-8953-79e9-fde3f9560c77@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/1] s390x/sclp: fix maxram
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, imbrenda@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>

On 30.07.2018 17:00, Christian Borntraeger wrote:
> 
> 
> On 07/30/2018 04:34 PM, David Hildenbrand wrote:
>> On 30.07.2018 16:09, Christian Borntraeger wrote:
>>> We clamp down ram_size to match the sclp increment size. We do
>>> not do the same for maxram_size, which means for large guests
>>> with some sizes (e.g. -m 50000) maxram_size differs from ram_size.
>>> This can break other code (e.g. CMMA migration) which uses maxram_size
>>> to calculate the number of pages and then throws some errors.
>>
>> So the only problem is that the buffer size between source and target
>> differ?
> 
> The problem is that the target tries to access a non-existing buffer when 
> committing all cmma value, so the kernel returns with EFAULT.
>>

Am I wrong or does CMMA migration code really not care about which parts
of maxram are actually used (== which memory regions are actually defined)?

If so, this looks broken to me and the right fix is to use ramsize for
now, because it simply does not support maxram.

(I assume using some -m X,maxmem=X+Y would make it fail in the same way)

(this patch still makes sense and should be done)


-- 

Thanks,

David / dhildenb
