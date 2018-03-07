Received: from eggs.gnu.org ([2001:4830:134:3::10]:57645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eteIb-0004kj-H5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eteIa-0004Ya-On
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:00:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Mar 2018 19:59:23 +0100
Message-Id: <20180307185946.29366-15-kwolf@redhat.com>
In-Reply-To: <20180307185946.29366-1-kwolf@redhat.com>
References: <20180307185946.29366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v4 14/37] block: Make bdrv_is_whitelisted()
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h | 1 +
 block.c               | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/block/block.h b/include/block/block.h
index 7805187b30..cdec3639a3 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -226,6 +226,7 @@ char *bdrv_perm_names(uint64_t perm);
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
 bool bdrv_uses_whitelist(void);
+int bdrv_is_whitelisted(BlockDriver *drv, bool read_only);
 BlockDriver *bdrv_find_protocol(const char *filename,
                                 bool allow_protocol_prefix,
                                 Error **errp);
diff --git a/block.c b/block.c
index 4fc65f7621..00f94241fc 100644
--- a/block.c
+++ b/block.c
@@ -370,7 +370,7 @@ BlockDriver *bdrv_find_format(const char *format_name)
     return bdrv_do_find_format(format_name);
 }
 
-static int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
+int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
 {
     static const char *whitelist_rw[] = {
         CONFIG_BDRV_RW_WHITELIST
-- 
2.13.6
