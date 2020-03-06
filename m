Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5C8C3F2D7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 05:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C392072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 05:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C392072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA5NA-00041e-QT
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 00:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA5Kz-0008ID-Rg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 00:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA5Ky-0000op-5z
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 00:15:53 -0500
Received: from relay.sw.ru ([185.231.240.75]:34040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jA5Kx-0000iM-Sf; Fri, 06 Mar 2020 00:15:52 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jA5Kl-0001tg-L3; Fri, 06 Mar 2020 08:15:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/10] error: auto propagated local_err part I
Date: Fri,  6 Mar 2020 08:15:26 +0300
Message-Id: <20200306051536.27803-1-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

File with errp-cleaning APIs dropped for two reasons:

1. I'm tired after a 3-days war with coccinelle, and don't want to add more
   patches here.

2. Markus noted, that we forget two more functions which needs such wrappers
   and corresponding conversion, so seems better to handle all these things
   in same manner for now.

changes in v8:

01: - update comments
    - fix bug in macro [Markus]
    - use do {} while(0)

02: a lot of changes
    - about error propagation: try to update only patterns where we propagate
      local_error to errp. So, patches 09 and 10 changed (wow!)
    - Now clearing functions are not defined. Still, do the conversion, so
      that when script applied where these functions needed, compilation will
      be broken.
    - improve ordering of hunks, and comment everything

09,10: drop hunks, which are converted for nothing.

v8 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-partI-v8
v7 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-partI-v7
 
In these series, there is no commit-per-subsystem script, each generated
commit is generated in separate.

Still, generating commands are very similar, and looks like

    sed -n '/^<Subsystem name>$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Note, that in each generated commit, generation command is the only
text, indented by 8 spaces in 'git log -1' output, so, to regenerate all
commits (for example, after rebase, or change in coccinelle script), you
may use the following command:

git rebase -x "sh -c \"git show --pretty= --name-only | xargs git checkout HEAD^ -- ; git reset; git log -1 | grep '^        ' | sh\"" HEAD~7

Which will start automated interactive rebase for generated patches,
which will stop if generated patch changed
(you may do git commit --amend to apply updated generated changes).

Note:
  git show --pretty= --name-only   - lists files, changed in HEAD
  git log -1 | grep '^        ' | sh   - rerun generation command of HEAD


Check for compilation of changed .c files
git rebase -x "sh -c \"git show --pretty= --name-only | sed -n 's/\.c$/.o/p' | xargs make -j9\"" HEAD~7


Vladimir Sementsov-Ogievskiy (10):
  error: auto propagated local_err
  scripts: add coccinelle script to use auto propagated errp
  hw/sd/ssi-sd: fix error handling in ssi_sd_realize
  SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
  pflash: introduce ERRP_AUTO_PROPAGATE
  fw_cfg: introduce ERRP_AUTO_PROPAGATE
  virtio-9p: introduce ERRP_AUTO_PROPAGATE
  TPM: introduce ERRP_AUTO_PROPAGATE
  nbd: introduce ERRP_AUTO_PROPAGATE
  xen: introduce ERRP_AUTO_PROPAGATE

 include/block/nbd.h                           |   1 +
 include/qapi/error.h                          | 206 +++++++++++++---
 block/nbd.c                                   |  21 +-
 hw/9pfs/9p-local.c                            |  12 +-
 hw/9pfs/9p.c                                  |   1 +
 hw/block/dataplane/xen-block.c                |  17 +-
 hw/block/pflash_cfi01.c                       |   7 +-
 hw/block/pflash_cfi02.c                       |   7 +-
 hw/block/xen-block.c                          | 125 ++++------
 hw/nvram/fw_cfg.c                             |  14 +-
 hw/pci-host/xen_igd_pt.c                      |   7 +-
 hw/sd/sdhci-pci.c                             |   7 +-
 hw/sd/sdhci.c                                 |  21 +-
 hw/sd/ssi-sd.c                                |  26 +-
 hw/tpm/tpm_util.c                             |   7 +-
 hw/xen/xen-backend.c                          |   7 +-
 hw/xen/xen-bus.c                              |  92 +++----
 hw/xen/xen-host-pci-device.c                  |  27 +-
 hw/xen/xen_pt.c                               |  25 +-
 hw/xen/xen_pt_config_init.c                   |  20 +-
 nbd/client.c                                  |   5 +
 nbd/server.c                                  |   5 +
 tpm.c                                         |   7 +-
 scripts/coccinelle/auto-propagated-errp.cocci | 231 ++++++++++++++++++
 24 files changed, 617 insertions(+), 281 deletions(-)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org

-- 
2.21.0


