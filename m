Received: from eggs.gnu.org ([2001:4830:134:3::10]:48433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCe-0001V1-VC
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCb-0005kv-JP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCb-0005jZ-AK
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0FKh1044218
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmsrsj1vk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:19 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:26 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-52-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 51/79] pc: Use "min-[x]level" on compat_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

Since the automatic cpuid-level code was introduced in commit
c39c0edf9bb3b968ba95484465a50c7b19f4aa3a ("target-i386: Automatically
set level/xlevel/xlevel2 when needed"), the CPU model tables just define
the default CPUID level code (set using "min-level").  Setting
"[x]level" forces CPUID level to a specific value and disable the
automatic-level logic.

But the PC compat code was not updated and the existing "[x]level"
compat properties broke compatibility for people using features that
triggered the auto-level code.  To keep previous behavior, we should set
"min-[x]level" instead of "[x]level" on compat_props.

This was not a problem for most cases, because old machine-types don't
have full-cpuid-auto-level enabled.  The only common use case it broke
was the CPUID[7] auto-level code, that was already enabled since the
first CPUID[7] feature was introduced (in QEMU 1.4.0).

This causes the regression reported at:
https://bugzilla.redhat.com/show_bug.cgi?id=1454641

Change the PC compat code to use "min-[x]level" instead of "[x]level" on
compat_props, and add new test cases to ensure we don't break this
again.

Reported-by: "Guo, Zhiyi" <zhguo@redhat.com>
Fixes: c39c0edf9bb ("target-i386: Automatically set level/xlevel/xlevel2 when needed")
Cc: qemu-stable@nongnu.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 1f43571604da85c62f25f3ba6d275b1b5ea76ca2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/hw/i386/pc.h          | 42 +++++++++++++++++++++---------------------
 tests/test-x86-cpuid-compat.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f278b3a..564486f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -558,75 +558,75 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .value    = "off",\
     },{\
         .driver   = "qemu64" "-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(4),\
     },{\
         .driver   = "kvm64" "-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(5),\
     },{\
         .driver   = "pentium3" "-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(2),\
     },{\
         .driver   = "n270" "-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(5),\
     },{\
         .driver   = "Conroe" "-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(4),\
     },{\
         .driver   = "Penryn" "-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(4),\
     },{\
         .driver   = "Nehalem" "-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(4),\
     },{\
         .driver   = "n270" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Penryn" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Conroe" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Nehalem" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Westmere" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "SandyBridge" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "IvyBridge" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Haswell" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Haswell-noTSX" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Broadwell" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver   = "Broadwell-noTSX" "-" TYPE_X86_CPU,\
-        .property = "xlevel",\
+        .property = "min-xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
         .driver = TYPE_X86_CPU,\
@@ -852,7 +852,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .value    = stringify(2),\
     },{\
         .driver   = "Conroe-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(2),\
     },{\
         .driver   = "Penryn-" TYPE_X86_CPU,\
@@ -860,7 +860,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .value    = stringify(2),\
     },{\
         .driver   = "Penryn-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(2),\
     },{\
         .driver   = "Nehalem-" TYPE_X86_CPU,\
@@ -868,7 +868,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .value    = stringify(2),\
     },{\
         .driver   = "Nehalem-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(2),\
     },{\
         .driver   = "virtio-net-pci",\
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 79a2e69..b449f54 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -228,6 +228,44 @@ int main(int argc, char **argv)
     add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
                    "-machine pc-i440fx-2.7 -cpu 486,+xstore",
                    "xlevel2", 0);
+    /*
+     * QEMU 1.4.0 had auto-level enabled for CPUID[7], already,
+     * and the compat code that sets default level shouldn't
+     * disable the auto-level=7 code:
+     */
+    add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-1.4/off",
+                   "-machine pc-i440fx-1.4 -cpu Nehalem",
+                   "level", 2);
+    add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-1.5/on",
+                   "-machine pc-i440fx-1.4 -cpu Nehalem,+smap",
+                   "level", 7);
+    add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
+                   "-machine pc-i440fx-2.3 -cpu Penryn",
+                   "level", 4);
+    add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/on",
+                   "-machine pc-i440fx-2.3 -cpu Penryn,+erms",
+                   "level", 7);
+    add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
+                   "-machine pc-i440fx-2.9 -cpu Conroe",
+                   "level", 10);
+    add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
+                   "-machine pc-i440fx-2.9 -cpu Conroe,+erms",
+                   "level", 10);
+
+    /*
+     * xlevel doesn't have any feature that triggers auto-level
+     * code on old machine-types.  Just check that the compat code
+     * is working correctly:
+     */
+    add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.3",
+                   "-machine pc-i440fx-2.3 -cpu SandyBridge",
+                   "xlevel", 0x8000000a);
+    add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
+                   "-machine pc-i440fx-2.4 -cpu SandyBridge,",
+                   "xlevel", 0x80000008);
+    add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
+                   "-machine pc-i440fx-2.4 -cpu SandyBridge,+npt",
+                   "xlevel", 0x80000008);
 
     return g_test_run();
 }
-- 
2.7.4
