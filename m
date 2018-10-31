Received: from eggs.gnu.org ([2001:4830:134:3::10]:52910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gHy9n-0003JM-KP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gHy9m-0006eY-TW
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:36:07 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 31 Oct 2018 14:35:50 -0700
Message-Id: <20181031213550.4544-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: drop num_[core_]regs from
 dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

gdb_regmap::num_core_regs field is initialized incorrectly in the dc232b
and dc233c configurations. As a result the following message is
displayed when attaching to an xtensa linux-user process:

  "Register 105 is not available",

and gdb is unable to control the inferior.

Now that xtensa_count_regs does the right thing, remove manual
initialization of these fields from the affected configurations and let
xtensa_finalize_config initialize them.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/core-dc232b.c | 2 --
 target/xtensa/core-dc233c.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index 71313378409e..7851bcb63687 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -40,8 +40,6 @@
 static XtensaConfig dc232b __attribute__((unused)) = {
     .name = "dc232b",
     .gdb_regmap = {
-        .num_regs = 120,
-        .num_core_regs = 52,
         .reg = {
 #include "core-dc232b/gdb-config.inc.c"
         }
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index d701e3f5de07..8853bfd4d08f 100644
--- a/target/xtensa/core-dc233c.c
+++ b/target/xtensa/core-dc233c.c
@@ -40,8 +40,6 @@
 static XtensaConfig dc233c __attribute__((unused)) = {
     .name = "dc233c",
     .gdb_regmap = {
-        .num_regs = 121,
-        .num_core_regs = 52,
         .reg = {
 #include "core-dc233c/gdb-config.inc.c"
         }
-- 
2.11.0
