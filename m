Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617FC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D1D24249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D1D24249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvdD-00030N-O5
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvE1-0008CZ-2s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvDu-0005DT-NP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:47:33 -0500
Received: from relay.sw.ru ([185.231.240.75]:48378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvDu-0003Y1-89; Thu, 05 Dec 2019 12:47:30 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvD5-00013M-LS; Thu, 05 Dec 2019 20:46:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/21] error: prepare for auto propagated local_err
Date: Thu,  5 Dec 2019 20:46:14 +0300
Message-Id: <20191205174635.18758-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, armbru@redhat.com,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Greg Kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

This is the first part of the bit series, which contains mostly simple
cleanups.

v6 was sent in separate (I'm sorry for inconvenience)

v7: by Markus review (and with his prepared fixups, thanks a lot!):
  - don't rename Error** paramters
  - switch to Error *const * where appropriate
  last patch is new and replaces
   "nbd: well form nbd_iter_channel_error errp handler"

v8: - fix outdated commit-messages (forget doing it in v7 :(
    - add Greg's and Cornelia's r-b sings

Vladimir Sementsov-Ogievskiy (21):
  hw/core/loader-fit: fix freeing errp in fit_load_fdt
  net/net: Clean up variable shadowing in net_client_init()
  error: make Error **errp const where it is appropriate
  hmp: drop Error pointer indirection in hmp_handle_error
  vnc: drop Error pointer indirection in vnc_client_io_error
  qdev-monitor: well form error hint helpers
  ppc: well form kvmppc_hint_smt_possible error hint helper
  9pfs: well form error hint helpers
  hw/core/qdev: cleanup Error ** variables
  block/snapshot: rename Error ** parameter to more common errp
  hw/i386/amd_iommu: rename Error ** parameter to more common errp
  qga: rename Error ** parameter to more common errp
  monitor/qmp-cmds: rename Error ** parameter to more common errp
  hw/s390x: rename Error ** parameter to more common errp
  hw/sd: drop extra whitespace in sdhci_sysbus_realize() header
  hw/tpm: rename Error ** parameter to more common errp
  hw/usb: rename Error ** parameter to more common errp
  include/qom/object.h: rename Error ** parameter to more common errp
  backends/cryptodev: drop local_err from cryptodev_backend_complete()
  hw/vfio/ap: drop local_err from vfio_ap_realize
  nbd: assert that Error** is not NULL in nbd_iter_channel_error

Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Paul Burton <pburton@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-s390x@nongnu.org


 include/block/snapshot.h   |   2 +-
 include/monitor/hmp.h      |   2 +-
 include/qapi/error.h       |   6 +-
 include/qom/object.h       |   4 +-
 target/ppc/kvm_ppc.h       |   4 +-
 ui/vnc.h                   |   2 +-
 backends/cryptodev.c       |  11 +--
 block/nbd.c                |   1 +
 block/snapshot.c           |   4 +-
 dump/dump-hmp-cmds.c       |   4 +-
 hw/9pfs/9p-local.c         |   2 +-
 hw/9pfs/9p-proxy.c         |   2 +-
 hw/core/loader-fit.c       |   5 +-
 hw/core/machine-hmp-cmds.c |   6 +-
 hw/core/qdev.c             |  28 ++++---
 hw/i386/amd_iommu.c        |  14 ++--
 hw/ppc/spapr.c             |   2 +-
 hw/s390x/event-facility.c  |   2 +-
 hw/s390x/s390-stattrib.c   |   3 +-
 hw/sd/sdhci.c              |   2 +-
 hw/tpm/tpm_emulator.c      |   8 +-
 hw/usb/dev-network.c       |   2 +-
 hw/vfio/ap.c               |   9 +--
 monitor/hmp-cmds.c         | 155 ++++++++++++++++++-------------------
 monitor/qmp-cmds.c         |   2 +-
 net/net.c                  |  17 ++--
 qdev-monitor.c             |  16 ++--
 qga/commands-posix.c       |   2 +-
 qga/commands-win32.c       |   2 +-
 qga/commands.c             |  12 +--
 qom/qom-hmp-cmds.c         |   4 +-
 target/ppc/kvm.c           |   2 +-
 ui/vnc.c                   |  20 ++---
 util/error.c               |   6 +-
 34 files changed, 173 insertions(+), 190 deletions(-)

-- 
2.21.0


