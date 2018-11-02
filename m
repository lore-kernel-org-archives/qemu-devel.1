Received: from eggs.gnu.org ([2001:4830:134:3::10]:43120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1gIbb1-0006Gr-6K
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1gIbav-000323-C7
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:42:51 -0400
Date: Fri, 2 Nov 2018 09:40:20 -0600
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20181102154019.GB26292@localhost.localdomain>
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ppandit@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, Nov 01, 2018 at 06:22:43PM -0700, Li Qiang wrote:
> Currently, the nvme_cmb_ops mr doesn't check the addr and size.
> This can lead an oob access issue. This is triggerable in the guest.
> Add check to avoid this issue.
> 
> Fixes CVE-2018-16847.
> 
> Reported-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Hey, so why is this memory region access even considered valid if the
request is out of range from what NVMe had registered for its
MemoryRegion? Wouldn't it be better to not call the mr->ops->read/write
if it's out of bounds? Otherwise every MemoryRegion needs to duplicate
the same check, right?

Would something like the following work (minimally tested)?

---
diff --git a/memory.c b/memory.c
index 9b73892768..883fd818e6 100644
--- a/memory.c
+++ b/memory.c
@@ -1369,6 +1369,9 @@ bool memory_region_access_valid(MemoryRegion *mr,
         access_size_max = 4;
     }
 
+    if (addr + size > mr->size)
+        return false;
+
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     for (i = 0; i < size; i += access_size) {
         if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
--
