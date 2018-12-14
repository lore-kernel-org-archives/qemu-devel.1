Received: from eggs.gnu.org ([2001:4830:134:3::10]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofZ-0008ND-N0
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofY-0004IS-Nf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofY-0004HW-HE
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:24 -0500
Received: by mail-wr1-x429.google.com with SMTP id v13so5670094wrw.5
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:41:57 +0000
Message-Id: <20181214144214.1260-6-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/22] monitor: Use address_space_read() to read
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

Currently monitor.c reads physical memory using
cpu_physical_memory_read(). This effectively hard-codes
assuming that all CPUs have the same view of physical
memory. Switch to address_space_read() instead, which
lets us use the AddressSpace for the CPU we're
reading memory for (falling back to address_space_memory
if there is no CPU, as happens with the "none" board).
As a bonus, this allows us to detect failures to read memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181122172653.3413-3-peter.maydell@linaro.org
---
 monitor.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 6e81b09294e..4c8d8c2a5a0 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1605,7 +1605,13 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         if (l > line_size)
             l = line_size;
         if (is_physical) {
-            cpu_physical_memory_read(addr, buf, l);
+            AddressSpace *as = cs ? cs->as : &address_space_memory;
+            MemTxResult r = address_space_read(as, addr,
+                                               MEMTXATTRS_UNSPECIFIED, buf, l);
+            if (r != MEMTX_OK) {
+                monitor_printf(mon, " Cannot access memory\n");
+                break;
+            }
         } else {
             if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
                 monitor_printf(mon, " Cannot access memory\n");
-- 
2.19.2
