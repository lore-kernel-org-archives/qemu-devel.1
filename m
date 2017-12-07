Received: from eggs.gnu.org ([2001:4830:134:3::10]:52134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGV-0005Sh-V1
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGU-0003bF-Qc
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtGU-000355-El
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:50 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:11 +0800
Message-Id: <20171207101812.23602-10-haozhong.zhang@intel.com>
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 09/10] nvdimm acpi: add
 compatibility for 64-bit integer in ACPI 2.0 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

When QEMU is used as Xen device model, the QEMU-built NVDIMM ACPI
tables (NFIT and SSDT) may be passed to Xen and merged with Xen-built
ACPI tables. However, different ACPI versions are used between QEMU
(ACPI 1.0) and Xen (ACPI 2.0), and different integer widths are used
between ACPI 1.0 (32 bits) and ACPI 2.0 (64 bits).

Due to the implicit type conversion between ACPI buffer field object
and ACPI integer object (ref. ACPI Spec 6.2, Sect 19.3.5.5, 19.3.5.7 &
19.3.5.8), the following AML in NVDIMM SSDT may behave differently in
ACPI 1.0 and ACPI 2.0:

    Method (NCAL, 5, Serialized)
    {
        Local6 = MEMA /* \MEMA */
        OperationRegion (NPIO, SystemIO, 0x0A18, 0x04)
        OperationRegion (NRAM, SystemMemory, Local6, 0x1000)
        Field (NPIO, DWordAcc, NoLock, Preserve)
        {
            NTFI,   32
        }

        ...

        Field (NRAM, DWordAcc, NoLock, Preserve)
        {
            RLEN,   32,
            ODAT,   32736
        }

        ...

        NTFI = Local6
        Local1 = (RLEN - 0x04)
        Local1 = (Local1 << 0x03)
        CreateField (ODAT, Zero, Local1, OBUF)
        Concatenate (Buffer (Zero){}, OBUF, Local7)
        Return (Local7)
    }

The C layout of the above ODAT is struct NvdimmFuncReadFitOut without
the length field:

    struct {
        uint32_t func_ret_status;
	uint8_t fit[0];
    }

When no error happens and no FIT data is needed to return,
nvdimm_dsm_func_read_fit() fills

    { .func_ret_status = 0 },

i.e., 4 bytes of 0's in ODAT. Because the length of ODAT is no larger
than an integer, OBUF is implicitly converted into an ACPI integer
object during the evaluation of CreateField. Later, when OBUF is
concatenated to another buffer, it needs to be converted to an ACPI
buffer object.  It's converted to a 4 bytes buffer in ACPI 1.0, but
it's converted to a 8 bytes buffer in ACPI 2.0. The extra 4 bytes in
ACPI 2.0 actually corresponds to the apparently incorrect case that

    { .func_ret_status = 0, fit = { 0, 0, 0, 0 } }

is filled in ODAT.

In order to mitigate this issue, we add a 32-bit reserved field after
func_ret_status and always fill it with 0. Therefore, the minimum
length of ODAT in both ACPI 1.0 and ACPI 2.0 is always 8 bytes, so no
extra bytes will be added accidentally by the implicit conversion.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/nvdimm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 7b3062e001..bceb35e75a 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -493,6 +493,7 @@ struct NvdimmFuncReadFITOut {
     /* the size of buffer filled by QEMU. */
     uint32_t len;
     uint32_t func_ret_status; /* return status code. */
+    uint32_t reserved;
     uint8_t fit[0]; /* the FIT data. */
 } QEMU_PACKED;
 typedef struct NvdimmFuncReadFITOut NvdimmFuncReadFITOut;
@@ -597,6 +598,7 @@ exit:
 
     read_fit_out->len = cpu_to_le32(size);
     read_fit_out->func_ret_status = cpu_to_le32(func_ret_status);
+    read_fit_out->reserved = 0;
     memcpy(read_fit_out->fit, fit->data + read_fit->offset, read_len);
 
     nvdimm_copy_to_dsm_mem(dsm_mem_addr, read_fit_out, size);
@@ -1168,7 +1170,8 @@ static void nvdimm_build_fit(Aml *dev)
 
     aml_append(method, aml_store(aml_sizeof(buf), buf_size));
     aml_append(method, aml_subtract(buf_size,
-                                    aml_int(4) /* the size of "STAU" */,
+                                    aml_int(8) /* the size of "STAU" and the
+                                                  consequent reserved field */,
                                     buf_size));
 
     /* if we read the end of fit. */
@@ -1177,7 +1180,7 @@ static void nvdimm_build_fit(Aml *dev)
     aml_append(method, ifctx);
 
     aml_append(method, aml_create_field(buf,
-                            aml_int(4 * BITS_PER_BYTE), /* offset at byte 4.*/
+                            aml_int(8 * BITS_PER_BYTE), /* offset at byte 8. */
                             aml_shiftleft(buf_size, aml_int(3)), "BUFF"));
     aml_append(method, aml_return(aml_name("BUFF")));
     aml_append(dev, method);
-- 
2.15.1
