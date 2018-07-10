Received: from eggs.gnu.org ([2001:4830:134:3::10]:36030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg62-00018F-Nd
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg61-0001o9-Ab
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fcg61-0001o5-5Q
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA3CB400138A
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:01:32 +0000 (UTC)
Date: Tue, 10 Jul 2018 03:01:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710000024.542612-4-mst@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710000024.542612-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH hack dontapply v2 3/7] acpi: aml_load/aml_unload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

Dynamic loading/unloading of tables.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build.c         | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 7cf2cf64bf..f764f71e25 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -381,6 +381,8 @@ Aml *aml_derefof(Aml *arg);
 Aml *aml_sizeof(Aml *arg);
 Aml *aml_concatenate(Aml *source1, Aml *source2, Aml *target);
 Aml *aml_object_type(Aml *object);
+Aml *aml_load(const char *name, Aml *ddbhandle);
+Aml *aml_unload(Aml *ddbhandle);
 
 void build_append_int_noprefix(GArray *table, uint64_t value, int size);
 void
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 7165f19585..ce691c1618 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1552,6 +1552,27 @@ Aml *aml_object_type(Aml *object)
     return var;
 }
 
+/* ACPI 2.0: 17.2.4.3 Type 1 Opcodes Encoding: DefLoad */
+Aml *aml_load(const char *name, Aml *ddbhandle)
+{
+    Aml *var = aml_alloc();
+    build_append_byte(var->buf, 0x5B); /* ExtOpPrefix */
+    build_append_byte(var->buf, 0x20); /* LoadOp */
+    aml_append(var, aml_name("%s", name));
+    aml_append(var, ddbhandle);
+    return var;
+}
+
+/* ACPI 2.0: 17.2.4.3 Type 1 Opcodes Encoding: DefUnload */
+Aml *aml_unload(Aml *ddbhandle)
+{
+    Aml *var = aml_alloc();
+    build_append_byte(var->buf, 0x5B); /* ExtOpPrefix */
+    build_append_byte(var->buf, 0x2A); /* UnloadOp */
+    aml_append(var, ddbhandle);
+    return var;
+}
+
 void
 build_header(BIOSLinker *linker, GArray *table_data,
              AcpiTableHeader *h, const char *sig, int len, uint8_t rev,
-- 
MST
