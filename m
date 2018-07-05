Received: from eggs.gnu.org ([2001:4830:134:3::10]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vO-0000gv-JC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vM-0002LA-AQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vM-0002KU-5Y
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFD0E87A72
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 11:59:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:33 +0200
Message-Id: <20180705115943.29402-2-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 01/11] memory-device: fix error message when
 hinted address is too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>

The "at" should actually be a "before".
    if (new_addr < address_space_start)
     -> "can't add memory ... before... $address_space_start"

So it looks similar to the other check
    } else if ((new_addr + size) > address_space_end)
     -> "can't add memory ... beyond..."

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 6de4f70bb4..efacbc2a7d 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -146,7 +146,8 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
         new_addr = *hint;
         if (new_addr < address_space_start) {
             error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
-                       "] at 0x%" PRIx64, new_addr, size, address_space_start);
+                       "] before 0x%" PRIx64, new_addr, size,
+                       address_space_start);
             return 0;
         } else if ((new_addr + size) > address_space_end) {
             error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
-- 
2.17.1
