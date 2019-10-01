Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A060AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B2B20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B2B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLFS-0000uD-VT
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKU0-0000jP-CA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKTy-0007Et-93
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:54:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:38478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKTr-0006Zp-Vr; Tue, 01 Oct 2019 11:54:34 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKSv-0004xb-Vc; Tue, 01 Oct 2019 18:53:30 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/31] error: auto propagated local_err
Date: Tue,  1 Oct 2019 18:52:48 +0300
Message-Id: <20191001155319.8066-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 mdroth@linux.vnet.ibm.com, kraxel@redhat.com, sundeep.lkml@gmail.com,
 qemu-block@nongnu.org, quintela@redhat.com, arikalo@wavecomp.com,
 mst@redhat.com, armbru@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 joel@jms.id.au, marcandre.lureau@redhat.com, rth@twiddle.net,
 farman@linux.ibm.com, ehabkost@redhat.com, sw@weilnetz.de, groug@kaod.org,
 yuval.shaia@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 integration@gluster.org, clg@kaod.org, stefanha@redhat.com, david@redhat.com,
 jsnow@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, berrange@redhat.com,
 andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is a proposal of auto propagation for local_err, to not call
error_propagate on every exit point, when we deal with local_err.

There are also two issues with errp:

1. error_fatal & error_append_hint/error_prepend: user can't see this
additional info, because exit() happens in error_setg earlier than info
is added. [Reported by Greg Kurz]

2. error_abort & error_propagate: when we wrap
error_abort by local_err+error_propagate, resulting coredump will
refer to error_propagate and not to the place where error happened.
(the macro itself don't fix the issue, but it allows to [3.] drop all
local_err+error_propagate pattern, which will definitely fix the issue)
[Reported by Kevin Wolf]

Still, applying new macro to all errp-functions is a huge task, which is
impossible to solve in one series.

So, here is a minimum: solve only [1.], by adding new macro to all
errp-functions which wants to call error_append_hint.

v4;
02: - check errp to be not NULL
    - drop Eric's r-b
03: add Eric's r-b
04: - rename macro to ERRP_AUTO_PROPAGATE [Kevin]
    - improve comment and commit msg, mention
      error_prepend
05: - handle error_prepend too
    - use new macro name
    - drop empty line at the end

commit message for auto-generated commits updated,
commits regenerated.

I'll use cc-cmd to cc appropriate recipients per patch, still
cover-letter together with 04-06 patches should be interesting for
all:

CC: kwolf@redhat.com
CC: mreitz@redhat.com
CC: jsnow@redhat.com
CC: fam@euphon.net
CC: sw@weilnetz.de
CC: codyprime@gmail.com
CC: marcandre.lureau@redhat.com
CC: pbonzini@redhat.com
CC: groug@kaod.org
CC: sundeep.lkml@gmail.com
CC: peter.maydell@linaro.org
CC: stefanha@redhat.com
CC: pburton@wavecomp.com
CC: arikalo@wavecomp.com
CC: berrange@redhat.com
CC: ehabkost@redhat.com
CC: david@gibson.dropbear.id.au
CC: clg@kaod.org
CC: mst@redhat.com
CC: marcel.apfelbaum@gmail.com
CC: mark.cave-ayland@ilande.co.uk
CC: yuval.shaia@oracle.com
CC: cohuck@redhat.com
CC: farman@linux.ibm.com
CC: rth@twiddle.net
CC: david@redhat.com
CC: pasic@linux.ibm.com
CC: borntraeger@de.ibm.com
CC: kraxel@redhat.com
CC: alex.williamson@redhat.com
CC: andrew@aj.id.au
CC: joel@jms.id.au
CC: eblake@redhat.com
CC: armbru@redhat.com
CC: mdroth@linux.vnet.ibm.com
CC: quintela@redhat.com
CC: dgilbert@redhat.com
CC: jasowang@redhat.com
CC: qemu-block@nongnu.org
CC: integration@gluster.org
CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org
CC: qemu-s390x@nongnu.org


Vladimir Sementsov-Ogievskiy (31):
  errp: rename errp to errp_in where it is IN-argument
  hw/core/loader-fit: fix freeing errp in fit_load_fdt
  net/net: fix local variable shadowing in net_client_init
  error: auto propagated local_err
  scripts: add script to fix error_append_hint/error_prepend usage
  python: add commit-per-subsystem.py
  s390: Fix error_append_hint/error_prepend usage
  ARM TCG CPUs: Fix error_append_hint/error_prepend usage
  PowerPC TCG CPUs: Fix error_append_hint/error_prepend usage
  arm: Fix error_append_hint/error_prepend usage
  SmartFusion2: Fix error_append_hint/error_prepend usage
  ASPEED BMCs: Fix error_append_hint/error_prepend usage
  Boston: Fix error_append_hint/error_prepend usage
  PowerNV (Non-Virtualized): Fix error_append_hint/error_prepend usage
  PCI: Fix error_append_hint/error_prepend usage
  SCSI: Fix error_append_hint/error_prepend usage
  USB: Fix error_append_hint/error_prepend usage
  VFIO: Fix error_append_hint/error_prepend usage
  vhost: Fix error_append_hint/error_prepend usage
  virtio: Fix error_append_hint/error_prepend usage
  virtio-9p: Fix error_append_hint/error_prepend usage
  XIVE: Fix error_append_hint/error_prepend usage
  block: Fix error_append_hint/error_prepend usage
  chardev: Fix error_append_hint/error_prepend usage
  cmdline: Fix error_append_hint/error_prepend usage
  QOM: Fix error_append_hint/error_prepend usage
  Migration: Fix error_append_hint/error_prepend usage
  Sockets: Fix error_append_hint/error_prepend usage
  nbd: Fix error_append_hint/error_prepend usage
  PVRDMA: Fix error_append_hint/error_prepend usage
  ivshmem: Fix error_append_hint/error_prepend usage

 include/block/nbd.h                         |  1 +
 include/monitor/hmp.h                       |  2 +-
 include/qapi/error.h                        | 39 +++++++++++-
 ui/vnc.h                                    |  2 +-
 block.c                                     |  3 +
 block/backup.c                              |  1 +
 block/dirty-bitmap.c                        |  1 +
 block/file-posix.c                          |  4 ++
 block/gluster.c                             |  2 +
 block/qcow.c                                |  1 +
 block/qcow2-bitmap.c                        |  1 +
 block/qcow2.c                               |  3 +
 block/vdi.c                                 |  1 +
 block/vhdx-log.c                            |  1 +
 block/vmdk.c                                |  1 +
 block/vpc.c                                 |  1 +
 chardev/spice.c                             |  1 +
 hw/9pfs/9p-local.c                          |  1 +
 hw/9pfs/9p-proxy.c                          |  1 +
 hw/9pfs/9p.c                                |  1 +
 hw/arm/msf2-soc.c                           |  1 +
 hw/arm/virt.c                               |  2 +
 hw/block/dataplane/virtio-blk.c             |  1 +
 hw/core/loader-fit.c                        |  7 ++-
 hw/core/qdev-properties-system.c            |  1 +
 hw/intc/arm_gicv3_kvm.c                     |  1 +
 hw/intc/pnv_xive.c                          |  1 +
 hw/intc/xive.c                              |  3 +
 hw/misc/ivshmem.c                           |  1 +
 hw/misc/msf2-sysreg.c                       |  1 +
 hw/pci-bridge/pcie_root_port.c              |  1 +
 hw/ppc/mac_newworld.c                       |  1 +
 hw/ppc/pnv_lpc.c                            |  1 +
 hw/ppc/pnv_occ.c                            |  1 +
 hw/ppc/spapr.c                              |  1 +
 hw/ppc/spapr_irq.c                          |  1 +
 hw/ppc/spapr_pci.c                          |  1 +
 hw/rdma/vmw/pvrdma_main.c                   |  1 +
 hw/s390x/s390-ccw.c                         |  1 +
 hw/scsi/scsi-disk.c                         |  1 +
 hw/scsi/scsi-generic.c                      |  1 +
 hw/scsi/vhost-scsi.c                        |  1 +
 hw/usb/ccid-card-emulated.c                 |  1 +
 hw/vfio/common.c                            |  3 +
 hw/vfio/pci-quirks.c                        |  1 +
 hw/vfio/pci.c                               |  3 +
 hw/vfio/platform.c                          |  1 +
 hw/virtio/vhost-vsock.c                     |  1 +
 hw/virtio/virtio-pci.c                      |  2 +
 hw/watchdog/wdt_aspeed.c                    |  1 +
 migration/migration.c                       |  1 +
 migration/savevm.c                          |  2 +
 monitor/hmp-cmds.c                          |  8 +--
 nbd/client.c                                |  5 ++
 nbd/server.c                                |  4 ++
 net/net.c                                   | 17 +++--
 qdev-monitor.c                              |  2 +
 target/ppc/kvm.c                            |  2 +
 target/s390x/cpu_models.c                   |  2 +
 ui/vnc.c                                    | 10 +--
 util/error.c                                |  8 +--
 util/qemu-option.c                          |  2 +
 util/qemu-sockets.c                         |  2 +
 python/commit-per-subsystem.py              | 69 +++++++++++++++++++++
 scripts/coccinelle/fix-error-add-info.cocci | 28 +++++++++
 65 files changed, 247 insertions(+), 27 deletions(-)
 create mode 100755 python/commit-per-subsystem.py
 create mode 100644 scripts/coccinelle/fix-error-add-info.cocci

-- 
2.21.0


