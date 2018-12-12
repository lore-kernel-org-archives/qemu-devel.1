Received: from eggs.gnu.org ([2001:4830:134:3::10]:52195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MY-0000mo-1v
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MW-0000Dd-P7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MW-0008Np-Dz
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:48 -0500
Received: by mail-wr1-x434.google.com with SMTP id x10so18065819wrs.8
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:28 +0100
Message-Id: <1544628195-37728-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/54] pam: wrap MemoryRegion initialization in
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
index e361ecb..aa5ecfd 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -52,11 +52,13 @@ void init_pam(DeviceState *dev, MemoryRegion *ram_memory,
     memory_region_init_alias(&mem->alias[2], OBJECT(dev), "pam-pci", ram_memory,
                              start, size);
 
+    memory_region_transaction_begin();
     for (i = 0; i < 4; ++i) {
         memory_region_set_enabled(&mem->alias[i], false);
         memory_region_add_subregion_overlap(system_memory, start,
                                             &mem->alias[i], 1);
     }
+    memory_region_transaction_commit();
     mem->current = 0;
 }
 
-- 
1.8.3.1
