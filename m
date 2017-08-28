Received: from eggs.gnu.org ([2001:4830:134:3::10]:33593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmFPC-0007kP-83
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmFP7-0002I8-A8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:28:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dmFP7-0002Hm-12
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:28:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S8RoXl133932
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:28:15 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cm5wnn36a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:28:15 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 28 Aug 2017 09:28:12 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 28 Aug 2017 10:28:07 +0200
In-Reply-To: <1503908887-67060-1-git-send-email-borntraeger@de.ibm.com>
References: <1503908887-67060-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1503908887-67060-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390/mm: avoid empty zero pages for KVM
 guests to avoid postcopy hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Right now there is a potential hang situation for postcopy migrations,
if the guest is enabling storage keys on the target system during the
postcopy process.

For storage key virtualization, we have to forbid the empty zero page as
the storage key is a property of the physical page frame.  As we enable
storage key handling lazily we then drop all mappings for empty zero
pages for lazy refaulting later on.

This does not work with the postcopy migration, which relies on the
empty zero page never triggering a fault again in the future. The reason
is that postcopy migration will simply read a page on the target system
if that page is a known zero page to fault in an empty zero page.  At
the same time postcopy remembers that this page was already transferred
- so any future userfault on that page will be NOT retransmitted again
to avoid races.

If now the guest enters the storage key mode while in postcopy, we will
break this assumption of postcopy.

The solution is to disable the empty zero page for KVM guests early on
and not during storage key enablement. With this change, the postcopy
migration process is guaranteed to start after no zero pages are left.

As guest pages are very likely not empty zero pages anyway the memory
overhead is also pretty small.

While at it this also adds proper page table locking to the zero page
removal.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/mm/gmap.c             | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index bb59a0a..9d7f62a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -506,7 +506,7 @@ static inline int mm_alloc_pgste(struct mm_struct *mm)
  * In the case that a guest uses storage keys
  * faults should no longer be backed by zero pages
  */
-#define mm_forbids_zeropage mm_use_skey
+#define mm_forbids_zeropage mm_has_pgste
 static inline int mm_use_skey(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 4fb3d3c..ae8bd57 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2121,6 +2121,39 @@ static inline void thp_split_mm(struct mm_struct *mm)
 }
 
 /*
+ * Remove all empty zero pages from the mapping for lazy refaulting
+ * - This must be called after mm->context.has_pgste is set, to avoid
+ *   future creation of zero pages
+ * - This must be called after THP was enabled
+ */
+static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
+			   unsigned long end, struct mm_walk *walk)
+{
+	unsigned long addr;
+
+	for (addr = start; addr != end; addr += PAGE_SIZE) {
+		pte_t *ptep;
+		spinlock_t *ptl;
+
+		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+		if (is_zero_pfn(pte_pfn(*ptep)))
+			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
+		pte_unmap_unlock(ptep, ptl);
+	}
+
+	return 0;
+
+}
+
+static inline void zap_zero_pages(struct mm_struct *mm)
+{
+	struct mm_walk walk = { .pmd_entry = __zap_zero_pages };
+
+	walk.mm = mm;
+	walk_page_range(0, TASK_SIZE, &walk);
+}
+
+/*
  * switch on pgstes for its userspace process (for kvm)
  */
 int s390_enable_sie(void)
@@ -2137,6 +2170,7 @@ int s390_enable_sie(void)
 	mm->context.has_pgste = 1;
 	/* split thp mappings and disable thp for future mappings */
 	thp_split_mm(mm);
+	zap_zero_pages(mm);
 	up_write(&mm->mmap_sem);
 	return 0;
 }
@@ -2149,13 +2183,6 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
 static int __s390_enable_skey(pte_t *pte, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	/*
-	 * Remove all zero page mappings,
-	 * after establishing a policy to forbid zero page mappings
-	 * following faults for that page will get fresh anonymous pages
-	 */
-	if (is_zero_pfn(pte_pfn(*pte)))
-		ptep_xchg_direct(walk->mm, addr, pte, __pte(_PAGE_INVALID));
 	/* Clear storage key */
 	ptep_zap_key(walk->mm, addr, pte);
 	return 0;
-- 
2.7.4
