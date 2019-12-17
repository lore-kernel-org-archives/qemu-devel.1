Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCCEC2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCFB2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO9sV6+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCFB2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6Qf-00019q-Bh
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6Jv-0000hi-8R
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Js-0000XS-Fo
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:26:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48853
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Js-0000Sx-35
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cpc5zqb0w5KSEXaCxvMAeCLmni3sWRnHVOCSyK0xgd8=;
 b=aO9sV6+Fs2TvIEDK/6qxKqkpxJey9B8cIrPZDPgDsNFUao/aFCW/7M1OAY6e+d/XS/yKX9
 LuzzsR248EAGvttu1hq3gCzjk9ftJwUjOdaWCBXBsN6RDkIHHjezri11QH4JmHlmvShOED
 6eOIbwvT0HmZlN5CD8EEQvIWXfhwi5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332--WG_kMRRMYKgK9YvGwQF-Q-1; Tue, 17 Dec 2019 01:26:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 276B8911A3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:26:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7FDF5C28C
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:26:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4263411386A7; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] Error reporting patches for 2019-12-16
Date: Tue, 17 Dec 2019 07:26:17 +0100
Message-Id: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -WG_kMRRMYKgK9YvGwQF-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166304=
:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-20=
19' into staging (2019-12-16 14:07:56 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2019-12-16

for you to fetch changes up to 0e7f83bab6559775cd71e418b12a49145e59faa7:

  nbd: assert that Error** is not NULL in nbd_iter_channel_error (2019-12-1=
6 20:50:16 +0100)

----------------------------------------------------------------
Error reporting patches for 2019-12-16

----------------------------------------------------------------
Markus Armbruster (14):
      error: Fix -msg timestamp default
      crypto: Fix certificate file error handling crash bug
      crypto: Fix typo in QCryptoTLSSession's <example> comment
      io: Fix Error usage in a comment <example>
      tests: Clean up initialization of Error *err variables
      exec: Fix file_ram_alloc() error API violations
      hw/acpi: Fix legacy CPU plug error API violations
      hw/core: Fix fit_load_fdt() error API violations
      hw/ipmi: Fix realize() error API violations
      qga: Fix guest-get-fsinfo error API violations
      memory-device: Fix memory pre-plug error API violations
      error: Clean up unusual names of Error * variables
      hw/intc/s390: Simplify error handling in kvm_s390_flic_realize()
      tests-blockjob: Use error_free_or_abort()

Vladimir Sementsov-Ogievskiy (20):
      net/net: Clean up variable shadowing in net_client_init()
      error: make Error **errp const where it is appropriate
      hmp: drop Error pointer indirection in hmp_handle_error
      vnc: drop Error pointer indirection in vnc_client_io_error
      qdev-monitor: make Error **errp const where it is appropriate
      ppc: make Error **errp const where it is appropriate
      9pfs: make Error **errp const where it is appropriate
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

 include/block/snapshot.h            |   2 +-
 include/crypto/tlssession.h         |   2 +-
 include/io/task.h                   |   2 +-
 include/monitor/hmp.h               |   2 +-
 include/qapi/error.h                |   6 +-
 include/qemu/error-report.h         |   3 +-
 include/qom/object.h                |   4 +-
 target/ppc/kvm_ppc.h                |   4 +-
 ui/vnc.h                            |   2 +-
 backends/cryptodev.c                |  11 +--
 block/nbd.c                         |   1 +
 block/snapshot.c                    |   4 +-
 crypto/tlscredsx509.c               |   2 +-
 dump/dump-hmp-cmds.c                |   4 +-
 exec.c                              |   6 +-
 hw/9pfs/9p-local.c                  |   2 +-
 hw/9pfs/9p-proxy.c                  |   2 +-
 hw/acpi/cpu_hotplug.c               |  10 +--
 hw/core/loader-fit.c                |  15 ++--
 hw/core/machine-hmp-cmds.c          |   6 +-
 hw/core/qdev.c                      |  28 +++----
 hw/i386/amd_iommu.c                 |  14 ++--
 hw/intc/s390_flic_kvm.c             |  16 ++--
 hw/ipmi/isa_ipmi_bt.c               |   7 +-
 hw/ipmi/isa_ipmi_kcs.c              |   7 +-
 hw/ipmi/pci_ipmi_bt.c               |   6 +-
 hw/ipmi/pci_ipmi_kcs.c              |   6 +-
 hw/mem/memory-device.c              |   6 +-
 hw/ppc/spapr.c                      |   2 +-
 hw/ppc/spapr_pci.c                  |  16 ++--
 hw/ppc/spapr_pci_nvlink2.c          |  10 +--
 hw/s390x/event-facility.c           |   2 +-
 hw/s390x/s390-stattrib.c            |   3 +-
 hw/sd/sdhci.c                       |   2 +-
 hw/tpm/tpm_emulator.c               |   8 +-
 hw/usb/dev-network.c                |   2 +-
 hw/vfio/ap.c                        |   9 +--
 monitor/hmp-cmds.c                  | 155 ++++++++++++++++++--------------=
----
 monitor/qmp-cmds.c                  |   2 +-
 net/net.c                           |  17 ++--
 qdev-monitor.c                      |  16 ++--
 qga/commands-posix.c                |   8 +-
 qga/commands-win32.c                |   2 +-
 qga/commands.c                      |  12 +--
 qom/qom-hmp-cmds.c                  |   4 +-
 target/ppc/kvm.c                    |   2 +-
 tests/test-blockjob.c               |  15 ++--
 tests/test-qobject-output-visitor.c |   8 +-
 tests/test-string-output-visitor.c  |   4 +-
 ui/vnc.c                            |  20 ++---
 util/error.c                        |   6 +-
 util/qemu-error.c                   |   6 +-
 vl.c                                |   2 +-
 qemu-options.hx                     |  10 ++-
 54 files changed, 260 insertions(+), 263 deletions(-)

--=20
2.21.0


