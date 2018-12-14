Received: from eggs.gnu.org ([2001:4830:134:3::10]:38289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofa-0008O1-En
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofZ-0004Jp-Mm
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofZ-0004Iw-Ed
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id n190so5943118wmd.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.23
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:41:58 +0000
Message-Id: <20181214144214.1260-7-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/22] elf_ops.h: Use address_space_write() to
 write memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently the load_elf function in elf_ops.h uses
cpu_physical_memory_write() to write the ELF file to
memory if it is not handling it as a ROM blob. This
means we ignore the AddressSpace that the function
is passed to define where it should be loaded.
Use address_space_write() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181122172653.3413-4-peter.maydell@linaro.org
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
2.19.2
