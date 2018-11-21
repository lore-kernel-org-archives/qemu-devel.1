Received: from eggs.gnu.org ([2001:4830:134:3::10]:49854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtp-0005ll-Ad
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtk-0002kv-8Y
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:12715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gPHtk-0002gn-0u
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:48 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Wed, 21 Nov 2018 10:06:01 +0800
Message-Id: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v2 0/5] support loading initrd below 4G for
 recent kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <zhijianx.li@intel.com>, Philip Li <philip.li@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Long long ago, linux kernel have supported up to 4G initrd, but it's header
still hard code to allow loading initrd below 2G only.
 cutting from arch/x86/head.S:
 # (Header version 0x0203 or later) the highest safe address for the contents
 # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
 # avoid possible bootloader bugs.

In order to supporting more than 2G initrd, qemu must allow loading initrd
above 2G address. Luckly, recent kernel introduced a new field to linux header
named xloadflags:XLF_CAN_BE_LOADED_ABOVE_4G which tells bootload an optional
and safe address to load initrd.

Current QEMU always load initrd below below_4g_mem_size which always
less than 4G, so here limit initrd_max to 4G - 1 simply is enough if
this bit is set.

Default roms(Seabios + optionrom(linuxboot_dma)) works as expected with those
patch set.

Patch 1/5 make a huge changes to address/memory APIs, but if it's not a good
idea, below is an specfic patch to avoid dma overflow

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 946f765..5c9607c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -338,7 +338,7 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
     while (dma.length > 0 && !(dma.control & FW_CFG_DMA_CTL_ERROR)) {
         if (s->cur_entry == FW_CFG_INVALID || !e->data ||
                                 s->cur_offset >= e->len) {
-            len = dma.length;
+            len = dma.length > INT32_MAX ? INT32_MAX : dma.length;
 
             /* If the access is not a read access, it will be a skip access,
              * tested before.
@@ -358,6 +358,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
                 len = (e->len - s->cur_offset);
             }
 
+            len = len > INT32_MAX ? INT32_MAX : len;
+
             /* If the access is not a read access, it will be a skip access,
              * tested before.
              */

changes:
V2: add 2 patches(3/5, 4/5) to fix potential loading issue.

Li Zhijian (5):
  unify len and addr type for memory/address APIs
  change load_image() reture type to ssize_t
  refactor load_image/load_image_size
  x86: exit qemu if load_image fails
  x86: allow load initrd below 4G for recent linux

 exec.c                    | 49 ++++++++++++++++++++++++-----------------------
 hw/core/loader.c          | 27 +++++++++++++++-----------
 hw/i386/pc.c              | 17 +++++++++++++++-
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h | 10 +++++-----
 include/exec/memory.h     | 20 +++++++++----------
 include/hw/loader.h       |  2 +-
 7 files changed, 74 insertions(+), 53 deletions(-)

-- 
2.7.4
