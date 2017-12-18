Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eR4Az-0003SY-3e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eR4Ay-0000G7-5n
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:46:25 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Dec 2017 23:46:16 +0100
Message-Id: <20171218224616.21030-3-david@redhat.com>
In-Reply-To: <20171218224616.21030-1-david@redhat.com>
References: <20171218224616.21030-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] s390x/sclp: fix missing be conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Linux crashes right now if maxmem > mem is specified on the command line.

On s390x, the guest can hotplug memory itself right now - very weird -
and e.g. Fedora 27 will simply add all memory it can when booting.

So now, we have at least the same behavior on TCG and KVM.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/sclp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9be0cb80ad..829c13bcf2 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -233,7 +233,7 @@ static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
         return;
     }
-    assign_addr = (assign_info->rn - 1) * mhd->rzm;
+    assign_addr = (be16_to_cpu(assign_info->rn) - 1) * mhd->rzm;
 
     if ((assign_addr % MEM_SECTION_SIZE == 0) &&
         (assign_addr >= mhd->padded_ram_size)) {
@@ -292,7 +292,7 @@ static void unassign_storage(SCLPDevice *sclp, SCCB *sccb)
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
         return;
     }
-    unassign_addr = (assign_info->rn - 1) * mhd->rzm;
+    unassign_addr = (be16_to_cpu(assign_info->rn) - 1) * mhd->rzm;
 
     /* if the addr is a multiple of 256 MB */
     if ((unassign_addr % MEM_SECTION_SIZE == 0) &&
-- 
2.14.3
