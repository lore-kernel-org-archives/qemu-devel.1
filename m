Received: from eggs.gnu.org ([2001:4830:134:3::10]:49315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyE-0004GW-FW
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyA-0000sU-G6
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:22 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dBfyA-0000rw-AK
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:18 -0400
Received: by mail-wm0-x243.google.com with SMTP id k15so16378668wmh.3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 04:21:18 -0700 (PDT)
Received: from 640k.lan (94-39-157-43.adsl-ull.clienti.tiscali.it.
	[94.39.157.43])
	by smtp.gmail.com with ESMTPSA id v65sm2640095wmv.5.2017.05.19.04.21.14
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 19 May 2017 04:21:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 13:20:52 +0200
Message-Id: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/20] Misc patches for 2017-05-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging (2017-05-18 13:36:15 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e10dc0ca6854c4f47cc5e9d47e20c62aa875f518:

  target/i386: use multiple CPU AddressSpaces (2017-05-19 13:01:32 +0200)

----------------------------------------------------------------
* virtio-scsi use-after-free fix (Fam)
* vhost-user-scsi support (Felipe)
* SMM fixes and improvements for TCG (myself)
* irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
* Coverity fix (Stefano)
* NBD cleanups (Vladimir)
* RTC accuracy improvements and code cleanups (Guangrong+Yunfang)

----------------------------------------------------------------
Fam Zheng (1):
      virtio-scsi: Unset hotplug handler when unrealize

Felipe Franciosi (2):
      vhost-user-scsi: Introduce vhost-user-scsi host device
      vhost-user-scsi: Introduce a vhost-user-scsi sample application

Paolo Bonzini (2):
      target/i386: enable A20 automatically in system management mode
      target/i386: use multiple CPU AddressSpaces

Peter Xu (4):
      kvm: irqchip: trace changes on msi add/remove
      msix: trace control bit write op
      kvm: irqchip: skip update msi when disabled
      exec: simplify phys_page_find() params

Stefano Stabellini (1):
      Check the return value of fcntl in qemu_set_cloexec

Tai Yunfang (1):
      mc146818rtc: precisely count the clock for periodic timer

Vladimir Sementsov-Ogievskiy (5):
      nbd: strict nbd_wr_syncv
      nbd: read_sync and friends: return 0 on success
      nbd: add errp parameter to nbd_wr_syncv()
      nbd: add errp to read_sync, write_sync and drop_sync
      nbd/client.c: use errp instead of LOG

Xiao Guangrong (4):
      mc146818rtc: update periodic timer only if it is needed
      mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on TARGET_I386
      mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
      mc146818rtc: embrace all x86 specific code

 .gitignore                                |   1 +
 Makefile                                  |   3 +
 Makefile.objs                             |   4 +
 block/nbd-client.c                        |  11 +-
 contrib/vhost-user-scsi/Makefile.objs     |   1 +
 contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++++++++
 default-configs/pci.mak                   |   1 +
 default-configs/s390x-softmmu.mak         |   1 +
 exec.c                                    |  13 +-
 hw/pci/msix.c                             |  11 +-
 hw/pci/trace-events                       |   3 +
 hw/scsi/Makefile.objs                     |   1 +
 hw/scsi/vhost-user-scsi.c                 | 215 ++++++++
 hw/scsi/virtio-scsi.c                     |   3 +
 hw/timer/mc146818rtc.c                    | 206 ++++---
 hw/virtio/virtio-pci.c                    |  54 ++
 hw/virtio/virtio-pci.h                    |  11 +
 include/block/nbd.h                       |   8 +-
 include/hw/virtio/vhost-user-scsi.h       |  35 ++
 include/hw/virtio/virtio-scsi.h           |   3 +
 kvm-all.c                                 |   4 +-
 nbd/client.c                              | 125 ++---
 nbd/common.c                              |  23 +-
 nbd/nbd-internal.h                        |  40 +-
 nbd/server.c                              |  92 ++--
 qemu-nbd.c                                |   3 +-
 target/i386/arch_memory_mapping.c         |  18 +-
 target/i386/cpu.c                         |  15 +-
 target/i386/cpu.h                         |  20 +-
 target/i386/helper.c                      |  96 ++--
 target/i386/kvm.c                         |  12 +-
 target/i386/machine.c                     |   4 -
 target/i386/smm_helper.c                  |  18 -
 trace-events                              |   3 +-
 util/oslib-posix.c                        |   4 +-
 35 files changed, 1642 insertions(+), 306 deletions(-)
 create mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
 create mode 100644 hw/scsi/vhost-user-scsi.c
 create mode 100644 include/hw/virtio/vhost-user-scsi.h
-- 
1.8.3.1
