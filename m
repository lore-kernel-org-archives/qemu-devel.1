Received: from eggs.gnu.org ([2001:4830:134:3::10]:58945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePRxE-0008Vo-0e
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePRxA-0003EA-TQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:45:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:59162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ePRxA-0003CC-It
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:45:28 -0500
Message-ID: <5A3264D1.8090405@intel.com>
Date: Thu, 14 Dec 2017 19:47:29 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>	<5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
In-Reply-To: <5A31F445.6070504@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v19 3/7] xbitmap: add more
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On 12/14/2017 11:47 AM, Wei Wang wrote:
> On 12/13/2017 10:16 PM, Tetsuo Handa wrote:
>
>
>>
>>>                           if (set)
>>>                                   ret = find_next_bit(&tmp,
>>> BITS_PER_LONG, ebit);
>>>                           else
>>>                                   ret = find_next_zero_bit(&tmp,
>>> BITS_PER_LONG,
>>> ebit);
>>>                           if (ret < BITS_PER_LONG)
>>>                                   return ret - 2 + ida_start;
>>>                   } else if (bitmap) {
>>>                           if (set)
>>>                                   ret = find_next_bit(bitmap->bitmap,
>>> IDA_BITMAP_BITS, bit);
>>>                           else
>>>                                   ret = 
>>> find_next_zero_bit(bitmap->bitmap,
>>> IDA_BITMAP_BITS, bit);
>> "bit" may not be 0 for the first round and "bit" is always 0 afterwords.
>> But where is the guaranteed that "end" is a multiple of 
>> IDA_BITMAP_BITS ?
>> Please explain why it is correct to use IDA_BITMAP_BITS unconditionally
>> for the last round.
>
> There missed something here, it will be:
>
> nbits = min(end - ida_start + 1, IDA_BITMAP_BITS - bit);


captured a bug here, should be:
nbits = min(end - ida_start + 1, (unsigned long)IDA_BITMAP_BITS);


> if (set)
>     ret = find_next_bit(bitmap->bitmap, nbits, bit);
> else
>     ret = find_next_zero_bit(bitmap->bitmap,
>                                            nbits, bit);
> if (ret < nbits)
>     return ret + ida_start;
>
>

Best,
Wei
