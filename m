Received: from eggs.gnu.org ([2001:4830:134:3::10]:38143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrS-0000vH-5g
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrO-0002ls-Ch
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Feb 2018 14:53:41 +0100
Message-Id: <20180221135404.27598-14-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-1-kwolf@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/36] block: Make bdrv_is_whitelisted()
 public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

We'll use a separate source file for image creation, and we need to
check there whether the requested driver is whitelisted.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 1 +
 block.c               | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/block/block.h b/include/block/block.h
index 54fe8b7a0e..cfce88cbda 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -225,6 +225,7 @@ char *bdrv_perm_names(uint64_t perm);
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
 bool bdrv_uses_whitelist(void);
+int bdrv_is_whitelisted(BlockDriver *drv, bool read_only);
 BlockDriver *bdrv_find_protocol(const char *filename,
                                 bool allow_protocol_prefix,
                                 Error **errp);
diff --git a/block.c b/block.c
index c0e343d278..4a7e448226 100644
--- a/block.c
+++ b/block.c
@@ -372,7 +372,7 @@ BlockDriver *bdrv_find_format(const char *format_name)
     return bdrv_do_find_format(format_name);
 }
 
-static int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
+int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
 {
     static const char *whitelist_rw[] = {
         CONFIG_BDRV_RW_WHITELIST
-- 
2.13.6
