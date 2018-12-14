Received: from eggs.gnu.org ([2001:4830:134:3::10]:38258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofY-0008Mf-8V
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofX-0004HD-Hw
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:24 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofX-0004Gb-AM
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id m1so5920123wml.2
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:41:56 +0000
Message-Id: <20181214144214.1260-5-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/22] disas.c: Use address_space_read() to read
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently disas.c reads physical memory using
cpu_physical_memory_read(). This effectively hard-codes
assuming that all CPUs have the same view of physical
memory. Switch to address_space_read() instead, which
lets us use the AddressSpace for the CPU we're
disassembling for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181122172653.3413-2-peter.maydell@linaro.org
---
 disas.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/disas.c b/disas.c
index 5325b7e6be6..f9c517b3588 100644
--- a/disas.c
+++ b/disas.c
@@ -588,7 +588,10 @@ static int
 physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
 {
-    cpu_physical_memory_read(memaddr, myaddr, length);
+    CPUDebug *s = container_of(info, CPUDebug, info);
+
+    address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
+                       myaddr, length);
     return 0;
 }
 
-- 
2.19.2
