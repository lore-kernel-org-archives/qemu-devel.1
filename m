Received: from eggs.gnu.org ([2001:4830:134:3::10]:37777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eqlEr-00044w-SE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eqlEn-0004ia-MR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:48:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eqlEn-0004i5-Ha
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:48:33 -0500
From: P J P <ppandit@redhat.com>
Date: Wed, 28 Feb 2018 01:18:16 +0530
Message-Id: <20180227194816.17940-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] multiboot: check mh_load_end_addr address field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, CERT CC <cert.cc@orange.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While loading kernel via multiboot-v1 image, (flags & 0x00010000)
indicates that multiboot header contains valid addresses to load
the kernel image. In that, end of the data segment address
'mh_load_end_addr' should be less than the bss segment address
'mh_bss_end_addr'. Add check to validate that.

Reported-by: CERT CC <cert.cc@orange.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/i386/multiboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 46d9c68bf5..d16e32bf4a 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -227,6 +227,10 @@ int load_multiboot(FWCfgState *fw_cfg,
             fprintf(stderr, "invalid mh_load_addr address\n");
             exit(1);
         }
+        if (mh_load_end_addr > mh_bss_end_addr) {
+            fprintf(stderr, "invalid mh_load_end_addr address\n");
+            exit(1);
+        }
 
         uint32_t mb_kernel_text_offset = i - (mh_header_addr - mh_load_addr);
         uint32_t mb_load_size = 0;
-- 
2.14.3
