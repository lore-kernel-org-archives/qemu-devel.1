Received: from eggs.gnu.org ([209.51.188.92]:35043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gqmef-0006ok-Vc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gqmed-0001hb-KP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:23:53 -0500
Received: from mail-eopbgr750044.outbound.protection.outlook.com
	([40.107.75.44]:33504
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1gqmed-0001ZM-B4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:23:51 -0500
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 4 Feb 2019 22:23:40 +0000
Message-ID: <20190204222322.26766-3-brijesh.singh@amd.com>
References: <20190204222322.26766-1-brijesh.singh@amd.com>
In-Reply-To: <20190204222322.26766-1-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 2/2] target/i386: sev: Do not pin the ram
 device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, Paolo Bonzini <pbonzini@redhat.com>

The RAM device presents a memory region that should be handled
as an IO region and should not be pinned.

In the case of the vfio-pci, RAM device represents a MMIO BAR
and the memory region is not backed by pages hence
KVM_MEMORY_ENCRYPT_REG_REGION fails to lock the memory range.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1667249
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/sev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 20b2d325d8..cd77f6b5d4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -131,6 +131,17 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, s=
ize_t size)
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
+    mr =3D memory_region_from_host(host, &offset);
+    if (mr && memory_region_is_ram_device(mr)) {
+        return;
+    }
=20
     range.addr =3D (__u64)(unsigned long)host;
     range.size =3D size;
--=20
2.17.1
