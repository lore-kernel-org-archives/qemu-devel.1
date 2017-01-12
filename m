Received: from eggs.gnu.org ([2001:4830:134:3::10]:35495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgO-00032m-Bx
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgL-0003EX-1u
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZgK-0003EP-Ks
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7Jp3T081414
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:19 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27x5a780qk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:19 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:20:18 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:19:37 +0100
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112071947.98071-6-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 05/15] vfio: ccw: introduce ccwprogram
 interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

Introduce ccwchain structure and helper functions that can be used to
handle a ccw programs issued from a virtual machine.

The following limitations apply:
1. Supports only prefetch enabled mode.
2. Supports idal(c64) ccw chaining.
3. Supports 4k idaw.
4. Supports ccw1.
5. Supports direct ccw chaining by translating them to idal ccws.

CCW translation requires to leverage the vfio_(un)pin_pages interfaces
to pin/unpin sets of mem pages frequently. Currently we have a lack of
support to do this in an efficient way. So we introduce pfn_array data
structure and helper functions to handle pin/unpin operations here.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/Makefile      |   2 +-
 drivers/s390/cio/vfio_ccw_cp.c | 815 +++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.h |  45 +++
 3 files changed, 861 insertions(+), 1 deletion(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_cp.c
 create mode 100644 drivers/s390/cio/vfio_ccw_cp.h

diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index 3d7390e..1bec279 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -18,5 +18,5 @@ obj-$(CONFIG_CCWGROUP) += ccwgroup.o
 qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
 
-vfio_ccw-objs += vfio_ccw_drv.o
+vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o
 obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
new file mode 100644
index 0000000..b81aff3
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -0,0 +1,815 @@
+/*
+ * ccwprogram interfaces
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/vfio.h>
+#include <asm/idals.h>
+
+#include "vfio_ccw_cp.h"
+
+/*
+ * Max length for ccw chain.
+ * XXX: Limit to 256, need to check more?
+ */
+#define CCWCHAIN_LEN_MAX	256
+
+struct pfn_array {
+	unsigned long		pa_iova;
+	unsigned long		*pa_iova_pfn;
+	unsigned long		*pa_pfn;
+	int			pa_nr;
+};
+
+struct pfn_array_table {
+	struct pfn_array	*pat_pa;
+	int			pat_nr;
+};
+
+struct ccwchain {
+	struct list_head	next;
+	struct ccw1		*ch_ccw;
+	/* Guest physical address of the current chain. */
+	u64			ch_iova;
+	/* Count of the valid ccws in chain. */
+	int			ch_len;
+	/* Pinned PAGEs for the original data. */
+	struct pfn_array_table	*ch_pat;
+};
+
+/*
+ * pfn_array_pin() - pin user pages in memory
+ * @pa: pfn_array on which to perform the operation
+ * @mdev: the mediated device to perform pin/unpin operations
+ *
+ * Attempt to pin user pages in memory.
+ *
+ * Usage of pfn_array:
+ * @pa->pa_iova     starting guest physical I/O address. Assigned by caller.
+ * @pa->pa_iova_pfn array that stores PFNs of the pages need to pin. Allocated
+ *                  by caller.
+ * @pa->pa_pfn      array that receives PFNs of the pages pinned. Allocated by
+ *                  caller.
+ * @pa->pa_nr       number of pages from @pa->pa_iova to pin. Assigned by
+ *                  caller.
+ *                  number of pages pinned. Assigned by callee.
+ *
+ * Returns:
+ *   Number of pages pinned on success.
+ *   If @pa->pa_nr is 0 or negative, returns 0.
+ *   If no pages were pinned, returns -errno.
+ */
+static int pfn_array_pin(struct pfn_array *pa, struct device *mdev)
+{
+	int i, ret;
+
+	if (pa->pa_nr <= 0) {
+		pa->pa_nr = 0;
+		return 0;
+	}
+
+	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
+	for (i = 1; i < pa->pa_nr; i++)
+		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
+
+	ret = vfio_pin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr,
+			     IOMMU_READ | IOMMU_WRITE, pa->pa_pfn);
+
+	if (ret > 0 && ret != pa->pa_nr) {
+		vfio_unpin_pages(mdev, pa->pa_iova_pfn, ret);
+		pa->pa_nr = 0;
+		return 0;
+	}
+
+	return ret;
+}
+
+/* Unpin the pages before releasing the memory. */
+static void pfn_array_unpin_free(struct pfn_array *pa, struct device *mdev)
+{
+	vfio_unpin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr);
+	pa->pa_nr = 0;
+	kfree(pa->pa_iova_pfn);
+}
+
+/* Alloc memory for PFNs, then pin pages with them. */
+static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
+			       u64 iova, unsigned int len)
+{
+	int ret = 0;
+
+	if (!len || pa->pa_nr)
+		return -EINVAL;
+
+	pa->pa_iova = iova;
+
+	pa->pa_nr = ((iova & ~PAGE_MASK) + len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
+	if (!pa->pa_nr)
+		return -EINVAL;
+
+	pa->pa_iova_pfn = kcalloc(pa->pa_nr,
+				  sizeof(*pa->pa_iova_pfn) +
+				  sizeof(*pa->pa_pfn),
+				  GFP_KERNEL);
+	if (unlikely(!pa->pa_iova_pfn))
+		return -ENOMEM;
+	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
+
+	ret = pfn_array_pin(pa, mdev);
+
+	if (ret > 0)
+		return ret;
+	else if (!ret)
+		ret = -EINVAL;
+
+	kfree(pa->pa_iova_pfn);
+
+	return ret;
+}
+
+static int pfn_array_table_init(struct pfn_array_table *pat, int nr)
+{
+	pat->pat_pa = kcalloc(nr, sizeof(*pat->pat_pa), GFP_KERNEL);
+	if (unlikely(ZERO_OR_NULL_PTR(pat->pat_pa))) {
+		pat->pat_nr = 0;
+		return -ENOMEM;
+	}
+
+	pat->pat_nr = nr;
+
+	return 0;
+}
+
+static void pfn_array_table_unpin_free(struct pfn_array_table *pat,
+				       struct device *mdev)
+{
+	int i;
+
+	for (i = 0; i < pat->pat_nr; i++)
+		pfn_array_unpin_free(pat->pat_pa + i, mdev);
+
+	if (pat->pat_nr) {
+		kfree(pat->pat_pa);
+		pat->pat_pa = NULL;
+		pat->pat_nr = 0;
+	}
+}
+
+static bool pfn_array_table_iova_pinned(struct pfn_array_table *pat,
+					unsigned long iova)
+{
+	struct pfn_array *pa = pat->pat_pa;
+	unsigned long iova_pfn = iova >> PAGE_SHIFT;
+	int i, j;
+
+	for (i = 0; i < pat->pat_nr; i++, pa++)
+		for (j = 0; j < pa->pa_nr; j++)
+			if (pa->pa_iova_pfn[i] == iova_pfn)
+				return true;
+
+	return false;
+}
+/* Create the list idal words for a pfn_array_table. */
+static inline void pfn_array_table_idal_create_words(
+	struct pfn_array_table *pat,
+	unsigned long *idaws)
+{
+	struct pfn_array *pa;
+	int i, j, k;
+
+	/*
+	 * Idal words (execept the first one) rely on the memory being 4k
+	 * aligned. If a user virtual address is 4K aligned, then it's
+	 * corresponding kernel physical address will also be 4K aligned. Thus
+	 * there will be no problem here to simply use the phys to create an
+	 * idaw.
+	 */
+	k = 0;
+	for (i = 0; i < pat->pat_nr; i++) {
+		pa = pat->pat_pa + i;
+		for (j = 0; j < pa->pa_nr; j++) {
+			idaws[k] = pa->pa_pfn[j] << PAGE_SHIFT;
+			if (k == 0)
+				idaws[k] += pa->pa_iova & (PAGE_SIZE - 1);
+			k++;
+		}
+	}
+}
+
+
+/*
+ * Within the domain (@mdev), copy @n bytes from a guest physical
+ * address (@iova) to a host physical address (@to).
+ */
+static long copy_from_iova(struct device *mdev,
+			   void *to, u64 iova,
+			   unsigned long n)
+{
+	struct pfn_array pa = {0};
+	u64 from;
+	int i, ret;
+	unsigned long l, m;
+
+	ret = pfn_array_alloc_pin(&pa, mdev, iova, n);
+	if (ret <= 0)
+		return ret;
+
+	l = n;
+	for (i = 0; i < pa.pa_nr; i++) {
+		from = pa.pa_pfn[i] << PAGE_SHIFT;
+		m = PAGE_SIZE;
+		if (i == 0) {
+			from += iova & (PAGE_SIZE - 1);
+			m -= iova & (PAGE_SIZE - 1);
+		}
+
+		m = min(l, m);
+		memcpy(to + (n - l), (void *)from, m);
+
+		l -= m;
+		if (l == 0)
+			break;
+	}
+
+	pfn_array_unpin_free(&pa, mdev);
+
+	return l;
+}
+
+static long copy_ccw_from_iova(struct ccwprogram *cp,
+			       struct ccw1 *to, u64 iova,
+			       unsigned long len)
+{
+	return copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
+}
+
+/*
+ * Helpers to operate ccwchain.
+ */
+#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
+
+#define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
+
+#define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
+
+#define ccw_is_idal(_ccw) ((_ccw)->flags & CCW_FLAG_IDA)
+
+
+#define ccw_is_chain(_ccw) ((_ccw)->flags & (CCW_FLAG_CC | CCW_FLAG_DC))
+
+static struct ccwchain *ccwchain_alloc(struct ccwprogram *cp, int len)
+{
+	struct ccwchain *chain;
+	void *data;
+	size_t size;
+
+	/* Make ccw address aligned to 8. */
+	size = ((sizeof(*chain) + 7L) & -8L) +
+		sizeof(*chain->ch_ccw) * len +
+		sizeof(*chain->ch_pat) * len;
+	chain = kzalloc(size, GFP_DMA | GFP_KERNEL);
+	if (!chain)
+		return NULL;
+
+	data = (u8 *)chain + ((sizeof(*chain) + 7L) & -8L);
+	chain->ch_ccw = (struct ccw1 *)data;
+
+	data = (u8 *)(chain->ch_ccw) + sizeof(*chain->ch_ccw) * len;
+	chain->ch_pat = (struct pfn_array_table *)data;
+
+	chain->ch_len = len;
+
+	list_add_tail(&chain->next, &cp->ccwchain_list);
+
+	return chain;
+}
+
+static void ccwchain_free(struct ccwchain *chain)
+{
+	list_del(&chain->next);
+	kfree(chain);
+}
+
+/* Free resource for a ccw that allocated memory for its cda. */
+static void ccwchain_cda_free(struct ccwchain *chain, int idx)
+{
+	struct ccw1 *ccw = chain->ch_ccw + idx;
+
+	if (!ccw->count)
+		return;
+
+	kfree((void *)(u64)ccw->cda);
+}
+
+/* Unpin the pages then free the memory resources. */
+static void cp_unpin_free(struct ccwprogram *cp)
+{
+	struct ccwchain *chain, *temp;
+	int i;
+
+	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+		for (i = 0; i < chain->ch_len; i++) {
+			pfn_array_table_unpin_free(chain->ch_pat + i,
+						   cp->mdev);
+			ccwchain_cda_free(chain, i);
+		}
+		ccwchain_free(chain);
+	}
+}
+
+/**
+ * ccwchain_calc_length - calculate the length of the ccw chain.
+ * @iova: guest physical address of the target ccw chain
+ * @cp: ccwprogram on which to perform the operation
+ *
+ * This is the chain length not considering any TICs.
+ * You need to do a new round for each TIC target.
+ *
+ * Returns: the length of the ccw chain or -errno.
+ */
+static int ccwchain_calc_length(u64 iova, struct ccwprogram *cp)
+{
+	struct ccw1 *ccw, *p;
+	int cnt;
+
+	/*
+	 * Copy current chain from guest to host kernel.
+	 * Currently the chain length is limited to CCWCHAIN_LEN_MAX (256).
+	 * So copying 2K is enough (safe).
+	 */
+	p = ccw = kcalloc(CCWCHAIN_LEN_MAX, sizeof(*ccw), GFP_KERNEL);
+	if (!ccw)
+		return -ENOMEM;
+
+	cnt = copy_ccw_from_iova(cp, ccw, iova, CCWCHAIN_LEN_MAX);
+	if (cnt) {
+		kfree(ccw);
+		return cnt;
+	}
+
+	cnt = 0;
+	do {
+		cnt++;
+
+		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
+			break;
+
+		ccw++;
+	} while (cnt < CCWCHAIN_LEN_MAX + 1);
+
+	if (cnt == CCWCHAIN_LEN_MAX + 1)
+		cnt = -EINVAL;
+
+	kfree(p);
+	return cnt;
+}
+
+static int tic_target_chain_exists(struct ccw1 *tic, struct ccwprogram *cp)
+{
+	struct ccwchain *chain;
+	u32 ccw_head, ccw_tail;
+
+	list_for_each_entry(chain, &cp->ccwchain_list, next) {
+		ccw_head = chain->ch_iova;
+		ccw_tail = ccw_head + (chain->ch_len - 1) * sizeof(struct ccw1);
+
+		if ((ccw_head <= tic->cda) && (tic->cda <= ccw_tail))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int ccwchain_loop_tic(struct ccwchain *chain, struct ccwprogram *cp);
+
+static int ccwchain_handle_tic(struct ccw1 *tic, struct ccwprogram *cp)
+{
+	struct ccwchain *chain;
+	int len, ret;
+
+	/* May transfer to an existing chain. */
+	if (tic_target_chain_exists(tic, cp))
+		return 0;
+
+	/* Get chain length. */
+	len = ccwchain_calc_length(tic->cda, cp);
+	if (len < 0)
+		return len;
+
+	/* Need alloc a new chain for this one. */
+	chain = ccwchain_alloc(cp, len);
+	if (!chain)
+		return -ENOMEM;
+	chain->ch_iova = tic->cda;
+
+	/* Copy the new chain from user. */
+	ret = copy_ccw_from_iova(cp, chain->ch_ccw, tic->cda, len);
+	if (ret) {
+		ccwchain_free(chain);
+		return ret;
+	}
+
+	/* Loop for tics on this new chain. */
+	return ccwchain_loop_tic(chain, cp);
+}
+
+/* Loop for TICs. */
+static int ccwchain_loop_tic(struct ccwchain *chain, struct ccwprogram *cp)
+{
+	struct ccw1 *tic;
+	int i, ret;
+
+	for (i = 0; i < chain->ch_len; i++) {
+		tic = chain->ch_ccw + i;
+
+		if (!ccw_is_tic(tic))
+			continue;
+
+		ret = ccwchain_handle_tic(tic, cp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ccwchain_fetch_tic(struct ccwchain *chain,
+			      int idx,
+			      struct ccwprogram *cp)
+{
+	struct ccw1 *ccw = chain->ch_ccw + idx;
+	struct ccwchain *iter;
+	u32 ccw_head, ccw_tail;
+
+	list_for_each_entry(iter, &cp->ccwchain_list, next) {
+		ccw_head = iter->ch_iova;
+		ccw_tail = ccw_head + (iter->ch_len - 1) * sizeof(struct ccw1);
+
+		if ((ccw_head <= ccw->cda) && (ccw->cda <= ccw_tail)) {
+			ccw->cda = (__u32) (addr_t) (iter->ch_ccw +
+						     (ccw->cda - ccw_head));
+			return 0;
+		}
+	}
+
+	return -EFAULT;
+}
+
+static int ccwchain_fetch_direct(struct ccwchain *chain,
+				 int idx,
+				 struct ccwprogram *cp)
+{
+	struct ccw1 *ccw;
+	struct pfn_array_table *pat;
+	unsigned long *idaws;
+	int idaw_nr;
+
+	ccw = chain->ch_ccw + idx;
+
+	/*
+	 * Pin data page(s) in memory.
+	 * The number of pages actually is the count of the idaws which will be
+	 * needed when translating a direct ccw to a idal ccw.
+	 */
+	pat = chain->ch_pat + idx;
+	if (pfn_array_table_init(pat, 1))
+		return -ENOMEM;
+	idaw_nr = pfn_array_alloc_pin(pat->pat_pa, cp->mdev,
+				      ccw->cda, ccw->count);
+	if (idaw_nr < 0)
+		return idaw_nr;
+
+	/* Translate this direct ccw to a idal ccw. */
+	idaws = kcalloc(idaw_nr, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
+	if (!idaws) {
+		pfn_array_table_unpin_free(pat, cp->mdev);
+		return -ENOMEM;
+	}
+	ccw->cda = (__u32) virt_to_phys(idaws);
+	ccw->flags |= CCW_FLAG_IDA;
+
+	pfn_array_table_idal_create_words(pat, idaws);
+
+	return 0;
+}
+
+static int ccwchain_fetch_idal(struct ccwchain *chain,
+			       int idx,
+			       struct ccwprogram *cp)
+{
+	struct ccw1 *ccw;
+	struct pfn_array_table *pat;
+	unsigned long *idaws;
+	u64 idaw_iova;
+	unsigned int idaw_nr, idaw_len;
+	int i, ret;
+
+	ccw = chain->ch_ccw + idx;
+
+	/* Calculate size of idaws. */
+	ret = copy_from_iova(cp->mdev, &idaw_iova, ccw->cda, sizeof(idaw_iova));
+	if (ret)
+		return ret;
+	idaw_nr = idal_nr_words((void *)(idaw_iova), ccw->count);
+	idaw_len = idaw_nr * sizeof(*idaws);
+
+	/* Pin data page(s) in memory. */
+	pat = chain->ch_pat + idx;
+	ret = pfn_array_table_init(pat, idaw_nr);
+	if (ret)
+		return ret;
+
+	/* Translate idal ccw to use new allocated idaws. */
+	idaws = kzalloc(idaw_len, GFP_DMA | GFP_KERNEL);
+	if (!idaws) {
+		ret = -ENOMEM;
+		goto out_unpin;
+	}
+
+	ret = copy_from_iova(cp->mdev, idaws, ccw->cda, idaw_len);
+	if (ret)
+		goto out_free_idaws;
+
+	ccw->cda = virt_to_phys(idaws);
+
+	for (i = 0; i < idaw_nr; i++) {
+		idaw_iova = *(idaws + i);
+		if (IS_ERR_VALUE(idaw_iova)) {
+			ret = -EFAULT;
+			goto out_free_idaws;
+		}
+
+		ret = pfn_array_alloc_pin(pat->pat_pa + i, cp->mdev,
+					  idaw_iova, 1);
+		if (ret < 0)
+			goto out_free_idaws;
+	}
+
+	pfn_array_table_idal_create_words(pat, idaws);
+
+	return 0;
+
+out_free_idaws:
+	kfree(idaws);
+out_unpin:
+	pfn_array_table_unpin_free(pat, cp->mdev);
+	return ret;
+}
+
+/*
+ * Fetch one ccw.
+ * To reduce memory copy, we'll pin the cda page in memory,
+ * and to get rid of the cda 2G limitiaion of ccw1, we'll translate
+ * direct ccws to idal ccws.
+ */
+static int ccwchain_fetch_one(struct ccwchain *chain,
+			      int idx,
+			      struct ccwprogram *cp)
+{
+	struct ccw1 *ccw = chain->ch_ccw + idx;
+
+	if (ccw_is_test(ccw) || ccw_is_noop(ccw))
+		return 0;
+
+	if (ccw_is_tic(ccw))
+		return ccwchain_fetch_tic(chain, idx, cp);
+
+	if (ccw_is_idal(ccw))
+		return ccwchain_fetch_idal(chain, idx, cp);
+
+	return ccwchain_fetch_direct(chain, idx, cp);
+}
+
+/**
+ * cp_init() - allocate ccwchains for a ccw program.
+ * @cp: ccwprogram on which to perform the operation
+ * @mdev: the mediated device to perform pin/unpin operations
+ * @orb: control block for the ccw program frm the guest
+ *
+ * This creates one or more ccwchain(s), and copies the raw data of
+ * the target ccw program from @orb->cmd.iova to the new ccwchain(s).
+ *
+ * Limitations:
+ * 1. Supports only prefetch enabled mode.
+ * 2. Supports idal(c64) ccw chaining.
+ * 3. Supports 4k idaw.
+ *
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ */
+int cp_init(struct ccwprogram *cp, struct device *mdev, union orb *orb)
+{
+	u64 iova = orb->cmd.cpa;
+	struct ccwchain *chain;
+	int len, ret;
+
+	/*
+	 * XXX:
+	 * Only support prefetch enable mode now.
+	 * Only support 64bit addressing idal.
+	 * Only support 4k IDAW.
+	 * Only support ccw1.
+	 */
+	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k || !orb->cmd.fmt)
+		return -EOPNOTSUPP;
+
+	INIT_LIST_HEAD(&cp->ccwchain_list);
+	memcpy(&cp->orb, orb, sizeof(*orb));
+	cp->mdev = mdev;
+
+	/* Get chain length. */
+	len = ccwchain_calc_length(iova, cp);
+	if (len < 0)
+		return len;
+
+	/* Alloc mem for the head chain. */
+	chain = ccwchain_alloc(cp, len);
+	if (!chain)
+		return -ENOMEM;
+	chain->ch_iova = iova;
+
+	/* Copy the head chain from guest. */
+	ret = copy_ccw_from_iova(cp, chain->ch_ccw, iova, len);
+	if (ret) {
+		ccwchain_free(chain);
+		return ret;
+	}
+
+	/* Now loop for its TICs. */
+	ret = ccwchain_loop_tic(chain, cp);
+	if (ret)
+		cp_unpin_free(cp);
+
+	return ret;
+}
+
+
+/**
+ * cp_free() - free resources for ccwprogram.
+ * @cp: ccwprogram on which to perform the operation
+ *
+ * This unpins the memory pages and frees the memory space occupied by
+ * @cp, which must have been returned by a previous call to cp_init().
+ * Otherwise, undefined behavior occurs.
+ */
+void cp_free(struct ccwprogram *cp)
+{
+	cp_unpin_free(cp);
+}
+
+/**
+ * cp_prefetch() - translate a guest physical address ccw program to a
+ *                 real-device runnable ccw program.
+ * @cp: ccwprogram on which to perform the operation
+ *
+ * This function translates the guest-physical-address ccw program and
+ * stores the result to ccwchain list. @cp must have been initialized
+ * by a previous call with cp_init(). Otherwise, undefined behavior
+ * occurs.
+ *
+ * The S/390 CCW Translation APIS (prefixed by 'cp_') are introduced
+ * as helpers to do ccw chain translation inside the kernel. Basically
+ * they accept a ccw program issued by a virtual machine, and
+ * translate the ccw program to a real-device runnable ccw program.
+ *
+ * These APIs will copy the ccws into kernel-space buffers, and update
+ * the guest phsical addresses with their corresponding host physical
+ * addresses.  Then channel I/O device drivers could issue the
+ * translated ccw program to real devices to perform an I/O operation.
+ *
+ * These interfaces are designed to support translation only for ccw
+ * programs, which are generated and formatted by a guest. Thus this
+ * will make it possible for things like VFIO to leverage the
+ * interfaces to passthrough a channel I/O mediated device in QEMU.
+ *
+ * We support direct ccw chaining by translating them to idal ccws.
+ *
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ */
+int cp_prefetch(struct ccwprogram *cp)
+{
+	struct ccwchain *chain;
+	int len, idx, ret;
+
+	list_for_each_entry(chain, &cp->ccwchain_list, next) {
+		len = chain->ch_len;
+		for (idx = 0; idx < len; idx++) {
+			ret = ccwchain_fetch_one(chain, idx, cp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * cp_get_orb() - get the orb of the ccw program
+ * @cp: ccwprogram on which to perform the operation
+ * @intparm: new intparm for the returned orb
+ * @lpm: candidate value of the logical-path mask for the returned orb
+ *
+ * This function returns the address of the updated orb of the ccw
+ * program. Channel I/O device drivers could use this orb to issue a
+ * ssch.
+ */
+union orb *cp_get_orb(struct ccwprogram *cp, u32 intparm, u8 lpm)
+{
+	union orb *orb;
+	struct ccwchain *chain;
+	struct ccw1 *cpa;
+
+	orb = &cp->orb;
+
+	orb->cmd.intparm = intparm;
+	orb->cmd.fmt = 1;
+	orb->cmd.key = PAGE_DEFAULT_KEY >> 4;
+
+	if (orb->cmd.lpm == 0)
+		orb->cmd.lpm = lpm;
+
+	chain = list_first_entry(&cp->ccwchain_list, struct ccwchain, next);
+	cpa = chain->ch_ccw;
+	orb->cmd.cpa = (__u32) __pa(cpa);
+
+	return orb;
+}
+
+/**
+ * cp_update_scsw() - update scsw for a ccw program.
+ * @cp: ccwprogram on which to perform the operation
+ * @scsw: I/O results of the ccw program and also the target to be updated
+ *
+ * @scsw contains the I/O results of the ccw program that pointed to
+ * by @cp. However what @scsw->cpa stores is a host physical address,
+ * which is meaningless for the guest, which is waiting for the I/O
+ * results.
+ *
+ * This function updates @scsw->cpa to its coressponding guest physical
+ * address.
+ */
+void cp_update_scsw(struct ccwprogram *cp, union scsw *scsw)
+{
+	struct ccwchain *chain;
+	u32 cpa = scsw->cmd.cpa;
+	u32 ccw_head, ccw_tail;
+
+	/*
+	 * LATER:
+	 * For now, only update the cmd.cpa part. We may need to deal with
+	 * other portions of the schib as well, even if we don't return them
+	 * in the ioctl directly. Path status changes etc.
+	 */
+	list_for_each_entry(chain, &cp->ccwchain_list, next) {
+		ccw_head = (u32)(u64)chain->ch_ccw;
+		ccw_tail = (u32)(u64)(chain->ch_ccw + chain->ch_len - 1);
+
+		if ((ccw_head <= cpa) && (cpa <= ccw_tail)) {
+			/*
+			 * (cpa - ccw_head) is the offset value of the host
+			 * physical ccw to its chain head.
+			 * Adding this value to the guest physical ccw chain
+			 * head gets us the guest cpa.
+			 */
+			cpa = chain->ch_iova + (cpa - ccw_head);
+			break;
+		}
+	}
+
+	scsw->cmd.cpa = cpa;
+}
+
+/**
+ * cp_iova_pinned() - check if an iova is pinned for a ccw chain.
+ * @cmd: ccwchain command on which to perform the operation
+ * @iova: the iova to check
+ *
+ * If the @iova is currently pinned for the ccw chain, return true;
+ * else return false.
+ */
+bool cp_iova_pinned(struct ccwprogram *cp, u64 iova)
+{
+	struct ccwchain *chain;
+	int i;
+
+	list_for_each_entry(chain, &cp->ccwchain_list, next) {
+		for (i = 0; i < chain->ch_len; i++)
+			if (pfn_array_table_iova_pinned(chain->ch_pat + i,
+							iova))
+				return true;
+	}
+
+	return false;
+}
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
new file mode 100644
index 0000000..2399492
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -0,0 +1,45 @@
+/*
+ * ccwprogram interfaces
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#ifndef _VFIO_CCW_CP_H_
+#define _VFIO_CCW_CP_H_
+
+#include <asm/cio.h>
+#include <asm/scsw.h>
+
+#include "orb.h"
+
+/**
+ * struct ccwprogram - manage information for ccw program
+ * @ccwchain_list: list head of ccwchains
+ * @orb: orb for the currently processed ssch request
+ * @mdev: the mediated device to perform page pinning/unpinning
+ *
+ * @ccwchain_list is the head of a ccwchain list, that contents the
+ * translated result of the guest ccw program that pointed out by
+ * the iova parameter when calling cp_init.
+ */
+struct ccwprogram {
+	struct list_head ccwchain_list;
+	union orb orb;
+	struct device *mdev;
+};
+
+extern int cp_init(struct ccwprogram *cp, struct device *mdev, union orb *orb);
+extern void cp_free(struct ccwprogram *cp);
+extern int cp_prefetch(struct ccwprogram *cp);
+extern union orb *cp_get_orb(struct ccwprogram *cp, u32 intparm, u8 lpm);
+extern void cp_update_scsw(struct ccwprogram *cp, union scsw *scsw);
+extern bool cp_iova_pinned(struct ccwprogram *cp, u64 iova);
+
+#endif
-- 
2.8.4
