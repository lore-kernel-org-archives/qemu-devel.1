Received: from eggs.gnu.org ([209.51.188.92]:33387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0sZ-0003PI-2J
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0sX-0003c1-W1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghook@redhat.com>) id 1hE0sW-0003Rn-Ei
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:14:13 -0400
From: Gary R Hook <ghook@redhat.com>
Date: Tue,  9 Apr 2019 20:08:03 -0400
Message-Id: <20190410000803.1744-3-ghook@redhat.com>
In-Reply-To: <20190410000803.1744-1-ghook@redhat.com>
References: <20190410000803.1744-1-ghook@redhat.com>
Subject: [Qemu-devel] [RHEL-8.1 virt 2/2] target/i386: sev: Do not pin the
 ram device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rhvirt-patches@redhat.com
Cc: ghook@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

BZ: 1667249
Branch: rhel-8.1.0
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
Upstream Status: 4.0.0-rc1
Build Info: https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=20980582
Conflicts: None

commit cedc0ad539afbbb669dba9e73dfad2915bc1c25b
Author: Singh, Brijesh <brijesh.singh@amd.com>
Date:   Mon Feb 4 22:23:40 2019 +0000

    target/i386: sev: Do not pin the ram device memory region

    The RAM device presents a memory region that should be handled
    as an IO region and should not be pinned.

    In the case of the vfio-pci, RAM device represents a MMIO BAR
    and the memory region is not backed by pages hence
    KVM_MEMORY_ENCRYPT_REG_REGION fails to lock the memory range.

    Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
    Cc: Alex Williamson <alex.williamson@redhat.com>
    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
    Message-Id: <20190204222322.26766-3-brijesh.singh@amd.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Richard Henderson <rth@twiddle.net> 
Cc: Eduardo Habkost <ehabkost@redhat.com> 
Cc: qemu-devel@nongnu.org 
---
 target/i386/sev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2395171acf..b8009b001a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -130,6 +130,17 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
 {
     int r;
     struct kvm_enc_region range;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+
+    /*
+     * The RAM device presents a memory region that should be treated
+     * as IO region and should not be pinned.
+     */
+    mr = memory_region_from_host(host, &offset);
+    if (mr && memory_region_is_ram_device(mr)) {
+	return;
+    }
 
     range.addr = (__u64)(unsigned long)host;
     range.size = size;
-- 
2.18.1
