Received: from eggs.gnu.org ([2001:4830:134:3::10]:58196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eS0S0-0003ul-Pm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eS0Rx-0003ZF-Jd
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:59:52 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:50354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eS0Rx-00021S-42
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:59:49 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <5A3A3CBC.4030202@intel.com>
	<20171220122547.GA1654@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F73938CC3E@shsmsx102.ccr.corp.intel.com>
	<20171220171019.GA12236@bombadil.infradead.org>
	<5A3B2148.8050306@intel.com>
In-Reply-To: <5A3B2148.8050306@intel.com>
Message-Id: <201712212156.AGC09823.OVFtFMJHOSFOLQ@I-love.SAKURA.ne.jp>
Date: Thu, 21 Dec 2017 21:56:55 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v20 0/7] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> Thanks for the effort. That's actually caused by the previous "!node" 
> path, which incorrectly changed "index = (index | RADIX_TREE_MAP_MASK) + 
> 1". With the change below, it will run pretty well with the test cases.
> 
> if (!node && !bitmap)
>      return size;
> 
> Would you mind to have a try with the v20 RESEND patch that was just 
> shared?

No. Please explain what "!node" situation indicates. Why did you try
"index = (index | RADIX_TREE_MAP_MASK) + 1; continue;" in the previous patch?

+unsigned long xb_find_set(struct xb *xb, unsigned long size,
+			  unsigned long offset)
+{
+	struct radix_tree_root *root = &xb->xbrt;
+	struct radix_tree_node *node;
+	void __rcu **slot;
+	struct ida_bitmap *bitmap;
+	unsigned long index = offset / IDA_BITMAP_BITS;
+	unsigned long index_end = size / IDA_BITMAP_BITS;
+	unsigned long bit = offset % IDA_BITMAP_BITS;
+
+	if (unlikely(offset >= size))
+		return size;
+
+	while (index <= index_end) {
+		unsigned long ret;
+		unsigned int nbits = size - index * IDA_BITMAP_BITS;
+
+		bitmap = __radix_tree_lookup(root, index, &node, &slot);
+
+		if (!node && !bitmap)
+			return size;
+
+		if (bitmap) {
+			if (nbits > IDA_BITMAP_BITS)
+				nbits = IDA_BITMAP_BITS;
+
+			ret = find_next_bit(bitmap->bitmap, nbits, bit);
+			if (ret != nbits)
+				return ret + index * IDA_BITMAP_BITS;
+		}
+		bit = 0;
+		index++;
+	}
+
+	return size;
+}
