Received: from eggs.gnu.org ([2001:4830:134:3::10]:36817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAG-0004oe-IC
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAF-0001UL-Bh
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAF-0001UG-5T
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:19 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41235293309
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:01:57 -0200
Message-Id: <20170117010204.4909-3-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/9] target-i386: Allow short strings to be
 used as vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If a short string is specified, it will be padded with zeroes.
Without this, "query-cpu-model-expansion model=base" would return
an expansion that would never work in the command-line.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3b7fb331b6..6046cc0ced 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1769,19 +1769,22 @@ static void x86_cpuid_set_vendor(Object *obj, const char *value,
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
     int i;
+    char buf[CPUID_VENDOR_SZ] = { 0 };
 
-    if (strlen(value) != CPUID_VENDOR_SZ) {
+    if (strlen(value) > CPUID_VENDOR_SZ) {
         error_setg(errp, QERR_PROPERTY_VALUE_BAD, "", "vendor", value);
         return;
     }
 
+    strncpy(buf, value, sizeof(buf));
+
     env->cpuid_vendor1 = 0;
     env->cpuid_vendor2 = 0;
     env->cpuid_vendor3 = 0;
     for (i = 0; i < 4; i++) {
-        env->cpuid_vendor1 |= ((uint8_t)value[i    ]) << (8 * i);
-        env->cpuid_vendor2 |= ((uint8_t)value[i + 4]) << (8 * i);
-        env->cpuid_vendor3 |= ((uint8_t)value[i + 8]) << (8 * i);
+        env->cpuid_vendor1 |= ((uint8_t)buf[i])     << (8 * i);
+        env->cpuid_vendor2 |= ((uint8_t)buf[i + 4]) << (8 * i);
+        env->cpuid_vendor3 |= ((uint8_t)buf[i + 8]) << (8 * i);
     }
 }
 
-- 
2.11.0.259.g40922b1
