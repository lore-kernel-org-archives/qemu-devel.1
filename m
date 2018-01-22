Received: from eggs.gnu.org ([2001:4830:134:3::10]:51476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamc-0001Zt-4c
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamb-0005sK-Ce
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:02 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 22 Jan 2018 13:00:39 +0100
Message-Id: <20180122120045.13538-4-cohuck@redhat.com>
In-Reply-To: <20180122120045.13538-1-cohuck@redhat.com>
References: <20180122120045.13538-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] s390x/sclp: fix missing be conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Linux crashes right now if maxmem > mem is specified on the command line.

On s390x, the guest can hotplug memory itself right now - very weird -
and e.g. Fedora 27 will simply add all memory it can when booting.

So now, we have at least the same behavior on TCG and KVM.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171218224616.21030-3-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 21351ffffc..276972b59f 100644
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
2.13.6
