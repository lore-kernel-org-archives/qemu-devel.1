Received: from eggs.gnu.org ([2001:4830:134:3::10]:57962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dbFhF-0000Ak-70
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 20:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dbFhC-0003NL-3I
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 20:33:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dbFhB-0003Kk-TC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 20:33:30 -0400
Date: Fri, 28 Jul 2017 20:33:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170729003327.GA16954@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] tb_invalidate_phys_range and
 tb_invalidate_phys_page_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>

While working on the removal of tb_lock, I stumbled upon the following.

Commit 77a8f1a51 ("linux-user: Fix stale tbs after mmap") introduced
tb_invalidate_phys_range(), which we now have in accel/tcg/translate-all.c
[ patchwork thread here: https://patchwork.ozlabs.org/patch/158556/ ]

This function calls
tb_invalidate_phys_page_range(). As the name suggests, the latter
function expects the range to be within the same page.
The former does not have this requirement, as stated in the comment
above the function (which I confirmed running some linux-user code):

+/*
+ * invalidate all TBs which intersect with the target physical pages
+ * starting in range [start;end[. NOTE: start and end may refer to
+ * different physical pages. 'is_cpu_write_access' should be true if called
+ * from a real cpu write access: the virtual CPU will exit the current
+ * TB if code is modified inside this TB.
+ */
+void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end,
+                              int is_cpu_write_access)
+{
+    while (start < end) {
+        tb_invalidate_phys_page_range(start, end, is_cpu_write_access);
+        start &= TARGET_PAGE_MASK;
+        start += TARGET_PAGE_SIZE;
+    }
+}

What I find puzzling is that here we pass 'end' unmodified, instead of
making sure the range passed is within a page.

Is this a bug, or am I missing something?

Thanks,

		Emilio
