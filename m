Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQm-0003w2-VY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQk-0005mo-NR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:25 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQk-0005mg-GL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:22 -0400
Received: by mail-wm0-x242.google.com with SMTP id k15so11050633wmh.3
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:41 +0200
Message-Id: <1496320911-51305-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/33] exec: fix address_space_get_iotlb_entry
 page mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

The IOTLB that it returned didn't guarantee that page_mask is indeed a
so-called page mask. That won't affect current usage since now only
vhost is using it (vhost API allows arbitary IOTLB range). However we
have IOTLB scemantic and we should best follow it. This patch fixes this
issue to make sure the page_mask is always a valid page mask.

Fixes: a764040 ("exec: abstract address_space_do_translate()")
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1496212378-22605-1-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index 29633cd..22b8f0c 100644
--- a/exec.c
+++ b/exec.c
@@ -528,16 +528,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
         section.offset_within_region;
 
     if (plen == (hwaddr)-1) {
-        /*
-         * We use default page size here. Logically it only happens
-         * for identity mappings.
-         */
-        plen = TARGET_PAGE_SIZE;
+        /* If not specified during translation, use default mask */
+        plen = TARGET_PAGE_MASK;
+    } else {
+        /* Make it a valid page mask */
+        assert(plen);
+        plen = pow2floor(plen) - 1;
     }
 
-    /* Convert to address mask */
-    plen -= 1;
-
     return (IOMMUTLBEntry) {
         .target_as = section.address_space,
         .iova = addr & ~plen,
-- 
1.8.3.1
