Received: from eggs.gnu.org ([2001:4830:134:3::10]:38482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGPlp-0006Hd-5n
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGPlk-0004Ip-96
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGPlk-0004Id-2N
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:04:04 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Jun 2017 17:03:25 +0400
Message-Id: <20170601130325.6433-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170601130325.6433-1-marcandre.lureau@redhat.com>
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/4] scripts/dump-guest-memory.py: add
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
Cc: lersek@redhat.com, qiaonuohan@cn.fujitsu.com, anderson@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add vmcoreinfo ELF note if qemu dump_info has been populated.

Also modify it with NUMBER(phys_base)=3D.. if the guest doesn't provide
it (on older kernel).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/dump-guest-memory.py | 52 ++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 52 insertions(+)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index f7c6635f15..a13f5d8b24 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -120,6 +120,33 @@ class ELF(object):
         self.segments[0].p_filesz +=3D ctypes.sizeof(note)
         self.segments[0].p_memsz +=3D ctypes.sizeof(note)
=20
+
+    def add_vmcoreinfo_note(self, vmcoreinfo, phys_base=3DNone):
+        """Adds a vmcoreinfo note to the ELF."""
+        chead =3D type(get_arch_note(self.endianness, 0, 0))
+        header =3D chead.from_buffer_copy(vmcoreinfo[0:ctypes.sizeof(che=
ad)])
+        note =3D get_arch_note(self.endianness,
+                             header.n_namesz - 1, header.n_descsz)
+        ctypes.memmove(ctypes.pointer(note), vmcoreinfo, ctypes.sizeof(n=
ote))
+        header_size =3D ctypes.sizeof(note) - header.n_descsz
+
+        if phys_base:
+            desc =3D bytearray(note.n_desc).decode().split()
+            if not next((v for v in desc if v.startswith('NUMBER(phys_ba=
se)=3D')),
+                        False):
+                desc.append('NUMBER(phys_base)=3D%ld' % phys_base)
+            desc =3D "\n".join(desc) + '\n'
+            descsz =3D (len(desc) + 3) // 4 * 4
+            desc +=3D '\0' * (descsz - len(desc))
+            note =3D get_arch_note(self.endianness, header.n_namesz - 1,=
 descsz)
+            ctypes.memmove(ctypes.pointer(note), vmcoreinfo, header_size=
)
+            note.n_descsz =3D descsz
+            ctypes.memmove(note.n_desc, desc.encode(), descsz)
+
+        self.notes.append(note)
+        self.segments[0].p_filesz +=3D ctypes.sizeof(note)
+        self.segments[0].p_memsz +=3D ctypes.sizeof(note)
+
     def add_segment(self, p_type, p_paddr, p_size):
         """Adds a segment to the elf."""
=20
@@ -505,6 +532,30 @@ shape and this command should mostly work."""
                 cur +=3D chunk_size
                 left -=3D chunk_size
=20
+    def add_vmcoreinfo(self):
+        qemu_core =3D gdb.inferiors()[0]
+
+        try:
+            coreinfo =3D gdb.parse_and_eval("dump_info.vmcoreinfo")
+        except gdb.error:
+            return
+
+        if coreinfo =3D=3D 0:
+            return
+
+        phys_base =3D None
+        has_phys_base =3D gdb.parse_and_eval("dump_info.has_phys_base")
+        if has_phys_base:
+            phys_base =3D int(gdb.parse_and_eval("dump_info.phys_base"))
+
+        addr, size =3D [int(val, 16) for val in coreinfo.string().split(=
)]
+        for block in self.guest_phys_blocks:
+            if block["target_start"] <=3D addr < block["target_end"]:
+                haddr =3D block["host_addr"] + (addr - block["target_sta=
rt"])
+                vmcoreinfo =3D qemu_core.read_memory(haddr, size)
+                self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes(), phys_=
base)
+                return
+
     def invoke(self, args, from_tty):
         """Handles command invocation from gdb."""
=20
@@ -518,6 +569,7 @@ shape and this command should mostly work."""
=20
         self.elf =3D ELF(argv[1])
         self.guest_phys_blocks =3D get_guest_phys_blocks()
+        self.add_vmcoreinfo()
=20
         with open(argv[0], "wb") as vmcore:
             self.dump_init(vmcore)
--=20
2.13.0.91.g00982b8dd
