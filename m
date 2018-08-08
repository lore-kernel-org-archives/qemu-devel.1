Received: from eggs.gnu.org ([2001:4830:134:3::10]:51459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQBx-0005pI-Th
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQBu-0002gi-7W
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fnQBu-0002gO-39
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB8C240216E9
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 15:16:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  8 Aug 2018 17:15:47 +0200
Message-Id: <1533741349-199141-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
References: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/4] acpi: add aml_create_byte_field()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

will be used by for packing _CST package in follow up patch

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/aml-build.h | 1 +
 hw/acpi/aml-build.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 10c7946..8c8ca0b 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -371,6 +371,7 @@ Aml *aml_release(Aml *mutex);
 Aml *aml_alias(const char *source_object, const char *alias_object);
 Aml *aml_create_field(Aml *srcbuf, Aml *bit_index, Aml *num_bits,
                       const char *name);
+Aml *aml_create_byte_field(Aml *srcbuf, Aml *index, const char *name);
 Aml *aml_create_dword_field(Aml *srcbuf, Aml *index, const char *name);
 Aml *aml_create_qword_field(Aml *srcbuf, Aml *index, const char *name);
 Aml *aml_varpackage(uint32_t num_elements);
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index def62b3..977d929 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1094,6 +1094,13 @@ Aml *aml_create_field(Aml *srcbuf, Aml *bit_index, Aml *num_bits,
     return var;
 }
 
+/* ACPI 1.0b: 16.2.5.2 Named Objects Encoding: DefCreateByteField */
+Aml *aml_create_byte_field(Aml *srcbuf, Aml *index, const char *name)
+{
+    return create_field_common(0x8C /* CreateByteFieldOp */,
+                               srcbuf, index, name);
+}
+
 /* ACPI 1.0b: 16.2.5.2 Named Objects Encoding: DefCreateDWordField */
 Aml *aml_create_dword_field(Aml *srcbuf, Aml *index, const char *name)
 {
-- 
2.7.4
