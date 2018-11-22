Received: from eggs.gnu.org ([2001:4830:134:3::10]:54996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPskw-0006jS-Ma
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPskv-00017l-PU
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:27:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gPskv-0000ga-Gq
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:27:09 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 17:26:53 +0000
Message-Id: <20181122172653.3413-4-peter.maydell@linaro.org>
In-Reply-To: <20181122172653.3413-1-peter.maydell@linaro.org>
References: <20181122172653.3413-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for-4.0 3/3] elf_ops.h: Use
 address_space_write() to write memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Currently the load_elf function in elf_ops.h uses
cpu_physical_memory_write() to write the ELF file to
memory if it is not handling it as a ROM blob. This
means we ignore the AddressSpace that the function
is passed to define where it should be loaded.
Use address_space_write() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: handle NULL as
---
 include/hw/elf_ops.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 81cecaf27e2..74679ff8da3 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -482,7 +482,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                     rom_add_elf_program(label, data, file_size, mem_size,
                                         addr, as);
                 } else {
-                    cpu_physical_memory_write(addr, data, file_size);
+                    address_space_write(as ? as : &address_space_memory,
+                                        addr, MEMTXATTRS_UNSPECIFIED,
+                                        data, file_size);
                     g_free(data);
                 }
             }
-- 
2.19.1
