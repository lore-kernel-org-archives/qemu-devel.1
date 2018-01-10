Received: from eggs.gnu.org ([2001:4830:134:3::10]:43524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZLDu-0005Ih-4k
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZLDp-0000t9-0C
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:35:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57474
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eZLDo-0000sf-KB
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:35:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0AIYJsd036124
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:35:31 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fdnxm7dr3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:35:31 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 11:35:30 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 10 Jan 2018 13:35:17 -0500
In-Reply-To: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1515609318-1897-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 2/3] acpi: implement aml_lless_equal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanb@linux.vnet.ibm.com, kevin@koconnor.net, marcandre.lureau@redhat.com

LLessEqualOp = LNotOp LGreaterOp

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/acpi/aml-build.c         | 10 ++++++++++
 include/hw/acpi/aml-build.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc4..597a58d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -568,6 +568,16 @@ Aml *aml_lless(Aml *arg1, Aml *arg2)
     return var;
 }
 
+Aml *aml_lless_equal(Aml *arg1, Aml *arg2)
+{
+    /* LLessEqualOp := LNotOp LGreaterOp */
+    Aml *var = aml_opcode(0x92 /* LNotOp */);
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
-- 
2.5.5
