Received: from eggs.gnu.org ([2001:4830:134:3::10]:43375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWnew-0005NT-34
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWnes-0003J8-UR
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:25:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWnes-0003In-MM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:25:30 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 17:25:27 -0200
Message-Id: <20181211192527.13254-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] x86: host-phys-bits-limit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, paul.c.lai@intel.com, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Bandan Das <bsd@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Yu Zhang <yu.c.zhang@linux.intel.com>

Some downstream distributions of QEMU set host-phys-bits=on by
default.  This worked very well for most use cases, because
phys-bits really didn't have huge consequences. The only
difference was on the CPUID data seen by guests, and on the
handling of reserved bits.

This changed in KVM commit 855feb673640 ("KVM: MMU: Add 5 level
EPT & Shadow page table support").  Now choosing a large
phys-bits value for a VM has bigger impact: it will make KVM use
5-level EPT even when it's not really necessary.  This means
using the host phys-bits value may not be the best choice.

Management software could address this problem by manually
configuring phys-bits depending on the size of the VM and the
amount of MMIO address space required for hotplug.  But this is
not trivial to implement.

However, there's another workaround that would work for most
cases: keep using the host phys-bits value, but only if it's
smaller than 48.  This patch makes this possible by introducing a
new "-cpu" option: "host-phys-bits-limit".  Management software
or users can make sure they will always use 4-level EPT using:
"host-phys-bits=on,host-phys-bits-limit=48".

This behavior is still not enabled by default because QEMU
doesn't enable host-phys-bits=on by default.  But users,
management software, or downstream distributions may choose to
change their defaults using the new option.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h                 |  3 ++
 target/i386/cpu.c                 |  5 ++
 tests/acceptance/x86-phys-bits.py | 81 +++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 tests/acceptance/x86-phys-bits.py

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c52d0cbeb..a545b77c2c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1457,6 +1457,9 @@ struct X86CPU {
     /* if true override the phys_bits value with a value read from the host */
     bool host_phys_bits;
 
+    /* if set, limit maximum value for phys_bits when host_phys_bits is true */
+    uint8_t host_phys_bits_limit;
+
     /* Stop SMI delivery for migration compatibility with old machines */
     bool kvm_no_smi_migration;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f9..df200754a2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5152,6 +5152,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             if (cpu->host_phys_bits) {
                 /* The user asked for us to use the host physical bits */
                 cpu->phys_bits = host_phys_bits;
+                if (cpu->host_phys_bits_limit &&
+                    cpu->phys_bits > cpu->host_phys_bits_limit) {
+                    cpu->phys_bits = cpu->host_phys_bits_limit;
+                }
             }
 
             /* Print a warning if the user set it to a value that's not the
@@ -5739,6 +5743,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
+    DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
     DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
     DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
     DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
diff --git a/tests/acceptance/x86-phys-bits.py b/tests/acceptance/x86-phys-bits.py
new file mode 100644
index 0000000000..ae85d7e4e7
--- /dev/null
+++ b/tests/acceptance/x86-phys-bits.py
@@ -0,0 +1,81 @@
+# Test for host-phys-bits-limit option
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+import re
+
+from avocado_qemu import Test
+
+class HostPhysbits(Test):
+    """
+    Check if `host-phys-bits` and `host-phys-bits` options work.
+
+    :avocado: enable
+    :avocado: tags=x86_64
+    """
+
+    def cpu_qom_get(self, prop):
+        qom_path = self.vm.command('query-cpus')[0]['qom_path']
+        return self.vm.command('qom-get', path=qom_path, property=prop)
+
+    def cpu_phys_bits(self):
+        return self.cpu_qom_get('phys-bits')
+
+    def host_phys_bits(self):
+        cpuinfo = open('/proc/cpuinfo', 'rb').read()
+        m = re.search(b'([0-9]+) bits physical', cpuinfo)
+        if m is None:
+            self.cancel("Couldn't read phys-bits from /proc/cpuinfo")
+        return int(m.group(1))
+
+    def setUp(self):
+        super(HostPhysbits, self).setUp()
+        self.vm.add_args('-S', '-machine', 'accel=kvm:tcg')
+        self.vm.launch()
+        if not self.vm.command('query-kvm')['enabled']:
+            self.cancel("Test case requires KVM")
+        self.vm.shutdown()
+
+
+    def test_no_host_phys_bits(self):
+        # default should be phys-bits=40 if host-phys-bits=off
+        self.vm.add_args('-cpu', 'qemu64,host-phys-bits=off')
+        self.vm.launch()
+        self.assertEqual(self.cpu_phys_bits(), 40)
+
+    def test_manual_phys_bits(self):
+        self.vm.add_args('-cpu', 'qemu64,host-phys-bits=off,phys-bits=35')
+        self.vm.launch()
+        self.assertEqual(self.cpu_phys_bits(), 35)
+
+    def test_host_phys_bits(self):
+        host_phys_bits = self.host_phys_bits()
+        self.vm.add_args('-cpu', 'qemu64,host-phys-bits=on')
+        self.vm.launch()
+        self.assertEqual(self.cpu_phys_bits(), host_phys_bits)
+
+    def test_host_phys_bits_limit_high(self):
+        hbits = self.host_phys_bits()
+        self.vm.add_args('-cpu', 'qemu64,host-phys-bits=on,'
+                                 'host-phys-bits-limit=%d' % (hbits + 1))
+        self.vm.launch()
+        self.assertEqual(self.cpu_phys_bits(), hbits)
+
+    def test_host_phys_bits_limit_equal(self):
+        hbits = self.host_phys_bits()
+        self.vm.add_args('-cpu', 'qemu64,host-phys-bits=on,'
+                                 'host-phys-bits-limit=%d' % (hbits))
+        self.vm.launch()
+        self.assertEqual(self.cpu_phys_bits(), hbits)
+
+    def test_host_phys_bits_limit_low(self):
+        hbits = self.host_phys_bits()
+        self.vm.add_args('-cpu', 'qemu64,host-phys-bits=on,'
+                                 'host-phys-bits-limit=%d' % (hbits - 1))
+        self.vm.launch()
+        self.assertEqual(self.cpu_phys_bits(), hbits - 1)
-- 
2.18.0.rc1.1.g3f1ff2140
