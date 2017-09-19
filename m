Received: from eggs.gnu.org ([2001:4830:134:3::10]:60087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfS-0004GE-PG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfJ-0005Sv-2O
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:22 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfI-0005SM-SF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:13 -0400
Received: by mail-wm0-x241.google.com with SMTP id i131so3749837wma.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:14 +0200
Message-Id: <1505824179-21541-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/50] multiboot: validate multiboot header
 address values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While loading kernel via multiboot-v1 image, (flags & 0x00010000)
indicates that multiboot header contains valid addresses to load
the kernel image. These addresses are used to compute kernel
size and kernel text offset in the OS image. Validate these
address values to avoid an OOB access issue.

This is CVE-2017-14167.

Reported-by: Thomas Garnier <thgarnie@google.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <20170907063256.7418-1-ppandit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/multiboot.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 6001f4c..c7b70c9 100644
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
1.8.3.1
