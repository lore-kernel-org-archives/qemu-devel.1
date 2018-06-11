Received: from eggs.gnu.org ([2001:4830:134:3::10]:48896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl2-000220-LA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl1-0008Te-QV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:50 +0200
Message-Id: <20180611121655.19616-7-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 06/11] pc-dimm: don't allow to access "size"
 before the device was realized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

"size" should not be queried before the device was realized. Let' make
that explicit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 86fbcf2d0c..5294734529 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -166,6 +166,12 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
     PCDIMMDevice *dimm = PC_DIMM(obj);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
 
+    if (!DEVICE(obj)->realized) {
+        error_setg(errp, "Property \"%s\" not accessible before realized",
+                   name);
+        return;
+    }
+
     mr = ddc->get_memory_region(dimm, errp);
     if (!mr) {
         return;
-- 
2.17.1
