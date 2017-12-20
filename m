Received: from eggs.gnu.org ([2001:4830:134:3::10]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1eRUEd-0001LX-FV
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 21:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1eRUEY-0008KH-G1
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 21:35:55 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:64319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1eRUEY-0006eJ-0j
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 21:35:50 -0500
Message-Id: <201712200233.vBK2X7oX028845@www262.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
MIME-Version: 1.0
Date: Wed, 20 Dec 2017 11:33:07 +0900
References: <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
	<20171219144020.GA30842@bombadil.infradead.org>
In-Reply-To: <20171219144020.GA30842@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 0/7] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Matthew Wilcox wrote:
> > I think xb_find_set() has a bug in !node path.
> 
> Don't think.  Write a test-case.  Please.  If it shows a bug, then great,

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
+		if (!node) {
+			index = (index | RADIX_TREE_MAP_MASK) + 1;

Why we don't need to reset "bit" to 0 here?
We will continue with wrong offset if "bit != 0", won't we?

+			continue;
+		}
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
