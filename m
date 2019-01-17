Received: from eggs.gnu.org ([209.51.188.92]:45779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gk778-0005l8-Is
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gk777-0001zW-8Z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:36270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gk776-0001rr-Ue
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:41 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu, 17 Jan 2019 20:49:00 +0800
Message-Id: <1547729344-3895-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v6 0/4] allow to load initrd below 4G for
 recent kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philmd@redhat.com, zhijianx.li@intel.com, philip.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Long long ago, linux kernel has supported up to 4G initrd, but it's header
still hard code to allow loading initrd below 2G only.
 cutting from arch/boot/x86/header.S:
 # (Header version 0x0203 or later) the highest safe address for the contents
 # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
 # avoid possible bootloader bugs.

In order to support more than 2G initrd, qemu must allow loading initrd
above 2G address. Luckly, recent kernel introduced a new field to linux header
named xloadflags:XLF_CAN_BE_LOADED_ABOVE_4G which tells bootloader an optional
and safe address to load initrd.

It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
be loaded into any address.

Default roms(Seabios + optionrom(linuxboot_dma)) works as expected with this
patchset.

I stole some comments from yours, fell free to let me know if you don't like this.

changes:
V6: no functional changes
 - Patch 3/4: Fix line over 80 characters && use double quates for all pathes (Stefano Garzarella)
 - Patch 4/4: update comments

V5: add a few reviewed-tag and update 4/4 changelog and comments
V4:
  - add Reviwed-by tag to 1/4 and 2/4
  - use scripts/update-linux-headers.sh to import bootparam.h
  - minor fix at commit log
V3:
 - rebase code basing on http://patchwork.ozlabs.org/cover/1005990 and
   https://patchew.org/QEMU/20181122133507.30950-1-peter.maydell@linaro.org
 - add new patch 3/4 to import header bootparam.h (Michael S. Tsirkin)

V2: add 2 patches(3/5, 4/5) to fix potential loading issue.


CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: Stefano Garzarella <sgarzare@redhat.com>
CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
CC: Peter Maydell <peter.maydell@linaro.org>

Li Zhijian (4):
  unify len and addr type for memory/address APIs
  hw/core/loader.c: Read as long as possible in load_image_size()
  i386: import & use bootparam.h
  i386: allow to load initrd below 4 GB for recent linux

 exec.c                                       | 47 ++++++++++++++--------------
 hw/core/loader.c                             | 11 +++----
 hw/i386/pc.c                                 | 29 ++++++++++++-----
 include/exec/cpu-all.h                       |  2 +-
 include/exec/cpu-common.h                    |  8 ++---
 include/exec/memory.h                        | 22 ++++++-------
 include/standard-headers/asm-x86/bootparam.h | 34 ++++++++++++++++++++
 scripts/update-linux-headers.sh              |  6 ++++
 8 files changed, 105 insertions(+), 54 deletions(-)
 create mode 100644 include/standard-headers/asm-x86/bootparam.h

-- 
2.7.4
