Received: from eggs.gnu.org ([2001:4830:134:3::10]:36117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgs-0004lJ-7U
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgr-0000es-A5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgr-0000e8-4D
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 430DE7E9D1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:46:09 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpe9028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:46:08 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:48 +0100
Message-Id: <20170227124551.8673-15-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 14/17] vmxcap: port to Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 2220255..af8de15 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -27,9 +27,9 @@ MSR_IA32_VMX_VMFUNC = 0x491
 class msr(object):
     def __init__(self):
         try:
-            self.f = open('/dev/cpu/0/msr', 'r', 0)
+            self.f = open('/dev/cpu/0/msr', 'rb', 0)
         except:
-            self.f = open('/dev/msr0', 'r', 0)
+            self.f = open('/dev/msr0', 'rb', 0)
     def read(self, index, default = None):
         import struct
         self.f.seek(index)
@@ -49,7 +49,7 @@ class Control(object):
         val = m.read(nr, 0)
         return (val & 0xffffffff, val >> 32)
     def show(self):
-        print self.name
+        print(self.name)
         mbz, mb1 = self.read2(self.cap_msr)
         tmbz, tmb1 = 0, 0
         if self.true_cap_msr:
@@ -69,7 +69,7 @@ class Control(object):
                 s = 'forced'
             elif one and zero:
                 s = 'yes'
-            print '  %-40s %s' % (self.bits[bit], s)
+            print('  %-40s %s' % (self.bits[bit], s))
 
 class Misc(object):
     def __init__(self, name, bits, msr):
@@ -77,9 +77,9 @@ class Misc(object):
         self.bits = bits
         self.msr = msr
     def show(self):
-        print self.name
+        print(self.name)
         value = msr().read(self.msr, 0)
-        print '  Hex: 0x%x' % (value)
+        print('  Hex: 0x%x' % (value))
         def first_bit(key):
             if type(key) is tuple:
                 return key[0]
@@ -94,7 +94,7 @@ class Misc(object):
                 def fmt(x):
                     return { True: 'yes', False: 'no' }[x]
             v = (value >> lo) & ((1 << (hi - lo + 1)) - 1)
-            print '  %-40s %s' % (self.bits[bits], fmt(v))
+            print('  %-40s %s' % (self.bits[bits], fmt(v)))
 
 controls = [
     Misc(
-- 
2.9.3
