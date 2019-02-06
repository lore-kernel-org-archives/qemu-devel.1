Received: from eggs.gnu.org ([209.51.188.92]:50067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grOf2-0007TG-AF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grOex-0000Ap-DI
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:58:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grOex-00007r-27
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:58:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 15:58:31 +0100
Message-Id: <20190206145831.656-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190206145831.656-1-marcandre.lureau@redhat.com>
References: <20190206145831.656-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] dump: Set correct vaddr for ELF dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peter.maydell@linaro.org, Jon Doron <arilou@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Jon Doron <arilou@gmail.com>

vaddr needs to be equal to the paddr since the dump file represents the
physical memory image.

Without setting vaddr correctly, GDB would load all the different memory
regions on top of each other to vaddr 0, thus making GDB showing the wron=
g
memory data for a given address.

Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20190109082203.27142-1-arilou@gmail.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
---
 scripts/dump-guest-memory.py | 1 +
 dump.c                       | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 198cd0fe40..2c587cbefc 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -163,6 +163,7 @@ class ELF(object):
         phdr =3D get_arch_phdr(self.endianness, self.elfclass)
         phdr.p_type =3D p_type
         phdr.p_paddr =3D p_paddr
+        phdr.p_vaddr =3D p_paddr
         phdr.p_filesz =3D p_size
         phdr.p_memsz =3D p_size
         self.segments.append(phdr)
diff --git a/dump.c b/dump.c
index ef1d8025c9..107a67165a 100644
--- a/dump.c
+++ b/dump.c
@@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
     phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
     phdr.p_filesz =3D cpu_to_dump64(s, filesz);
     phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
-    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
+    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr) ?: phdr=
.p_paddr;
=20
     assert(memory_mapping->length >=3D filesz);
=20
@@ -216,7 +216,8 @@ static void write_elf32_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
     phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
     phdr.p_filesz =3D cpu_to_dump32(s, filesz);
     phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
-    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
+    phdr.p_vaddr =3D
+        cpu_to_dump32(s, memory_mapping->virt_addr) ?: phdr.p_paddr;
=20
     assert(memory_mapping->length >=3D filesz);
=20
--=20
2.20.1.98.gecbdaf0899
