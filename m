Received: from eggs.gnu.org ([209.51.188.92]:40887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN8-0002eY-Rb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN7-0008MW-N9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:02 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBN5-0008H2-Om
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:00 -0500
Received: by mail-wr1-x429.google.com with SMTP id u4so19163413wrp.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:10:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:10:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:27 +0000
Message-Id: <20190128181047.20781-7-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/26] exec.c: Use correct attrs in
 cpu_memory_rw_debug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the softmmu version of cpu_memory_rw_debug(), we ask the
CPU for the attributes to use for the virtual memory access,
and we correctly use those to identify the address space
index. However, we were not passing them in to the
address_space_write_rom() and address_space_rw() functions.

The effect of this was that a memory access from the gdbstub
to a device which had behaviour that was sensitive to the
memory attributes (such as some ARMv8M NVIC registers) was
incorrectly always performed as if non-secure, rather than
using the right security state for the CPU's current state.

Fixes: https://bugs.launchpad.net/qemu/+bug/1812091

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190117133834.7480-1-peter.maydell@linaro.org
---
 exec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 895449f9261..9557a4e523c 100644
--- a/exec.c
+++ b/exec.c
@@ -3882,12 +3882,10 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
             address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
-                                    MEMTXATTRS_UNSPECIFIED,
-                                    buf, l);
+                                    attrs, buf, l);
         } else {
             address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
-                             MEMTXATTRS_UNSPECIFIED,
-                             buf, l, 0);
+                             attrs, buf, l, 0);
         }
         len -= l;
         buf += l;
-- 
2.20.1
