Received: from eggs.gnu.org ([2001:4830:134:3::10]:53640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWp-0002ma-2O
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWl-0003uO-7G
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50328
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ebTWl-0003u6-1u
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GFnhXL054280
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:53 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fhkkrju0e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:52 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 08:51:51 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 10:51:39 -0500
In-Reply-To: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1516117900-11382-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/4] acpi: implement aml_lless_equal
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

LLessEqualOp =3D LNotOp LGreaterOp

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/aml-build.c         | 11 +++++++++++
 include/hw/acpi/aml-build.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc4..c475f56 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -568,6 +568,17 @@ Aml *aml_lless(Aml *arg1, Aml *arg2)
     return var;
 }
=20
+/* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLLessEqual */
+Aml *aml_lless_equal(Aml *arg1, Aml *arg2)
+{
+    /* LLessEqualOp :=3D LNotOp LGreaterOp */
+    Aml *var =3D aml_opcode(0x92 /* LNotOp */);
+    build_append_byte(var->buf, 0x94 /* LGreaterOp */);
+    aml_append(var, arg1);
+    aml_append(var, arg2);
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefAdd */
 Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst)
 {
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 88d0738..c4398cc 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -267,6 +267,7 @@ Aml *aml_lor(Aml *arg1, Aml *arg2);
 Aml *aml_shiftleft(Aml *arg1, Aml *count);
 Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
 Aml *aml_lless(Aml *arg1, Aml *arg2);
+Aml *aml_lless_equal(Aml *arg1, Aml *arg2);
 Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst);
 Aml *aml_subtract(Aml *arg1, Aml *arg2, Aml *dst);
 Aml *aml_increment(Aml *arg);
--=20
2.5.5
