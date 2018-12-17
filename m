Received: from eggs.gnu.org ([2001:4830:134:3::10]:43075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28Z-0000Ix-GR
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28Y-0003HN-Oz
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28Y-0003Gn-IZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44EBC804FA
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:21 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.112.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5AA125D9C5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:32 +0100
Message-Id: <20181217231700.24482-8-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/35] pam: wrap MemoryRegion initialization in
 a transaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This avoids a few re-rendering of the memory AddressSpace.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/pam.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/pam.c b/hw/pci-host/pam.c
index e361ecb7ee..aa5ecfd0c2 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -52,11 +52,13 @@ void init_pam(DeviceState *dev, MemoryRegion *ram_mem=
ory,
     memory_region_init_alias(&mem->alias[2], OBJECT(dev), "pam-pci", ram=
_memory,
                              start, size);
=20
+    memory_region_transaction_begin();
     for (i =3D 0; i < 4; ++i) {
         memory_region_set_enabled(&mem->alias[i], false);
         memory_region_add_subregion_overlap(system_memory, start,
                                             &mem->alias[i], 1);
     }
+    memory_region_transaction_commit();
     mem->current =3D 0;
 }
=20
--=20
2.20.1
