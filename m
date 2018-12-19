Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZddG-0005j2-BZ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZddF-0003yX-6w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZddF-0003xK-0a
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2647CFD199
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:19:32 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-76.ams2.redhat.com
	[10.36.112.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54B4317197
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:19:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Dec 2018 16:18:49 +0100
Message-Id: <20181219151917.3874-8-pbonzini@redhat.com>
In-Reply-To: <20181219151917.3874-1-pbonzini@redhat.com>
References: <20181219151917.3874-1-pbonzini@redhat.com>
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
