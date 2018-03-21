Received: from eggs.gnu.org ([2001:4830:134:3::10]:37454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyevc-0006qK-UB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyeva-0002Cn-QI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eyeva-0002Ca-ME
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 15:41:03 +0100
Message-Id: <20180321144107.22770-2-kwolf@redhat.com>
In-Reply-To: <20180321144107.22770-1-kwolf@redhat.com>
References: <20180321144107.22770-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] multiboot: Reject kernels exceeding the
 address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org

The code path where mh_load_end_addr is non-zero in the Multiboot
header checks that mh_load_end_addr >= mh_load_addr and so
mb_load_size is checked.  However, mb_load_size is not checked when
calculated from the file size, when mh_load_end_addr is 0.

If the kernel binary size is larger than can fit in the address space
after load_addr, we ended up with a kernel_size that is smaller than
load_size, which means that we read the file into a too small buffer.

Add a check to reject kernel files with such Multiboot headers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>
---
 hw/i386/multiboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index b9064264d8..1e215bf8d3 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -247,6 +247,10 @@ int load_multiboot(FWCfgState *fw_cfg,
             }
             mb_load_size = kernel_file_size - mb_kernel_text_offset;
         }
+        if (mb_load_size > UINT32_MAX - mh_load_addr) {
+            error_report("kernel does not fit in address space");
+            exit(1);
+        }
         if (mh_bss_end_addr) {
             if (mh_bss_end_addr < (mh_load_addr + mb_load_size)) {
                 error_report("invalid bss_end_addr address");
-- 
2.13.6
