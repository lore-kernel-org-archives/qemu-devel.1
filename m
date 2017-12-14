Received: from eggs.gnu.org ([2001:4830:134:3::10]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1ePWRO-0006gt-9q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1ePWRL-0004Mb-2B
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:32:58 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:29649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1ePWRK-0002D6-CO
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:32:54 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
	<5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
In-Reply-To: <5A31F445.6070504@intel.com>
Message-Id: <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
Date: Fri, 15 Dec 2017 01:29:45 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> I used the example of xb_clear_bit_range(), and xb_find_next_bit() is 
> the same fundamentally. Please let me know if anywhere still looks fuzzy.

I don't think it is the same for xb_find_next_bit() with set == 0.

+		if (radix_tree_exception(bmap)) {
+			unsigned long tmp = (unsigned long)bmap;
+			unsigned long ebit = bit + 2;
+
+			if (ebit >= BITS_PER_LONG)
+				continue;
+			if (set)
+				ret = find_next_bit(&tmp, BITS_PER_LONG, ebit);
+			else
+				ret = find_next_zero_bit(&tmp, BITS_PER_LONG,
+							 ebit);
+			if (ret < BITS_PER_LONG)
+				return ret - 2 + IDA_BITMAP_BITS * index;

What I'm saying is that find_next_zero_bit() will not be called if you do
"if (ebit >= BITS_PER_LONG) continue;" before calling find_next_zero_bit().

When scanning "0000000000000000000000000000000000000000000000000000000000000001",
"bit < BITS_PER_LONG - 2" case finds "0" in this word but
"bit >= BITS_PER_LONG - 2" case finds "0" in next word or segment.

I can't understand why this is correct behavior. It is too much puzzling.



> > Also, one more thing you need to check. Have you checked how long does
> > xb_find_next_set_bit(xb, 0, ULONG_MAX) on an empty xbitmap takes?
> > If it causes soft lockup warning, should we add cond_resched() ?
> > If yes, you have to document that this API might sleep. If no, you
> > have to document that the caller of this API is responsible for
> > not to pass such a large value range.
> 
> Yes, that will take too long time. Probably we can document some 
> comments as a reminder for the callers.
> 

Then, I feel that API is poorly implemented. There is no need to brute-force
when scanning [0, ULONG_MAX] range. If you eliminate exception path and
redesign the data structure, xbitmap will become as simple as a sample
implementation shown below. Not tested yet, but I think that this will be
sufficient for what virtio-baloon wants to do; i.e. find consecutive "1" bits
quickly. I didn't test whether finding "struct ulong_list_data" using radix
tree can improve performance.

----------------------------------------
#include <linux/module.h>
#include <linux/slab.h>

#define BITMAP_LEN 1024

struct ulong_list_data {
	struct list_head list;
	unsigned long segment; /* prev->segment < segment < next->segment */
	unsigned long bits;    /* Number of bits set in this offset bitmap. */
	unsigned long *bitmap; /* Offset bitmap of BITMAP_LEN bits. */
};

static struct ulong_list_data null_ulong_list = {
	{ NULL, NULL }, ULONG_MAX, 0, NULL
};

struct ulong_list_head {
	struct list_head list;
	struct ulong_list_data *last_used;
};

static void init_ulong(struct ulong_list_head *head)
{
	INIT_LIST_HEAD(&head->list);
	head->last_used = &null_ulong_list;
}

static bool set_ulong(struct ulong_list_head *head, const unsigned long value)
{
	struct ulong_list_data *ptr = head->last_used;
	struct list_head *list = &head->list;
	const unsigned long segment = value / BITMAP_LEN;
	const unsigned long offset = value % BITMAP_LEN;
	bool found = false;

	if (ptr->segment == segment)
		goto shortcut;
	list_for_each_entry(ptr, &head->list, list) {
		if (ptr->segment < segment) {
			list = &ptr->list;
			continue;
		}
		found = ptr->segment == segment;
		break;
	}
	if (!found) {
		ptr = kzalloc(sizeof(*ptr), GFP_NOWAIT | __GFP_NOWARN);
		if (!ptr)
			return false;
		ptr->bitmap = kzalloc(BITMAP_LEN / 8,
				      GFP_NOWAIT | __GFP_NOWARN);
		if (!ptr->bitmap) {
			kfree(ptr);
			return false;
		}
		ptr->segment = segment;
		list_add(&ptr->list, list);
	}
	head->last_used = ptr;
 shortcut:
	if (!test_bit(offset, ptr->bitmap)) {
		__set_bit(offset, ptr->bitmap);
		ptr->bits++;
	}
	return true;
}

static void clear_ulong(struct ulong_list_head *head, const unsigned long value)
{
	struct ulong_list_data *ptr = head->last_used;
	const unsigned long segment = value / BITMAP_LEN;
	const unsigned long offset = value % BITMAP_LEN;

	if (ptr->segment == segment)
		goto shortcut;
	list_for_each_entry(ptr, &head->list, list) {
		if (ptr->segment < segment)
			continue;
		if (ptr->segment == segment) {
			head->last_used = ptr;
shortcut:
			if (test_bit(offset, ptr->bitmap)) {
				__clear_bit(offset, ptr->bitmap);
				if (--ptr->bits)
					return;
				if (head->last_used == ptr)
					head->last_used = &null_ulong_list;
				list_del(&ptr->list);
				kfree(ptr);
			}
		}
		return;
	}
}

static void destroy_ulong(struct ulong_list_head *head)
{
	struct ulong_list_data *ptr;
	struct ulong_list_data *tmp;

	list_for_each_entry_safe(ptr, tmp, &head->list, list) {
		list_del(&ptr->list);
		kfree(ptr);
	}
	init_ulong(head);
}

static unsigned long get_ulong_set_range(struct ulong_list_head *head,
					 unsigned long *start)
{
	struct ulong_list_data *ptr;
	unsigned long segment = *start / BITMAP_LEN;
	unsigned int offset = *start % BITMAP_LEN;
	unsigned long ret = BITMAP_LEN;

	list_for_each_entry(ptr, &head->list, list) {
		if (ptr->segment < segment)
			continue;
		if (ptr->segment > segment)
			offset = 0;
		ret = find_next_bit(ptr->bitmap, BITMAP_LEN, offset);
		if (ret == BITMAP_LEN)
			continue;
		break;
	}
	if (ret == BITMAP_LEN)
		return 0;
	segment = ptr->segment;
	*start = segment * BITMAP_LEN + ret;
	ret = find_next_zero_bit(ptr->bitmap, BITMAP_LEN, ret);
	if (ret < BITMAP_LEN || segment == ULONG_MAX / BITMAP_LEN)
		return segment * BITMAP_LEN + ret - *start;
	ret = 0;
	list_for_each_entry_continue(ptr, &head->list, list) {
		if (ptr->segment != ++segment)
			break;
		if (ptr->bits == BITMAP_LEN)
			continue;
		ret = find_next_zero_bit(ptr->bitmap, BITMAP_LEN, 0);
		break;
	}
	return segment * BITMAP_LEN + ret - *start;
}

static int __init test_init(void)
{
	struct ulong_list_data *ptr;
	struct ulong_list_head head;
	unsigned long start = 0;
	unsigned long len;

	init_ulong(&head);

	set_ulong(&head, 0);
	set_ulong(&head, 10);
	set_ulong(&head, 11);
	set_ulong(&head, ULONG_MAX);
	set_ulong(&head, 1000000);
	set_ulong(&head, 12);
	clear_ulong(&head, 11);
	for (len = 1048576; len < 1048576 + BITMAP_LEN * 3; len++)
		set_ulong(&head, len);
	clear_ulong(&head, 1048600);
	set_ulong(&head, 2000000000);

	pr_info("Debug dump start\n");
	list_for_each_entry(ptr, &head.list, list)
		pr_info("Segment %lu %lu\n", ptr->segment, ptr->bits);
	pr_info("Debug dump end\n");

	while ((len = get_ulong_set_range(&head, &start)) > 0) {
		pr_info("Range %lu@%lu\n", len, start);
		start += len;
		if (!start)
			break;
	}
	destroy_ulong(&head);
	return -EINVAL;
}

module_init(test_init);
MODULE_LICENSE("GPL");
----------------------------------------
