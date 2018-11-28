Received: from eggs.gnu.org ([2001:4830:134:3::10]:36531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRwG6-0004z8-Hi
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRwG5-0000TX-Tg
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:35:50 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 28 Nov 2018 10:35:36 +0100
Message-Id: <1543397736-8198-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1?] hw/arm/aspeed: Fix build issue with
 clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org

When using clang 3.4.2, compilation of QEMU fails like this:

  CC      aarch64-softmmu/hw/arm/aspeed.o
hw/arm/aspeed.c:36:3: error: redefinition of typedef 'AspeedBoardState' is a C11
      feature [-Werror,-Wtypedef-redefinition]
} AspeedBoardState;
  ^
include/hw/arm/aspeed.h:14:33: note: previous definition is here
typedef struct AspeedBoardState AspeedBoardState;
                                ^
1 error generated.
make[1]: *** [hw/arm/aspeed.o] Error 1
make: *** [subdir-aarch64-softmmu] Error 2

Remove the duplicated typedef to fix this issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6b33ecd..5158985 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -29,11 +29,11 @@ static struct arm_boot_info aspeed_board_binfo = {
     .nb_cpus = 1,
 };
 
-typedef struct AspeedBoardState {
+struct AspeedBoardState {
     AspeedSoCState soc;
     MemoryRegion ram;
     MemoryRegion max_ram;
-} AspeedBoardState;
+};
 
 /* Palmetto hardware value: 0x120CE416 */
 #define PALMETTO_BMC_HW_STRAP1 (                                        \
-- 
1.8.3.1
