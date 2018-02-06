Received: from eggs.gnu.org ([2001:4830:134:3::10]:43857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ig-0005Ba-3t
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ic-0007us-Mx
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ic-0007uL-F8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JFBDU139261
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:49 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyha5u360-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:48 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:47 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:41 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-21-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 20/54] i386: Change X86CPUDefinition::model_id
 to const char*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

It is valid to have a 48-character model ID on CPUID, however the
definition of X86CPUDefinition::model_id is char[48], which can
make the compiler drop the null terminator from the string.

If a CPU model happens to have 48 bytes on model_id, "-cpu help"
will print garbage and the object_property_set_str() call at
x86_cpu_load_def() will read data outside the model_id array.

We could increase the array size to 49, but this would mean the
compiler would not issue a warning if a 49-char string is used by
mistake for model_id.

To make things simpler, simply change model_id to be const char*,
and validate the string length using an assert() on
x86_register_cpudef_type().

Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180109154519.25634-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 807e9869b8c4119b81df902625af818519e01759)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 045d66191f..63279526a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -748,7 +748,7 @@ struct X86CPUDefinition {
     int model;
     int stepping;
     FeatureWordArray features;
-    char model_id[48];
+    const char *model_id;
 };
 
 static X86CPUDefinition builtin_x86_defs[] = {
@@ -917,6 +917,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             I486_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium",
@@ -928,6 +929,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium2",
@@ -939,6 +941,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM2_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium3",
@@ -950,6 +953,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM3_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "athlon",
@@ -2708,6 +2712,9 @@ static void x86_register_cpudef_type(X86CPUDefinition *def)
      * they shouldn't be set on the CPU model table.
      */
     assert(!(def->features[FEAT_8000_0001_EDX] & CPUID_EXT2_AMD_ALIASES));
+    /* catch mistakes instead of silently truncating model_id when too long */
+    assert(def->model_id && strlen(def->model_id) <= 48);
+
 
     type_register(&ti);
     g_free(typename);
-- 
2.11.0
