Received: from eggs.gnu.org ([2001:4830:134:3::10]:39980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQ9S1-0001Mf-RO
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQ9Rx-0004KM-Ra
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:12:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:16737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eQ9Rx-0004IU-HQ
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:12:09 -0500
Message-ID: <5A34F1F4.6010900@intel.com>
Date: Sat, 16 Dec 2017 18:14:12 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>	<5A311C5E.7000304@intel.com>	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
In-Reply-To: <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
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

On 12/15/2017 12:29 AM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> I used the example of xb_clear_bit_range(), and xb_find_next_bit() is
>> the same fundamentally. Please let me know if anywhere still looks fuzzy.
> I don't think it is the same for xb_find_next_bit() with set == 0.
>
> +		if (radix_tree_exception(bmap)) {
> +			unsigned long tmp = (unsigned long)bmap;
> +			unsigned long ebit = bit + 2;
> +
> +			if (ebit >= BITS_PER_LONG)
> +				continue;
> +			if (set)
> +				ret = find_next_bit(&tmp, BITS_PER_LONG, ebit);
> +			else
> +				ret = find_next_zero_bit(&tmp, BITS_PER_LONG,
> +							 ebit);
> +			if (ret < BITS_PER_LONG)
> +				return ret - 2 + IDA_BITMAP_BITS * index;
>
> What I'm saying is that find_next_zero_bit() will not be called if you do
> "if (ebit >= BITS_PER_LONG) continue;" before calling find_next_zero_bit().
>
> When scanning "0000000000000000000000000000000000000000000000000000000000000001",
> "bit < BITS_PER_LONG - 2" case finds "0" in this word but
> "bit >= BITS_PER_LONG - 2" case finds "0" in next word or segment.
>
> I can't understand why this is correct behavior. It is too much puzzling.
>

OK, I'll post out a version without the exceptional path.

Best,
Wei
