Received: from eggs.gnu.org ([2001:4830:134:3::10]:52813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etEnV-0008Ey-IT
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etEnR-00026k-CE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:46:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etEnR-00026X-6K
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:46:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B07B4023155
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 15:46:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  6 Mar 2018 15:46:25 +0000
Message-Id: <20180306154625.23910-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace: only permit standard C types and fixed
 size integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Some trace backends will compile code based on the declared trace
events. It should not be assumed that the backends can resolve any QEMU
specific typedefs. So trace events should restrict their argument
types to the standard C types and fixed size integer types. Any complex
pointer types can be declared as "void *" for purposes of trace events,
since nothing will be dereferencing these pointer arguments.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 scripts/tracetool/__init__.py | 45 +++++++++++++++++++++++++++++++++++++=
++++++
 trace-events                  |  6 +++---
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 3646c2b9fc..52cc687ae3 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -41,6 +41,50 @@ def out(*lines, **kwargs):
     lines =3D [ l % kwargs for l in lines ]
     sys.stdout.writelines("\n".join(lines) + "\n")
=20
+# We only want to allow standard C types or fixed sized
+# integer types. We don't want QEMU specific types
+# as we can't assume trace backends can resolve all the
+# typedefs
+ALLOWED_TYPES =3D [
+    "int",
+    "long",
+    "short",
+    "char",
+    "bool",
+    "unsigned",
+    "signed",
+    "float",
+    "double",
+    "int8_t",
+    "uint8_t",
+    "int16_t",
+    "uint16_t",
+    "int32_t",
+    "uint32_t",
+    "int64_t",
+    "uint64_t",
+    "void",
+    "size_t",
+    "ssize_t",
+    "uintptr_t",
+    # Magic substitution is done by tracetool
+    "TCGv",
+]
+
+def validate_type(name):
+    bits =3D name.split(" ")
+    for bit in bits:
+        bit =3D re.sub("\*", "", bit)
+        if bit =3D=3D "":
+            continue
+        if bit =3D=3D "const":
+            continue
+        if bit not in ALLOWED_TYPES:
+            raise ValueError("Argument type '%s' is not in whitelist. "
+                             "Only standard C types and fixed size integ=
er "
+                             "types should be used. struct, union, and "
+                             "other complex pointer types should be "
+                             "declared as 'void *'" % name)
=20
 class Arguments:
     """Event arguments description."""
@@ -87,6 +131,7 @@ class Arguments:
             else:
                 arg_type, identifier =3D arg.rsplit(None, 1)
=20
+            validate_type(arg_type)
             res.append((arg_type, identifier))
         return Arguments(res)
=20
diff --git a/trace-events b/trace-events
index 89fcad0fd1..855b0ab240 100644
--- a/trace-events
+++ b/trace-events
@@ -68,9 +68,9 @@ memory_region_tb_read(int cpu_index, uint64_t addr, uin=
t64_t value, unsigned siz
 memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, uns=
igned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PR=
Ix64" size %u"
-flatview_new(FlatView *view, MemoryRegion *root) "%p (root %p)"
-flatview_destroy(FlatView *view, MemoryRegion *root) "%p (root %p)"
-flatview_destroy_rcu(FlatView *view, MemoryRegion *root) "%p (root %p)"
+flatview_new(void *view, void *root) "%p (root %p)"
+flatview_destroy(void *view, void *root) "%p (root %p)"
+flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
=20
 # gdbstub.c
 gdbstub_op_start(const char *device) "Starting gdbstub using device %s"
--=20
2.14.3
