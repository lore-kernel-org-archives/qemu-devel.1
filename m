Received: from eggs.gnu.org ([2001:4830:134:3::10]:33743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNt-00021R-F0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNp-0000fP-C2
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:32844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gTpNp-0000ex-0T
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:37 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon,  3 Dec 2018 22:48:48 +0800
Message-Id: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH for-4.0 v3 0/4] allow to load initrd below 4G
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
Cc: philip.li@intel.com, zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>

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
V3:
 - rebase code basing on http://patchwork.ozlabs.org/cover/1005990 and
   https://patchew.org/QEMU/20181122133507.30950-1-peter.maydell@linaro.org
 - add new patch 3/4 to import header bootparam.h (Michael S. Tsirkin)

V2: add 2 patches(3/5, 4/5) to fix potential loading issue.

Li Zhijian (4):
  unify len and addr type for memory/address APIs
  refactor load_image_size
  i386: import bootparam.h
  i386: allow to load initrd below 4G for recent linux

 exec.c                    | 47 +++++++++++++++++++++++------------------------
 hw/core/loader.c          | 11 +++++------
 hw/i386/pc.c              | 25 ++++++++++---------------
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h |  8 ++++----
 include/exec/memory.h     | 22 +++++++++++-----------
 6 files changed, 54 insertions(+), 61 deletions(-)

-- 
2.7.4
