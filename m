Received: from eggs.gnu.org ([2001:4830:134:3::10]:46854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eSIvT-0006dr-NP
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eSIvR-0005OF-3d
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:43:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:63863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eSIvQ-0005Mi-RX
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:43:29 -0500
Message-ID: <5A3CC62D.6020001@intel.com>
Date: Fri, 22 Dec 2017 16:45:33 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>	<20171221141805.GA27695@bombadil.infradead.org>
	<201712212337.JFC57368.tLFOJFVSFHMOOQ@I-love.SAKURA.ne.jp>
In-Reply-To: <201712212337.JFC57368.tLFOJFVSFHMOOQ@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 3/7 RESEND] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com

On 12/21/2017 10:37 PM, Tetsuo Handa wrote:
> Matthew Wilcox wrote:
>>> +/**
>>> + * xb_find_set - find the next set bit in a range of bits
>>> + * @xb: the xbitmap to search from
>>> + * @offset: the offset in the range to start searching
>>> + * @size: the size of the range
>>> + *
>>> + * Returns: the found bit or, @size if no set bit is found.
>>> + */
>>> +unsigned long xb_find_set(struct xb *xb, unsigned long size,
>>> +			  unsigned long offset)
>>> +{
>>> +	struct radix_tree_root *root = &xb->xbrt;
>>> +	struct radix_tree_node *node;
>>> +	void __rcu **slot;
>>> +	struct ida_bitmap *bitmap;
>>> +	unsigned long index = offset / IDA_BITMAP_BITS;
>>> +	unsigned long index_end = size / IDA_BITMAP_BITS;
>>> +	unsigned long bit = offset % IDA_BITMAP_BITS;
>>> +
>>> +	if (unlikely(offset >= size))
>>> +		return size;
>>> +
>>> +	while (index <= index_end) {
>>> +		unsigned long ret;
>>> +		unsigned int nbits = size - index * IDA_BITMAP_BITS;
>>> +
>>> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
>>> +
>>> +		if (!node && !bitmap)
>>> +			return size;
>>> +
>>> +		if (bitmap) {
>>> +			if (nbits > IDA_BITMAP_BITS)
>>> +				nbits = IDA_BITMAP_BITS;
>>> +
>>> +			ret = find_next_bit(bitmap->bitmap, nbits, bit);
>>> +			if (ret != nbits)
>>> +				return ret + index * IDA_BITMAP_BITS;
>>> +		}
>>> +		bit = 0;
>>> +		index++;
>>> +	}
>>> +
>>> +	return size;
>>> +}
>>> +EXPORT_SYMBOL(xb_find_set);
>> This is going to be slower than the implementation I sent yesterday.  If I
>> call:
>> 	xb_init(xb);
>> 	xb_set_bit(xb, ULONG_MAX);
>> 	xb_find_set(xb, ULONG_MAX, 0);
>>
>> it's going to call __radix_tree_lookup() 16 quadrillion times.
>> My implementation will walk the tree precisely once.
>>
> Yes. Wei's patch still can not work.
> We should start reviewing Matthew's implementation.

It runs without any issue on my machine. I didn't generate an "xbitmap" 
executable (I just found adding xbitmap executable causes a build error 
due to a Makefile error), instead, I tested it within "main" and it 
passed all the tests.

Matthew has implemented a new version, let's start from there.

Best,
Wei
