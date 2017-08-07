Received: from eggs.gnu.org ([2001:4830:134:3::10]:39671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demaP-00073z-1r
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demaJ-0000DN-O5
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:17:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1demaJ-0000Cw-EQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 066D8883BE
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 18:16:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Aug 2017 20:16:17 +0200
Message-Id: <20170807181618.22562-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170807181618.22562-1-marcandre.lureau@redhat.com>
References: <20170807181618.22562-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 7/8] scripts/dump-guest-memory.py: add
 vmcoreinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, anderson@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add vmcoreinfo ELF note if fw-cfg has the memory location details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/dump-guest-memory.py | 51 ++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 51 insertions(+)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index f7c6635f15..1f97373f0d 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -14,6 +14,7 @@ the COPYING file in the top-level directory.
 """
=20
 import ctypes
+import struct
=20
 UINTPTR_T =3D gdb.lookup_type("uintptr_t")
=20
@@ -45,6 +46,12 @@ EM_S390 =3D 22
 EM_AARCH =3D 183
 EM_X86_64 =3D 62
=20
+def le32_to_cpu(val):
+    return struct.unpack("<I", struct.pack("=3DI", val))[0]
+
+def le64_to_cpu(val):
+    return struct.unpack("<Q", struct.pack("=3DQ", val))[0]
+
 class ELF(object):
     """Representation of a ELF file."""
=20
@@ -120,6 +127,25 @@ class ELF(object):
         self.segments[0].p_filesz +=3D ctypes.sizeof(note)
         self.segments[0].p_memsz +=3D ctypes.sizeof(note)
=20
+
+    def add_vmcoreinfo_note(self, vmcoreinfo):
+        """Adds a vmcoreinfo note to the ELF dump."""
+        # compute the header size, and copy that many bytes from the not=
e
+        header =3D get_arch_note(self.endianness, 0, 0)
+        ctypes.memmove(ctypes.pointer(header),
+                       vmcoreinfo, ctypes.sizeof(header))
+        if header.n_descsz > 1 << 20:
+            print('warning: invalid vmcoreinfo size')
+            return
+        # now get the full note
+        note =3D get_arch_note(self.endianness,
+                             header.n_namesz - 1, header.n_descsz)
+        ctypes.memmove(ctypes.pointer(note), vmcoreinfo, ctypes.sizeof(n=
ote))
+
+        self.notes.append(note)
+        self.segments[0].p_filesz +=3D ctypes.sizeof(note)
+        self.segments[0].p_memsz +=3D ctypes.sizeof(note)
+
     def add_segment(self, p_type, p_paddr, p_size):
         """Adds a segment to the elf."""
=20
@@ -505,6 +531,30 @@ shape and this command should mostly work."""
                 cur +=3D chunk_size
                 left -=3D chunk_size
=20
+    def phys_memory_read(self, addr, size):
+        qemu_core =3D gdb.inferiors()[0]
+        for block in self.guest_phys_blocks:
+            if block["target_start"] <=3D addr \
+               and addr + size <=3D block["target_end"]:
+                haddr =3D block["host_addr"] + (addr - block["target_sta=
rt"])
+                return qemu_core.read_memory(haddr, size)
+        return None
+
+    def add_vmcoreinfo(self):
+        if not gdb.parse_and_eval("fw_cfg_find()") \
+           or not gdb.parse_and_eval("fw_cfg_find()->have_vmcoreinfo"):
+            return
+
+        addr =3D gdb.parse_and_eval("fw_cfg_find()->vmcoreinfo.paddr")
+        size =3D gdb.parse_and_eval("fw_cfg_find()->vmcoreinfo.size")
+
+        addr =3D le64_to_cpu(addr)
+        size =3D le32_to_cpu(size)
+
+        vmcoreinfo =3D self.phys_memory_read(addr, size)
+        if vmcoreinfo:
+            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
+
     def invoke(self, args, from_tty):
         """Handles command invocation from gdb."""
=20
@@ -518,6 +568,7 @@ shape and this command should mostly work."""
=20
         self.elf =3D ELF(argv[1])
         self.guest_phys_blocks =3D get_guest_phys_blocks()
+        self.add_vmcoreinfo()
=20
         with open(argv[0], "wb") as vmcore:
             self.dump_init(vmcore)
--=20
2.14.0.1.geff633fa0
