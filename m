Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB8C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B205C206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B205C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq0Jk-0005ts-LS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iq0Ao-0001mT-E5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iq0Am-0004xr-H0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:42:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:53974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iq0Am-0004mb-4E; Fri, 10 Jan 2020 14:42:20 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iq0AT-0008Ob-Ke; Fri, 10 Jan 2020 22:42:01 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/11] error: auto propagated local_err part I
Date: Fri, 10 Jan 2020 22:41:47 +0300
Message-Id: <20200110194158.14190-1-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Now, when preparations from
 [RFC v5 000/126] error: auto propagated local_err
 https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg02771.html
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-v5 
, after some iterations, are finally merged, let's proceed with the
rest. Sorry for a big delay on my part.

As a first step, I decided to take subsystems, each of them covered by
one patch, which get r-b/a-b marks by maintainer of the subsystem in v5.

v6 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-partI-v6 

Changes v5->v6:
01: use errp name for the parameter, add assertion
02: add a lot of text information, drop Eric's r-b.
    no semantic changes.
03: add more comments
    skip functions with pattern error_append_.*_hint in name
    make errp identifier, to match any name of Error ** paramter
    some other improvements
04: only commit message changed,
    keep Philippe's r-b
05: new, manual update for hw/sd/ssi-sd
06: only commit message changed,
    keep Philippe's r-b
07: only commit message changed,
    keep Philippe's r-b
08: local_parse_opts() changed, so patch changed in this
    function, drop a-b mark
    also, indentation fixed, by improvement in coccinelle script
09: only commit message changed,
    keep Stefan's r-b
10: commit message and a bit of context changed, still seems
    valid to keep Eric's r-b
11: add new hunk: hw/pci-host/xen_igd_pt.c, so, drop r-b
    also, indentation fixed, by improvement in coccinelle script

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
  

Vladimir Sementsov-Ogievskiy (11):
  qapi/error: add (Error **errp) cleaning APIs
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
 include/qapi/error.h                          | 113 +++++++++++++-
 block/nbd.c                                   |  49 +++---
 hw/9pfs/9p-local.c                            |  12 +-
 hw/9pfs/9p.c                                  |   1 +
 hw/block/dataplane/xen-block.c                |  17 +--
 hw/block/pflash_cfi01.c                       |   7 +-
 hw/block/pflash_cfi02.c                       |   7 +-
 hw/block/xen-block.c                          | 125 +++++++---------
 hw/nvram/fw_cfg.c                             |  14 +-
 hw/pci-host/xen_igd_pt.c                      |   7 +-
 hw/sd/sdhci-pci.c                             |   7 +-
 hw/sd/sdhci.c                                 |  21 ++-
 hw/sd/ssi-sd.c                                |  26 +++-
 hw/tpm/tpm_util.c                             |   7 +-
 hw/xen/xen-backend.c                          |   7 +-
 hw/xen/xen-bus.c                              | 100 ++++++-------
 hw/xen/xen-host-pci-device.c                  |  27 ++--
 hw/xen/xen_pt.c                               |  25 ++--
 hw/xen/xen_pt_config_init.c                   |  20 +--
 nbd/client.c                                  |   5 +
 nbd/server.c                                  |   5 +
 tpm.c                                         |   7 +-
 scripts/coccinelle/auto-propagated-errp.cocci | 139 ++++++++++++++++++
 24 files changed, 482 insertions(+), 267 deletions(-)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

CC: Cornelia Huck <cohuck@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Greg Kurz <groug@kaod.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Anthony Perard <anthony.perard@citrix.com>
CC: Paul Durrant <paul@xen.org>
CC: "Philippe Mathieu-Daudé" <philmd@redhat.com>
CC: Laszlo Ersek <lersek@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Stefan Berger <stefanb@linux.ibm.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Michael Roth <mdroth@linux.vnet.ibm.com>
CC: qemu-block@nongnu.org
CC: xen-devel@lists.xenproject.org

-- 
2.21.0


