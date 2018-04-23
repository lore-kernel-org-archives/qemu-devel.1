Received: from eggs.gnu.org ([2001:4830:134:3::10]:48630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <erik.schmauss@intel.com>) id 1fAiBr-0002lB-5K
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <erik.schmauss@intel.com>) id 1fAiBm-0008Tt-7S
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:35:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:3328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <erik.schmauss@intel.com>)
	id 1fAiBl-0008Sl-VM
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:35:54 -0400
From: "Schmauss, Erik" <erik.schmauss@intel.com>
Date: Mon, 23 Apr 2018 20:35:45 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53973A6AF@ORSMSX110.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] RFC: altering the NVDIMM acpi table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "He, Junyan" <junyan.he@intel.com>, "Moore, Robert" <robert.moore@intel.com>

Hello,=0A=
=0A=
I work on ACPICA and we have recently made changes to the behavior of =0A=
the Linux AML interpreter to match other OS implementations. After =0A=
sending the patches to upstream Linux, we have identified that =0A=
hw/acpi/nvdimm.c specifies an ACPI table with a forward reference=0A=
 (MEMA is a forward reference that is no longer supported as of Linux =0A=
4.17-rc1).=0A=
=0A=
We would like to change this file to move the declaration of Name =0A=
(MEMA,...) to appear as the very first declaration in the SSDT. Below is a =
patch outlining the change that I would like to make. =0A=
However, I am having a hard time getting make check to run=0A=
 to completion in a reasonable amount of time. It always seems to fail =0A=
on some sort of checksum test... It would be great if you could let me =0A=
know what you think of the change and what I can do to speed up the =0A=
execution time of make check...=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
Erik Schmauss=0A=
=0A=
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c=0A=
index 59d6e4254c..7c9efd9ac7 100644=0A=
--- a/hw/acpi/nvdimm.c=0A=
+++ b/hw/acpi/nvdimm.c=0A=
@@ -1234,6 +1234,9 @@ static void nvdimm_build_ssdt(GArray *table_offsets, =
GArray *table_data,=0A=
     ssdt =3D init_aml_allocator();=0A=
     acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));=0A=
 =0A=
+    mem_addr_offset =3D build_append_named_dword(table_data,=0A=
+                                               NVDIMM_ACPI_MEM_ADDR);=0A=
+=0A=
     sb_scope =3D aml_scope("\\_SB");=0A=
 =0A=
     dev =3D aml_device("NVDR");=0A=
@@ -1266,9 +1269,6 @@ static void nvdimm_build_ssdt(GArray *table_offsets, =
GArray *table_data,=0A=
 =0A=
     /* copy AML table into ACPI tables blob and patch header there */=0A=
     g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);=0A=
-    mem_addr_offset =3D build_append_named_dword(table_data,=0A=
-                                               NVDIMM_ACPI_MEM_ADDR);=0A=
-=0A=
     bios_linker_loader_alloc(linker,=0A=
                              NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,=0A=
                              sizeof(NvdimmDsmIn), false /* high memory */)=
;=0A=
