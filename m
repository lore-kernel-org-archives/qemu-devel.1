Received: from eggs.gnu.org ([2001:4830:134:3::10]:47566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRp-0001sb-FR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MII-00061d-Gz
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:21:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:10 +0200
Message-Id: <20181005092024.14344-3-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 02/16] memory-device: fix error message when
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
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

The "at" should actually be a "before".
    if (new_addr < address_space_start)
     -> "can't add memory ... before... $address_space_start"

So it looks similar to the other check
    } else if ((new_addr + size) > address_space_end)
     -> "can't add memory ... beyond..."

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 0b52fe2c5e..7c706fadfc 100644
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
