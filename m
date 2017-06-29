Received: from eggs.gnu.org ([2001:4830:134:3::10]:47545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQI-0001vF-Uk
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQG-0007rF-8a
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dQZQF-0007r2-Vi
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0726468A0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 13:23:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Jun 2017 15:23:09 +0200
Message-Id: <20170629132310.18865-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170629132310.18865-1-marcandre.lureau@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/7] scripts/dump-guest-memory.py: add
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
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Add vmcoreinfo ELF note if vmcoreinfo device is ready.

To help the python script, add a little global vmcoreinfo_gdb
structure, that is populated with vmcoreinfo_gdb_update().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/dump-guest-memory.py | 32 ++++++++++++++++++++++++++++++++
 include/hw/acpi/vmcoreinfo.h |  1 +
 hw/acpi/vmcoreinfo.c         | 16 ++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index f7c6635f15..16c3d7cb10 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -120,6 +120,20 @@ class ELF(object):
         self.segments[0].p_filesz +=3D ctypes.sizeof(note)
         self.segments[0].p_memsz +=3D ctypes.sizeof(note)
=20
+
+    def add_vmcoreinfo_note(self, vmcoreinfo):
+        """Adds a vmcoreinfo note to the ELF dump."""
+        chead =3D type(get_arch_note(self.endianness, 0, 0))
+        header =3D chead.from_buffer_copy(vmcoreinfo[0:ctypes.sizeof(che=
ad)])
+        note =3D get_arch_note(self.endianness,
+                             header.n_namesz - 1, header.n_descsz)
+        ctypes.memmove(ctypes.pointer(note), vmcoreinfo, ctypes.sizeof(n=
ote))
+        header_size =3D ctypes.sizeof(note) - header.n_descsz
+
+        self.notes.append(note)
+        self.segments[0].p_filesz +=3D ctypes.sizeof(note)
+        self.segments[0].p_memsz +=3D ctypes.sizeof(note)
+
     def add_segment(self, p_type, p_paddr, p_size):
         """Adds a segment to the elf."""
=20
@@ -505,6 +519,23 @@ shape and this command should mostly work."""
                 cur +=3D chunk_size
                 left -=3D chunk_size
=20
+    def add_vmcoreinfo(self):
+        qemu_core =3D gdb.inferiors()[0]
+
+        gdb.execute("call vmcoreinfo_gdb_update()")
+        avail =3D gdb.parse_and_eval("vmcoreinfo_gdb.available")
+        if not avail:
+            return;
+
+        addr =3D gdb.parse_and_eval("vmcoreinfo_gdb.paddr")
+        size =3D gdb.parse_and_eval("vmcoreinfo_gdb.size")
+        for block in self.guest_phys_blocks:
+            if block["target_start"] <=3D addr < block["target_end"]:
+                haddr =3D block["host_addr"] + (addr - block["target_sta=
rt"])
+                vmcoreinfo =3D qemu_core.read_memory(haddr, size)
+                self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
+                return
+
     def invoke(self, args, from_tty):
         """Handles command invocation from gdb."""
=20
@@ -518,6 +549,7 @@ shape and this command should mostly work."""
=20
         self.elf =3D ELF(argv[1])
         self.guest_phys_blocks =3D get_guest_phys_blocks()
+        self.add_vmcoreinfo()
=20
         with open(argv[0], "wb") as vmcore:
             self.dump_init(vmcore)
diff --git a/include/hw/acpi/vmcoreinfo.h b/include/hw/acpi/vmcoreinfo.h
index 40fe99c3ed..4efa678237 100644
--- a/include/hw/acpi/vmcoreinfo.h
+++ b/include/hw/acpi/vmcoreinfo.h
@@ -32,5 +32,6 @@ void vmcoreinfo_build_acpi(VmcoreinfoState *vis, GArray=
 *table_data,
 void vmcoreinfo_add_fw_cfg(VmcoreinfoState *vis, FWCfgState *s, GArray *=
vmci);
 bool vmcoreinfo_get(VmcoreinfoState *vis, uint64_t *paddr, uint64_t *siz=
e,
                     Error **errp);
+void vmcoreinfo_gdb_update(void);
=20
 #endif
diff --git a/hw/acpi/vmcoreinfo.c b/hw/acpi/vmcoreinfo.c
index 216e0bb83a..75e3330813 100644
--- a/hw/acpi/vmcoreinfo.c
+++ b/hw/acpi/vmcoreinfo.c
@@ -145,6 +145,22 @@ bool vmcoreinfo_get(VmcoreinfoState *vis,
     return true;
 }
=20
+struct vmcoreinfo_gdb {
+    bool available;
+    uint64_t paddr;
+    uint64_t size;
+} vmcoreinfo_gdb;
+
+void vmcoreinfo_gdb_update(void)
+{
+    Object *vmci =3D find_vmcoreinfo_dev();
+
+    vmcoreinfo_gdb.available =3D vmci ?
+        vmcoreinfo_get(VMCOREINFO(vmci),
+                       &vmcoreinfo_gdb.paddr, &vmcoreinfo_gdb.size, NULL=
)
+        : false;
+}
+
 static const VMStateDescription vmstate_vmcoreinfo =3D {
     .name =3D "vmcoreinfo",
     .version_id =3D 1,
--=20
2.13.1.395.gf7b71de06
