Received: from eggs.gnu.org ([2001:4830:134:3::10]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gOvxC-00008N-NW
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gOvxC-00066R-16
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:54 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gOvxB-00064P-QU
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:53 -0500
Received: by mail-lj1-x242.google.com with SMTP id e5-v6so308974lja.4
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 18:39:53 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 19 Nov 2018 18:39:33 -0800
Message-Id: <20181120023934.8552-2-jcmvbkbc@gmail.com>
In-Reply-To: <20181120023934.8552-1-jcmvbkbc@gmail.com>
References: <20181120023934.8552-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] target/xtensa: gdbstub fix register
 counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

In order to communicate correctly with gdb xtensa gdbstub must provide
expected number of registers in 'g' packet response. xtensa-elf-gdb
expects both nonprivileged and privileged registers. xtensa-linux-gdb
only expects nonprivileged registers. gdb only counts one contiguous
stretch of registers, do the same for the core registers in the
xtensa_count_regs.

With this change qemu-system-xtensa is able to communicate with all
xtensa-elf-gdb versions (versions prior to 8.2 require overlay fixup),
and qemu-xtensa is able to communicate with all xtensa-linux-gdb
versions, except 8.2.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/gdbstub.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index c9450914c72d..d43bb190c614 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -45,15 +45,20 @@ void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs)
 {
     unsigned i;
+    bool count_core_regs = true;
 
     for (i = 0; config->gdb_regmap.reg[i].targno >= 0; ++i) {
         if (config->gdb_regmap.reg[i].type != xtRegisterTypeTieState &&
             config->gdb_regmap.reg[i].type != xtRegisterTypeMapped &&
             config->gdb_regmap.reg[i].type != xtRegisterTypeUnmapped) {
             ++*n_regs;
-            if ((config->gdb_regmap.reg[i].flags &
-                 XTENSA_REGISTER_FLAGS_PRIVILEGED) == 0) {
-                ++*n_core_regs;
+            if (count_core_regs) {
+                if ((config->gdb_regmap.reg[i].flags &
+                     XTENSA_REGISTER_FLAGS_PRIVILEGED) == 0) {
+                    ++*n_core_regs;
+                } else {
+                    count_core_regs = false;
+                }
             }
         }
     }
-- 
2.11.0
