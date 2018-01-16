Received: from eggs.gnu.org ([2001:4830:134:3::10]:53652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWr-0002mq-2J
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWm-0003vn-VY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:52:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ebTWm-0003vB-MY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:56 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GFoqdu026128
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:55 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fhgrpmmbx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:54 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 08:51:54 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 10:51:40 -0500
In-Reply-To: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanb@linux.vnet.ibm.com, kevin@koconnor.net, marcandre.lureau@redhat.com, lersek@redhat.com

The TPM Physical Presence interface consists of an ACPI part, a shared
memory part, and code in the firmware. Users can send messages to the
firmware by writing a code into the shared memory through invoking the
ACPI code. When a reboot happens, the firmware looks for the code and
acts on it by sending sequences of commands to the TPM.

This patch adds the ACPI code. It is similar to the one in EDK2 but doesn't
assume that SMIs are necessary to use. It uses a similar datastructure for
the shared memory as EDK2 does so that EDK2 and SeaBIOS could both make use
of it. I extended the shared memory data structure with an array of 256
bytes, one for each code that could be implemented. The array contains
flags describing the individual codes. This decouples the ACPI implementation
from the firmware implementation.

The underlying TCG specification is accessible from the following page.

https://trustedcomputinggroup.org/tcg-physical-presence-interface-specification/

This patch implements version 1.30.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

---
 v1->v2:
   - get rid of FAIL variable; function 5 was using it and always
     returns 0; the value is related to the ACPI function call not
     a possible failure of the TPM function call.
   - extend shared memory data structure with per-opcode entries
     holding flags and use those flags to determine what to return
     to caller
   - implement interface version 1.3
---
 hw/i386/acpi-build.c        | 273 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/acpi/acpi-defs.h |   2 +
 include/hw/acpi/tpm.h       |  31 +++++
 3 files changed, 306 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 522d6d2..f8c2d01 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -42,6 +42,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
+#include "hw/tpm/tpm_ppi.h"
 #include "hw/acpi/vmgenid.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/timer/mc146818rtc_regs.h"
@@ -1860,6 +1861,276 @@ static Aml *build_q35_osc_method(void)
 }
 
 static void
+build_tpm_ppi(Aml *dev, TPMVersion tpm_version)
+{
+    Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *pak;
+
+    aml_append(dev,
+               aml_operation_region("TPPI", AML_SYSTEM_MEMORY,
+                                    aml_int(TPM_PPI_ADDR_BASE),
+                                    TPM_PPI_STRUCT_SIZE));
+
+    field = aml_field("TPPI", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("PPIN",
+               sizeof(uint8_t) * BITS_PER_BYTE));
+    aml_append(field, aml_named_field("PPIP",
+               sizeof(uint32_t) * BITS_PER_BYTE));
+    aml_append(field, aml_named_field("PPRP",
+               sizeof(uint32_t) * BITS_PER_BYTE));
+    aml_append(field, aml_named_field("PPRQ",
+               sizeof(uint32_t) * BITS_PER_BYTE));
+    aml_append(field, aml_named_field("PPRM",
+               sizeof(uint32_t) * BITS_PER_BYTE));
+    aml_append(field, aml_named_field("LPPR",
+               sizeof(uint32_t) * BITS_PER_BYTE));
+    aml_append(field, aml_reserved_field(
+               sizeof(uint32_t) * BITS_PER_BYTE /* FRET */ +
+               sizeof(uint8_t) * BITS_PER_BYTE /* MCIN */ +
+               sizeof(uint32_t) * BITS_PER_BYTE * 4 /* MCIP .. UCRQ */ +
+               sizeof(uint8_t) * BITS_PER_BYTE * 214));
+    aml_append(field, aml_named_field("FUNC",
+               sizeof(uint8_t) * BITS_PER_BYTE * 256));
+    aml_append(dev, field);
+
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    {
+        uint8_t zerobyte[1] = { 0 };
+
+        ifctx = aml_if(
+                  aml_equal(aml_arg(0),
+                            aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653"))
+                );
+        {
+            aml_append(ifctx,
+                       aml_store(aml_to_integer(aml_arg(2)), aml_local(0)));
+
+            /* standard DSM query function */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(0)));
+            {
+                uint8_t byte_list[2] = { 0xff, 0x01 };
+                aml_append(ifctx2, aml_return(aml_buffer(2, byte_list)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* interface version: 1.3 */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(1)));
+            {
+                aml_append(ifctx2, aml_return(aml_string("1.3")));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* submit TPM operation */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(2)));
+            {
+                /* get opcode */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(aml_arg(3),
+                                                           aml_int(0))),
+                                     aml_local(0)));
+                /* get opcode flags */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
+                                                           aml_local(0))),
+                                     aml_local(1)));
+                ifctx3 = aml_if(
+                              aml_equal(
+                                  aml_and(aml_local(1),
+                                          aml_int(TPM_PPI_FUNC_IMPLEMENTED),
+                                          NULL),
+                                  aml_int(0)
+                              )
+                         );
+                {
+                    /* 1: not implemented */
+                    aml_append(ifctx3, aml_return(aml_int(1)));
+                }
+                aml_append(ifctx2, ifctx3);
+                aml_append(ifctx2, aml_store(aml_local(0), aml_name("PPRQ")));
+                aml_append(ifctx2, aml_store(aml_int(0), aml_name("PPRM")));
+                /* 0: success */
+                aml_append(ifctx2, aml_return(aml_int(0)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* get pending TPM operation */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(3)));
+            {
+                /* revision to integer */
+                aml_append(ifctx2,
+                           aml_store(
+                             aml_to_integer(aml_arg(1)),
+                             aml_local(1)));
+                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(1)));
+                {
+                    pak = aml_package(2);
+                    aml_append(pak, aml_int(0));
+                    aml_append(pak, aml_name("PPRQ"));
+                    aml_append(ifctx3, aml_return(pak));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(2)));
+                {
+                    pak = aml_package(3);
+                    aml_append(pak, aml_int(0));
+                    aml_append(pak, aml_name("PPRQ"));
+                    aml_append(pak, aml_name("PPRM"));
+                    aml_append(ifctx3, aml_return(pak));
+                }
+                aml_append(ifctx2, ifctx3);
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* get platform-specific action to transition to pre-OS env. */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(4)));
+            {
+                /* get opcode */
+                aml_append(ifctx2,
+                           aml_store(aml_name("PPRQ"),
+                                     aml_local(0)));
+                /* get opcode flags */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
+                                                           aml_local(0))),
+                                     aml_local(1)));
+                /* return action flags */
+                aml_append(ifctx2,
+                           aml_return(
+                               aml_shiftright(
+                                   aml_and(aml_local(1),
+                                           aml_int(TPM_PPI_FUNC_ACTION_MASK),
+                                           NULL),
+                                   aml_int(1),
+                                   NULL)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* get TPM operation response */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(5)));
+            {
+                pak = aml_package(3);
+
+                aml_append(pak, aml_int(0));
+                aml_append(pak, aml_name("LPPR"));
+                aml_append(pak, aml_name("PPRP"));
+
+                aml_append(ifctx2, aml_return(pak));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* submit preferred user language */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(6)));
+            {
+                /* 3 = not implemented */
+                aml_append(ifctx2, aml_return(aml_int(3)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* submit TPM operation v2 */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(7)));
+            {
+                /* get opcode */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(aml_arg(3),
+                                                           aml_int(0))),
+                                     aml_local(0)));
+                /* get opcode flags */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
+                                                           aml_local(0))),
+                                     aml_local(1)));
+                ifctx3 = aml_if(
+                              aml_equal(
+                                  aml_and(aml_local(1),
+                                          aml_int(TPM_PPI_FUNC_MASK),
+                                          NULL),
+                                  aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)
+                              )
+                         );
+                {
+                    /* 1: not implemented */
+                    aml_append(ifctx3, aml_return(aml_int(1)));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                ifctx3 = aml_if(
+                              aml_equal(
+                                  aml_and(
+                                      aml_local(1),
+                                      aml_int(TPM_PPI_FUNC_MASK),
+                                      NULL),
+                                  aml_int(TPM_PPI_FUNC_BLOCKED)
+                              )
+                         );
+                {
+                    /* 3: blocked by firmware */
+                    aml_append(ifctx3, aml_return(aml_int(3)));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                /* revision to integer */
+                aml_append(ifctx2,
+                           aml_store(
+                             aml_to_integer(aml_arg(1)),
+                             aml_local(1)));
+
+                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(1)));
+                {
+                    /* revision 1 */
+                    aml_append(ifctx3, aml_store(aml_local(0), aml_name("PPRQ")));
+                    aml_append(ifctx3, aml_store(aml_int(0), aml_name("PPRM")));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(2)));
+                {
+                    /* revision 2 */
+                    aml_append(ifctx3, aml_store(aml_local(0), aml_name("PPRQ")));
+                    aml_append(ifctx3, aml_store(
+                                         aml_derefof(
+                                           aml_index(aml_arg(3),
+                                                     aml_int(1))),
+                                         aml_name("PPRM")));
+                }
+                aml_append(ifctx2, ifctx3);
+                /* 0: success */
+                aml_append(ifctx2, aml_return(aml_int(0)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /* get user confirmation status for operation */
+            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(8)));
+            {
+                /* get opcode */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(aml_arg(3),
+                                                           aml_int(0))),
+                                     aml_local(0)));
+                /* get opcode flags */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
+                                                           aml_local(0))),
+                                     aml_local(1)));
+                /* return confirmation status code */
+                aml_append(ifctx2,
+                           aml_return(
+                               aml_shiftright(
+                                   aml_and(aml_local(1),
+                                           aml_int(TPM_PPI_FUNC_MASK),
+                                           NULL),
+                                   aml_int(3),
+                                   NULL)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
+        }
+        aml_append(method, ifctx);
+    }
+    aml_append(dev, method);
+}
+
+static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
            Range *pci_hole, Range *pci_hole64, MachineState *machine)
@@ -2218,6 +2489,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                  */
                 /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
                 aml_append(dev, aml_name_decl("_CRS", crs));
+                build_tpm_ppi(dev, misc->tpm_version);
                 aml_append(scope, dev);
             }
 
@@ -2636,6 +2908,7 @@ static void build_qemu(GArray *table_data, BIOSLinker *linker,
     if (tpm_version != TPM_VERSION_UNSPEC) {
         qemu->tpmppi_addr = TPM_PPI_ADDR_BASE;
         qemu->tpm_version = tpm_version;
+        qemu->tpmppi_version = TPM_PPI_VERSION_1_30;
     }
 
     build_header(linker, table_data,
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 98764c1..a182194 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -578,6 +578,8 @@ struct AcpiTableQemu {
     ACPI_TABLE_HEADER_DEF
     uint32_t tpmppi_addr;
     uint8_t tpm_version; /* 1 = 1.2, 2 = 2 */
+    uint8_t tpmppi_version;
+#define TPM_PPI_VERSION_1_30  1
 };
 typedef struct AcpiTableQemu AcpiTableQemu;
 
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 16227bc..130a039 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -37,4 +37,35 @@
 #define TPM_PPI_ADDR_SIZE           0x400
 #define TPM_PPI_ADDR_BASE           0xfffef000
 
+struct tpm_ppi {
+    uint8_t ppin;            /*  0: set by BIOS */
+    uint32_t ppip;           /*  1: set by ACPI; not used */
+    uint32_t pprp;           /*  5: response from TPM; set by BIOS */
+    uint32_t pprq;           /*  9: opcode; set by ACPI */
+    uint32_t pprm;           /* 13: parameter for opcode; set by ACPI */
+    uint32_t lppr;           /* 17: last opcode; set by BIOS */
+    uint32_t fret;           /* 21: set by ACPI; not used */
+    uint8_t res1;            /* 25: reserved */
+    uint32_t res2[4];        /* 26: reserved */
+    uint8_t  res3[214];      /* 42: reserved */
+    uint8_t  func[256];      /* 256: per TPM function implementation flags;
+                                     set by BIOS */
+/* indication whether function is implemented; bit 0 */
+#define TPM_PPI_FUNC_IMPLEMENTED       (1 << 0)
+/* actions OS should take to transition to the pre-OS env.; bits 1, 2 */
+#define TPM_PPI_FUNC_ACTION_SHUTDOWN   (1 << 1)
+#define TPM_PPI_FUNC_ACTION_REBOOT     (2 << 1)
+#define TPM_PPI_FUNC_ACTION_VENDOR     (3 << 1)
+#define TPM_PPI_FUNC_ACTION_MASK       (3 << 1)
+/* whether function is blocked by BIOS settings; bits 3,4,5 */
+#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 3)
+#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 3)
+#define TPM_PPI_FUNC_BLOCKED             (2 << 3)
+#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 3)
+#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 3)
+#define TPM_PPI_FUNC_MASK                (7 << 3)
+} QEMU_PACKED;
+
+#define TPM_PPI_STRUCT_SIZE  sizeof(struct tpm_ppi)
+
 #endif /* HW_ACPI_TPM_H */
-- 
2.5.5
