Received: from eggs.gnu.org ([2001:4830:134:3::10]:60461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUjIF-00051c-Gu
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 21:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUjIA-000825-US
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 21:21:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:31843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gUjIA-0007yB-DT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 21:21:30 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu,  6 Dec 2018 10:32:09 +0800
Message-Id: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH for-4.0 v4 0/4] allow to load initrd below 4G
 for recent kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philip.li@intel.com, zhijianx.li@intel.com, philmd@redhat.com, Li Zhijian <lizhijian@cn.fujitsu.com>

Long long ago, linux kernel has supported up to 4G initrd, but it's header
still hard code to allow loading initrd below 2G only.
 cutting from arch/x86/head.S:
 # (Header version 0x0203 or later) the highest safe address for the contents
 # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
 # avoid possible bootloader bugs.

In order to support more than 2G initrd, qemu must allow loading initrd
above 2G address. Luckly, recent kernel introduced a new field to linux header
named xloadflags:XLF_CAN_BE_LOADED_ABOVE_4G which tells bootload an optional
and safe address to load initrd.

Current QEMU/BIOS always loads initrd below below_4g_mem_size which always
less than 4G, so here limiting initrd_max to 4G - 1 simply is enough if
this bit is set.

Default roms(Seabios + optionrom(linuxboot_dma)) works as expected with this
patchset.

changes:
V4:
  - add Reviwed-by tag to 1/4 and 2/4
  - use scripts/update-linux-headers.sh to import bootparam.h
  - minor fix at commit log
V3:
 - rebase code basing on http://patchwork.ozlabs.org/cover/1005990 and
   https://patchew.org/QEMU/20181122133507.30950-1-peter.maydell@linaro.org
 - add new patch 3/4 to import header bootparam.h (Michael S. Tsirkin)

V2: add 2 patches(3/5, 4/5) to fix potential loading issue.

Li Zhijian (4):
  unify len and addr type for memory/address APIs
  refactor load_image_size
  i386: import & use bootparam.h
  i386: allow to load initrd below 4G for recent linux

 exec.c                                       | 47 ++++++++++++++--------------
 hw/core/loader.c                             | 11 +++----
 hw/i386/pc.c                                 | 18 ++++++-----
 include/exec/cpu-all.h                       |  2 +-
 include/exec/cpu-common.h                    |  8 ++---
 include/exec/memory.h                        | 22 ++++++-------
 include/standard-headers/asm-x86/bootparam.h | 34 ++++++++++++++++++++
 scripts/update-linux-headers.sh              |  4 +++
 8 files changed, 92 insertions(+), 54 deletions(-)
 create mode 100644 include/standard-headers/asm-x86/bootparam.h

-- 
2.7.4
