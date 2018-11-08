Received: from eggs.gnu.org ([2001:4830:134:3::10]:39799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhRx-0004gG-RP
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhI8-0008V9-8D
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:7254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gKhI7-0008PV-S1
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:00 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu,  8 Nov 2018 18:59:41 +0800
Message-Id: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [RFC/PoC PATCH 0/3] support initrd size up to 4G
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Long long ago, linux kernel have supported up to 4G initrd, but it's header still
hard code to allow 2G - 1 only.
 # (Header version 0x0203 or later) the highest safe address for the contents
 # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
 # avoid possible bootloader bugs.

kexec is one of the known scenario which has supported up to 4G initrd.

This patches is to enable up to 4G initrd, Seabios + optionrom(linuxboot_dma)
works as expected so far.

3/3 has a huge change of address/memory APIs.
I replace 'int len' in a stupid way, but it looks not safety.
$ sed -i 's/int len/uint32_t len/' exec.c
$ make # and check compiling errors
$ sed -i 's/int len/uint32_t len/' cpu-all.h
$ make -i 's/int len/uint32_t len/' include/exec/cpu-common.h
$ make -i 's/int len/uint32_t len/' include/exec/memory.h
$ make # all errors gone

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
CC: Richard Henderson <rth@twiddle.net>

Li Zhijian (3):
  i386: set initrd_max to 4G - 1 to allow up to 4G initrd
  change size type from int to int64_t on load_image()
  change int len to uin32_t len

 exec.c                    | 42 +++++++++++++++++++++---------------------
 hw/core/loader.c          |  3 ++-
 hw/i386/pc.c              |  6 ++++++
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h | 10 +++++-----
 include/exec/memory.h     | 20 ++++++++++----------
 6 files changed, 45 insertions(+), 38 deletions(-)

-- 
2.7.4
