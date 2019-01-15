Received: from eggs.gnu.org ([209.51.188.92]:35526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyo-00081s-CK
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyQ-0003PC-8f
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyN-0003JH-UN
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:09 -0500
Date: Tue, 15 Jan 2019 15:06:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-41-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 40/49] acpi: build TPM Physical Presence
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

The TPM Physical Presence interface consists of an ACPI part, a shared
memory part, and code in the firmware. Users can send messages to the
firmware by writing a code into the shared memory through invoking the
ACPI code. When a reboot happens, the firmware looks for the code and
acts on it by sending sequences of commands to the TPM.

This patch adds the ACPI code. It is similar to the one in EDK2 but doesn=
't
assume that SMIs are necessary to use. It uses a similar datastructure fo=
r
the shared memory as EDK2 does so that EDK2 and SeaBIOS could both make u=
se
of it. I extended the shared memory data structure with an array of 256
bytes, one for each code that could be implemented. The array contains
flags describing the individual codes. This decouples the ACPI implementa=
tion
from the firmware implementation.

The underlying TCG specification is accessible from the following page.

https://trustedcomputinggroup.org/tcg-physical-presence-interface-specifi=
cation/

This patch implements version 1.30.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
[ Marc-Andr=C3=A9 - ACPI code improvements and windows fixes ]
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/tpm.txt    |  83 +++++++++
 include/hw/acpi/tpm.h |  12 ++
 hw/acpi/tpm.c         | 404 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |  12 +-
 stubs/tpm.c           |   5 +
 hw/acpi/Makefile.objs |   1 +
 6 files changed, 514 insertions(+), 3 deletions(-)
 create mode 100644 hw/acpi/tpm.c

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index e4bb094700..424d1511fc 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -76,6 +76,89 @@ URL:
=20
 https://trustedcomputinggroup.org/tcg-acpi-specification/
=20
+=3D=3D ACPI PPI Interface =3D=3D
+
+QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and TPM =
2. This
+interface requires ACPI and firmware support. The specification can be f=
ound at
+the following URL:
+
+https://trustedcomputinggroup.org/resource/tcg-physical-presence-interfa=
ce-specification/
+
+PPI enables a system administrator (root) to request a modification to t=
he
+TPM upon reboot. The PPI specification defines the operation requests an=
d the
+actions the firmware has to take. The system administrator passes the op=
eration
+request number to the firmware through an ACPI interface which writes th=
is
+number to a memory location that the firmware knows. Upon reboot, the fi=
rmware
+finds the number and sends commands to the the TPM. The firmware writes =
the TPM
+result code and the operation request number to a memory location that A=
CPI can
+read from and pass the result on to the administrator.
+
+The PPI specification defines a set of mandatory and optional operations=
 for
+the firmware to implement. The ACPI interface also allows an administrat=
or to
+list the supported operations. In QEMU the ACPI code is generated by QEM=
U, yet
+the firmware needs to implement support on a per-operations basis, and
+different firmwares may support a different subset. Therefore, QEMU intr=
oduces
+the virtual memory device for PPI where the firmware can indicate which
+operations it supports and ACPI can enable the ones that are supported a=
nd
+disable all others. This interface lies in main memory and has the follo=
wing
+layout:
+
+ +----------+--------+--------+-----------------------------------------=
--+
+ |  Field   | Length | Offset | Description                             =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | func     |  0x100 |  0x000 | Firmware sets values for each supported =
  |
+ |          |        |        | operation. See defined values below.    =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | ppin     |   0x1  |  0x100 | SMI interrupt to use. Set by firmware.  =
  |
+ |          |        |        | Not supported.                          =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | ppip     |   0x4  |  0x101 | ACPI function index to pass to SMM code.=
  |
+ |          |        |        | Set by ACPI. Not supported.             =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | pprp     |   0x4  |  0x105 | Result of last executed operation. Set b=
y |
+ |          |        |        | firmware. See function index 5 for value=
s.|
+ +----------+--------+--------+-----------------------------------------=
--+
+ | pprq     |   0x4  |  0x109 | Operation request number to execute. See=
  |
+ |          |        |        | 'Physical Presence Interface Operation  =
  |
+ |          |        |        | Summary' tables in specs. Set by ACPI.  =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | pprm     |   0x4  |  0x10d | Operation request optional parameter.   =
  |
+ |          |        |        | Values depend on operation. Set by ACPI.=
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | lppr     |   0x4  |  0x111 | Last executed operation request number. =
  |
+ |          |        |        | Copied from pprq field by firmware.     =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | fret     |   0x4  |  0x115 | Result code from SMM function.          =
  |
+ |          |        |        | Not supported.                          =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | res1     |  0x40  |  0x119 | Reserved for future use                 =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | next_step|   0x1  |  0x159 | Operation to execute after reboot by    =
  |
+ |          |        |        | firmware. Used by firmware.             =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+
+   The following values are supported for the 'func' field. They corresp=
ond
+   to the values used by ACPI function index 8.
+
+ +----------+-----------------------------------------------------------=
--+
+ | value    | Description                                               =
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 0        | Operation is not implemented.                             =
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 1        | Operation is only accessible through firmware.            =
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 2        | Operation is blocked for OS by firmware configuration.    =
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 3        | Operation is allowed and physically present user required.=
  |
+ +----------+-----------------------------------------------------------=
--+
+ | 4        | Operation is allowed and physically present user is not   =
  |
+ |          | required.                                                 =
  |
+ +----------+-----------------------------------------------------------=
--+
+
+The location of the table is given by the fw_cfg tpmppi_address field.
+The PPI memory region size is 0x400 (TPM_PPI_ADDR_SIZE) to leave
+enough room for future updates.
+
=20
 QEMU files related to TPM ACPI tables:
  - hw/i386/acpi-build.c
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index a6109a97fc..1a2a57a21f 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -18,6 +18,8 @@
=20
 #include "qemu/units.h"
 #include "hw/registerfields.h"
+#include "hw/acpi/aml-build.h"
+#include "sysemu/tpm.h"
=20
 #define TPM_TIS_ADDR_BASE           0xFED40000
 #define TPM_TIS_ADDR_SIZE           0x5000
@@ -197,4 +199,14 @@ REG32(CRB_DATA_BUFFER, 0x80)
 #define TPM_PPI_VERSION_NONE        0
 #define TPM_PPI_VERSION_1_30        1
=20
+/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
+#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
+#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
+#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
+#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
+#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
+#define TPM_PPI_FUNC_MASK                (7 << 0)
+
+void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev);
+
 #endif /* HW_ACPI_TPM_H */
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
new file mode 100644
index 0000000000..9f205378f2
--- /dev/null
+++ b/hw/acpi/tpm.c
@@ -0,0 +1,404 @@
+/* Support for generating ACPI TPM tables
+ *
+ * Copyright (C) 2018 IBM, Corp.
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/acpi/tpm.h"
+
+void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
+{
+    Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
+        *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
+
+    if (!object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
+        return;
+    }
+
+    zero =3D aml_int(0);
+    one =3D aml_int(1);
+    func_mask =3D aml_int(TPM_PPI_FUNC_MASK);
+    not_implemented =3D aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED);
+
+    /*
+     * TPP2 is for the registers that ACPI code used to pass
+     * the PPI code and parameter (PPRQ, PPRM) to the firmware.
+     */
+    aml_append(dev,
+               aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
+                                    aml_int(TPM_PPI_ADDR_BASE + 0x100),
+                                    0x5A));
+    field =3D aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("PPIN", 8));
+    aml_append(field, aml_named_field("PPIP", 32));
+    aml_append(field, aml_named_field("PPRP", 32));
+    aml_append(field, aml_named_field("PPRQ", 32));
+    aml_append(field, aml_named_field("PPRM", 32));
+    aml_append(field, aml_named_field("LPPR", 32));
+    aml_append(dev, field);
+    pprq =3D aml_name("PPRQ");
+    pprm =3D aml_name("PPRM");
+
+    /*
+     * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynamic
+     * operation region inside of a method for getting FUNC[op].
+     */
+    method =3D aml_method("TPFN", 1, AML_SERIALIZED);
+    {
+        Aml *op =3D aml_arg(0);
+        ifctx =3D aml_if(aml_lgreater_equal(op, aml_int(0x100)));
+        {
+            aml_append(ifctx, aml_return(zero));
+        }
+        aml_append(method, ifctx);
+
+        aml_append(method,
+            aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
+                aml_add(aml_int(TPM_PPI_ADDR_BASE), op, NULL), 0x1));
+        field =3D aml_field("TPP1", AML_BYTE_ACC, AML_NOLOCK, AML_PRESER=
VE);
+        aml_append(field, aml_named_field("TPPF", 8));
+        aml_append(method, field);
+        aml_append(method, aml_return(aml_name("TPPF")));
+    }
+    aml_append(dev, method);
+
+    /*
+     * Use global TPM2 & TPM3 variables to workaround Windows ACPI bug
+     * when returning packages.
+     */
+    pak =3D aml_package(2);
+    aml_append(pak, zero);
+    aml_append(pak, zero);
+    aml_append(dev, aml_name_decl("TPM2", pak));
+    tpm2 =3D aml_name("TPM2");
+
+    pak =3D aml_package(3);
+    aml_append(pak, zero);
+    aml_append(pak, zero);
+    aml_append(pak, zero);
+    aml_append(dev, aml_name_decl("TPM3", pak));
+    tpm3 =3D aml_name("TPM3");
+
+    method =3D aml_method("_DSM", 4, AML_SERIALIZED);
+    {
+        uint8_t zerobyte[1] =3D { 0 };
+        Aml *function, *arguments, *rev, *op, *op_arg, *op_flags, *uuid;
+
+        uuid =3D aml_arg(0);
+        rev =3D aml_arg(1);
+        function =3D aml_arg(2);
+        arguments =3D aml_arg(3);
+        op =3D aml_local(0);
+        op_flags =3D aml_local(1);
+
+        /* Physical Presence Interface */
+        ifctx =3D aml_if(
+            aml_equal(uuid,
+                      aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653")=
));
+        {
+            /* standard DSM query function */
+            ifctx2 =3D aml_if(aml_equal(function, zero));
+            {
+                uint8_t byte_list[2] =3D { 0xff, 0x01 }; /* functions 1-=
8 */
+
+                aml_append(ifctx2,
+                           aml_return(aml_buffer(sizeof(byte_list),
+                                                 byte_list)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.0: 2.1.1 Get Physical Presence Interface Version
+             *
+             * Arg 2 (Integer): Function Index =3D 1
+             * Arg 3 (Package): Arguments =3D Empty Package
+             * Returns: Type: String
+             */
+            ifctx2 =3D aml_if(aml_equal(function, one));
+            {
+                aml_append(ifctx2, aml_return(aml_string("1.3")));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.0: 2.1.3 Submit TPM Operation Request to Pre-OS Env=
ironment
+             *
+             * Arg 2 (Integer): Function Index =3D 2
+             * Arg 3 (Package): Arguments =3D Package: Type: Integer
+             *                              Operation Value of the Reque=
st
+             * Returns: Type: Integer
+             *          0: Success
+             *          1: Operation Value of the Request Not Supported
+             *          2: General Failure
+             */
+            ifctx2 =3D aml_if(aml_equal(function, aml_int(2)));
+            {
+                /* get opcode */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(arguments,
+                                                           zero)), op));
+
+                /* get opcode flags */
+                aml_append(ifctx2,
+                           aml_store(aml_call1("TPFN", op), op_flags));
+
+                /* if func[opcode] & TPM_PPI_FUNC_NOT_IMPLEMENTED */
+                ifctx3 =3D aml_if(
+                    aml_equal(
+                        aml_and(op_flags, func_mask, NULL),
+                        not_implemented));
+                {
+                    /* 1: Operation Value of the Request Not Supported *=
/
+                    aml_append(ifctx3, aml_return(one));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                aml_append(ifctx2, aml_store(op, pprq));
+                aml_append(ifctx2, aml_store(zero, pprm));
+                /* 0: success */
+                aml_append(ifctx2, aml_return(zero));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.0: 2.1.4 Get Pending TPM Operation Requested By the=
 OS
+             *
+             * Arg 2 (Integer): Function Index =3D 3
+             * Arg 3 (Package): Arguments =3D Empty Package
+             * Returns: Type: Package of Integers
+             *          Integer 1: Function Return code
+             *                     0: Success
+             *                     1: General Failure
+             *          Integer 2: Pending operation requested by the OS
+             *                     0: None
+             *                    >0: Operation Value of the Pending Req=
uest
+             *          Integer 3: Optional argument to pending operatio=
n
+             *                     requested by the OS
+             *                     0: None
+             *                    >0: Argument Value of the Pending Requ=
est
+             */
+            ifctx2 =3D aml_if(aml_equal(function, aml_int(3)));
+            {
+                /*
+                 * Revision ID of 1, no integer parameter beyond
+                 * parameter two are expected
+                 */
+                ifctx3 =3D aml_if(aml_equal(rev, one));
+                {
+                    /* TPM2[1] =3D PPRQ */
+                    aml_append(ifctx3,
+                               aml_store(pprq, aml_index(tpm2, one)));
+                    aml_append(ifctx3, aml_return(tpm2));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                /*
+                 * A return value of {0, 23, 1} indicates that
+                 * operation 23 with argument 1 is pending.
+                 */
+                ifctx3 =3D aml_if(aml_equal(rev, aml_int(2)));
+                {
+                    /* TPM3[1] =3D PPRQ */
+                    aml_append(ifctx3,
+                               aml_store(pprq, aml_index(tpm3, one)));
+                    /* TPM3[2] =3D PPRM */
+                    aml_append(ifctx3,
+                               aml_store(pprm, aml_index(tpm3, aml_int(2=
))));
+                    aml_append(ifctx3, aml_return(tpm3));
+                }
+                aml_append(ifctx2, ifctx3);
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.0: 2.1.5 Get Platform-Specific Action to Transition=
 to
+             *     Pre-OS Environment
+             *
+             * Arg 2 (Integer): Function Index =3D 4
+             * Arg 3 (Package): Arguments =3D Empty Package
+             * Returns: Type: Integer
+             *          0: None
+             *          1: Shutdown
+             *          2: Reboot
+             *          3: OS Vendor-specific
+             */
+            ifctx2 =3D aml_if(aml_equal(function, aml_int(4)));
+            {
+                /* reboot */
+                aml_append(ifctx2, aml_return(aml_int(2)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.0: 2.1.6 Return TPM Operation Response to OS Enviro=
nment
+             *
+             * Arg 2 (Integer): Function Index =3D 5
+             * Arg 3 (Package): Arguments =3D Empty Package
+             * Returns: Type: Package of Integer
+             *          Integer 1: Function Return code
+             *                     0: Success
+             *                     1: General Failure
+             *          Integer 2: Most recent operation request
+             *                     0: None
+             *                    >0: Operation Value of the most recent=
 request
+             *          Integer 3: Response to the most recent operation=
 request
+             *                     0: Success
+             *                     0x00000001..0x00000FFF: Corresponding=
 TPM
+             *                                             error code
+             *                     0xFFFFFFF0: User Abort or timeout of =
dialog
+             *                     0xFFFFFFF1: firmware Failure
+             */
+            ifctx2 =3D aml_if(aml_equal(function, aml_int(5)));
+            {
+                /* TPM3[1] =3D LPPR */
+                aml_append(ifctx2,
+                           aml_store(aml_name("LPPR"),
+                                     aml_index(tpm3, one)));
+                /* TPM3[2] =3D PPRP */
+                aml_append(ifctx2,
+                           aml_store(aml_name("PPRP"),
+                                     aml_index(tpm3, aml_int(2))));
+                aml_append(ifctx2, aml_return(tpm3));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.0: 2.1.7 Submit preferred user language
+             *
+             * Arg 2 (Integer): Function Index =3D 6
+             * Arg 3 (Package): Arguments =3D String Package
+             *                  Preferred language code
+             * Returns: Type: Integer
+             * Function Return Code
+             *          3: Not implemented
+             */
+            ifctx2 =3D aml_if(aml_equal(function, aml_int(6)));
+            {
+                /* 3 =3D not implemented */
+                aml_append(ifctx2, aml_return(aml_int(3)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.1: 2.1.7 Submit TPM Operation Request to
+             *     Pre-OS Environment 2
+             *
+             * Arg 2 (Integer): Function Index =3D 7
+             * Arg 3 (Package): Arguments =3D Package: Type: Integer
+             *                  Integer 1: Operation Value of the Reques=
t
+             *                  Integer 2: Argument for Operation (optio=
nal)
+             * Returns: Type: Integer
+             *          0: Success
+             *          1: Not Implemented
+             *          2: General Failure
+             *          3: Operation blocked by current firmware setting=
s
+             */
+            ifctx2 =3D aml_if(aml_equal(function, aml_int(7)));
+            {
+                /* get opcode */
+                aml_append(ifctx2, aml_store(aml_derefof(aml_index(argum=
ents,
+                                                                   zero)=
),
+                                             op));
+
+                /* get opcode flags */
+                aml_append(ifctx2, aml_store(aml_call1("TPFN", op),
+                                             op_flags));
+                /* if func[opcode] & TPM_PPI_FUNC_NOT_IMPLEMENTED */
+                ifctx3 =3D aml_if(
+                    aml_equal(
+                        aml_and(op_flags, func_mask, NULL),
+                        not_implemented));
+                {
+                    /* 1: not implemented */
+                    aml_append(ifctx3, aml_return(one));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                /* if func[opcode] & TPM_PPI_FUNC_BLOCKED */
+                ifctx3 =3D aml_if(
+                    aml_equal(
+                        aml_and(op_flags, func_mask, NULL),
+                        aml_int(TPM_PPI_FUNC_BLOCKED)));
+                {
+                    /* 3: blocked by firmware */
+                    aml_append(ifctx3, aml_return(aml_int(3)));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                /* revision to integer */
+                ifctx3 =3D aml_if(aml_equal(rev, one));
+                {
+                    /* revision 1 */
+                    /* PPRQ =3D op */
+                    aml_append(ifctx3, aml_store(op, pprq));
+                    /* no argument, PPRM =3D 0 */
+                    aml_append(ifctx3, aml_store(zero, pprm));
+                }
+                aml_append(ifctx2, ifctx3);
+
+                ifctx3 =3D aml_if(aml_equal(rev, aml_int(2)));
+                {
+                    /* revision 2 */
+                    /* PPRQ =3D op */
+                    op_arg =3D aml_derefof(aml_index(arguments, one));
+                    aml_append(ifctx3, aml_store(op, pprq));
+                    /* PPRM =3D arg3[1] */
+                    aml_append(ifctx3, aml_store(op_arg, pprm));
+                }
+                aml_append(ifctx2, ifctx3);
+                /* 0: success */
+                aml_append(ifctx2, aml_return(zero));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * PPI 1.1: 2.1.8 Get User Confirmation Status for Operation
+             *
+             * Arg 2 (Integer): Function Index =3D 8
+             * Arg 3 (Package): Arguments =3D Package: Type: Integer
+             *                  Operation Value that may need user confi=
rmation
+             * Returns: Type: Integer
+             *          0: Not implemented
+             *          1: Firmware only
+             *          2: Blocked for OS by firmware configuration
+             *          3: Allowed and physically present user required
+             *          4: Allowed and physically present user not requi=
red
+             */
+            ifctx2 =3D aml_if(aml_equal(function, aml_int(8)));
+            {
+                /* get opcode */
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(arguments,
+                                                           zero)),
+                                     op));
+
+                /* get opcode flags */
+                aml_append(ifctx2, aml_store(aml_call1("TPFN", op),
+                                             op_flags));
+                /* return confirmation status code */
+                aml_append(ifctx2,
+                           aml_return(
+                               aml_and(op_flags, func_mask, NULL)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
+        }
+        aml_append(method, ifctx);
+    }
+    aml_append(dev, method);
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9898247705..2e21a31f82 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1802,6 +1802,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     uint32_t nr_mem =3D machine->ram_slots;
     int root_bus_limit =3D 0xFF;
     PCIBus *bus =3D NULL;
+    TPMIf *tpm =3D tpm_find();
     int i;
=20
     dsdt =3D init_aml_allocator();
@@ -2139,7 +2140,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             /* Scan all PCI buses. Generate tables to support hotplug. *=
/
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
=20
-            if (TPM_IS_TIS(tpm_find())) {
+            if (TPM_IS_TIS(tpm)) {
                 dev =3D aml_device("ISA.TPM");
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C3=
1")));
                 aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
@@ -2153,6 +2154,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                  */
                 /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
                 aml_append(dev, aml_name_decl("_CRS", crs));
+
+                tpm_build_ppi_acpi(tpm, dev);
+
                 aml_append(scope, dev);
             }
=20
@@ -2160,7 +2164,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
=20
-    if (TPM_IS_CRB(tpm_find())) {
+    if (TPM_IS_CRB(tpm)) {
         dev =3D aml_device("TPM");
         aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
         crs =3D aml_resource_template();
@@ -2172,6 +2176,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(method, aml_return(aml_int(0x0f)));
         aml_append(dev, method);
=20
+        tpm_build_ppi_acpi(tpm, dev);
+
         aml_append(sb_scope, dev);
     }
=20
@@ -2894,7 +2900,7 @@ void acpi_setup(void)
         tpm_config =3D (FwCfgTPMConfig) {
             .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
             .tpm_version =3D tpm_get_version(tpm),
-            .tpmppi_version =3D TPM_PPI_VERSION_NONE
+            .tpmppi_version =3D TPM_PPI_VERSION_1_30
         };
         fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
                         &tpm_config, sizeof tpm_config);
diff --git a/stubs/tpm.c b/stubs/tpm.c
index 80939cd3db..66c99d667d 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-commands-tpm.h"
 #include "sysemu/tpm.h"
+#include "hw/acpi/tpm.h"
=20
 void tpm_init(void)
 {
@@ -31,3 +32,7 @@ TpmModelList *qmp_query_tpm_models(Error **errp)
 {
     return NULL;
 }
+
+void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
+{
+}
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 11c35bcb44..2d46e3789a 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-st=
ub.o
 common-obj-y +=3D acpi_interface.o
 common-obj-y +=3D bios-linker-loader.o
 common-obj-y +=3D aml-build.o
+common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
 common-obj-$(CONFIG_IPMI) +=3D ipmi.o
 common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
--=20
MST
