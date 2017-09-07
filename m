Received: from eggs.gnu.org ([2001:4830:134:3::10]:50583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dpqN9-0003R8-2k
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dpqN5-0001OK-VZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1dpqN5-0001O7-Q2
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:33:03 -0400
From: P J P <ppandit@redhat.com>
Date: Thu,  7 Sep 2017 12:02:56 +0530
Message-Id: <20170907063256.7418-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] multiboot: validate multiboot header
 address values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Garnier <thgarnie@google.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While loading kernel via multiboot-v1 image, (flags & 0x00010000)
indicates that multiboot header contains valid addresses to load
the kernel image. These addresses are used to compute kernel
size and kernel text offset in the OS image. Validate these
address values to avoid an OOB access issue.

This is CVE-2017-14167.

Reported-by: Thomas Garnier <thgarnie@google.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/i386/multiboot.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Update: add CVE-ID to the commit message.

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 6001f4caa2..c7b70c91d5 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -221,15 +221,34 @@ int load_multiboot(FWCfgState *fw_cfg,
         uint32_t mh_header_addr = ldl_p(header+i+12);
         uint32_t mh_load_end_addr = ldl_p(header+i+20);
         uint32_t mh_bss_end_addr = ldl_p(header+i+24);
+
         mh_load_addr = ldl_p(header+i+16);
+        if (mh_header_addr < mh_load_addr) {
+            fprintf(stderr, "invalid mh_load_addr address\n");
+            exit(1);
+        }
+
         uint32_t mb_kernel_text_offset = i - (mh_header_addr - mh_load_addr);
         uint32_t mb_load_size = 0;
         mh_entry_addr = ldl_p(header+i+28);
 
         if (mh_load_end_addr) {
+            if (mh_bss_end_addr < mh_load_addr) {
+                fprintf(stderr, "invalid mh_bss_end_addr address\n");
+                exit(1);
+            }
             mb_kernel_size = mh_bss_end_addr - mh_load_addr;
+
+            if (mh_load_end_addr < mh_load_addr) {
+                fprintf(stderr, "invalid mh_load_end_addr address\n");
+                exit(1);
+            }
             mb_load_size = mh_load_end_addr - mh_load_addr;
         } else {
+            if (kernel_file_size < mb_kernel_text_offset) {
+                fprintf(stderr, "invalid kernel_file_size\n");
+                exit(1);
+            }
             mb_kernel_size = kernel_file_size - mb_kernel_text_offset;
             mb_load_size = mb_kernel_size;
         }
-- 
2.13.5
