Received: from eggs.gnu.org ([2001:4830:134:3::10]:32868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCTWV-0006pY-FP
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCTWR-0006ck-H3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:52:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCTWM-0006OW-Q4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:52:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 18:52:36 +0100
Message-Id: <20181016175236.5840-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/acpi/nvdimm: Don't take address of fields
 in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by not using the
"modify in place" byte swapping functions.

Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Automatically generated patch, tested with "make check" only.

 hw/acpi/nvdimm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 27eeb6609f5..e53b2cb6819 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -581,7 +581,7 @@ static void nvdimm_dsm_func_read_fit(AcpiNVDIMMState *state, NvdimmDsmIn *in,
     int size;
 
     read_fit = (NvdimmFuncReadFITIn *)in->arg3;
-    le32_to_cpus(&read_fit->offset);
+    read_fit->offset = le32_to_cpu(read_fit->offset);
 
     fit = fit_buf->fit;
 
@@ -742,8 +742,8 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     int size;
 
     get_label_data = (NvdimmFuncGetLabelDataIn *)in->arg3;
-    le32_to_cpus(&get_label_data->offset);
-    le32_to_cpus(&get_label_data->length);
+    get_label_data->offset = le32_to_cpu(get_label_data->offset);
+    get_label_data->length = le32_to_cpu(get_label_data->length);
 
     nvdimm_debug("Read Label Data: offset %#x length %#x.\n",
                  get_label_data->offset, get_label_data->length);
@@ -781,8 +781,8 @@ static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
 
     set_label_data = (NvdimmFuncSetLabelDataIn *)in->arg3;
 
-    le32_to_cpus(&set_label_data->offset);
-    le32_to_cpus(&set_label_data->length);
+    set_label_data->offset = le32_to_cpu(set_label_data->offset);
+    set_label_data->length = le32_to_cpu(set_label_data->length);
 
     nvdimm_debug("Write Label Data: offset %#x length %#x.\n",
                  set_label_data->offset, set_label_data->length);
@@ -877,9 +877,9 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     in = g_new(NvdimmDsmIn, 1);
     cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
 
-    le32_to_cpus(&in->revision);
-    le32_to_cpus(&in->function);
-    le32_to_cpus(&in->handle);
+    in->revision = le32_to_cpu(in->revision);
+    in->function = le32_to_cpu(in->function);
+    in->handle = le32_to_cpu(in->handle);
 
     nvdimm_debug("Revision %#x Handler %#x Function %#x.\n", in->revision,
                  in->handle, in->function);
-- 
2.19.0
