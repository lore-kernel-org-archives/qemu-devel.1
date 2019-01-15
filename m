Received: from eggs.gnu.org ([209.51.188.92]:35521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyo-00081k-99
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyS-0003TH-4M
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyQ-0003MW-Ap
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:11 -0500
Date: Tue, 15 Jan 2019 15:06:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-42-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 41/49] acpi: add ACPI memory clear interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The interface is described in the "TCG Platform Reset Attack
Mitigation Specification", chapter 6 "ACPI _DSM Function". According
to Laszlo, it's not so easy to implement in OVMF, he suggested to do
it in qemu instead.

See specification documentation for more details, and next commit for
memory clear on reset handling.

The underlying TCG specification is accessible from the following
page.

https://trustedcomputinggroup.org/resource/pc-client-work-group-platform-=
reset-attack-mitigation-specification-version-1-0/

This patch implements version 1.0.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/tpm.txt |  2 ++
 hw/acpi/tpm.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 424d1511fc..5d8c26b1ad 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -135,6 +135,8 @@ layout:
  +----------+--------+--------+-----------------------------------------=
--+
  | next_step|   0x1  |  0x159 | Operation to execute after reboot by    =
  |
  |          |        |        | firmware. Used by firmware.             =
  |
+ +----------+--------+--------+-----------------------------------------=
--+
+ | movv     |   0x1  |  0x15a | Memory overwrite variable               =
  |
  +----------+--------+--------+-----------------------------------------=
--+
=20
    The following values are supported for the 'func' field. They corresp=
ond
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index 9f205378f2..b96459e45b 100644
--- a/hw/acpi/tpm.c
+++ b/hw/acpi/tpm.c
@@ -53,6 +53,16 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
     pprq =3D aml_name("PPRQ");
     pprm =3D aml_name("PPRM");
=20
+    aml_append(dev,
+               aml_operation_region(
+                   "TPP3", AML_SYSTEM_MEMORY,
+                   aml_int(TPM_PPI_ADDR_BASE +
+                           0x15a /* movv, docs/specs/tpm.txt */),
+                           0x1));
+    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("MOVV", 8));
+    aml_append(dev, field);
+
     /*
      * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynamic
      * operation region inside of a method for getting FUNC[op].
@@ -399,6 +409,51 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
             aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
         }
         aml_append(method, ifctx);
+
+        /*
+         * "TCG Platform Reset Attack Mitigation Specification 1.00",
+         * Chapter 6 "ACPI _DSM Function"
+         */
+        ifctx =3D aml_if(
+            aml_equal(uuid,
+                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45D")=
));
+        {
+            /* standard DSM query function */
+            ifctx2 =3D aml_if(aml_equal(function, zero));
+            {
+                uint8_t byte_list[1] =3D { 0x03 }; /* functions 1-2 supp=
orted */
+
+                aml_append(ifctx2,
+                           aml_return(aml_buffer(sizeof(byte_list),
+                                                 byte_list)));
+            }
+            aml_append(ifctx, ifctx2);
+
+            /*
+             * TCG Platform Reset Attack Mitigation Specification 1.0 Ch=
.6
+             *
+             * Arg 2 (Integer): Function Index =3D 1
+             * Arg 3 (Package): Arguments =3D Package: Type: Integer
+             *                  Operation Value of the Request
+             * Returns: Type: Integer
+             *          0: Success
+             *          1: General Failure
+             */
+            ifctx2 =3D aml_if(aml_equal(function, one));
+            {
+                aml_append(ifctx2,
+                           aml_store(aml_derefof(aml_index(arguments, ze=
ro)),
+                                     op));
+                {
+                    aml_append(ifctx2, aml_store(op, aml_name("MOVV")));
+
+                    /* 0: success */
+                    aml_append(ifctx2, aml_return(zero));
+                }
+            }
+            aml_append(ifctx, ifctx2);
+        }
+        aml_append(method, ifctx);
     }
     aml_append(dev, method);
 }
--=20
MST
