Received: from eggs.gnu.org ([2001:4830:134:3::10]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmM5-0005Oh-UT
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmM1-0004mK-Uu
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmM1-0004lV-My
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:57 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:13 -0200
Message-Id: <20181211180129.7661-9-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/24] memory-device: avoid overflows on very
 huge devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Should not be a problem right now, but it could theoretically happen
in the future.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181023152306.3123-7-david@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mem/memory-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 996ad1490f..8be63c8032 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -85,7 +85,8 @@ static void memory_device_check_addable(MachineState *ms, uint64_t size,
 
     /* will we exceed the total amount of memory specified */
     memory_device_used_region_size(OBJECT(ms), &used_region_size);
-    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
+    if (used_region_size + size < used_region_size ||
+        used_region_size + size > ms->maxram_size - ms->ram_size) {
         error_setg(errp, "not enough space, currently 0x%" PRIx64
                    " in use of total space for memory devices 0x" RAM_ADDR_FMT,
                    used_region_size, ms->maxram_size - ms->ram_size);
-- 
2.18.0.rc1.1.g3f1ff2140
