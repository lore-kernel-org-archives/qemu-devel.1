Received: from eggs.gnu.org ([2001:4830:134:3::10]:48429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCzA-00051j-4G
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCz4-0004ZE-NC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCz4-0004Vs-AL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:28:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 02:26:47 +0400
Message-Id: <20181212222648.595-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181212222648.595-1-marcandre.lureau@redhat.com>
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 5/6] acpi: add ACPI memory clear interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, f4bug@amsat.org, Stefan Berger <stefanb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The interface is described in the "TCG Platform Reset Attack
Mitigation Specification", chapter 6 "ACPI _DSM Function". According
to Laszlo, it's not so easy to implement in OVMF, he suggested to do
it in qemu instead.

See specification documentation for more details, and next commit for
memory clear on reset handling.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/acpi/tpm.h |  2 ++
 hw/acpi/tpm.c         | 47 +++++++++++++++++++++++++++++++++++++++++++
 docs/specs/tpm.txt    |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 1a2a57a21f..7245eac4f9 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -207,6 +207,8 @@ REG32(CRB_DATA_BUFFER, 0x80)
 #define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
 #define TPM_PPI_FUNC_MASK                (7 << 0)
=20
+#define TPM_PPI_MOVV_OFFSET 0x15a
+
 void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev);
=20
 #endif /* HW_ACPI_TPM_H */
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index fee9490306..e3f92db570 100644
--- a/hw/acpi/tpm.c
+++ b/hw/acpi/tpm.c
@@ -53,6 +53,15 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
     pprq =3D aml_name("PPRQ");
     pprm =3D aml_name("PPRM");
=20
+    aml_append(dev,
+               aml_operation_region("TPP3", AML_SYSTEM_MEMORY,
+                                    aml_int(TPM_PPI_ADDR_BASE +
+                                            TPM_PPI_MOVV_OFFSET),
+                                    0x1));
+    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("MOVV", 8));
+    aml_append(dev, field);
+
     /*
      * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynamic
      * operation region inside of a method for getting FUNC[op].
@@ -395,6 +404,44 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
             aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
         }
         aml_append(method, ifctx);
+
+        ifctx =3D aml_if(
+            aml_equal(uuid,
+                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45D")=
));
+        {
+            /* standard DSM query function */
+            ifctx2 =3D aml_if(aml_equal(function, zero));
+            {
+                uint8_t byte_list[1] =3D { 0x03 };
+                aml_append(ifctx2, aml_return(aml_buffer(1, byte_list)))=
;
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
--=20
2.20.0
