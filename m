Received: from eggs.gnu.org ([2001:4830:134:3::10]:37541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHuNN-0004gH-GR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHuNK-0000pJ-EH
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:57:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHuNK-0000on-6a
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:57:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Jun 2017 12:56:55 -0300
Message-Id: <20170605155655.19315-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] pc: Use "min-[x]level" on compat_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

Since the automatic cpuid-level code was introduced in commit
c39c0edf9bb3b968ba95484465a50c7b19f4aa3a, the CPU model tables just
define the default CPUID level code (set using "min-level").  Setting
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
Signd-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h          | 42 +++++++++++++++++++++---------------------
 tests/test-x86-cpuid-compat.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e447f5d8f4..d071c9c0e9 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -566,75 +566,75 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
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
@@ -860,7 +860,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .value    = stringify(2),\
     },{\
         .driver   = "Conroe-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(2),\
     },{\
         .driver   = "Penryn-" TYPE_X86_CPU,\
@@ -868,7 +868,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .value    = stringify(2),\
     },{\
         .driver   = "Penryn-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(2),\
     },{\
         .driver   = "Nehalem-" TYPE_X86_CPU,\
@@ -876,7 +876,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .value    = stringify(2),\
     },{\
         .driver   = "Nehalem-" TYPE_X86_CPU,\
-        .property = "level",\
+        .property = "min-level",\
         .value    = stringify(2),\
     },{\
         .driver   = "virtio-net-pci",\
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 6c71e46391..652216f531 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -313,6 +313,44 @@ int main(int argc, char **argv)
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
+     * xlevel don't have any feature that triggers auto-level
+     * code on old machine-types.  Just check if the compat code
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
 
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
-- 
2.11.0.259.g40922b1
