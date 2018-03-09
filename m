Received: from eggs.gnu.org ([2001:4830:134:3::10]:45181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1euLQX-0005RU-LB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1euLQU-0002M1-Il
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:03:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1euLQU-0002Lr-EF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:03:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74C634029AC2
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 17:03:25 +0000 (UTC)
From: Wei Huang <wei@redhat.com>
Date: Fri,  9 Mar 2018 12:03:23 -0500
Message-Id: <1520615003-20869-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] dump: Update correct kdump phys_base field
 for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, wei@redhat.com

For guest kernel that supports KASLR, the load address can change every
time when guest VM runs. To find the physical base address correctly,
current QEMU dump searches VMCOREINFO for the string "NUMBER(phys_base)=".
However this string pattern is only available on x86_64. AArch64 uses a
different field, called "NUMBER(PHYS_OFFSET)=". This patch makes sure
QEMU dump uses the correct string on AArch64.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 dump.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/dump.c b/dump.c
index 097e60b..6bdb0db 100644
--- a/dump.c
+++ b/dump.c
@@ -1609,10 +1609,18 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
 
     lines = g_strsplit((char *)vmci, "\n", -1);
     for (i = 0; lines[i]; i++) {
-        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=")) {
-            if (qemu_strtou64(lines[i] + 18, NULL, 16,
+        const char *prefix = NULL;
+
+        if (s->dump_info.d_machine == EM_X86_64) {
+            prefix = "NUMBER(phys_base)=";
+        } else if (s->dump_info.d_machine == EM_AARCH64) {
+            prefix = "NUMBER(PHYS_OFFSET)=";
+        }
+
+        if (prefix && g_str_has_prefix(lines[i], prefix)) {
+            if (qemu_strtou64(lines[i] + strlen(prefix), NULL, 16,
                               &phys_base) < 0) {
-                warn_report("Failed to read NUMBER(phys_base)=");
+                warn_report("Failed to read %s", prefix);
             } else {
                 s->dump_info.phys_base = phys_base;
             }
-- 
1.8.3.1
