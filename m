Received: from eggs.gnu.org ([2001:4830:134:3::10]:47318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRo-0001nG-9v
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MIP-00065t-LE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:21:19 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:11 +0200
Message-Id: <20181005092024.14344-4-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/16] memory-device: improve "range
 conflicts" error message
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

Handle id==NULL better and indicate that we are dealing with memory
devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 7c706fadfc..0624184c40 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -175,7 +175,8 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
         if (ranges_overlap(md_addr, md_size, new_addr, size)) {
             if (hint) {
                 const DeviceState *d = DEVICE(md);
-                error_setg(errp, "address range conflicts with '%s'", d->id);
+                error_setg(errp, "address range conflicts with memory device"
+                           " id='%s'", d->id ? d->id : "(unnamed)");
                 goto out;
             }
             new_addr = QEMU_ALIGN_UP(md_addr + md_size, align);
-- 
2.17.1
