Received: from eggs.gnu.org ([2001:4830:134:3::10]:58145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfnx-0003Fn-0p
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfnt-0000K6-MS
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:36:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:36 -0300
Message-Id: <20181025133301.16578-19-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 18/43] memory-device: fix error message when
 hinted address is too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20181005092024.14344-3-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
